pageextension 50077 "JobTaskLinesExt" extends "Job Task Lines"
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
                ApplicationArea = All;
                Caption = 'Quantity In Time Sheet';

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
                    //>>EVPK 180116
                    DrillDownBillableQty();
                    //<<EVPK 180116
                end;
            }
            field("Billable Qty. Indi:d"; BillableQtyIndid(Totaling))
            {
                Caption = 'Billable Qty. Indi:d';
                Visible = false;
                ApplicationArea = All;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    //>>EVPK 180116
                    DrillDownBillableQtyIndid();
                    //<<EVPK 180116
                end;
            }
        }
        addafter("Amt. Rcd. Not Invoiced")
        {
            field("Project ID Harvest"; "Project ID Harvest")
            {
                ApplicationArea = All;
            }
            field("Task ID Harvest"; "Task ID Harvest")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Job &Task Card")
        {
            action("Job Sub Task Lines")
            {
                Promoted = true;
                ApplicationArea = All;
                Image = Default;
                RunObject = Page "Job Sub Task Lines";
                RunPageLink = "Job Sub Task No." = FIELD ("Job No."),
                              "Job No." = FIELD ("Job Task No.");
                RunPageView = SORTING ("Job Sub Task No.");
            }
        }
    }
}

