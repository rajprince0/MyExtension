pageextension 50058 JobCardExt extends "Job Card"
{

    layout
    {
        addafter("Description")
        {
            field("External Description"; "External Description")
            {
                ApplicationArea = All;
            }
        }
        addafter("Last Date Modified")
        {
            field("Customer Price Group"; "Customer Price Group")
            {
                ApplicationArea = All;
            }
            field(Synch; Synch)
            {
                ApplicationArea = All;
            }
        }
        addafter("Job Details")
        {
            part(TMStatusFactBox; 50009)
            {
                Caption = 'TM Status';
                SubPageLink = "No." = FIELD ("No.");
                UpdatePropagation = SubPart;
            }
        }
    }
    actions
    {
        addfirst("&Job")
        {
            action("Job Task &Lines")
            {
                ApplicationArea = Jobs;
                Caption = 'Job Task &Lines';
                Image = TaskList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 1002;
                RunPageLink = "Job No." = FIELD ("No.");
                ShortCutKey = 'Shift+Ctrl+T';
                ToolTip = 'Plan how you want to set up your planning information. In this window you can specify the tasks involved in a job. To start planning a job or to post usage for a job, you must set up at least one job task.';
            }
            action("Time Sheet Detail")
            {
                Caption = 'Time Sheet Detail';
                Image = JobTimeSheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50010;
                RunPageLink = "Job No." = FIELD ("No.");
            }
        }
    }
}

