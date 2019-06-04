query 50001 "Job Eson"
{

    elements
    {
        dataitem(Job_Ledger_Entry; "Job Ledger Entry")
        {
            DataItemTableFilter = "Job No." = FILTER (243 | 259),
            "Entry Type" = FILTER (Usage),
            Type = FILTER (Resource);
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
            column(Unit_Price_LCY; "Unit Price (LCY)")
            {
            }
            column(Total_Price_LCY; "Total Price (LCY)")
            {
            }
            dataitem(Resource; Resource)
            {
                DataItemLink = "No." = Job_Ledger_Entry."No.";
                column(Name; Name)
                {
                }
            }
        }
    }
}

