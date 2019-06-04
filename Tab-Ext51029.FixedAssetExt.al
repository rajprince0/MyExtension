tableextension 51029 "FixedAssetExt" extends "Fixed Asset"
{

    fields
    {
        field(50000; "Purch. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Purch. No.';
            Description = 'EVRS 170117';
            TableRelation = "Purch. Inv. Header"."No.";
        }
        field(50001; "External Document No."; Code[35])
        {
            DataClassification = CustomerContent;
            Caption = 'External Document No.';
            Description = 'EVRS 170117';
        }
        field(50002; "IP Address"; Text[11])
        {
            DataClassification = CustomerContent;
            Caption = 'IP Address';
            Description = 'EVRS 170117';
        }
        field(50003; "Windows Edition"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Windows Edition';
            Description = 'EVRS 170117';
        }
        field(50004; "SQL Edition"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'SQL Edition';
            Description = 'EVRS 170117';
        }
        field(50005; "Installed Memory"; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Installed Memory';
            Description = 'EVRS 170117';
        }
        field(50006; "Unit Cost (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
            Description = 'EVRS 170117';
        }
        field(50007; "Licence Plate"; Text[6])
        {
            DataClassification = CustomerContent;
            Caption = 'Licence Plate';
            Description = 'EVRS 170117';
        }
        field(50008; "Sales Person"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Person';
            Description = 'EVRS 170117';
        }
        field(50009; Dealer; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Dealer';
            Description = 'EVRS 170117';
        }
        field(50010; "Sales Person Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Person Phone No.';
            Description = 'EVRS 170117';
        }
        field(50011; "Insurance Company"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Insurance Company';
            Description = 'EVRS 170117';
            TableRelation = Vendor;
        }
        field(50012; "Finance Corporation"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Finance Corporation';
            Description = 'EVRS 170117';
            TableRelation = Vendor;
        }
    }
}

