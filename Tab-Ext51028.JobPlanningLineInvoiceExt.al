tableextension 51028 "JobPlanningLineInvoiceExt" extends "Job Planning Line Invoice"
{

    fields
    {
        field(50000; "Job Sub Task No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Sub Task No.';
            TableRelation = "Job Sub Task"."Job Sub Task No." WHERE ("Job No." = FIELD ("Job No."),
                                                                     "Job Task No." = FIELD ("Job Task No."));

        }
    }
}

