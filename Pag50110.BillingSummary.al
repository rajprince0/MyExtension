page 50110 "Billing Summary"
{
    // version EVAK

    // EVAK 161102 New Object

    Caption = 'Billing Summary';
    PageType = CardPart;
    SourceTable = "Time Sheet Header";

    layout
    {
        area(content)
        {
            field("Billable Hours"; BillableHours)
            {
                Caption = 'Billable Hours';
                DecimalPlaces = 1 : 1;
                ApplicationArea = All;
            }
            field("Billing Rate"; TotalBillingRate)
            {
                Caption = 'Billing Rate';
                DecimalPlaces = 0 : 0;
                ApplicationArea = All;
            }
            field("Billing Rate(Scheduled)"; ActualBillingRate)
            {
                Caption = 'Billing Rate (Scheduled)';
                DecimalPlaces = 0 : 0;
                ApplicationArea = All;
            }
            field("Billing Rate (Precense)"; PresenceBillingRate)
            {
                Caption = 'Billing Rate (Precense)';
                DecimalPlaces = 0 : 0;
                ApplicationArea = All;
            }
            field("Total Amount"; TotalAmt)
            {
                Caption = 'Total Amount';
                DecimalPlaces = 0 : 0;
                ApplicationArea = All;
            }
            field("Amount Per Worked Hour"; AmountPerWorkedHour)
            {
                Caption = 'Amount Per Worked Hour';
                DecimalPlaces = 0 : 0;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        BillableHours := BillMGT.CalculateBillableHours(Rec);
        TotalBillingRate := BillMGT.CalculateTotalBillingRate(Rec);
        ActualBillingRate := BillMGT.CalculateActualBillingRate(Rec);
        TotalAmt := BillMGT.CalculateTotalAmt(Rec);
        PresenceBillingRate := BillMGT.CalculatePresenceBillingRate(Rec);
        AmountPerWorkedHour := BillMGT.CalculateAmountWorkedperHour(Rec);
    end;

    var
        BillMGT: Codeunit "Billing Summary Calculation";
        TotalBillingRate: Decimal;
        BillableHours: Decimal;
        TotalAmt: Decimal;
        ActualBillingRate: Decimal;
        PresenceBillingRate: Decimal;
        AmountPerWorkedHour: Decimal;
}

