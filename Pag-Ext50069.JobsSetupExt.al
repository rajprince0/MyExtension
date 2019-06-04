pageextension 50069 "JobsSetupExt" extends "Jobs Setup"
{
    layout
    {
        addafter("Default Job Posting Group")
        {
            field("Start Date for Time Bank"; "Start Date for Time Bank")
            {
                ApplicationArea = All;
            }
        }
        addafter("Job Nos.")
        {
            field("Sub Task Nos."; "Sub Task Nos.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Job WIP Nos.")
        {
            field("Enticon Batch Name"; "Enticon Batch Name")
            {
                ApplicationArea = All;
            }
        }
    }
}

