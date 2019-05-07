tableextension 51023 TimeSheetLineArchiveExt extends "Time Sheet Line Archive"
{
    fields
    {

        field(50000; "Job Sub Task No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Sub Task No.';
            TableRelation = "Job Sub Task"."Job Sub Task No." WHERE ("Job No." = FIELD ("Job No."),
                                                                     "Job Task No." = FIELD ("Job Task No."));

            trigger OnValidate()
            var
                JobSubTask: Record 50012;
            begin
                IF JobSubTask.GET("Job No.", "Job Task No.", "Job Sub Task No.") THEN
                    Description := JobSubTask.Description;
            end;
        }
        field(50001; "Job Description"; Text[50])
        {
            CalcFormula = Lookup (Job.Description WHERE ("No." = FIELD ("Job No.")));
            Caption = 'Job Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Job Task Description"; Text[50])
        {
            CalcFormula = Lookup ("Job Task".Description WHERE ("Job No." = FIELD ("Job No."),
                                                               "Job Task No." = FIELD ("Job Task No.")));
            Caption = 'Job Task Description';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

