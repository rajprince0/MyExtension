page 50024 "Leave Plan Card"
{
    // version LPM

    // EVAK 170929 New Object

    Caption = 'Leave Plan Card';
    DataCaptionExpression = FORMAT("No.") + ' ' + '-' + ' ' + "Resource No.";
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Leave Plan";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cause of Absence"; "Cause of Absence")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CheckFields() THEN
            CreateLeavePlanEntry()
        ELSE BEGIN
            MESSAGE(GETLASTERRORTEXT());
            DELETE(TRUE);
        END;
    end;
}

