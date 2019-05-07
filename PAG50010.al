page 50010 "Time Sheet Detail"
{
    // version EV

    // EVMC 150811 New Page
    // EVST 150922 New Fields: "Job Description", "Job Task Description"
    // EVST 150928 New Field: "Time Sheet Description"
    // EVST 151005 New Field: "Work Type Code"

    Caption = 'Time Sheet Detail';
    Editable = false;
    PageType = List;
    SourceTable = "Time Sheet Detail";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Time Sheet No."; "Time Sheet No.")
                {
                    ApplicationArea = All;
                }
                field("Time Sheet Line No."; "Time Sheet Line No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                }
                field("Job Description"; "Job Description")
                {
                    ApplicationArea = All;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("Job Task Description"; "Job Task Description")
                {
                    ApplicationArea = All;
                }
                field("Time Sheet Description"; "Time Sheet Description")
                {
                    ApplicationArea = All;
                }
                field("Work Type Code"; "Work Type Code")
                {
                    ApplicationArea = All;
                }
                field("Cause of Absence Code"; "Cause of Absence Code")
                {
                    ApplicationArea = All;
                }
                field("Service Order No."; "Service Order No.")
                {
                    ApplicationArea = All;
                }
                field("Service Order Line No."; "Service Order Line No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Posted Quantity"; "Posted Quantity")
                {
                    ApplicationArea = All;
                }
                field("Assembly Order No."; "Assembly Order No.")
                {
                    ApplicationArea = All;
                }
                field("Assembly Order Line No."; "Assembly Order Line No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = All;
                }
                field(Chargeable; Chargeable)
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

