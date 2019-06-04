table 50019 "Time Sheet Amount Chart Setup"
{

    Caption = 'Time Sheet Chart Setup';

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
            OptionCaption = 'Status,Type,Posted';
            OptionMembers = Status,Type,Posted;
        }
        field(4; "Measure Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Measure Type';
            OptionCaption = 'Open,Submitted,Rejected,Approved,Scheduled,Posted,Not Posted,Resource,Job,Service,Absence,Assembly Order';
            OptionMembers = Open,Submitted,Rejected,Approved,Scheduled,Posted,"Not Posted",Resource,Job,Service,Absence,"Assembly Order";
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
        Text001Lbl: Label 'Period: %1..%2 | Show by: %3 | Updated: %4.', Comment = 'Period: (date)..(date) | show by (Status or Posted) | updated (time).';

    procedure GetCurrentSelectionText(): Text[250]
    begin
        EXIT(STRSUBSTNO(Text001Lbl, "Starting Date", GetEndingDate(), "Show by", TIME()));
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
            "Show by"::Status:
                EXIT(MeasureIndex);
            "Show by"::Posted:
                CASE MeasureIndex OF
                    0:
                        EXIT("Measure Type"::Posted);
                    1:
                        EXIT("Measure Type"::"Not Posted");
                    2:
                        EXIT("Measure Type"::Scheduled);
                END;
            "Show by"::Type:
                BEGIN
                    IF MeasureIndex = 5 THEN
                        EXIT("Measure Type"::Scheduled);
                    EXIT(MeasureIndex + 7);
                END;
        END;
    end;
}

