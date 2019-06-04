tableextension 51020 "TimeSheetLineExt" extends "Time Sheet Line"
{
    // version NAVW110.00.00.17501,#2741

    // EJC 150814 Decription only changed if blank
    // EVSP 150819 New Field - 50000 : "Job Sub Task No."
    // EVST 150831 Description size changed 50 -> 70
    // EVST 150831 New Function - SetUpNewLine
    // EVST 150929 New Field - 50001: "Job Description"
    //                         50002 : "Job Task Description"
    // EVRG 190222 #2741 Table Relation changed for "Job No." and 'Job Task No."
    fields
    {

        field(50000; "Job Sub Task No."; Code[20])
        {
            Caption = 'Job Sub Task No.';
            TableRelation = "Job Sub Task"."Job Sub Task No." WHERE ("Job No." = FIELD ("Job No."),
                                                                     "Job Task No." = FIELD ("Job Task No."),
                                                                     Status = FILTER ('In Progress' | 'On Hold' | New));

            trigger OnValidate()
            var
                JobSubTask: Record "Job Sub Task";
            begin
                IF JobSubTask.GET("Job Sub Task No.") THEN
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

    local procedure "***EV***"()
    begin
    end;

    procedure SetUpNewLine()
    var
        WorkType: Record "Work Type";
    begin
        WorkType.SETRANGE(Default, TRUE);
        IF WorkType.FINDFIRST THEN
            VALIDATE("Work Type Code", WorkType.Code);
    end;

    var
        JobTask2: Record "Job Task";
}

