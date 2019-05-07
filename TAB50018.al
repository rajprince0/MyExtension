table 50018 "Task Budget Entry"
{

    DrillDownPageID = 50017;
    LookupPageID = 50017;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Job Sub Task No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Sub Task No.';
            TableRelation = "Job Sub Task";
        }
        field(3; "Resource No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Resource No.';
            TableRelation = Resource;
        }
        field(4; Budget; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Budget';
        }
        field(5; "Utilised Hours"; Decimal)
        {
            CalcFormula = Sum ("Time Sheet Detail".Quantity WHERE ("Job Sub Task No." = FIELD ("Job Sub Task No."),
                                                                  "Resource No." = FIELD ("Resource No."),
                                                                  Chargeable = CONST (TRUE)));
            Caption = 'Utilised Hours';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Time Sheet Detail".Quantity WHERE ("Job Sub Task No." = FIELD ("Job Sub Task No."),
                                                                "Resource No." = FIELD ("Resource No."));
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Job Sub Task No.")
        {
        }
    }

    fieldgroups
    {
    }
}

