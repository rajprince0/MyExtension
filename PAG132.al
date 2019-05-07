pageextension 50062 PostedSalesInvoiceExt extends "Posted Sales Invoice"
{
    actions
    {
        addafter("&Navigate")
        {
            action("&Print None Job")
            {
                Caption = '&Print None Job';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                    REPORT.RUNMODAL(12047973, TRUE, FALSE, SalesInvHeader);
                end;

            }
        }
    }
    var
        SalesInvHeader: Record 112;
}

