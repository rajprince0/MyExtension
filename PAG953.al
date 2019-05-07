pageextension 50084 ManagerTimesheetext extends "Manager Time Sheet List"
{
    // version NAVW110.00

    // EVAK 161025 New FactBox : "Billing Summary"
    layout
    {
        addfirst(factboxes)
        {
            part("Billing Summary"; 50110)
            {
                Caption = 'Billing Summary';
                SubPageLink = "No." = FIELD ("No.");
                SubPageView = SORTING ("No.");
            }
        }
    }

    var
        TotalBillingRate: Decimal;
        BillableHours: Decimal;
        TotalAmt: Decimal;
        ActualBillingRate: Decimal;
        PresenceBillingRate: Decimal;
        AmountPerWorkedHour: Decimal;
}

