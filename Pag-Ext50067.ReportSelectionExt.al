pageextension 50067 "ReportSelectionExt" extends "Report Selection - Sales"
{
    layout
    {
        addafter("Email Body Layout Description")
        {
            field("Attachment Report ID"; "Attachment Report ID")
            {
                ApplicationArea = All;
            }
        }
    }
}

