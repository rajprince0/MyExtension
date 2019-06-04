tableextension 51013 "WorkTypeExt" extends "Work Type"
{

    fields
    {
        field(50000; Default; Boolean)
        {
            Caption = 'Default';
            Description = 'EV';

            trigger OnValidate()
            begin
                CheckDefaultValue;
            end;
        }
    }

    local procedure CheckDefaultValue()
    var
        WorkType: Record 200;
    begin
        WorkType.SETFILTER(Code, '<>%1', Code);
        WorkType.SETRANGE(Default, TRUE);
        IF WorkType.FINDFIRST THEN
            WorkType.TESTFIELD(Default, FALSE);
    end;
}

