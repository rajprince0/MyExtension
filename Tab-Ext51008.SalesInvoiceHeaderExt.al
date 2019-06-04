tableextension 51008 "SalesInvoiceHeaderExt" extends "Sales Invoice Header"
{
    // version NAVW110.00.00.15601,PE5.00

    // #1..4
    // ERS No change
    // EVUK 190328 New Field : 50000 -"Deferral Purch. Inv. No."
    fields
    {
        field(50000; "Deferral Purch. Inv. No."; Code[20])
        {
            Caption = 'Deferral Purch. Inv. No.';
            Description = 'EVUK';
        }
    }
}

