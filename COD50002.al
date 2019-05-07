codeunit 50002 "Send Workload Report"
{
    // version EVAK


    trigger OnRun()
    var
        TempEmailItem: Record "Email Item" temporary;
        SMTPMailSetup: Record "SMTP Mail Setup";
        UserSetup: Record "User Setup";
        MailManagement: Codeunit "Mail Management";
        FileMgt: Codeunit "File Management";
        WeekNo: Integer;
    begin
        FilePath := COPYSTR(FileMgt.ServerTempFileName('html'), 1, 250);
        REPORT.SAVEASHTML(50017, FilePath);

        WeekNo := DATE2DWY(WORKDATE, 2);

        SMTPMailSetup.GET;
        UserSetup.GET('EV\ST');

        //TempEmailItem.Init();
        TempEmailItem."From Address" := SMTPMailSetup."User ID";
        TempEmailItem."Send to" := UserSetup."E-Mail";
        TempEmailItem.Subject := STRSUBSTNO(Text000, WeekNo, WeekNo + 1);
        TempEmailItem."Plaintext Formatted" := FALSE;
        TempEmailItem."Message Type" := TempEmailItem."Message Type"::"From Email Body Template";
        TempEmailItem."Body File Path" := FilePath;
        TempEmailItem.INSERT();
        COMMIT();

        MailManagement.InitializeFrom(TRUE, TRUE);
        IF MailManagement.IsEnabled THEN
            MailManagement.Send(TempEmailItem)
    end;

    var
        FilePath: Text;
        Text000: Label 'Workload - Seven Summits (Week %1 -%2).';
        TotalExpectedHours: Decimal;
}

