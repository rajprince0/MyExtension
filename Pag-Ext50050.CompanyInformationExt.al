pageextension 50050 "CompanyInformationExt" extends "Company Information"
{
    layout
    {
        addafter("Registered Office")
        {
            field("Subsidiary Company Name"; "Subsidiary Company Name")
            {
                ApplicationArea = All;
                Caption ='Subsidiary Company Name';
            }
        }
    }
}

