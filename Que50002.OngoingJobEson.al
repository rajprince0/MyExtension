query 50002 "Ongoing Job Eson"
{

    elements
    {
        dataitem(Time_Sheet_Detail; "Time Sheet Detail")
        {
            DataItemTableFilter = "Job No." = FILTER (243 | 259),
            "Posted Quantity" = FILTER (0);
            column(Date; Date)
            {
            }
            column(Type; Type)
            {
            }
            column(Resource_No; "Resource No.")
            {
            }
            column(Time_Sheet_Description; "Time Sheet Description")
            {
            }
            column(Job_Task_No; "Job Task No.")
            {
            }
            column(Quantity; Quantity)
            {
            }
            dataitem(QueryElement1100560008; Resource)
            {
                DataItemLink = "No." = Time_Sheet_Detail."Resource No.";
                column(Name; Name)
                {
                }
            }
        }
    }
}

