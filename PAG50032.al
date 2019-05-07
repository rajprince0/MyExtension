page 50032 "LPM Setup"
{
    // version LPM

    // EVKK 190225 New Object

    Caption = 'LPM Setup';
    PageType = Card;
    SourceTable = "LPM Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Company Name"; "Company Name")
                {
                    ApplicationArea = All;
                    Caption = 'Company Name';
                }
            }
        }
    }

    actions
    {
    }
}

