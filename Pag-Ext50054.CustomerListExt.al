pageextension 50054 "CustomerListExt" extends "Customer List"
{
    layout
    {
        addafter("Country/Region Code")
        {
            field("Outstanding Orders"; "Outstanding Orders")
            {
                ApplicationArea = All;
            }
            field("Outstanding Invoices"; "Outstanding Invoices")
            {
                ApplicationArea = All;
            }
        }
        addafter("Base Calendar Code")
        {
            field("Internal Customer"; "Internal Customer")
            {
                ApplicationArea = All;
            }

        }
    }
}

