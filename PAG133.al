pageextension 50063 PostedSalesInvSubExt extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("Auto. Acc. Group")
        {
            field("Shipment Date"; "Shipment Date")
            {
                ApplicationArea = All;
            }
        }
    }
}

