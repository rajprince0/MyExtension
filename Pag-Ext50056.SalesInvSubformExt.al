pageextension 50056 "SalesInvSubformExt" extends "Sales Invoice Subform"
{
    layout
    {

        //Unsupported feature: Property Insertion (Name) on "Control 14".

        addafter("Location Code")
        {
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addafter("Auto. Acc. Group")
        {
            field("Shipment Date"; "Shipment Date")
            {
                ApplicationArea = All;
            }
        }
    }
}

