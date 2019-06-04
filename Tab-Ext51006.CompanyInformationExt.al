tableextension 51006 "CompanyInformationExt" extends "Company Information"
{

    fields
    {
        field(50000; "Subsidiary Company Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Subsidiary Company Name';
            TableRelation = Company;
        }
    }
}

