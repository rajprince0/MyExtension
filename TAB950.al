tableextension 51019 TimeSheetHeaderExt extends "Time Sheet Header"
{
    fields
    {
        field(50000; "Chargeble Quantity"; Decimal)
        {
            CalcFormula = Sum ("Time Sheet Detail".Quantity WHERE ("Time Sheet No." = FIELD ("No."),
                                                                  Status = FIELD ("Status Filter"),
                                                                  "Job No." = FIELD ("Job No. Filter"),
                                                                  "Job Task No." = FIELD ("Job Task No. Filter"),
                                                                  Date = FIELD ("Date Filter"),
                                                                  Posted = FIELD ("Posted Filter"),
                                                                  Type = FIELD ("Type Filter"),
                                                                  Chargeable = CONST (TRUE)));
            Caption = 'Chargeble Quantity';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

