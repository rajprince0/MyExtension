page 50113 "Job Sub Task Lines Filtered"
{
    // version NAVW18.00

    // EVNKG 161130 New Page : Save As - "Job Sub Task Lines"
    // EVNKG 170202 New Functions : EstimatedTimeRequired,EstimatedRemainingTime

    Caption = 'Job Sub Task Lines Filtered';
    DataCaptionFields = "Job Task No.";
    PageType = List;
    SaveValues = true;
    SourceTable = "Job Sub Task";
    SourceTableView = SORTING ("Job Sub Task No.") WHERE (Status = FILTER (New | "In Progress"), "Job No." = FILTER (<> 55 & <> 58));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Customer Name"; Customer_Name())
                {
                    ApplicationArea = All;
                    Caption = 'Customer Name';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Job Sub Task No."; "Job Sub Task No.")
                {
                    ApplicationArea = All;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                }
                field(Budget; Budget)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Utilised Hours"; "Utilised Hours")
                {
                    ApplicationArea = All;
                }
                field("Remaining Hours"; Budget - "Utilised Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Remaining Hours';
                }
                field("Progress %"; ROUND(ProgressPerc()))
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 0;
                }
                field("Task Progress"; "Task Progress")
                {
                    ApplicationArea = All;
                    Caption = 'Task Progress';
                }
                field("Estimated Time Needed"; EstimatedTimeRequired())
                {
                    ApplicationArea = All;
                    Caption = 'Estimated Time Needed';
                }
                field("Estimated Required Time"; EstimatedRemainingTime())
                {
                    ApplicationArea = All;
                    Caption = 'Estimated Required Time';
                }
                field("Delivery Date"; FORMAT("Delivery Date"))
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        ProgPercent: Integer;
        RequiredDuration: Decimal;

    local procedure Customer_Name(): Text
    var
        Job: Record 167;
    begin
        IF Job.GET("Job No.") THEN
            EXIT(Job.Description);
    end;

    local procedure ProgressPerc() ProgPerc: Decimal
    begin
        IF (Status = Status::"In Progress") AND (Budget <> 0) THEN
            ProgPerc := "Utilised Hours" / Budget * 100;
    end;

    local procedure EstimatedTimeRequired() Duration: Decimal
    begin
        IF (Status = Status::"In Progress") AND ("Task Progress" <> 0) THEN
            Duration := ROUND("Utilised Hours" / ("Task Progress" / 100));
    end;

    local procedure EstimatedRemainingTime() EstimatedTime: Decimal
    begin
        EstimatedTime := ROUND(EstimatedTimeRequired() * (100 - "Task Progress") / 100);
    end;
}

