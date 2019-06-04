report 50010 "Update job"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Job; 167)
        {
            DataItemTableView = WHERE ("No." = CONST ('137'));

            trigger OnAfterGetRecord()
            begin
                IF CONFIRM('%1', TRUE, Job."No.") THEN BEGIN
                    "Bill-to Customer No." := '1266';
                    MODIFY();
                END ELSE ERROR('');
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

