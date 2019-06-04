report 50008 "Update Length in Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Update Length in Invoice.rdlc';

    dataset
    {
        dataitem(SalesLine; 37)
        {

            trigger OnAfterGetRecord()
            begin
                Description := COPYSTR(Description, 1, 50);
                MODIFY();
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

