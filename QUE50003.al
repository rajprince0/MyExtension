query 50003 "Ongoing Job Eson2"
{

    elements
    {
        dataitem(Job_Journal_Line; "Job Journal Line")
        {
            DataItemTableFilter = "Job No." = FILTER (243 | 259),
            Type = CONST (Resource);
            column(Posting_Date; "Posting Date")
            {
            }
            column(Type; Type)
            {
            }
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Job_Task_No; "Job Task No.")
            {
            }
            column(Quantity; Quantity)
            {
            }
            dataitem(Resource; Resource)
            {
                DataItemLink = "No." = Job_Journal_Line."No.";
                column(Name; Name)
                {
                }
            }
        }
    }
}

