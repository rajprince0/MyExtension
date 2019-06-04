report 50011 "BillingSummary"
{

    DefaultLayout = RDLC;
    RDLCLayout = './BillingSummary.rdlc';


    dataset
    {
        dataitem(Resource; 156)
        {
            DataItemTableView = SORTING ("No.");
            column(BillableHours; ROUND(BillableHours, 0.01, '>'))
            {
            }
            column(Total_Amount; ROUND(TotalAmt, 0.01, '>'))
            {
            }
            column(Actual_Billing_Rate; ROUND(ActualBillingRate, 0.01, '>'))
            {
            }
            column(Presence_Billing_Rate; ROUND(PresenceBillingRate, 0.01, '>'))
            {
            }
            column(Amt_Per_Wrkd_Hour; ROUND(AmountPerWorkedHour, 0.01, '>'))
            {
            }
            column(Total_Billing_Hour; ROUND(TotalBillingRate, 0.01, '>'))
            {
            }
            column(Working_Hours; WorkingHours)
            {
            }
            column(Absence_Hours; ResAbsenceHours)
            {
            }
            column(CompanyName; COMPANYNAME())
            {
            }
            column(ResourceNo; ResourceNo)
            {
            }
            column(FilteredonRec; FilteredonRec)
            {
            }
            column(BillingSummaryCaption; BillingSummaryCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(BillableHours);
                CLEAR(TotalAmt);
                CLEAR(TotalScheduleQty);
                CLEAR(TotalPresncQty);
                CLEAR(AbsncQty);
                CLEAR(TotalBillingRate);
                CLEAR(ActualBillingRate);
                CLEAR(PresenceBillingRate);
                CLEAR(AmountPerWorkedHour);
                CLEAR(WorkingHours);
                CLEAR(AbsenceHours);
                CLEAR(ResAbsenceHours);

                TimeSheetHeader.SETRANGE("Resource No.", "No.");

                IF Str2 <> '' THEN
                    TimeSheetHeader.SETFILTER("No.", '%1..%2', STRSUBSTNO(Text000Lbl, "No.", Str1), STRSUBSTNO(Text000Lbl, "No.", Str2))
                ELSE
                    TimeSheetHeader.SETFILTER("No.", '%1', STRSUBSTNO(Text000Lbl, "No.", Str1));

                IF TimeSheetHeader.FINDSET() THEN
                    REPEAT

                        IF StartingDate = 0D THEN
                            StartingDate := TimeSheetHeader."Starting Date";

                        BillableHours += BillMGT.CalculateBillableHours(TimeSheetHeader);
                        TotalAmt += BillMGT.CalculateTotalAmt(TimeSheetHeader);
                        TotalScheduleQty += BillMGT.CalcActSchedQty(TimeSheetHeader);
                        TotalPresncQty += BillMGT.CalcPresenceQty(TimeSheetHeader);
                        AbsncQty += BillMGT.CalcAbsenceQty(TimeSheetHeader);
                        PresenceQty := TotalPresncQty - AbsncQty;
                        TotalBillingRate := CalcTotalBillingRate(BillableHours);
                        ActualBillingRate := CalcABR(BillableHours);
                        PresenceBillingRate := CalcPBR(BillableHours);
                        AmountPerWorkedHour := CalcAWPH(TotalAmt);
                        ResourceNo := TimeSheetHeader."Resource No.";
                        ResAbsenceHours += BillMGT.CalcAbsenceQty(TimeSheetHeader);

                        IF AbsenceQty <> AbsenceHours THEN
                            AbsenceHours += BillMGT.CalcAbsenceQty(TimeSheetHeader)
                        ELSE
                            AbsenceHours := BillMGT.CalcAbsenceQty(TimeSheetHeader);

                        TimeSheetHeader.CALCFIELDS(Quantity);
                        WorkingHours += TimeSheetHeader.Quantity - AbsenceHours;
                        AbsenceQty := AbsenceHours;

                    UNTIL TimeSheetHeader.NEXT() = 0;

                FilteredonRec := STRSUBSTNO('%1..%2', StartingDate, TimeSheetHeader."Ending Date");
            end;

            trigger OnPreDataItem()
            begin
                Str1 := COPYSTR(No, 3, 4);
                Str2 := COPYSTR(No, 11, 4);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(TimeSheetHeaderNo; No)
                {
                    TableRelation = "Time Sheet Header"."No.";
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Calender: Record Date;
        TimeSheetHeader: Record "Time Sheet Header";
        BillMGT: Codeunit "Billing Summary Calculation";
        Str1: Text;
        Str2: Text;
        No: Code[20];
        BillableHours: Decimal;
        TotalAmt: Decimal;
        ActualBillingRate: Decimal;
        PresenceBillingRate: Decimal;
        AmountPerWorkedHour: Decimal;
        AbsenceHours: Decimal;
        WorkingHours: Decimal;
        BillHours: Decimal;
        TotAmt: Decimal;
        TotalScheduleQty: Decimal;
        TotalPresncQty: Decimal;
        AbsncQty: Decimal;
        PresenceQty: Decimal;
        TotalBillingRate: Decimal;
        ResourceNo: Code[10];
        FilteredonRec: Text;
        BillingSummaryCaptionLbl: Label 'Billing Summary Details';
        CurrReportPageNoCaptionLbl: Label 'Page';
        Text000Lbl: Label '%1%2';
        StartingDate: Date;
        EndDate: Date;
        AbsenceQty: Decimal;
        ResAbsenceHours: Decimal;

    local procedure CalcTotalBillingRate(BillHours: Decimal) TBR: Decimal
    begin
        IF TotalScheduleQty <> 0 THEN
            TBR := (BillHours / TotalScheduleQty) * 100;
    end;

    local procedure CalcABR(BillHours: Decimal) ABR: Decimal
    begin
        IF TotalPresncQty <> 0 THEN
            ABR := (BillHours / TotalPresncQty) * 100;
    end;

    local procedure CalcPBR(BillHours: Decimal) PBR: Decimal
    begin
        IF PresenceQty <> 0 THEN
            PBR := (BillHours / PresenceQty) * 100;
    end;

    local procedure CalcAWPH(TotAmt: Decimal) APWH: Decimal
    begin
        IF PresenceQty <> 0 THEN
            APWH := (TotAmt / PresenceQty);
    end;
}

