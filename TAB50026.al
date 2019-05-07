table 50026 "Internal Projects"
{


    fields
    {
        field(1; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = Job;
        }
    }

    keys
    {
        key(Key1; "Job No.")
        {
        }
    }

    fieldgroups
    {
    }
}

