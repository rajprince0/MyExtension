page 50013 "Time Sheet Amount Chart"
{
    // version NAVW18.00

    // EVSP 150904 New Object

    Caption = 'Time Sheets';
    PageType = CardPart;
    SourceTable = "Business Chart Buffer";

    layout
    {
        area(content)
        {
            field(StatusText; StatusText)
            {
                Caption = 'Status Text';
                ShowCaption = false;
                ApplicationArea = All;
            }
            usercontrol(BusinessChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {

                trigger DataPointClicked(point: DotNet BusinessChartDataPoint)
                begin
                    SetDrillDownIndexes(point);
                    TimeSheetChartMgt.DrillDown(Rec);
                end;

                trigger DataPointDoubleClicked(point: DotNet BusinessChartDataPoint)
                begin
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Previous Period")
            {
                Caption = 'Previous Period';
                Image = PreviousSet;

                trigger OnAction()
                begin
                    TimeSheetChartSetup.FindPeriod(SetWanted::Previous);
                    UpdateStatus;
                end;
            }
            action("Next Period")
            {
                Caption = 'Next Period';
                Image = NextSet;

                trigger OnAction()
                begin
                    TimeSheetChartSetup.FindPeriod(SetWanted::Next);
                    UpdateStatus;
                end;
            }
            group("Show by")
            {
                Caption = 'Show by';
                Image = View;
                action(Status)
                {
                    Caption = 'Status';
                    Image = "Report";

                    trigger OnAction()
                    begin
                        TimeSheetChartSetup.SetShowBy(TimeSheetChartSetup."Show by"::Status);
                        UpdateStatus;
                    end;
                }
                action(Type)
                {
                    Caption = 'Type';

                    trigger OnAction()
                    begin
                        TimeSheetChartSetup.SetShowBy(TimeSheetChartSetup."Show by"::Type);
                        UpdateStatus;
                    end;
                }
                action(Posted)
                {
                    Caption = 'Posted';
                    Image = PostedTimeSheet;

                    trigger OnAction()
                    begin
                        TimeSheetChartSetup.SetShowBy(TimeSheetChartSetup."Show by"::Posted);
                        UpdateStatus;
                    end;
                }
            }
            action(Refresh)
            {
                Caption = 'Refresh';
                Image = Refresh;

                trigger OnAction()
                begin
                    NeedsUpdate := TRUE;
                    UpdateStatus;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateChart;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        UpdateChart;
        IsChartDataReady := TRUE;
    end;

    var
        TimeSheetChartSetup: Record "Time Sheet Chart Setup";
        OldTimeSheetChartSetup: Record "Time Sheet Chart Setup";
        TSChartSetup: Record "Time Sheet Chart Setup";
        TimeSheetChartMgt: Codeunit "Time Sheet Chart Mgt.";
        StatusText: Text[250];
        NeedsUpdate: Boolean;
        SetWanted: Option Previous,Next;
        IsChartDataReady: Boolean;
        IsChartAddInReady: Boolean;
        Text001: Label 'Time Sheet Resource';
        MeasureType: Option Open,Submitted,Rejected,Approved,Scheduled,Posted,"Not Posted",Resource,Job,Service,Absence,"Assembly Order";

    local procedure UpdateChart()
    begin
        IF NOT NeedsUpdate THEN
            EXIT;
        IF NOT IsChartAddInReady THEN
            EXIT;
        UpdateData(Rec);
        Update(CurrPage.BusinessChart);
        UpdateStatus;

        NeedsUpdate := FALSE;
    end;

    local procedure UpdateStatus()
    begin
        NeedsUpdate := NeedsUpdate OR IsSetupChanged;

        OldTimeSheetChartSetup := TimeSheetChartSetup;

        IF NeedsUpdate THEN
            StatusText := TimeSheetChartSetup.GetCurrentSelectionText;
    end;

    local procedure IsSetupChanged(): Boolean
    begin
        EXIT(
          (OldTimeSheetChartSetup."Starting Date" <> TimeSheetChartSetup."Starting Date") OR
          (OldTimeSheetChartSetup."Show by" <> TimeSheetChartSetup."Show by"));
    end;

    procedure UpdateData(var BusChartBuf: Record "Business Chart Buffer")
    var
        TimeSheetChartSetup: Record "Time Sheet Amount Chart Setup";
        BusChartMapColumn: Record "Business Chart Map";
        BusChartMapMeasure: Record "Business Chart Map";
    begin
        TimeSheetChartSetup.GET(USERID);

        WITH BusChartBuf DO BEGIN
            Initialize;
            SetXAxis(Text001, "Data Type"::String);

            AddColumns(BusChartBuf);
            AddMeasures(BusChartBuf, TimeSheetChartSetup);

            IF FindFirstMeasure(BusChartMapMeasure) THEN
                REPEAT
                    IF FindFirstColumn(BusChartMapColumn) THEN
                        REPEAT
                            SetValue(
                              BusChartMapMeasure.Name,
                              BusChartMapColumn.Index,
                              CalcAmount(
                                TimeSheetChartSetup,
                                BusChartMapColumn.Name,
                                TimeSheetChartSetup.MeasureIndex2MeasureType(BusChartMapMeasure.Index)));
                        UNTIL NOT NextColumn(BusChartMapColumn);

                UNTIL NOT NextMeasure(BusChartMapMeasure);
        END;
    end;

    local procedure AddColumns(var BusChartBuf: Record "Business Chart Buffer")
    var
        UserSetup: Record "User Setup";
        Resource: Record Resource;
    begin
        IF NOT UserSetup.GET(USERID) THEN
            EXIT;

        Resource.SETRANGE("Use Time Sheet", TRUE);
        IF NOT UserSetup."Time Sheet Admin." THEN
            Resource.SETRANGE("Time Sheet Approver User ID", USERID);
        IF Resource.FINDSET THEN
            REPEAT
                BusChartBuf.AddColumn(Resource."No.");
            UNTIL Resource.NEXT = 0;
    end;

    local procedure AddMeasures(var BusChartBuf: Record "Business Chart Buffer"; TimeSheetChartSetup: Record "Time Sheet Amount Chart Setup")
    begin
        WITH BusChartBuf DO BEGIN
            CASE TimeSheetChartSetup."Show by" OF
                TimeSheetChartSetup."Show by"::Status:
                    BEGIN
                        AddMeasure(GetMeasureCaption(MeasureType::Open), '', "Data Type"::Decimal, "Chart Type"::StackedColumn);
                        AddMeasure(GetMeasureCaption(MeasureType::Submitted), '', "Data Type"::Decimal, "Chart Type"::StackedColumn);
                        AddMeasure(GetMeasureCaption(MeasureType::Rejected), '', "Data Type"::Decimal, "Chart Type"::StackedColumn);
                        AddMeasure(GetMeasureCaption(MeasureType::Approved), '', "Data Type"::Decimal, "Chart Type"::StackedColumn);
                    END;
                TimeSheetChartSetup."Show by"::Type:
                    BEGIN
                        AddMeasure(GetMeasureCaption(MeasureType::Resource), '', "Data Type"::Decimal, "Chart Type"::StackedColumn);
                        AddMeasure(GetMeasureCaption(MeasureType::Job), '', "Data Type"::Decimal, "Chart Type"::StackedColumn);
                        AddMeasure(GetMeasureCaption(MeasureType::Service), '', "Data Type"::Decimal, "Chart Type"::StackedColumn);
                        AddMeasure(GetMeasureCaption(MeasureType::Absence), '', "Data Type"::Decimal, "Chart Type"::StackedColumn);
                        AddMeasure(GetMeasureCaption(MeasureType::"Assembly Order"), '', "Data Type"::Decimal, "Chart Type"::StackedColumn);
                    END;
                TimeSheetChartSetup."Show by"::Posted:
                    BEGIN
                        AddMeasure(GetMeasureCaption(MeasureType::Posted), '', "Data Type"::Decimal, "Chart Type"::StackedColumn);
                        AddMeasure(GetMeasureCaption(MeasureType::"Not Posted"), '', "Data Type"::Decimal, "Chart Type"::StackedColumn);
                    END;
            END;
            AddMeasure(GetMeasureCaption(MeasureType::Scheduled), '', "Data Type"::Decimal, "Chart Type"::Point);
        END;
    end;

    procedure CalcAmount(TimeSheetChartSetup: Record "Time Sheet Amount Chart Setup"; ResourceNo: Code[249]; MType: Integer): Decimal
    var
        Resource: Record Resource;
        TimeSheetHeader: Record "Time Sheet Header";
        TimeSheetPostingEntry: Record "Time Sheet Posting Entry";
    begin
        TimeSheetHeader.SETRANGE("Starting Date", TimeSheetChartSetup."Starting Date");
        TimeSheetHeader.SETRANGE("Resource No.", ResourceNo);
        IF NOT TimeSheetHeader.FINDFIRST THEN
            EXIT(0);

        CASE TimeSheetChartSetup."Show by" OF
            TimeSheetChartSetup."Show by"::Status:
                BEGIN
                    // status option is the same with MType here
                    TimeSheetHeader.SETRANGE("Status Filter", MType);
                    TimeSheetHeader.CALCFIELDS("Chargeble Quantity");
                    Resource.GET(ResourceNo);
                    TimeSheetHeader."Chargeble Quantity" := TimeSheetHeader."Chargeble Quantity" * Resource."Unit Price";
                    EXIT(TimeSheetHeader."Chargeble Quantity");
                END;
            TimeSheetChartSetup."Show by"::Type:
                BEGIN
                    TimeSheetHeader.SETRANGE("Type Filter", MType - 6);
                    TimeSheetHeader.CALCFIELDS("Chargeble Quantity");
                    Resource.GET(ResourceNo);
                    TimeSheetHeader."Chargeble Quantity" := TimeSheetHeader."Chargeble Quantity" * Resource."Unit Price";
                    EXIT(TimeSheetHeader."Chargeble Quantity");
                END;
            TimeSheetChartSetup."Show by"::Posted:
                BEGIN
                    TimeSheetPostingEntry.SETCURRENTKEY("Time Sheet No.", "Time Sheet Line No.");
                    TimeSheetPostingEntry.SETRANGE("Time Sheet No.", TimeSheetHeader."No.");
                    TimeSheetPostingEntry.CALCSUMS(Quantity);
                    TimeSheetHeader.CALCFIELDS("Chargeble Quantity");
                    CASE MType OF
                        MeasureType::Posted:
                            BEGIN
                                Resource.GET(ResourceNo);
                                EXIT(TimeSheetPostingEntry.Quantity * Resource."Unit Price");
                            END;
                        MeasureType::"Not Posted":
                            BEGIN
                                Resource.GET(ResourceNo);
                                EXIT((TimeSheetHeader."Chargeble Quantity" - TimeSheetPostingEntry.Quantity) * Resource."Unit Price");
                            END;
                    END;
                END;
        END;
    end;

    procedure GetMeasureCaption(Type: Option): Text
    var
        TimeSheetChartSetup: Record "Time Sheet Chart Setup";
    begin
        TimeSheetChartSetup.INIT;
        TimeSheetChartSetup."Measure Type" := Type;
        EXIT(FORMAT(TimeSheetChartSetup."Measure Type"));
    end;

    procedure OnOpenPage2(var TimeSheetChartSetup: Record "Time Sheet Amount Chart Setup")
    var
        TimeSheetMgt: Codeunit "Time Sheet Management";
    begin
        WITH TimeSheetChartSetup DO
            IF NOT GET(USERID) THEN BEGIN
                "User ID" := USERID;
                "Starting Date" := TimeSheetMgt.FindNearestTimeSheetStartDate(WORKDATE);
                INSERT;
            END;
    end;
}

