tableextension 51000 Cust_Extension extends Customer
{

    fields
    {
        field(50000; "External Document No."; Code[20])
        {
            Description = 'ERS 151008';
            DataClassification = CustomerContent;
            Caption = 'External Document No.';
        }
        field(50001; "Internal Customer"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Internal Customer';
        }
    }
}

