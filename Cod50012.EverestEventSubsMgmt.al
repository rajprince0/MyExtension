codeunit 50012 "Everest Event & Subs. Mgmt."
{
    // version EVRG,EVUK

    // EVRG 190328 New Object

    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Bill-to Customer No.', false, false)]
    local procedure T36_OnAfterValidateEven_BilltoCustomerNo(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        Cust: Record Customer;
    begin
        Cust.GET(Rec."Bill-to Customer No.");
        IF Rec."External Document No." = '' THEN
            Rec."External Document No." := Cust."External Document No.";
    end;

    [EventSubscriber(ObjectType::Table, 951, 'OnAfterValidateEvent', 'Job No.', false, false)]
    local procedure T951_OnAfterValidateEvent_JobNo(var Rec: Record "Time Sheet Line"; var xRec: Record "Time Sheet Line"; CurrFieldNo: Integer)
    var
        JobTask2: Record "Job Task";
    begin
        IF (Rec."Job No." <> '') AND (Rec."Job Task No." = '') AND (Rec.Type = Rec.Type::Job) THEN BEGIN
            JobTask2.SETRANGE("Job No.", Rec."Job No.");
            JobTask2.SETRANGE("Job Task Type", JobTask2."Job Task Type"::Posting);
            IF JobTask2.COUNT = 1 THEN BEGIN
                JobTask2.FINDFIRST;
                Rec.VALIDATE("Job Task No.", JobTask2."Job Task No.");
            END;
        END;

        Rec.CALCFIELDS("Job Description");
        Rec.CALCFIELDS("Job Task Description");
    end;

    [EventSubscriber(ObjectType::Table, 951, 'OnBeforeValidateEvent', 'Job Task No.', false, false)]
    local procedure T951_OnBeforeValidateEvent_JobTaskNo(var Rec: Record "Time Sheet Line"; var xRec: Record "Time Sheet Line"; CurrFieldNo: Integer)
    var
        JobTask: Record "Job Task";
    begin
        IF Rec."Job Task No." <> '' THEN BEGIN
            IF Rec.Description = '' THEN
                Rec.Description := JobTask.Description;
        END;
    end;

    [EventSubscriber(ObjectType::Table, 951, 'OnAfterValidateEvent', 'Job Task No.', false, false)]
    local procedure T951_OnAfterValidateEvent_JobTaskNo(var Rec: Record "Time Sheet Line"; var xRec: Record "Time Sheet Line"; CurrFieldNo: Integer)
    begin
        Rec.CALCFIELDS("Job Task Description");
    end;

    [EventSubscriber(ObjectType::Page, 43, 'OnBeforeActionEvent', 'Post', false, false)]
    local procedure P43_OnBeforeActionEvent_Post(var Rec: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        DeferralTemplate: Record "Deferral Template";
    begin
        SalesLine.SETRANGE("Document Type", Rec."Document Type");
        SalesLine.SETRANGE("Document No.", Rec."No.");
        SalesLine.SETFILTER("Deferral Code", '<>%1', '');
        IF SalesLine.FINDSET THEN BEGIN
            REPEAT
                IF DeferralTemplate.GET(SalesLine."Deferral Code") AND DeferralTemplate."Deferral Revenue Check" THEN BEGIN
                    Rec.TESTFIELD("Deferral Purch. Inv. No.");
                    EXIT;
                END;
            UNTIL SalesLine.NEXT = 0;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure C80_OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    var
        SalesInvHeader: Record "Sales Invoice Header";
        DefRevenueSummary: Record "Deferral Revenue Summary";
    begin
        IF SalesInvHeader.GET(SalesInvHdrNo) OR (SalesInvHeader."Deferral Purch. Inv. No." = '') THEN
            EXIT;

        DefRevenueSummary.INIT;
        DefRevenueSummary.VALIDATE("Sales Invoice No.", SalesInvHeader."No.");
        DefRevenueSummary.VALIDATE("Purchase Invoice No.", SalesInvHeader."Deferral Purch. Inv. No.");
        DefRevenueSummary.INSERT(TRUE);
    end;

    [EventSubscriber(ObjectType::Table, 167, 'OnAfterValidateEvent', 'Customer Price Group', false, false)]
    local procedure T167_OnAfterValidateEvent_CustomerPriceGroup(VAR Rec: Record Job; VAR xRec: Record Job; CurrFieldNo: Integer)
    begin
        rec.CreateCustResPrice();
    end;

    [EventSubscriber(ObjectType::Table, 210, 'OnAfterValidateEvent', 'Job No.', false, false)]
    local procedure T210_OnAfterValidateEvent_JobNo(VAR Rec: Record "Job Journal Line"; VAR xRec: Record "Job Journal Line"; CurrFieldNo: Integer)
    var
        Cust: Record Customer;
    begin
        Rec.Validate("Gen. Bus. Posting Group", Cust."Gen. Bus. Posting Group");
    end;

    [EventSubscriber(ObjectType::Table, 167, 'OnAfterValidateEvent', 'Customer Price Group', false, false)]
    LOCAL procedure T167_OnAfterValidate_CustomerPriceGroup(VAR Rec: Record Job; VAR xRec: Record Job; CurrFieldNo: Integer)
    begin
        Rec.CreateCustResPrice();
    end;

    [EventSubscriber(ObjectType::Table, 952, 'OnAfterCopyFromTimeSheetLine', '', false, false)]
    local procedure T952_OnAfterCopyFromTimeSheetLine(VAR TimeSheetDetail: Record "Time Sheet Detail"; TimeSheetLine: Record "Time Sheet Line")
    var
        TimeSheetHeader: Record "Time Sheet Header";
    begin
        TimeSheetDetail."Job Sub Task No." := TimeSheetLine."Job Sub Task No.";
        TimeSheetHeader.GET(TimeSheetLine."Time Sheet No.");
        TimeSheetDetail."Resource No." := TimeSheetHeader."Resource No.";
    end;

    [EventSubscriber(ObjectType::Table, 210, 'OnAfterSetUpNewLine', '', false, false)]
    local procedure T210_OnAfterSetUpNewLine_JobJournalLine(VAR JobJournalLine: Record "Job Journal Line"; LastJobJournalLine: Record "Job Journal Line"; JobJournalTemplate: Record "Job Journal Template"; JobJournalBatch: Record "Job Journal Batch")
    begin
        JobJournalTemplate.GET(LastJobJournalLine."Journal Template Name");
        JobJournalBatch.GET(LastJobJournalLine."Journal Template Name", LastJobJournalLine."Journal Batch Name");
        JobJournalLine.SETRANGE("Journal Template Name", LastJobJournalLine."Journal Template Name");
        JobJournalLine.SETRANGE("Journal Batch Name", LastJobJournalLine."Journal Batch Name");
        IF NOT lastJobJournalLine.FINDFIRST THEN BEGIN
            JobJournalLine.Validate("Line Type", LastJobJournalLine."Line Type"::Billable);
        END;
    end;
}

