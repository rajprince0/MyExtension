page 50111 "Time Sheet Details Archive"
{
    // version EVPK

    // EVPK 160914 New Object

    Caption = 'Time Sheet Details Archive';
    PageType = List;
    SourceTable = "Time Sheet Detail Archive";

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
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Task No."; "Job Task No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Job Sub Task No."; "Job Sub Task No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

