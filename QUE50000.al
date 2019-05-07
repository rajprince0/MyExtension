query 50000 "Budget Analysis"
{

    elements
    {
        dataitem(G_L_Entry; "G/L Entry")
        {
            DataItemTableFilter = "Posting Date" = FILTER ('01/01/17..12/31/17');
            column(Year_Posting_Date; "Posting Date")
            {
                Method = Year;
            }
            column(Month_Posting_Date; "Posting Date")
            {
                Method = Month;
            }
            column(G_L_Account_No; "G/L Account No.")
            {
            }
            filter(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {
            }
            column(Sum_Amount; Amount)
            {
                Method = Sum;
            }
            dataitem(G_L_Budget_Entry; "G/L Budget Entry")
            {
                DataItemLink = "G/L Account No." = G_L_Entry."G/L Account No.",
                Date = G_L_Entry."Posting Date",
                "Global Dimension 2 Code" = G_L_Entry."Global Dimension 2 Code";
                DataItemTableFilter = "Budget Name" = FILTER ('2017');
                column(BudgetDim2; "Global Dimension 2 Code")
                {
                }
                column(BudgetAmount; Amount)
                {
                    Method = Sum;
                }
            }
        }
    }
}

