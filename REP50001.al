report 50001 "Suggest Job Jnl. Lines Indi:d"
{


    Caption = 'Suggest Job Jnl. Lines';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Job; 167)
        {
            RequestFilterFields = "No.", "Person Responsible";

            trigger OnAfterGetRecord()
            var
                TimeSheetMgt: Codeunit "Time Sheet Management";
            begin
                DateFilter := TimeSheetMgt.GetDateFilter(StartingDate, EndingDate);
                FillJobJnlLineBuffer();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartingDate; StartingDate)
                    {
                        Caption = 'Starting Date';
                        ApplicationArea = All;
                    }
                    field(EndingDate; EndingDate)
                    {
                        Caption = 'Ending Date';
                        ApplicationArea = all;
                    }
                    field(ResourceNoFilter; ResourceNoFilter)
                    {
                        Caption = 'Resource No. Filter';
                        TableRelation = Resource;
                        ApplicationArea = all;
                    }
                    field(JobNoFilter; JobNoFilter)
                    {
                        Caption = 'Job No. Filter';
                        TableRelation = Job."No." WHERE (Synch = CONST (true));
                        Visible = false;
                        ApplicationArea = all;
                    }
                    field(JobTaskNoFilter; JobTaskNoFilter)
                    {
                        Caption = 'Job Task No. Filter';
                        Visible = false;
                        ApplicationArea = all;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            JobTask: Record "Job Task";
                        begin
                            JobTask.FILTERGROUP(2);
                            IF JobNoFilter <> '' THEN
                                JobTask.SETFILTER("Job No.", JobNoFilter);
                            JobTask.FILTERGROUP(0);
                            IF PAGE.RUNMODAL(PAGE::"Job Task List", JobTask) = ACTION::LookupOK THEN
                                JobTask.TESTFIELD("Job Task Type", JobTask."Job Task Type"::Posting);
                            JobTaskNoFilter := JobTask."Job Task No.";
                        end;
                    }
                    field(CompanyName2; CompanyName2)
                    {
                        Caption = 'Company Name';
                        TableRelation = Company;
                        ApplicationArea = all;
                    }
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

    trigger OnPostReport()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextDocNo: Code[20];
        LineNo: Integer;
    begin
        JobLedgerEntry.SETRANGE("Entry Type", JobLedgerEntry."Entry Type"::Usage);
        IF JobLedgerEntry.FINDSET() THEN BEGIN
            JobJnlLine.LOCKTABLE();
            JobJnlTemplate.GET(JobJnlLine."Journal Template Name");
            JobJnlBatch.GET(JobJnlLine."Journal Template Name", JobJnlLine."Journal Batch Name");
            IF JobJnlBatch."No. Series" = '' THEN
                NextDocNo := ''
            ELSE
                NextDocNo := NoSeriesMgt.GetNextNo(JobJnlBatch."No. Series", JobLedgerEntry."Posting Date", FALSE);

            JobJnlLine.SETRANGE("Journal Template Name", JobJnlLine."Journal Template Name");
            JobJnlLine.SETRANGE("Journal Batch Name", JobJnlLine."Journal Batch Name");
            IF JobJnlLine.FINDLAST() THEN;
            LineNo := JobJnlLine."Line No.";

            REPEAT
                JobJnlLine.INIT();
                LineNo := LineNo + 10000;
                JobJnlLine."Line No." := LineNo;
                JobJnlLine."Line Type" := JobLedgerEntry."Line Type";
                JobJnlLine.VALIDATE("Job No.", JobLedgerEntry."Job No.");
                JobJnlLine.VALIDATE("Job Task No.", JobLedgerEntry."Job Task No.");
                JobJnlLine.VALIDATE(Type, JobJnlLine.Type::Resource);
                JobJnlLine.VALIDATE("No.", 'Indid');
                JobJnlLine.VALIDATE("Work Type Code", JobLedgerEntry."Work Type Code");
                JobJnlLine.VALIDATE("Posting Date", JobLedgerEntry."Posting Date");
                JobJnlLine."Document No." := NextDocNo;
                NextDocNo := INCSTR(NextDocNo);
                JobJnlLine."Posting No. Series" := JobJnlBatch."Posting No. Series";
                JobJnlLine.Description := JobLedgerEntry.Description;
                JobJnlLine.VALIDATE(Quantity, JobLedgerEntry.Quantity);
                JobJnlLine.VALIDATE(Chargeable, JobLedgerEntry.Chargeable);
                JobJnlLine."Source Code" := JobJnlTemplate."Source Code";
                JobJnlLine."Reason Code" := JobJnlBatch."Reason Code";
                JobJnlLine.INSERT();
            UNTIL JobLedgerEntry.NEXT() = 0;
        END;
    end;

    var
        JobJnlLine: Record 210;
        JobJnlBatch: Record 237;
        JobJnlTemplate: Record 209;
        JobLedgerEntry: Record 169 temporary;
        JobLedgerEntryFrom: Record 169;
        ResourceNoFilter: Code[1024];
        JobNoFilter: Code[1024];
        JobTaskNoFilter: Code[1024];
        StartingDate: Date;
        EndingDate: Date;
        DateFilter: Text[30];
        CompanyName2: Text[30];

    procedure SetJobJnlLine(NewJobJnlLine: Record 210)
    begin
        JobJnlLine := NewJobJnlLine;
    end;

    procedure InitParameters(NewJobJnlLine: Record 210; NewResourceNoFilter: Code[1024]; NewJobNoFilter: Code[1024]; NewJobTaskNoFilter: Code[1024]; NewStartingDate: Date; NewEndingDate: Date)
    begin
        JobJnlLine := NewJobJnlLine;
        ResourceNoFilter := NewResourceNoFilter;
        JobNoFilter := NewJobNoFilter;
        JobTaskNoFilter := NewJobTaskNoFilter;
        StartingDate := NewStartingDate;
        EndingDate := NewEndingDate;
    end;

    local procedure FillJobJnlLineBuffer()
    begin
        JobLedgerEntryFrom.CHANGECOMPANY(CompanyName2);
        JobLedgerEntryFrom.SETFILTER("Job No.", Job."No.");
        IF DateFilter <> '' THEN
            JobLedgerEntryFrom.SETFILTER("Posting Date", DateFilter);
        IF JobLedgerEntryFrom.FINDSET(FALSE) THEN
            REPEAT
                JobLedgerEntry.INIT();
                JobLedgerEntry := JobLedgerEntryFrom;
                JobLedgerEntry.INSERT(TRUE);
            UNTIL JobLedgerEntryFrom.NEXT() = 0;
    end;
}

