pageextension 50071 "CashFlowAvailExt" extends "Cash Flow Availability Lines"
{
    layout
    {
        modify(SalesOrders)
        {
            Visible = false;
        }
        modify(ServiceOrders)
        {
            Visible = false;
        }
        modify(SalesofFixedAssets)
        {
            Visible = false;
        }
        modify(ManualRevenues)
        {
            Caption = 'Cash Flow Manual Revenues';
        }
        modify(PurchaseOrders)
        {
            Visible = false;
        }
        modify(BudgetedFixedAssets)
        {
            Visible = false;
        }
        modify(Job)
        {
            Visible = false;
        }
        addafter(Total)
        {
            field("Sum"; CashFlowSum2)
            {
                ApplicationArea = Basic, Suite;
                AutoFormatExpression = FormatStr;
                AutoFormatType = 10;
                Caption = 'Sum';
                Style = Strong;
                StyleExpr = TRUE;
                ToolTip = 'Specifies total amounts.';

                trigger OnDrillDown()
                begin
                    CashFlowForecast.DrillDownEntriesFromSource(CashFlowForecast."Source Type Filter"::" ");
                end;
            }
        }
    }

    // trigger OnAfterGetRecord()
    // begin
    //     CashFlowForecast.CalculateAllAmounts(0D, "Period End", Amounts, CashFlowSum2);
    // end;

    var
        CashFlowSum2: Decimal;
        CashFlowForecast: Record "Cash Flow Forecast";
        RoundingFactorFormatString: Text;
        Amounts: Array[15] of Decimal;

    local procedure FormatStr(): Text
    begin
        EXIT(RoundingFactorFormatString);
    end;

}

