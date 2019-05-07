tableextension 51030 JobcueExt extends "Job Cue"
{

    fields
    {
        field(50001; "Invoices to post"; Integer)
        {
            CalcFormula = Count ("Sales Header" WHERE ("Document Type" = FILTER (Invoice),
                                                      "Salesperson Code" = FIELD ("User ID Filter")));
            Caption = 'Invoices to post';
            FieldClass = FlowField;
        }
    }
}

