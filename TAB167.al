tableextension 51011 JobExt extends Job
{
    fields
    {
        field(50000; Synch; Boolean)
        {
            DataClassification = CustomerContent;

        }
        field(50001; "External Description"; Text[50])
        {
            Caption = 'External Description';
            DataClassification = CustomerContent;
        }
        field(81404; "Bill-to"; Boolean)
        {
            Caption = 'Bill-to';
            DataClassification = CustomerContent;
            InitValue = true;
        }
    }

    local procedure "***EV***"()
    begin
    end;

    procedure GetOpenQty(): Decimal
    begin
        TimeSheetDetail.RESET();
        TimeSheetDetail.SETRANGE("Job No.", "No.");
        IF GETFILTER("Posting Date Filter") <> '' THEN
            TimeSheetDetail.SETFILTER(Date, GETFILTER("Posting Date Filter"));
        IF GETFILTER("Resource Filter") <> '' THEN
            TimeSheetDetail.SETFILTER("Resource No.", GETFILTER("Resource Filter"));
        TimeSheetDetail.SETRANGE(Status, TimeSheetDetail.Status::Open);
        TimeSheetDetail.CALCSUMS(Quantity);
        EXIT(TimeSheetDetail.Quantity);
    end;

    procedure GetSubmittedQty(): Decimal
    begin
        TimeSheetDetail.RESET();
        TimeSheetDetail.SETRANGE("Job No.", "No.");
        IF GETFILTER("Posting Date Filter") <> '' THEN
            TimeSheetDetail.SETFILTER(Date, GETFILTER("Posting Date Filter"));
        IF GETFILTER("Resource Filter") <> '' THEN
            TimeSheetDetail.SETFILTER("Resource No.", GETFILTER("Resource Filter"));
        TimeSheetDetail.SETRANGE(Status, TimeSheetDetail.Status::Submitted);
        TimeSheetDetail.CALCSUMS(Quantity);
        EXIT(TimeSheetDetail.Quantity);
    end;

    procedure GetRejectedQty(): Decimal
    begin
        TimeSheetDetail.RESET();
        TimeSheetDetail.SETRANGE("Job No.", "No.");
        IF GETFILTER("Posting Date Filter") <> '' THEN
            TimeSheetDetail.SETFILTER(Date, GETFILTER("Posting Date Filter"));
        IF GETFILTER("Resource Filter") <> '' THEN
            TimeSheetDetail.SETFILTER("Resource No.", GETFILTER("Resource Filter"));
        TimeSheetDetail.SETRANGE(Status, TimeSheetDetail.Status::Rejected);
        TimeSheetDetail.CALCSUMS(Quantity);
        EXIT(TimeSheetDetail.Quantity);
    end;

    procedure GetApprovedQty(): Decimal
    begin
        TimeSheetDetail.RESET();
        TimeSheetDetail.SETRANGE("Job No.", "No.");
        IF GETFILTER("Posting Date Filter") <> '' THEN
            TimeSheetDetail.SETFILTER(Date, GETFILTER("Posting Date Filter"));
        IF GETFILTER("Resource Filter") <> '' THEN
            TimeSheetDetail.SETFILTER("Resource No.", GETFILTER("Resource Filter"));
        TimeSheetDetail.SETRANGE(Status, TimeSheetDetail.Status::Approved);
        TimeSheetDetail.SETRANGE(Posted, FALSE);
        TimeSheetDetail.CALCSUMS(Quantity);
        EXIT(TimeSheetDetail.Quantity);
    end;

    procedure GetPostedQty(): Decimal
    begin
        TimeSheetDetail.RESET();
        TimeSheetDetail.SETRANGE("Job No.", "No.");
        IF GETFILTER("Posting Date Filter") <> '' THEN
            TimeSheetDetail.SETFILTER(Date, GETFILTER("Posting Date Filter"));
        IF GETFILTER("Resource Filter") <> '' THEN
            TimeSheetDetail.SETFILTER("Resource No.", GETFILTER("Resource Filter"));
        TimeSheetDetail.SETRANGE(Status, TimeSheetDetail.Status::Approved);
        TimeSheetDetail.SETRANGE(Posted, TRUE);
        TimeSheetDetail.CALCSUMS(Quantity);
        EXIT(TimeSheetDetail.Quantity);
    end;

    procedure ShowDetail(Status: Option Open,Submitted,Rejected,Approved,Posted; IfPosted: Boolean)
    var
        TimeSheetDetails: Page "Time Sheet Detail";
    begin
        TimeSheetDetail.RESET();
        TimeSheetDetail.FILTERGROUP(2);
        TimeSheetDetail.SETRANGE("Job No.", "No.");
        TimeSheetDetail.SETRANGE(Status, Status);
        IF Status = Status::Approved THEN
            TimeSheetDetail.SETRANGE(Posted, IfPosted);

        IF GETFILTER("Posting Date Filter") <> '' THEN
            TimeSheetDetail.SETFILTER(Date, GETFILTER("Posting Date Filter"));

        IF GETFILTER("Resource Filter") <> '' THEN
            TimeSheetDetail.SETFILTER("Resource No.", GETFILTER("Resource Filter"));

        TimeSheetDetail.FILTERGROUP(0);
        TimeSheetDetails.SETTABLEVIEW(TimeSheetDetail);
        TimeSheetDetails.RUN();
    end;

    procedure CreateCustResPrice()
    var
        JobResPrice: Record "Job Resource Price";
        CustJobResPrice: Record "Cust. Job Resource Price";
    begin
        IF (xRec."Customer Price Group" <> "Customer Price Group") THEN BEGIN
            JobResPrice.SETRANGE("Job No.", "No.");
            JobResPrice.DELETEALL();
        END;

        IF ("Customer Price Group" = '') THEN
            MESSAGE(Text50000Lbl, FIELDCAPTION("Customer Price Group"), TABLECAPTION(), "No.")
        ELSE BEGIN
            JobResPrice.SETRANGE("Job No.", "No.");
            JobResPrice.DELETEALL();
            CustJobResPrice.SETRANGE("Cust. Price Group", "Customer Price Group");
            IF CustJobResPrice.FINDSET(FALSE) THEN
                REPEAT
                    JobResPrice.INIT();
                    JobResPrice.VALIDATE("Job No.", "No.");
                    JobResPrice.VALIDATE(Type, CustJobResPrice.Type);
                    JobResPrice.VALIDATE(Code, CustJobResPrice.Code);
                    JobResPrice.VALIDATE("Work Type Code", CustJobResPrice."Work Type Code");
                    JobResPrice.VALIDATE("Currency Code", CustJobResPrice."Currency Code");
                    JobResPrice.VALIDATE("Unit Price", CustJobResPrice."Unit Price");
                    JobResPrice.VALIDATE("Line Discount %", CustJobResPrice."Line Discount %");
                    JobResPrice.Description := CustJobResPrice.Description;
                    JobResPrice.INSERT(TRUE);
                UNTIL CustJobResPrice.NEXT() = 0
            ELSE BEGIN
                MESSAGE(Text50001Lbl, FIELDCAPTION("Customer Price Group"), "Customer Price Group");
                JobResPrice.SETRANGE("Job No.", "No.");
                JobResPrice.DELETEALL();
            END;
        END;
    end;

    procedure ShowInvoicedQty()
    var
        JobPlanningLineInv: Record "Job Planning Line Invoice";

    begin
        FilterJPLI(JobPlanningLineInv);
        PAGE.RUNMODAL(PAGE::"Job Invoices", JobPlanningLineInv);
    end;

    procedure GetInvoicedQty(): Decimal
    var
        JobPlanningLineInv: Record "Job Planning Line Invoice";
    begin
        FilterJPLI(JobPlanningLineInv);
        JobPlanningLineInv.CALCSUMS("Quantity Transferred");
        EXIT(JobPlanningLineInv."Quantity Transferred");
    end;

    procedure ShowTotalPostedQty()
    var
        JobLedgerEntry: Record "Job Ledger Entry";
    begin
        FilterJLE(JobLedgerEntry);
        PAGE.RUNMODAL(PAGE::"Job Ledger Entries", JobLedgerEntry);
    end;

    procedure GetTotalPostedQty(): Decimal
    var
        JobLedgerEntry: Record "Job Ledger Entry";
    begin
        FilterJLE(JobLedgerEntry);
        JobLedgerEntry.CALCSUMS(Quantity);
        EXIT(JobLedgerEntry.Quantity);
    end;

    procedure GetPostedAmt(): Decimal
    var
        JobLedgerEntry: Record "Job Ledger Entry";
    begin
        FilterJLE(JobLedgerEntry);
        JobLedgerEntry.CALCSUMS("Line Amount");
        EXIT(JobLedgerEntry."Line Amount");
    end;

    procedure GetInvoicedAmt(): Decimal
    var
        JobPlanningLineInv: Record "Job Planning Line Invoice";
    begin
        FilterJPLI(JobPlanningLineInv);
        JobPlanningLineInv.CALCSUMS("Invoiced Amount (LCY)");
        EXIT(JobPlanningLineInv."Invoiced Amount (LCY)");
    end;

    procedure FilterJLE(var JobLedgerEntry: Record "Job Ledger Entry")
    var
        JobsSetup: Record "Jobs Setup";
    begin
        JobsSetup.GET();
        JobLedgerEntry.RESET();
        JobLedgerEntry.SETCURRENTKEY("Job No.", "Entry Type");
        JobLedgerEntry.FILTERGROUP(2);
        JobLedgerEntry.SETRANGE("Job No.", "No.");
        JobLedgerEntry.SETFILTER("Entry Type", 'Usage');
        IF GETFILTER("Posting Date Filter") <> '' THEN
            JobLedgerEntry.SETFILTER("Posting Date", GETFILTER("Posting Date Filter"))
        ELSE
            JobLedgerEntry.SETFILTER("Posting Date", '<>%1', 0D);
        JobLedgerEntry.FILTERGROUP(0);
    end;

    procedure FilterJPLI(var JobPlanningLineInv: Record "Job Planning Line Invoice")
    begin
        JobPlanningLineInv.RESET();
        JobPlanningLineInv.FILTERGROUP(2);
        JobPlanningLineInv.SETRANGE("Job No.", "No.");
        IF GETFILTER("Posting Date Filter") <> '' THEN
            JobPlanningLineInv.SETFILTER("Invoiced Date", GETFILTER("Posting Date Filter"))
        ELSE
            JobPlanningLineInv.SETFILTER("Invoiced Date", '<>%1', 0D);
        JobPlanningLineInv.FILTERGROUP(0);
    end;

    procedure GetArchivedQty(): Decimal
    var
        TimeSheetDetailArchive: Record "Time Sheet Detail Archive";
    begin
        TimeSheetDetailArchive.RESET();
        TimeSheetDetailArchive.SETRANGE("Job No.", "No.");
        IF GETFILTER("Posting Date Filter") <> '' THEN
            TimeSheetDetailArchive.SETFILTER(Date, GETFILTER("Posting Date Filter"));
        IF GETFILTER("Resource Filter") <> '' THEN
            TimeSheetDetailArchive.SETFILTER("Resource No.", GETFILTER("Resource Filter"));
        TimeSheetDetailArchive.CALCSUMS(Quantity);
        EXIT(TimeSheetDetailArchive.Quantity);
    end;

    procedure ShowDetails()
    var
        TimeSheetDetailArchive: Record "Time Sheet Detail Archive";
        TimeSheetDetailsArchive: Page "Time Sheet Details Archive";
    begin
        TimeSheetDetailArchive.RESET();
        TimeSheetDetailArchive.FILTERGROUP(2);
        TimeSheetDetailArchive.SETRANGE("Job No.", "No.");

        IF GETFILTER("Posting Date Filter") <> '' THEN
            TimeSheetDetailArchive.SETFILTER(Date, GETFILTER("Posting Date Filter"));

        IF GETFILTER("Resource Filter") <> '' THEN
            TimeSheetDetailArchive.SETFILTER("Resource No.", GETFILTER("Resource Filter"));

        TimeSheetDetailArchive.FILTERGROUP(0);
        TimeSheetDetailsArchive.SETTABLEVIEW(TimeSheetDetailArchive);
        TimeSheetDetailsArchive.RUN();
    end;

    procedure FilterJPL(var JobPlanningLine: Record "Job Planning Line")
    begin
        JobPlanningLine.RESET();
        JobPlanningLine.FILTERGROUP(2);
        JobPlanningLine.SETRANGE("Job No.", "No.");
        IF GETFILTER("Posting Date Filter") <> '' THEN
            JobPlanningLine.SETFILTER("Planning Date", GETFILTER("Planning Date Filter"))
        ELSE
            JobPlanningLine.SETFILTER("Planning Date", '<>%1', 0D);
        JobPlanningLine.FILTERGROUP(0);
    end;

    procedure ShowQtyToInvoice()
    var
        JobPlanningLine: Record 1003;
    begin
        FilterJPL(JobPlanningLine);
        PAGE.RUNMODAL(PAGE::"Job Planning Lines", JobPlanningLine);
    end;

    procedure GetQtyToInvoice(): Decimal
    var
        JobPlanningLine: Record 1003;
    begin
        FilterJPL(JobPlanningLine);
        JobPlanningLine.CALCSUMS("Qty. to Invoice");
        EXIT(JobPlanningLine."Qty. to Invoice");
    end;

    var
        "*EV*": Integer;
        TimeSheetDetail: Record 952;
        Text50000Lbl: Label 'There is no %1 selected for %2 %3, Resource prices wil not be created.';
        Text50001Lbl: Label 'There are no Resource Prices created for %1 %2, Resource prices wil not be created.';
}

