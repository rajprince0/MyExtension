page 50009 "TM Status FactBox"
{
    // version EVTS

    // EVMC 150812 New Page
    // EVAR 150818 New Function - SetCurrRecFilters
    // EVAR 151013 ShowInvoicedQty

    Caption = 'TM Status';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = Job;

    layout
    {
        area(content)
        {
            field(Open; GetOpenQty())
            {
                ApplicationArea = All;
                Caption = 'Open';
                Editable = false;

                trigger OnDrillDown()
                begin
                    ShowDetail(TimeSheetDetail.Status::Open, FALSE);
                end;
            }
            field(Submitted; GetSubmittedQty())
            {
                ApplicationArea = All;
                Caption = 'Submitted';
                Editable = false;

                trigger OnDrillDown()
                begin
                    ShowDetail(TimeSheetDetail.Status::Submitted, FALSE);
                end;
            }
            field(Rejected; GetRejectedQty())
            {
                ApplicationArea = All;
                Caption = 'Rejected';
                Editable = false;

                trigger OnDrillDown()
                begin
                    ShowDetail(TimeSheetDetail.Status::Rejected, FALSE);
                end;
            }
            field(Approved; GetApprovedQty())
            {
                ApplicationArea = All;
                Caption = 'Approved';
                Editable = false;

                trigger OnDrillDown()
                begin
                    ShowDetail(TimeSheetDetail.Status::Approved, FALSE);
                end;
            }
            field(Posted; GetPostedQty())
            {
                ApplicationArea = All;
                Caption = 'Posted';

                trigger OnDrillDown()
                begin
                    ShowDetail(TimeSheetDetail.Status::Approved, TRUE);
                end;
            }
            field(Invoiced; GetInvoicedQty())
            {
                ApplicationArea = All;
                Caption = 'Invoiced';

                trigger OnDrillDown()
                begin
                    ShowInvoicedQty();
                end;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        COPYFILTERS(JobCurr);
    end;

    var
        TimeSheetDetail: Record "Time Sheet Detail";
        JobCurr: Record Job;
        FilVal: Text;

    procedure SetCurrRecFilters(var CurrRecFilter: Record Job)
    begin
        JobCurr.COPYFILTERS(CurrRecFilter);
    end;
}

