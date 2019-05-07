pageextension 50116 TrialBalanceExt extends "Trial Balance"
{
    // version NAVW110.00

    layout
    {
        modify(Description1)
        {
            Style = Strong;
            StyleExpr = TRue;
        }
        modify(Description8)
        {
            Style = Strong;
        }
        modify(CurrentPeriodValues1)
        {
            Style = Strong;
            StyleExpr = TRUE;
        }
        modify(CurrentPeriodValues8)
        {
            StyleExpr = GrossMarginPct1;
        }
        modify(CurrentPeriodMinusOneValues1)
        {
            Style = Strong;
            StyleExpr = TRUE;
        }
        modify(CurrentPeriodMinusOneValues8)
        {
            StyleExpr = GrossMarginPct2;
        }

    }

    var
        Values: array[9, 2] of Decimal;
        GrossMarginPct1: Text;
        GrossMarginPct2: Text;
        IncomeBeforeInterestAndTax1: Text;
        IncomeBeforeInterestAndTax2: Text;

    procedure SetStyles();
    begin
        //SetRedForNegativeBoldForPositiveStyle(4,1,GrossMarginPct1);
        //SetRedForNegativeBoldForPositiveStyle(4,2,GrossMarginPct2);

        SetRedForNegativeBoldForPositiveStyle(8, 1, GrossMarginPct1);
        SetRedForNegativeBoldForPositiveStyle(8, 2, GrossMarginPct2);

        SetRedForNegativeBoldForPositiveStyle(9, 1, IncomeBeforeInterestAndTax1);
        SetRedForNegativeBoldForPositiveStyle(9, 2, IncomeBeforeInterestAndTax2);

    end;

    procedure SetRedForNegativeBoldForPositiveStyle(RowNo: Integer; ColumnNo: Integer; VAR StyleText: Text)
    begin
        IF Values[RowNo, ColumnNo] < 0 THEN
            StyleText := 'Unfavorable'
        ELSE
            StyleText := 'Strong';
    end;
}

