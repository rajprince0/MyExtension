tableextension 51001 "SaesHeaderExt" extends "Sales Header"
{
    // version NAVW110.00.00.17501,NAVSE10.00.00.17501,PE5.00

    // #1..9
    // ERS 151008 "External Document No." from customer
    // EVUK 190328 New Field : 50000-"Deferral Purch. Inv. No."
    fields
    {
        field(50000; "Deferral Purch. Inv. No."; Code[20])
        {
            Description = 'EVUK';
            Caption = 'Deferral Purch. Inv. No.';
        }
    }
}

