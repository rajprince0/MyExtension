pageextension 50118 "DeferralTemplateListExt" extends "Deferral Template List"
{
    // version NAVW110.00

    // EVUK 190328 New Field : 50000 - "Deferral Revenue Check"
    layout
    {
        addafter("Period Description")
        {
            field("Deferral Revenue Check"; "Deferral Revenue Check")
            {
                ApplicationArea = All;
            }
        }
    }
}

