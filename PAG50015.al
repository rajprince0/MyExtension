page 50015 "Resource Overview Chart"
{
    // version NAVW18.00

    // EVST 150923 New Object

    Caption = 'Resource Overview Chart';
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
                    DrillDown(Rec);
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
                Visible = false;

                trigger OnAction()
                begin
                    ResOverviewChartSetup.FindPeriod(SetWanted::Previous);
                    UpdateStatus;
                end;
            }
            action("Next Period")
            {
                Caption = 'Next Period';
                Image = NextSet;
                Visible = false;

                trigger OnAction()
                begin
                    ResOverviewChartSetup.FindPeriod(SetWanted::Next);
                    UpdateStatus;
                end;
            }
            group("Show by")
            {
                Caption = 'Show by';
                Image = View;
                action(Tasks)
                {
                    Caption = 'Tasks';
                    Image = "Report";

                    trigger OnAction()
                    begin
                        ResOverviewChartSetup.SetShowBy(ResOverviewChartSetup."Show by"::Tasks);
                        UpdateStatus;
                    end;
                }
                action(Hours)
                {
                    Caption = 'Hours';

                    trigger OnAction()
                    begin
                        ResOverviewChartSetup.SetShowBy(ResOverviewChartSetup."Show by"::Hours);
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
        ResOverviewChartSetup: Record "Resource Overview Setup";
        OldResOverviewChartSetup: Record "Resource Overview Setup";
        TimeSheetChartMgt: Codeunit "Time Sheet Chart Mgt.";
        StatusText: Text[250];
        NeedsUpdate: Boolean;
        SetWanted: Option Previous,Next;
        IsChartDataReady: Boolean;
        IsChartAddInReady: Boolean;
        Text001: Label 'Time Sheet Resource';
        MeasureType: Option Tasks,Hours;

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

        OldResOverviewChartSetup := ResOverviewChartSetup;

        IF NeedsUpdate THEN
            StatusText := ResOverviewChartSetup.GetCurrentSelectionText;
    end;

    local procedure IsSetupChanged(): Boolean
    begin
        EXIT(OldResOverviewChartSetup."Show by" <> ResOverviewChartSetup."Show by");
    end;

    procedure UpdateData(var BusChartBuf: Record "Business Chart Buffer")
    var
        ResOverviewChartSetup: Record "Resource Overview Setup";
        BusChartMapColumn: Record "Business Chart Map";
        BusChartMapMeasure: Record "Business Chart Map";
    begin
        ResOverviewChartSetup.GET(USERID);

        WITH BusChartBuf DO BEGIN
            Initialize;
            SetXAxis(Text001, "Data Type"::String);

            AddColumns(BusChartBuf);
            AddMeasures(BusChartBuf, ResOverviewChartSetup);

            IF FindFirstMeasure(BusChartMapMeasure) THEN
                REPEAT
                    IF FindFirstColumn(BusChartMapColumn) THEN
                        REPEAT
                            SetValue(
                              BusChartMapMeasure.Name,
                              BusChartMapColumn.Index,
                              GetReturnValue(
                                BusChartMapColumn.Name, BusChartMapMeasure.Index));
                        UNTIL NOT NextColumn(BusChartMapColumn);

                UNTIL NOT NextMeasure(BusChartMapMeasure);
        END;
    end;

    local procedure AddColumns(var BusChartBuf: Record 485)
    var
        UserSetup: Record "User Setup";
        Resource: Record Resource;
    begin
        IF NOT UserSetup.GET(USERID) THEN
            EXIT;

        Resource.SETRANGE("Use Time Sheet", TRUE);
        //IF NOT UserSetup."Time Sheet Admin." THEN
        //Resource.SETRANGE("Time Sheet Approver User ID",USERID);
        IF Resource.FINDSET THEN
            REPEAT
                BusChartBuf.AddColumn(Resource."No.");
            UNTIL Resource.NEXT = 0;
    end;

    local procedure AddMeasures(var BusChartBuf: Record "Business Chart Buffer"; ResOverviewChartSetup: Record "Resource Overview Setup")
    begin
        WITH BusChartBuf DO BEGIN
            IF ResOverviewChartSetup."Show by" = ResOverviewChartSetup."Show by"::Tasks THEN BEGIN
                AddMeasure('New', '', "Data Type"::Decimal, "Chart Type"::StackedColumn);
                AddMeasure('In Progress', '', "Data Type"::Decimal, "Chart Type"::StackedColumn);
            END ELSE
                AddMeasure('Remaining Hours', '', "Data Type"::Decimal, "Chart Type"::StackedColumn);
        END;
    end;

    procedure GetReturnValue(ResourceNo: Code[249]; MType: Option New,"In Progress") Return: Decimal
    begin
        IF ResOverviewChartSetup."Show by" = ResOverviewChartSetup."Show by"::Tasks THEN
            EXIT(GetTasks(ResourceNo, MType))
        ELSE
            EXIT(GetHours(ResourceNo, MType));
    end;

    local procedure GetTasks(ResourceNo: Code[249]; MType: Option New,"In Progress") NoOfTask: Integer
    var
        Job: Record 167;
        JobSubTask: Record 50012;
        TaskBudgetEntry: Record 50018;
    begin
        JobSubTask.SETRANGE("Resource No.", ResourceNo);
        JobSubTask.SETFILTER(JobSubTask.Status, '=%1', MType);
        IF JobSubTask.FINDSET THEN BEGIN
            REPEAT
                IF Job.GET(JobSubTask."Job No.") AND (Job.Synch) THEN
                    NoOfTask += 1;
            UNTIL JobSubTask.NEXT = 0;
        END;

        IF ResOverviewChartSetup."Show by" = ResOverviewChartSetup."Show by"::Hours THEN BEGIN
            TaskBudgetEntry.SETRANGE("Resource No.", ResourceNo);
            IF TaskBudgetEntry.FINDSET(FALSE) THEN BEGIN
                REPEAT
                    TaskBudgetEntry.CALCFIELDS("Utilised Hours");
                    NoOfTask += (TaskBudgetEntry.Budget - TaskBudgetEntry."Utilised Hours");
                UNTIL TaskBudgetEntry.NEXT = 0;
            END;
        END;

        EXIT(NoOfTask);
    end;

    local procedure GetHours(ResourceNo: Code[249]; MType: Option New,"In Progress") NoOfHours: Decimal
    var
        Job: Record Job;
        JobSubTask: Record "Job Sub Task";
        TaskBudgetEntry: Record "Task Budget Entry";
    begin
        IF ResOverviewChartSetup."Show by" = ResOverviewChartSetup."Show by"::Hours THEN BEGIN
            TaskBudgetEntry.SETRANGE("Resource No.", ResourceNo);
            IF TaskBudgetEntry.FINDSET(FALSE) THEN BEGIN
                REPEAT
                    IF JobSubTask.GET(TaskBudgetEntry."Job Sub Task No.") AND
                      (JobSubTask.Status IN [JobSubTask.Status::New, JobSubTask.Status::"In Progress", JobSubTask.Status::"On Hold"]) THEN BEGIN
                        IF Job.GET(JobSubTask."Job No.") AND (Job.Synch) THEN BEGIN
                            TaskBudgetEntry.CALCFIELDS("Utilised Hours");
                            NoOfHours += (TaskBudgetEntry.Budget - TaskBudgetEntry."Utilised Hours");
                        END;
                    END;
                UNTIL TaskBudgetEntry.NEXT = 0;
            END;
        END;

        EXIT(NoOfHours);
    end;

    procedure GetMeasureCaption(Type: Option): Text
    var
        ResOverviewChartSetup: Record "Resource Overview Setup";
    begin
        ResOverviewChartSetup.INIT;
        ResOverviewChartSetup."Measure Type" := Type;
        EXIT(FORMAT(ResOverviewChartSetup."Measure Type"));
    end;

    procedure DrillDown(var BusChartBuf: Record "Business Chart Buffer")
    var
        Job: Record Job;
        JobSubTask: Record "Job Sub Task";
        TempJobSubTask: Record "Job Sub Task" temporary;
        TaskBudEntry: Record "Task Budget Entry";
        Value: Variant;
        ResourceNo: Code[20];
        CurrMeasureType: Integer;
    begin
        TempJobSubTask.DELETEALL;
        BusChartBuf.GetXValue(BusChartBuf."Drill-Down X Index", Value);
        ResourceNo := FORMAT(Value);

        CurrMeasureType := ResOverviewChartSetup.MeasureIndex2MeasureType(BusChartBuf."Drill-Down Measure Index");

        JobSubTask.SETRANGE("Resource No.", ResourceNo);
        IF ResOverviewChartSetup."Show by" = ResOverviewChartSetup."Show by"::Tasks THEN
            JobSubTask.SETRANGE(Status, CurrMeasureType)
        ELSE
            JobSubTask.SETFILTER(Status, '=%1|=%2', JobSubTask.Status::New, JobSubTask.Status::"In Progress");
        IF JobSubTask.FINDSET(FALSE) THEN BEGIN
            REPEAT
                IF Job.GET(JobSubTask."Job No.") AND (Job.Synch) THEN BEGIN
                    TempJobSubTask.INIT;
                    TempJobSubTask := JobSubTask;
                    TempJobSubTask.INSERT;
                END;
            UNTIL JobSubTask.NEXT = 0;
        END;

        IF ResOverviewChartSetup."Show by" = ResOverviewChartSetup."Show by"::Hours THEN BEGIN
            TaskBudEntry.SETRANGE("Resource No.", ResourceNo);
            IF TaskBudEntry.FINDSET(FALSE) THEN BEGIN
                REPEAT
                    JobSubTask.RESET;
                    IF JobSubTask.GET(TaskBudEntry."Job Sub Task No.") THEN BEGIN
                        IF JobSubTask.Status IN [JobSubTask.Status::New, JobSubTask.Status::"In Progress"] THEN BEGIN
                            IF Job.GET(JobSubTask."Job No.") AND (Job.Synch) THEN BEGIN
                                TempJobSubTask.INIT;
                                TempJobSubTask := JobSubTask;
                                IF TempJobSubTask.INSERT THEN;
                            END;
                        END;
                    END;
                UNTIL TaskBudEntry.NEXT = 0;
            END;
        END;

        PAGE.RUN(PAGE::"Job Sub Task Lines", TempJobSubTask);
    end;

    local procedure GetWorkTypeCode(TimeSheetNo: Code[10]; TimeSheetLineNo: Integer): Code[10]
    var
        TimeSheetLine: Record "Time Sheet Line";
    begin
        IF TimeSheetLine.GET(TimeSheetNo, TimeSheetLineNo) THEN
            EXIT(TimeSheetLine."Work Type Code");
    end;
}

