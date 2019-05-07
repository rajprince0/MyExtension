page 50012 "Assignee List"
{
    // EVSP 150827 New Object

    PageType = List;
    SourceTable = "Assignee";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Assignee; Assignee)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
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

