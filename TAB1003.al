tableextension 51027 JobPlanningLineExt extends "Job Planning Line"
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
    }
}

