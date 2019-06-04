tableextension 51012 "JobLedgerEntryExt" extends "Job Ledger Entry"
{
    fields
    {

        field(50000; "Job Sub Task No."; Code[20])
        {
            Caption = 'Job Sub Task No.';
            DataClassification = CustomerContent;
            TableRelation = "Job Sub Task"."Job Sub Task No." WHERE ("Job No." = FIELD ("Job No."),
                                                                     "Job Task No." = FIELD ("Job Task No."));

            trigger OnValidate()
            var
                JobSubTask: Record 50012;
            begin
                IF JobSubTask.GET("Job Sub Task No.") THEN
                    Description := JobSubTask.Description;
            end;
        }
        field(50001; Chargeable; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Chargeable';
            InitValue = true;
        }
    }
}

