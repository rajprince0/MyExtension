page 50112 "Billing Summary List"
{
    // version EVAK

    // EVAK 161102 New Object

    Caption = 'Billing Summary';
    Editable = false;
    PageType = List;
    SourceTable = "Time Sheet Header";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; "Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; "Ending Date")
                {
                    ApplicationArea = All;
                }
                field("Working Hours"; WorkingHours)
                {
                    ApplicationArea = All;
                    Caption = 'Working Hours';
                }
                field("Absence Hours"; AbsenceHours)
                {
                    ApplicationArea = All;
                    Caption = 'Absence Hours';
                }
                field("Billable Hours"; BillableHours)
                {
                    ApplicationArea = All;
                    Caption = 'Billable Hours';
                    DecimalPlaces = 1 : 1;
                }
                field("Billing Rate"; TotalBillingRate)
                {
                    ApplicationArea = All;
                    Caption = 'Billing Rate';
                    DecimalPlaces = 0 : 0;
                }
                field("Billing Rate(Scheduled)"; ActualBillingRate)
                {
                    ApplicationArea = All;
                    Caption = 'Billing Rate (Scheduled)';
                    DecimalPlaces = 0 : 0;
                }
                field("Billing Rate (Precense)"; PresenceBillingRate)
                {
                    ApplicationArea = All;
                    Caption = 'Billing Rate (Precense)';
                    DecimalPlaces = 0 : 0;
                }
                field("Total Amount"; TotalAmt)
                {
                    ApplicationArea = All;
                    Caption = 'Total Amount';
                    DecimalPlaces = 0 : 0;
                }
                field("Amount Per Worked Hour"; AmountPerWorkedHour)
                {
                    ApplicationArea = All;
                    Caption = 'Amount Per Worked Hour';
                    DecimalPlaces = 0 : 0;
                }
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
        AbsenceHours := BillMGT.CalcAbsenceQty(Rec);
        CALCFIELDS(Quantity);
        WorkingHours := Quantity - AbsenceHours;
    end;

    trigger OnOpenPage()
    begin
        SETFILTER("No.", '%1', '*' + (FORMAT(TODAY(), 0, '<Year><Week,2>')));
    end;

    var
        TimeSheetHeader: Record "Time Sheet Header";
        BillMGT: Codeunit "Billing Summary Calculation";
        TotalBillingRate: Decimal;
        BillableHours: Decimal;
        TotalAmt: Decimal;
        ActualBillingRate: Decimal;
        PresenceBillingRate: Decimal;
        AmountPerWorkedHour: Decimal;
        AbsenceHours: Decimal;
        WorkingHours: Decimal;
}

