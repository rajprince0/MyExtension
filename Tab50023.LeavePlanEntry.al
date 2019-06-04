table 50023 "Leave Plan Entry"
{
    // version LPM

    // EVAK 170519 New Object

    Caption = 'Leave Plan Entry';

    fields
    {
        field(1; "LeavePlan No."; Integer)
        {
            Caption = 'LeavePlan No.';
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Resource No."; Code[20])
        {
            Caption = 'Resource No';
            TableRelation = Resource;
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
        }
        field(5; Hours; Decimal)
        {
            Caption = 'Hours';

            trigger OnValidate()
            begin
                IF Hours > 8 THEN
                    ERROR(Text000);
            end;
        }
    }

    keys
    {
        key(Key1; "LeavePlan No.", "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Entry No." := GetLastLeavePlanEntry + 1;
    end;

    var
        Text000: Label 'You can''t enter more than 8 hours..!!';

    local procedure GetLastLeavePlanEntry(): Integer
    var
        LeavePlanEntry: Record "Leave Plan Entry";
    begin
        LeavePlanEntry.SETRANGE("LeavePlan No.", "LeavePlan No.");
        IF LeavePlanEntry.FINDLAST THEN
            EXIT(LeavePlanEntry."Entry No.");
    end;
}

