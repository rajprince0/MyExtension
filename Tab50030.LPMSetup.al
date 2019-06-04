table 50030 "LPM Setup"
{
    // version LPM

    // EVKK 190222 New Object

    Caption = 'LPM Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }
        field(2; "Company Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Company Name';
            TableRelation = Company.Name;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

