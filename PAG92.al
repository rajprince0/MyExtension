pageextension 50060 JobLedgerEntExt extends "Job Ledger Entries"
{
    layout
    {

        //Unsupported feature: Property Insertion (Name) on "Control 1900000001".


        //Unsupported feature: Property Deletion (Level) on "Control 1900000001".

        addafter("Job Task No.")
        {
            field("Job Sub Task No."; "Job Sub Task No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

