page 50014 "Time Sheet Details"
{
    // EVST 150923 New Object

    PageType = List;
    SourceTable = "Time Sheet Detail";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Sub Task No."; "Job Sub Task No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

