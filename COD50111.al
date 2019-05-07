codeunit 50111 "Billing Summary Calculation"
{
    trigger OnRun()
    begin
    end;

    procedure GetTotalAmount(JobNo: Code[20]; JobTaskNo: Code[20]; Quantity: Decimal; WorkTypeCode: Code[10]; TimeSheetHeader: Record 950): Decimal
    var
        JobJnlLine: Record 210 temporary;
    begin
        JobJnlLine.SuspendStatusCheck(TRUE);
        JobJnlLine.INIT();
        JobJnlLine.VALIDATE("Job No.", JobNo);
        JobJnlLine.VALIDATE("Job Task No.", JobTaskNo);
        JobJnlLine.VALIDATE("Time Sheet No.", TimeSheetHeader."No.");
        JobJnlLine.VALIDATE("No.", TimeSheetHeader."Resource No.");
        JobJnlLine.VALIDATE("Work Type Code", WorkTypeCode);
        JobJnlLine.VALIDATE(Quantity, Quantity);
        JobJnlLine.INSERT();
        EXIT(JobJnlLine."Line Amount");
    end;

    procedure CalcActSchedQty(TimeSheetHeader: Record 950) TotalSchedQty: Decimal
    var
        Resource: Record Resource;
        Calendar: Record 2000000007;
    begin
        Resource.GET(TimeSheetHeader."Resource No.");
        FilterCalender(Calendar, TimeSheetHeader);
        IF Calendar.FINDSET() THEN
            REPEAT
                Resource.SETRANGE("Date Filter", Calendar."Period Start");
                Resource.CALCFIELDS(Capacity);
                TotalSchedQty += Resource.Capacity;
            UNTIL Calendar.NEXT() = 0;
        EXIT(TotalSchedQty);
    end;

    procedure CalcPresenceQty(TimeSheetHeader: Record 950) TotalPresenceQty: Decimal
    var
        Calendar: Record 2000000007;
    begin
        TotalPresenceQty := 0;
        TimeSheetHeader.GET(TimeSheetHeader."No.");
        FilterCalender(Calendar, TimeSheetHeader);
        IF Calendar.FINDSET() THEN
            REPEAT
                TimeSheetHeader.SETRANGE("Date Filter", Calendar."Period Start");
                TimeSheetHeader.CALCFIELDS(Quantity);
                TotalPresenceQty += TimeSheetHeader.Quantity;
            UNTIL Calendar.NEXT() = 0;

        EXIT(TotalPresenceQty);
    end;

    procedure FilterCalender(var Calendar: Record 2000000007; TimeSheetHeader: Record 950)
    begin
        Calendar.SETRANGE("Period Type", Calendar."Period Type"::Date);
        Calendar.SETRANGE("Period Start", TimeSheetHeader."Starting Date", TimeSheetHeader."Ending Date");
    end;

    procedure CalcAbsenceQty(TimeSheetHeader: Record 950) AbsenceQty: Decimal
    begin
        TimeSheetHeader.GET(TimeSheetHeader."No.");
        TimeSheetHeader.SETRANGE("Type Filter", TimeSheetHeader."Type Filter"::Absence);
        TimeSheetHeader.SETRANGE("Date Filter", TimeSheetHeader."Starting Date", TimeSheetHeader."Ending Date");
        TimeSheetHeader.CALCFIELDS(Quantity);
        AbsenceQty := TimeSheetHeader.Quantity;
        EXIT(AbsenceQty);
    end;

    procedure CalculateBillableHours(TimeSheetHeader: Record 950) BillableHours: Decimal
    var
        TimeSheetDetail: Record 952;
        Cust: Record 18;
        Job: Record 167;
    begin
        CLEAR(BillableHours);
        TimeSheetDetail.SETRANGE("Time Sheet No.", TimeSheetHeader."No.");
        IF TimeSheetDetail.FINDSET() THEN
            REPEAT
                IF Job.GET(TimeSheetDetail."Job No.") THEN BEGIN
                    Cust.GET(Job."Bill-to Customer No.");
                    TimeSheetDetail.CALCFIELDS(Chargeable);
                    IF NOT Cust."Internal Customer" AND TimeSheetDetail.Chargeable THEN
                        BillableHours += TimeSheetDetail.Quantity;
                END;
            UNTIL TimeSheetDetail.NEXT() = 0;
    end;

    procedure CalculateTotalBillingRate(TimeSheetHeader: Record "Time Sheet Header") TotalBillingRate: Decimal
    var
        BillableHours: Decimal;
        TotalScheduleQuantity: Decimal;
    begin
        TotalScheduleQuantity := CalcActSchedQty(TimeSheetHeader);
        BillableHours := CalculateBillableHours(TimeSheetHeader);
        IF TotalScheduleQuantity <> 0 THEN
            TotalBillingRate := (BillableHours / TotalScheduleQuantity) * 100;
    end;

    procedure CalculateActualBillingRate(TimeSheetHeader: Record "Time Sheet Header") ActualBillingRate: Decimal
    var
        BillableHours: Decimal;
        TotalPresenceQty: Decimal;
    begin
        TotalPresenceQty := CalcPresenceQty(TimeSheetHeader);
        BillableHours := CalculateBillableHours(TimeSheetHeader);
        IF TotalPresenceQty <> 0 THEN
            ActualBillingRate := (BillableHours / TotalPresenceQty) * 100;
    end;

    procedure CalculateTotalAmt(TimeSheetHeader: Record "Time Sheet Header") TotalAmt: Decimal
    var
        TimeSheetDetail: Record "Time Sheet Detail";
        Cust: Record Customer;
        Job: Record Job;
    begin
        TimeSheetDetail.SETRANGE("Time Sheet No.", TimeSheetHeader."No.");
        IF TimeSheetDetail.FINDSET() THEN
            REPEAT
                IF Job.GET(TimeSheetDetail."Job No.") THEN BEGIN
                    Cust.GET(Job."Bill-to Customer No.");
                    TimeSheetDetail.CALCFIELDS(Chargeable, "Work Type Code");
                    IF NOT Cust."Internal Customer" AND TimeSheetDetail.Chargeable THEN
                        TotalAmt += GetTotalAmount(TimeSheetDetail."Job No.", TimeSheetDetail."Job Task No.", TimeSheetDetail.Quantity, TimeSheetDetail."Work Type Code", TimeSheetHeader);
                END;
            UNTIL TimeSheetDetail.NEXT() = 0;
    end;

    procedure CalculatePresenceBillingRate(TimeSheetHeader: Record "Time Sheet Header") PresenceBillingRate: Decimal
    var
        BillableHours: Decimal;
        TotalPresenceQty: Decimal;
        PresenceQty: Decimal;
        AbsenceQty: Decimal;
    begin
        TotalPresenceQty := CalcPresenceQty(TimeSheetHeader);
        AbsenceQty := CalcAbsenceQty(TimeSheetHeader);
        PresenceQty := TotalPresenceQty - AbsenceQty;
        BillableHours := CalculateBillableHours(TimeSheetHeader);
        IF PresenceQty <> 0 THEN
            PresenceBillingRate := (BillableHours / PresenceQty) * 100;
    end;

    procedure CalculateAmountWorkedperHour(TimeSheetHeader: Record "Time Sheet Header") AmountPerWorkedHour: Decimal
    var
        TotalPresenceQty: Decimal;
        PresenceQty: Decimal;
        AbsenceQty: Decimal;
        TotalAmount: Decimal;
    begin
        TotalPresenceQty := CalcPresenceQty(TimeSheetHeader);
        AbsenceQty := CalcAbsenceQty(TimeSheetHeader);
        PresenceQty := TotalPresenceQty - AbsenceQty;
        TotalAmount := CalculateTotalAmt(TimeSheetHeader);
        IF PresenceQty <> 0 THEN
            AmountPerWorkedHour := (TotalAmount / PresenceQty);
    end;
}

