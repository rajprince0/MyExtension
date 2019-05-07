report 50013 "Update Eson Proj"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Update Eson Proj.rdlc';

    dataset
    {
        dataitem(UpdateJobTask; UpdateJobTask)
        {

            trigger OnAfterGetRecord()
            begin
                JobLedgEntry.SETRANGE("Posting Date", UpdateJobTask.JobDate);
                JobLedgEntry.SETRANGE(Type, JobLedgEntry.Type::Resource);
                JobLedgEntry.SETRANGE("No.", UpdateJobTask.Resource);
                JobLedgEntry.SETRANGE("Job No.", '243');
                JobLedgEntry.SETRANGE("Job Task No.", UpdateJobTask.JobTask);
                JobLedgEntry.SETRANGE(Quantity, UpdateJobTask.Qty);
                JobLedgEntry.SETRANGE(Description, UpdateJobTask.OldDesc);
                IF JobLedgEntry.COUNT = 1 THEN BEGIN
                    JobLedgEntry.FINDSET;
                    JobLedgEntry."Job Task No." := UpdateJobTask.NewJobTask;
                    JobLedgEntry.Description := UpdateJobTask.NewDesc;
                    JobLedgEntry.MODIFY;
                    i += 1;
                END;

            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('%1', i);
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
        TimeSheetDet: Record "Time Sheet Detail";
        JobPlanLine: Record "Job Planning Line";
        JobPlanLine2: Record "Job Planning Line";
        JobPlanLine3: Record "Job Planning Line";
        LineNo: Integer;
        JobLedgEntry: Record "Job Ledger Entry";
        i: Integer;
}

