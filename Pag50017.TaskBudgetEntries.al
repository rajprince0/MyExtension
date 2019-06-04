page 50017 "Task Budget Entries"
{
    // EVST 150923 New Object

    PageType = List;
    SourceTable = "Task Budget Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                }
                field(Budget; Budget)
                {
                    ApplicationArea = All;
                }
                field("Utilised Hours"; "Utilised Hours")
                {
                    ApplicationArea = All;
                }
                field("Remaining Hours"; Budget - "Utilised Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Remaining Hours';
                }
            }
        }
    }

    actions
    {
    }
}

