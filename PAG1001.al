pageextension 50076 JobTasklinesSubExt extends "Job Task Lines Subform"
{
    layout
    {
        addafter("End Date")
        {
            field("Planned Quantity"; "Planned Quantity")
            {
                ApplicationArea = All;
            }
            field("Quantity In Time Sheet"; GetTimeSheetQty(Totaling))
            {
                Caption = 'Quantity In Time Sheet';
                ApplicationArea = All;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    DrillDownTimeSheetQty();
                end;
            }
            field("Billable Quantity"; BillableQty(Totaling))
            {
                Caption = 'Billable Quantity';
                ApplicationArea = All;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    DrillDownBillableQty();
                end;
            }
            field("Billable Qty. Indi:d"; BillableQtyIndid(Totaling))
            {
                Caption = 'Billable Qty. Indi:d';
                Visible = false;
                ApplicationArea = All;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    DrillDownBillableQtyIndid();
                end;
            }
        }
    }
}

