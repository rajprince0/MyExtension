table 50014 "Assignee"
{

    Caption = 'Assignee';
    DrillDownPageID = "Assignee List";
    LookupPageID = "Assignee List";

    fields
    {
        field(1; Assignee; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Assignee)
        {
        }
    }

    fieldgroups
    {
    }
}

