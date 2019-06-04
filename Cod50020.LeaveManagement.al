codeunit 50020 "Leave Management"
{

    trigger OnRun()
    begin
    end;

    var
        TimeSheetHeader: Record "Time Sheet Header";
        TimeSheetLine: Record "Time Sheet Line";
        LeavePlanEntry: Record "Leave Plan Entry";
        TestMailSuccessMsgLbl: Label 'Leave plan approval request has been %1..!';
        EmailAddrLbl: Text;
        BodySubmittedLbl: Label '%1 has applied leave from %2 to %3';
        TSCreated: Boolean;
        Text001Lbl: Label 'TimeSheet has been created for %1 to %2.';
        BodyLbl: Label 'The leave Application of %1 from %2 to %3 has been %4.';
        SubjectLbl: Label 'Leave Application from %1 has been %2';

    procedure CreateTimeSheet(LeavePlan: Record "Leave Plan")
    var
        TimeSheetDetail: Record "Time Sheet Detail";
        TimeSheetNo: Code[20];
    begin
        LeavePlanEntry.SETRANGE("LeavePlan No.", LeavePlan."No.");
        IF LeavePlanEntry.FINDSET() THEN
            REPEAT
                TimeSheetNo := LeavePlan."Resource No." + FORMAT(LeavePlanEntry.Date, 0, '<Year><Week,2>');

                IF TimeSheetHeader.GET(TimeSheetNo) THEN BEGIN
                    TimeSheetDetail.SETRANGE("Time Sheet No.", TimeSheetHeader."No.");
                    TimeSheetDetail.SETRANGE(Date, LeavePlanEntry.Date);
                    IF NOT TimeSheetDetail.FINDFIRST() THEN
                        CreateTSLine(LeavePlan)
                    ELSE BEGIN
                        IF TimeSheetLine.GET(TimeSheetHeader."No.", TimeSheetDetail."Time Sheet Line No.") AND (TimeSheetDetail.Status = TimeSheetDetail.Status::Open) THEN
                            IF TimeSheetLine."Cause of Absence Code" <> LeavePlan."Cause of Absence" THEN
                                TimeSheetDetail.DELETE();
                        CreateTSLine(LeavePlan);
                    END;
                    UpdateTimeSheetDetail();
                END;
            UNTIL LeavePlanEntry.NEXT() = 0;


        IF TSCreated THEN
            MESSAGE(Text001Lbl, LeavePlan."From Date", LeavePlan."To Date");
    end;

    local procedure UpdateTimeSheetDetail()
    var
        TimeSheetDetail: Record "Time Sheet Detail";
    begin
        IF TimeSheetDetail.GET(
             TimeSheetLine."Time Sheet No.",
             TimeSheetLine."Line No.",
             LeavePlanEntry.Date)
        THEN BEGIN
            IF LeavePlanEntry.Hours <> TimeSheetDetail.Quantity THEN
                TestTimeSheetLineStatus(TimeSheetLine."Time Sheet No.", TimeSheetLine."Line No.");

            IF LeavePlanEntry.Hours = 0 THEN
                TimeSheetDetail.DELETE()
            ELSE BEGIN
                TimeSheetDetail.Quantity := LeavePlanEntry.Hours;
                TimeSheetDetail.MODIFY(TRUE);
            END;
            TSCreated := TRUE;
        END ELSE BEGIN
            IF LeavePlanEntry.Hours <> 0 THEN
                TestTimeSheetLineStatus(TimeSheetLine."Time Sheet No.", TimeSheetLine."Line No.");

            TimeSheetDetail.INIT();
            TimeSheetDetail.CopyFromTimeSheetLine(TimeSheetLine);
            TimeSheetDetail.Date := LeavePlanEntry.Date;
            TimeSheetDetail.Quantity := LeavePlanEntry.Hours;
            TimeSheetDetail.INSERT(TRUE);
            TSCreated := TRUE;
        END;
    end;

    local procedure TestTimeSheetLineStatus(TimeSheetNo: Code[20]; TimeSheetLineNo: Integer)
    begin
        TimeSheetLine.GET(TimeSheetNo, TimeSheetLineNo);
        TimeSheetLine.TestStatus();
    end;

    local procedure GetLastTimeSheetNo(TimeSheetNo: Code[20]): Integer
    var
        TimeSheetLine: Record "Time Sheet Line";
    begin
        TimeSheetLine.SETRANGE("Time Sheet No.", TimeSheetNo);
        IF TimeSheetLine.FINDLAST() THEN
            EXIT(TimeSheetLine."Line No.");
    end;

    local procedure CreateTSLine(LeavePlan: Record "Leave Plan")
    begin
        TimeSheetLine.SETRANGE("Time Sheet No.", TimeSheetHeader."No.");
        TimeSheetLine.SETRANGE("Cause of Absence Code", LeavePlan."Cause of Absence");
        IF TimeSheetLine.FINDFIRST() THEN
            EXIT;

        TimeSheetLine.INIT();
        TimeSheetLine."Time Sheet No." := TimeSheetHeader."No.";
        TimeSheetLine."Line No." := GetLastTimeSheetNo(TimeSheetHeader."No.") + 10000;
        TimeSheetLine."Time Sheet Starting Date" := TimeSheetHeader."Starting Date";
        TimeSheetLine.VALIDATE(Type, TimeSheetLine.Type::Absence);
        TimeSheetLine.VALIDATE("Cause of Absence Code", LeavePlan."Cause of Absence");
        TimeSheetLine.Description := LeavePlan.Description;
        TimeSheetLine.INSERT(TRUE);
    end;

    procedure Submit(var LeavePlan: Record "Leave Plan")
    var
        Resource: Record 156;
    begin
        WITH LeavePlan DO BEGIN
            IF ISEMPTY() THEN
                EXIT;

            IF Status IN [Status::Submitted, Status::Approved, Status::Rejected] THEN
                EXIT;

            "Apply Date" := TODAY();
            Status := Status::Submitted;
            Resource.GET(LeavePlan."Resource No.");
            "Approver User ID" := Resource."Time Sheet Approver User ID";
            MODIFY(TRUE);
        END;

        SendEmail(LeavePlan);
    end;

    procedure ReopenSubmitted(var LeavePlan: Record "Leave Plan")
    begin
        WITH LeavePlan DO BEGIN
            IF ISEMPTY() THEN
                EXIT;
            IF Status IN [Status::Created, Status::Approved] THEN
                EXIT;

            Status := Status::Created;
            "Apply Date" := 0D;
            MODIFY(TRUE);
        END;
    end;

    procedure ReopenApproved(var LeavePlan: Record "Leave Plan")
    begin
        WITH LeavePlan DO BEGIN
            IF Status = Status::Submitted THEN
                EXIT;

            Status := Status::Created;
            "Apply Date" := 0D;
            "Approve Date" := 0D;
            MODIFY(TRUE);
        END;
    end;

    procedure Reject(var LeavePlan: Record 50020)
    begin
        WITH LeavePlan DO BEGIN
            IF Status IN [Status::Rejected, Status::Approved] THEN
                EXIT;

            Status := Status::Rejected;
            MODIFY(TRUE);
        END;

        //SendEmailRejection(LeavePlan);
        SendEmail(LeavePlan);
    end;

    procedure Approve(var LeavePlan: Record "Leave Plan")
    begin
        WITH LeavePlan DO BEGIN
            IF Status IN [Status::Approved, Status::Rejected] THEN
                EXIT;

            Status := Status::Approved;
            "Approve Date" := TODAY();
            MODIFY(TRUE);
        END;

        //SendEmailApproval(LeavePlan);
        SendEmail(LeavePlan);
        CreateTimeSheet(LeavePlan);
    end;

    procedure SendEmail(LeavePlan: Record "Leave Plan")
    var
        Resource: Record Resource;
        UserSetup: Record "User Setup";
        SMTPMailSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
    begin
        SMTPMailSetup.GET();
        Resource.GET(LeavePlan."Resource No.");

        CASE LeavePlan.Status OF
            LeavePlan.Status::Submitted:
                BEGIN
                    UserSetup.GET(Resource."Time Sheet Approver User ID");
                    UserSetup.TESTFIELD("E-Mail");
                END;
            LeavePlan.Status::Approved, LeavePlan.Status::Rejected:
                BEGIN
                    UserSetup.GET(Resource."Time Sheet Owner User ID");
                    UserSetup.TESTFIELD("E-Mail");
                END;
        END;

        SMTPMail.CreateMessage(
              '',
              SMTPMailSetup."User ID",
              UserSetup."E-Mail",
              STRSUBSTNO(SubjectLbl, Resource.Name, LeavePlan.Status),
              STRSUBSTNO(BodyLbl, Resource.Name, LeavePlan."From Date", LeavePlan."To Date", LeavePlan.Status),
              TRUE);

        IF LeavePlan.Status = LeavePlan.Status::Submitted THEN BEGIN
            UserSetup.GET(Resource."Time Sheet Owner User ID");
            SMTPMail.AddCC(UserSetup."E-Mail");
        END;

        SMTPMail.Send();
        MESSAGE(TestMailSuccessMsgLbl, LeavePlan.Status);
    end;

    procedure GetResourceNo(UserName: Code[50]): Code[20]
    var
        Pos: Integer;
    begin
        Pos := STRPOS(UserName, '\');

        IF Pos > 0 THEN
            EXIT(COPYSTR(UserName, Pos + 1, STRLEN(UserName)))
        ELSE
            EXIT(UserName);
    end;
}

