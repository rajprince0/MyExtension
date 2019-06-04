tableextension 51026 "JobTaskExt" extends "Job Task"
{

    fields
    {
        field(50000; "Project ID Harvest"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50001; "Task ID Harvest"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50002; "Quantity In Time Sheet"; Decimal)
        {

            CalcFormula = Sum ("Time Sheet Detail".Quantity WHERE ("Job No." = FIELD ("Job No."),
                                                                  "Job Task No." = FIELD ("Job Task No."),
                                                                  Date = FIELD ("Posting Date Filter")));
            Caption = 'Quantity In Time Sheet';
            FieldClass = FlowField;
        }
        field(50003; "Planned Quantity"; Decimal)
        {
            CalcFormula = Sum ("Job Planning Line".Quantity WHERE ("Job No." = FIELD ("Job No."),
                                                                  "Job Task No." = FIELD ("Job Task No."),
                                                                  "Job Task No." = FIELD (FILTER (Totaling)),
                                                                  "Schedule Line" = CONST (true),
                                                                  "Planning Date" = FIELD ("Planning Date Filter")));
            Caption = 'Planned Quantity';
            FieldClass = FlowField;
        }
    }
    keys
    {
    }

    local procedure "***EV***"()
    begin
    end;

    procedure BillableQty(Totaling: Text[250]) Qty: Decimal
    var
        TimeSheetDetail: Record 952;
    begin
        TimeSheetDetail.SETRANGE("Job No.", "Job No.");
        IF Totaling <> '' THEN
            TimeSheetDetail.SETFILTER("Job Task No.", Totaling)
        ELSE
            TimeSheetDetail.SETRANGE("Job Task No.", "Job Task No.");

        TimeSheetDetail.SETFILTER(Date, GETFILTER("Posting Date Filter"));
        IF TimeSheetDetail.FINDSET() THEN
            REPEAT
                TimeSheetDetail.CALCFIELDS(Chargeable);
                IF TimeSheetDetail.Chargeable THEN
                    Qty += TimeSheetDetail.Quantity;
            UNTIL TimeSheetDetail.NEXT() = 0;
    end;

    procedure BillableQtyIndid(Totaling: Text[250]) Qty: Decimal
    var
        CompInfo: Record 79;
        TimeSheetLine: Record 951;
        TimeSheetDetail: Record 952;
        Company: Record 2000000006;
    begin
        CompInfo.GET();

        IF NOT Company.GET(CompInfo."Subsidiary Company Name") THEN
            EXIT(0);

        TimeSheetDetail.CHANGECOMPANY(CompInfo."Subsidiary Company Name");
        TimeSheetLine.CHANGECOMPANY(CompInfo."Subsidiary Company Name");

        TimeSheetDetail.SETRANGE("Job No.", "Job No.");

        IF Totaling <> '' THEN
            TimeSheetDetail.SETFILTER("Job Task No.", Totaling)
        ELSE
            TimeSheetDetail.SETRANGE("Job Task No.", "Job Task No.");

        TimeSheetDetail.SETFILTER(Date, GETFILTER("Posting Date Filter"));
        IF TimeSheetDetail.FINDSET() THEN
            REPEAT
                IF TimeSheetLine.GET(TimeSheetDetail."Time Sheet No.", TimeSheetDetail."Time Sheet Line No.")
                AND TimeSheetLine.Chargeable THEN
                    Qty += TimeSheetDetail.Quantity;
            UNTIL TimeSheetDetail.NEXT() = 0;
    end;

    procedure GetTimeSheetQty(Totaling: Text[250]) Qty: Decimal
    var
        TimeSheetDetail: Record 952;
    begin
        TimeSheetDetail.SETRANGE("Job No.", "Job No.");
        IF Totaling <> '' THEN
            TimeSheetDetail.SETFILTER("Job Task No.", Totaling)
        ELSE
            TimeSheetDetail.SETRANGE("Job Task No.", "Job Task No.");

        TimeSheetDetail.SETFILTER(Date, GETFILTER("Posting Date Filter"));
        IF TimeSheetDetail.FINDSET() THEN
            REPEAT
                Qty += TimeSheetDetail.Quantity;
            UNTIL TimeSheetDetail.NEXT() = 0;
    end;

    procedure DrillDownTimeSheetQty()
    var
        TimeSheetDetail: Record "Time Sheet Detail";
    begin
        TimeSheetDetail.SETRANGE("Job No.", "Job No.");
        IF Totaling <> '' THEN
            TimeSheetDetail.SETFILTER("Job Task No.", Totaling)
        ELSE
            TimeSheetDetail.SETRANGE("Job Task No.", "Job Task No.");

        TimeSheetDetail.SETFILTER(Date, GETFILTER("Posting Date Filter"));
        PAGE.RUN(PAGE::"Time Sheet Detail", TimeSheetDetail);
    end;

    procedure DrillDownBillableQty()
    var
        TimeSheetDetail: Record "Time Sheet Detail";
    begin
        TimeSheetDetail.SETRANGE("Job No.", "Job No.");
        IF Totaling <> '' THEN
            TimeSheetDetail.SETFILTER("Job Task No.", Totaling)
        ELSE
            TimeSheetDetail.SETRANGE("Job Task No.", "Job Task No.");

        TimeSheetDetail.SETFILTER(Date, GETFILTER("Posting Date Filter"));
        TimeSheetDetail.SETFILTER(Chargeable, '%1', TRUE);
        PAGE.RUN(PAGE::"Time Sheet Detail", TimeSheetDetail);
    end;

    procedure DrillDownBillableQtyIndid()
    var
        CompInfo: Record "Company Information";
        TimeSheetLine: Record "Time Sheet Line";
        TimeSheetDetail: Record "Time Sheet Detail";
        Company: Record Company;
    begin
        CompInfo.GET();

        IF NOT Company.GET(CompInfo."Subsidiary Company Name") THEN
            EXIT;

        TimeSheetDetail.CHANGECOMPANY(CompInfo."Subsidiary Company Name");
        TimeSheetLine.CHANGECOMPANY(CompInfo."Subsidiary Company Name");

        TimeSheetDetail.SETRANGE("Job No.", "Job No.");

        IF Totaling <> '' THEN
            TimeSheetDetail.SETFILTER("Job Task No.", Totaling)
        ELSE
            TimeSheetDetail.SETRANGE("Job Task No.", "Job Task No.");

        TimeSheetDetail.SETFILTER(Date, GETFILTER("Posting Date Filter"));
        TimeSheetDetail.SETFILTER(Chargeable, '%1', TRUE);
        PAGE.RUN(PAGE::"Time Sheet Detail", TimeSheetDetail);
    end;
}

