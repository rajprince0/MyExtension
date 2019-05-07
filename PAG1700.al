pageextension 50117 DeferralTemplateCardExt extends "Deferral Template Card"
{
    // version NAVW110.00

    // EVUK 190328 New Field : 50000 - "Deferral Revenue Check"
    layout
    {
        addafter("Deferral Account")
        {
            field("Deferral Revenue Check"; "Deferral Revenue Check")
            {
                ApplicationArea = All;
            }
        }
    }
}

