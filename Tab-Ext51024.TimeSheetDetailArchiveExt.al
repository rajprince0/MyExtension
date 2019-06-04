tableextension 51024 "TimeSheetDetailArchiveExt" extends "Time Sheet Detail Archive"
{

    fields
    {
        field(50000; Chargeable; Boolean)
        {
            CalcFormula = Lookup ("Time Sheet Line".Chargeable WHERE ("Time Sheet No." = FIELD ("Time Sheet No."),
                                                                     "Line No." = FIELD ("Time Sheet Line No.")));
            Caption = 'Chargeable';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Job Sub Task No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Sub Task No.';
        }
        field(50002; "Job Description"; Text[50])
        {
            CalcFormula = Lookup (Job.Description WHERE ("No." = FIELD ("Job No.")));
            Caption = 'Job Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Job Task Description"; Text[50])
        {
            CalcFormula = Lookup ("Job Task".Description WHERE ("Job No." = FIELD ("Job No."),
                                                               "Job Task No." = FIELD ("Job Task No.")));
            Caption = 'Job Task Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Time Sheet Description"; Text[70])
        {
            CalcFormula = Lookup ("Time Sheet Line".Description WHERE ("Time Sheet No." = FIELD ("Time Sheet No."),
                                                                      "Line No." = FIELD ("Time Sheet Line No.")));
            Caption = 'Time Sheet Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Work Type Code"; Code[10])
        {
            CalcFormula = Lookup ("Time Sheet Line"."Work Type Code" WHERE ("Time Sheet No." = FIELD ("Time Sheet No."),
                                                                           "Line No." = FIELD ("Time Sheet Line No.")));
            Caption = 'Work Type Code';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

