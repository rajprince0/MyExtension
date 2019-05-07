pageextension 50059 JobListExt extends "Job List"
{
    layout
    {
        addafter("% Invoiced")
        {
            field(Open; GetOpenQty())
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    ShowDetail(TimeSheetDetail.Status::Open, FALSE);
                end;
            }
            field("Submitted Qty"; GetSubmittedQty())
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    ShowDetail(TimeSheetDetail.Status::Submitted, FALSE);
                end;
            }
            field("Rejected Qty"; GetRejectedQty())
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    ShowDetail(TimeSheetDetail.Status::Rejected, FALSE);
                end;
            }
            field("Approved Qty"; GetApprovedQty())
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    ShowDetail(TimeSheetDetail.Status::Approved, FALSE);
                end;
            }
            field("Archived Quantity"; GetArchivedQty())
            {
                ApplicationArea = All;
                Caption = 'Archived Quantity';

                trigger OnDrillDown()
                begin
                    ShowDetails();
                end;
            }
            field("Posted Qty"; GetPostedQty())
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    ShowDetail(TimeSheetDetail.Status::Approved, TRUE);
                end;
            }
            field("Total Posted Quantity"; GetTotalPostedQty())
            {
                Caption = 'Total Posted Quantity';
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    ShowTotalPostedQty();
                end;
            }
            field("Posted Amt"; GetPostedAmt())
            {
                Caption = 'Posted Amt';
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    ShowTotalPostedQty();
                end;
            }
            field("Qty. to Invoice"; GetQtyToInvoice())
            {
                Caption = 'Qty. to Invoice';
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    ShowQtyToInvoice();
                end;
            }
            field("Invoiced Qty"; GetInvoicedQty())
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    ShowInvoicedQty();
                end;
            }
            field("Invoiced Amt"; GetInvoicedAmt())
            {
                Caption = 'Invoiced Amt';
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    ShowInvoicedQty();
                end;
            }
        }
        addafter(Control1900383207)
        {
            part(TMStatusFactBox; 50009)
            {
                Caption = 'TM Status';
                SubPageLink = "No." = FIELD ("No.");
                UpdatePropagation = SubPart;
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Insertion (Name) on "Action 1903691404".



        //Unsupported feature: Code Insertion on ""Report Job Create Sales Invoice"(Action 1903691404)".


        //Unsupported feature: Property Deletion (RunObject) on "Action 1903691404".

        addafter("Job Task &Lines")
        {
            action("Time Sheet Detail")
            {
                Caption = 'Time Sheet Detail';
                Image = JobTimeSheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50010;
                RunPageLink = "Job No." = FIELD ("No.");
            }
        }
        addafter("Ledger E&ntries")
        {
            action("Page Everest Job Journal")
            {
                Caption = 'Job Journal';
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    EverestJobJournal: Page "Everest Job Journal";
                begin
                    EverestJobJournal.SetJobNo("No.");
                    EverestJobJournal.RUNMODAL();
                end;
            }
        }
    }

    var
        TimeSheetDetail: Record "Time Sheet Detail";
        TimeSheetDetailArchive: Record "Time Sheet Detail Archive";

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.TMStatusFactBox.PAGE.SetCurrRecFilters(Rec);
    end;
}

