pageextension 50053 CustomerCardExt extends "Customer Card"
{
    layout
    {

        addafter("Last Date Modified")
        {
            field("External Document No."; "External Document No.")
            {
                ApplicationArea = All;
            }
            field("Internal Customer"; "Internal Customer")
            {
                ApplicationArea = All;
            }
        }
    }
}

