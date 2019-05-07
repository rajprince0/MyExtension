table 50015 "Resource Overview Setup"
{

    Caption = 'Resource Overview Setup';

    fields
    {
        field(1; "User ID"; Text[132])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(2; "Starting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Starting Date';
        }
        field(3; "Show by"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Show by';
            OptionCaption = 'Tasks,Hours';
            OptionMembers = Tasks,Hours;
        }
        field(4; "Measure Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Measure Type';
            OptionCaption = 'Tasks,Hours';
            OptionMembers = Tasks,Hours;
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text001Lbl: Label 'Show by: %1 | Updated: %2.', Comment = 'show by (Status or Posted) | updated (time).';

    procedure GetCurrentSelectionText(): Text[250]
    begin
        EXIT(STRSUBSTNO(Text001Lbl, "Show by", TIME()));
    end;

    procedure SetStartingDate(StartingDate: Date)
    begin
        "Starting Date" := StartingDate;
        MODIFY();
    end;

    procedure GetEndingDate(): Date
    begin
        EXIT(CALCDATE('<1W>', "Starting Date") - 1);
    end;

    procedure FindPeriod(Which: Option Previous,Next)
    begin
        CASE Which OF
            Which::Previous:
                "Starting Date" := CALCDATE('<-1W>', "Starting Date");
            Which::Next:
                "Starting Date" := CALCDATE('<+1W>', "Starting Date");
        END;
        MODIFY();
    end;

    procedure SetShowBy(ShowBy: Option)
    begin
        "Show by" := ShowBy;
        MODIFY();
    end;

    procedure MeasureIndex2MeasureType(MeasureIndex: Integer): Integer
    begin
        CASE "Show by" OF
            "Show by"::Tasks:
                EXIT(MeasureIndex);
            "Show by"::Hours:
                EXIT(MeasureIndex);
        END;
    end;
}

