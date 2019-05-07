page 50016 "Resource Time Bank"
{
    Caption = 'Resource Time Bank';
    PageType = List;
    SourceTable = "Resource";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(GetTimeBankValues; GetTimeBankValue())
                {
                    ApplicationArea = All;
                    Caption = 'Time Bank';
                }
            }
        }
    }

    actions
    {
    }

    local procedure GetTimeBankValue(): Decimal
    var
        ResActivity: Page 50011;
    begin
        EXIT(ResActivity.CalculateTimeBank("Time Sheet Owner User ID"));
    end;
}

