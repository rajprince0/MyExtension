tableextension 51017 "JobsSetupExt" extends "Jobs Setup"
{

    fields
    {
        field(50000; "Start Date for Time Bank"; Date)
        {
            Caption = 'Start Date for Time Bank';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ValidateStartingDate();
            end;
        }
        field(50001; "Sub Task Nos."; Code[10])
        {
            Caption = 'Sub Task Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50002; "Enticon Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Job Journal Batch".Name WHERE ("Journal Template Name" = CONST ('PROJEKT'));
        }
    }

    local procedure "***EV***"()
    begin
    end;

    procedure ValidateStartingDate()
    var
        ResourcesSetup: Record 314;
    begin
        ResourcesSetup.GET();
        IF DATE2DWY("Start Date for Time Bank", 1) <> ResourcesSetup."Time Sheet First Weekday" + 1 THEN
            ERROR(Text50000Lbl, ResourcesSetup."Time Sheet First Weekday");
    end;

    var
        "**EV**": integer;
        Text50000Lbl: Label 'Starting Date must be %1.';
}

