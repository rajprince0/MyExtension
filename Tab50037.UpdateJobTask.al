table 50037 "UpdateJobTask"
{

    fields
    {
        field(1; JobDate; Date)
        {
            DataClassification = CustomerContent;
        }
        field(2; Resource; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; JobTask; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; NewJobTask; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; Qty; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(6; NewDesc; Text[150])
        {
            DataClassification = CustomerContent;
        }
        field(7; OldDesc; Text[150])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; JobDate, Resource, JobTask, NewJobTask, NewDesc)
        {
        }
    }

    fieldgroups
    {
    }
}

