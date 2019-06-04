page 50035 "Leave Plan Entries"
{
    // version LPM

    // EVAK 170519 New Object

    Caption = 'Leave Plan Entries';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Leave Plan Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    Caption = 'Entry No';
                    ApplicationArea = All;
                }
                field("Resource No."; "Resource No.")
                {
                    Caption = 'Resource No';
                    ApplicationArea = All;
                }
                field(Date; Date)
                {
                    Caption = 'Date';
                    ApplicationArea = All;
                }
                field(Hours; Hours)
                {
                    Caption = 'Hours';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

