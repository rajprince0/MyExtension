report 50014 "Create Enticon Jnl"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Create Enticon Jnl.rdlc';

    dataset
    {
        dataitem("Job Ledger Entry"; "Job Ledger Entry")
        {
            DataItemTableView = WHERE ("Job No." = FILTER (243 | 259),
                                      "Posting Date" = FILTER ('02/01/19..02/28/19'),
                                      Type = CONST (Resource),
                                      "No." = FILTER ('LA' | 'HH'));

            trigger OnAfterGetRecord()
            begin

                JobJnl.INIT;
                JobJnl."Journal Template Name" := 'PROJEKT';
                JobJnl."Journal Batch Name" := 'ENTICON';
                JobJnl."Line No." := LineNo;
                JobJnl.VALIDATE("Job No.", '243');
                JobJnl.VALIDATE("Job Task No.", "Job Ledger Entry"."Job Task No.");

                JobJnl.VALIDATE("Posting Date", "Job Ledger Entry"."Posting Date");
                JobJnl.VALIDATE(Type, JobJnl.Type::Resource);
                JobJnl.VALIDATE("No.", "Job Ledger Entry"."No.");
                JobJnl.VALIDATE(Description, "Job Ledger Entry".Description);
                JobJnl.VALIDATE(Quantity, "Job Ledger Entry".Quantity);
                JobJnl.VALIDATE("Line Type", JobJnl."Line Type"::Billable);
                JobJnl.VALIDATE("Unit Price", "Job Ledger Entry"."Unit Price");
                JobJnl.INSERT;
                LineNo += 10000;

                Quantity := 0;
                "Unit Price" := 0;
                "Job Ledger Entry"."Total Price (LCY)" := 0;
                "Job Ledger Entry"."Total Price" := 0;
                "Job Ledger Entry"."Unit Price (LCY)" := 0;
                MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                LineNo := 10000;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        JobJnl: Record "Job Journal Line";
        LineNo: Integer;
}

