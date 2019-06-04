tableextension 51004 "DeferralTemplateExt" extends "Deferral Template"
{
    // version NAVW110.00

    // EVUK 190328 New Field : 50000 - "Deferral Revenue Check"
    fields
    {
        field(50000; "Deferral Revenue Check"; Boolean)
        {
            Caption = 'Deferral Revenue Check';
        }
    }
}

