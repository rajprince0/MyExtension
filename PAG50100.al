page 50100 Provisionsunderlag
{
    PageType = List;
    SourceTable = "Job Planning Line";
    SourceTableView = WHERE ("Unit of Measure Code" = FILTER ('TIM' | ''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line Type"; "Line Type")
                {
                    ApplicationArea = All;
                }
                field("Planning Date"; "Planning Date")
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price (LCY)"; "Unit Price (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Total Price (LCY)"; "Total Price (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

