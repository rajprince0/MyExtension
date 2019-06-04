pageextension 50073 "ManagerTSExt" extends "Manager Time Sheet"
{
    layout
    {

        addafter("Job No.")
        {
            field("Job Description"; "Job Description")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Job Task No.")
        {
            field("Job Task Description"; "Job Task Description")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter(ActivityDetailsFactBox)
        {
            part("Billing Summary"; 50110)
            {
                Caption = 'Billing Summary';
                SubPageLink = "No." = FIELD ("Time Sheet No.");
                SubPageView = SORTING ("No.");
            }
        }
    }
}

