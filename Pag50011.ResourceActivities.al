page 50011 "Resource Activities"
{
    // version EV

    // EVST 150904 New Page

    Caption = 'Resource Activities';
    PageType = CardPart;

    layout
    {
        area(content)
        {
            cuegroup("Resource Time Bank")
            {
                Caption = 'Resource Time Bank';
                field(TimeBank; TimeBank)
                {
                    ApplicationArea = All;
                    Caption = 'Time Bank';
                    DecimalPlaces = 0 : 2;
                    StyleExpr = ColorVar;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        CalculateCueFieldValues();
    end;

    var
        TimeBank: Decimal;
        ColorVar: Text;

    local procedure CalculateCueFieldValues()
    begin
        TimeBank := CalculateTimeBank(USERID());
    end;

    procedure CalculateTimeBank(UserID2: Code[20]) TotalQty: Decimal
    var
        JobsSetup: Record "Jobs Setup";
        Resource: Record Resource;
        TimeSheetHeader: Record "Time Sheet Header";
        EndDate: Date;
        TotalPresenceQty: Decimal;
        TotalSchedQty: Decimal;
    begin
        JobsSetup.GET();
        IF JobsSetup."Start Date for Time Bank" = 0D THEN
            EXIT;

        EndDate := CALCDATE('<-WD7>', TODAY());

        Resource.SETRANGE("Time Sheet Owner User ID", UserID2);
        IF NOT Resource.FINDFIRST() THEN
            EXIT;

        //Resource Capacity
        Resource.SETRANGE("Date Filter", JobsSetup."Start Date for Time Bank", EndDate);
        Resource.CALCFIELDS(Capacity);
        TotalSchedQty += Resource.Capacity;

        TimeSheetHeader.SETCURRENTKEY("Resource No.", "Starting Date");
        TimeSheetHeader.SETRANGE("Resource No.", Resource."No.");
        TimeSheetHeader.SETRANGE("Starting Date", JobsSetup."Start Date for Time Bank", EndDate);
        IF TimeSheetHeader.FINDSET() THEN
            REPEAT
                //Presence Quantity
                TimeSheetHeader.CALCFIELDS(Quantity);
                TotalPresenceQty += TimeSheetHeader.Quantity;
            UNTIL TimeSheetHeader.NEXT() = 0;

        TotalQty := TotalPresenceQty - TotalSchedQty;

        CASE TRUE OF
            TotalQty > 0:
                ColorVar := 'Favorable';
            TotalQty < 0:
                ColorVar := 'Unfavorable';
            TotalQty = 0:
                ColorVar := 'Ambiguous';
        END;
    end;
}

