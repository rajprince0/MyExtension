report 50009 "Update Estimated Hours"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(JobSubTask; 50012)
        {

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS(Budget);
                "Estimated Hours" := Budget;
                MODIFY();
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

