table 50020 "Leave Plan"
{

    Caption = 'Leave Plan';

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            Editable = false;
        }
        field(2; "Resource No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Resource No.';
            TableRelation = Resource;
        }
        field(3; "Cause of Absence"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cause of Absence';
            TableRelation = "Cause of Absence";

            trigger OnValidate()
            var
                CauseofAbsence: Record 5206;
            begin
                CauseofAbsence.GET("Cause of Absence");
                Description := CauseofAbsence.Description;
            end;
        }
        field(4; Description; Text[70])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            Editable = true;
        }
        field(5; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Created,Submitted,Approved,Rejected';
            OptionMembers = Created,Submitted,Approved,Rejected;
        }
        field(6; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF ("From Date" > "To Date") AND ("To Date" <> 0D) THEN
                    ERROR(Text000Lbl, FIELDCAPTION("From Date"), FIELDCAPTION("To Date"));
            end;
        }
        field(7; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                VALIDATE("From Date");
            end;
        }
        field(8; Hours; Decimal)
        {
            CalcFormula = Sum ("Leave Plan Entry".Hours WHERE ("LeavePlan No." = FIELD ("No."),
                                                              Date = FIELD ("Date Filter")));
            Caption = 'Hours';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Approver User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Approver User ID';
            Editable = false;
            TableRelation = "User Setup";
        }
        field(10; "Apply Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date of Submission';
            Editable = false;
        }
        field(13; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(14; "Owner User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Owner User ID';
            TableRelation = "User Setup";
        }
        field(15; "Approve Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Approve Date';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Resource No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        LeavePlanEntry: Record 50023;
    begin
        CheckStatus();

        LeavePlanEntry.SETRANGE("LeavePlan No.", "No.");
        LeavePlanEntry.DELETEALL();
    end;

    trigger OnInsert()
    begin
        "No." := GetLastLeavePlanNo() + 1;
        SetDefaultValues();
    end;

    var
        TimeSheetLine: Record "Time Sheet Line";
        TimeSheetHeader: Record "Time Sheet Header";
        LeavePlanEntry: Record "Leave Plan Entry";
        Resource: Record Resource;
        AddResourceCapacity: Report "Add Resource Capacity";
        Text000Lbl: Label '%1 cannot be after %2;SVE=%1 kan inte vara efter %2';
        Visible: Boolean;
        Text001Lbl: Label '" Fields ""From date"" & ""To date"" cannot be empty!!!"';
        Text002Lbl: Label 'Status must be Created or Rejected with Leave plan';
        TempDate: Date;

    procedure CreateLeavePlanEntry()
    var
        LeavePlanEntry: Record "Leave Plan Entry";
        Calendar: Record 2000000007;
    begin
        LeavePlanEntry.SETRANGE("LeavePlan No.", "No.");
        LeavePlanEntry.DELETEALL();

        Calendar.SETRANGE("Period Type", Calendar."Period Type"::Date);
        Calendar.SETRANGE("Period Start", "From Date", "To Date");
        IF Calendar.FINDSET() THEN
            REPEAT
                LeavePlanEntry.INIT();
                LeavePlanEntry."LeavePlan No." := "No.";
                LeavePlanEntry."Resource No." := "Resource No.";
                LeavePlanEntry.Date := Calendar."Period Start";
                Resource.GET(LeavePlanEntry."Resource No.");
                Resource.SETRANGE("Date Filter", Calendar."Period Start");
                LeavePlanEntry.Hours := GetHours(LeavePlanEntry.Date);
                LeavePlanEntry.INSERT(TRUE);
            UNTIL Calendar.NEXT() = 0;
    end;

    procedure FilterLeavePlan(FieldNo: Integer)
    begin
        FILTERGROUP(2);
        CASE FieldNo OF
            Rec.FIELDNO("Owner User ID"):
                SETRANGE("Owner User ID", USERID);
            Rec.FIELDNO("Approver User ID"):
                SETRANGE("Approver User ID", USERID);
        END;
        FILTERGROUP(0);
    end;

    local procedure SetDefaultValues()
    var
        LeaveMgt: Codeunit "Leave Management";
    begin
        "Owner User ID" := USERID();
        "Resource No." := LeaveMgt.GetResourceNo("Owner User ID");
    end;

    local procedure GetLastLeavePlanNo(): Integer
    var
        LeavePlan: Record 50020;
    begin
        IF LeavePlan.FINDLAST() THEN
            EXIT(LeavePlan."No.");
    end;

    local procedure CheckStatus()
    begin
        IF NOT (Status IN [Status::Created, Status::Rejected]) THEN
            ERROR(Text002Lbl, "No.");
    end;

    [TryFunction]
    procedure CheckFields()
    begin
        IF "No." = 0 THEN
            EXIT;

        TESTFIELD("Cause of Absence");
        TESTFIELD("From Date");
        TESTFIELD("To Date");
    end;

    local procedure GetHours(LeavePlanEntryDate: Date): Decimal
    var
        ResCapacityEntry: Record 160;
    begin
        ResCapacityEntry.SETRANGE(Date, LeavePlanEntryDate);
        IF ResCapacityEntry.ISEMPTY() THEN BEGIN
            AddResourceCapacity.SetTempDate(LeavePlanEntryDate);
            EXIT(AddResourceCapacity.SelectCapacity());
        END ELSE BEGIN
            Resource.CALCFIELDS(Capacity);
            EXIT(Resource.Capacity);
        END;
    end;
}

