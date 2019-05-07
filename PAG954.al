pageextension 50074 ManagerTSJobExt extends "Manager Time Sheet by Job"
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
    }
}

