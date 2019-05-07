pageextension 50055 SalesInvoiceExt extends "Sales Invoice"
{
    // version NAVW110.00.00.17501,PE5.00

    // #1..7
    // EVUK 190328 New Field : 50000 -"Deferral Purch. Inv. No."
    layout
    {
        addafter("Job Queue Status")
        {
            field("Deferral Purch. Inv. No."; "Deferral Purch. Inv. No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

