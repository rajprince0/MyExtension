pageextension 50119 GLSetupExt extends "General Ledger Setup"
{
    // version NAVW110.00,PE7.00

    // #1..16
    // EVUK 190328 New Fields: "Deferral Sales Account","Deferral Purchase Account"
    layout
    {
        addafter("Bank Account Nos.")
        {
            field("Deferral Purchase Account"; "Deferral Purchase Account")
            {
                ApplicationArea = All;
            }
            field("Deferral Sales Account"; "Deferral Sales Account")
            {
                ApplicationArea = All;
            }
        }
    }
}

