tableextension 51016 JobJournalLineExt extends "Job Journal Line"
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
                JobSubTask: Record "Job Sub Task";
            begin
                IF JobSubTask.GET("Job Sub Task No.") THEN
                    Description := JobSubTask.Description;
            end;
        }
        field(50002; "Rapporterat antal"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Job.GET("Job No.");
                IF Job."Bill-to" = TRUE THEN
                    VALIDATE(Quantity, "Rapporterat antal");
            end;
        }
    }

    local procedure "***EV***"()
    begin
    end;

    procedure GetJobName(): Text[50]
    begin
        IF Job.GET("Job No.") THEN
            EXIT(Job.Description);
    end;

    procedure SuspendStatusCheck(Suspend: Boolean)
    begin
        StatusCheckSuspended := Suspend;
    end;

    var
        Job: Record 167;
        "*EV*": Integer;
        StatusCheckSuspended: Boolean;
}

