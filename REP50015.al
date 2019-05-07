report 50015 "Update Job Eson"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Update Job Eson.rdlc';

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = WHERE (Number = CONST (1));

            trigger OnAfterGetRecord()
            begin
                JobLedgEntry.SETRANGE("Job No.", '243');
                JobLedgEntry.SETRANGE("No.", 'PS');
                JobLedgEntry.SETRANGE("Posting Date", 20190101D, 20190131D);
                IF JobLedgEntry.FINDSET THEN
                    REPEAT
                        IF JobLedgEntry."Work Type Code" = 'RUG' THEN BEGIN
                            JobLedgEntry."Job Task No." := '6010';
                            JobPlanLine.SETRANGE("Job Ledger Entry No.", JobLedgEntry."Entry No.");
                            IF JobPlanLine.FINDSET THEN BEGIN
                                JobPlanLine2 := JobPlanLine;
                                JobPlanLine2."Job Task No." := '6010';

                                JobPlanLine2."Line No." := JobPlanLine2."Line No." + 600000;
                                JobPlanLine.DELETE;
                                JobPlanLine2.INSERT;
                            END;
                            JobLedgEntry.MODIFY;


                        END;
                        IF JobLedgEntry."Work Type Code" = 'RES' THEN BEGIN
                            JobLedgEntry."Job Task No." := '6011';
                            JobPlanLine.SETRANGE("Job Ledger Entry No.", JobLedgEntry."Entry No.");
                            IF JobPlanLine.FINDSET THEN BEGIN
                                JobPlanLine2 := JobPlanLine;
                                JobPlanLine2."Job Task No." := '6011';

                                JobPlanLine2."Line No." := JobPlanLine2."Line No." + 600000;
                                JobPlanLine.DELETE;
                                JobPlanLine2.INSERT;
                            END;
                            JobLedgEntry.MODIFY;
                        END;
                    UNTIL JobLedgEntry.NEXT = 0;
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
        JobLedgEntry: Record "Job Ledger Entry";
        JobPlanLine: Record "Job Planning Line";
        JobPlanLine2: Record "Job Planning Line";
}

