page 50036 "Job Sub Task Cue"
{
    // version #2767

    // EVUK 190423 New Object

    Caption = 'Job Sub Task Cue';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Job Sub Task Cue";

    layout
    {
        area(content)
        {
            cuegroup(Control1)
            {
                field(New; New)
                {

                    trigger OnDrillDown()
                    begin
                        IF IsclearFilter THEN
                            FilterJobTaskEntry(0, FALSE, FALSE, FALSE)
                        ELSE
                            FilterJobTaskEntry(0, TRUE, FALSE, FALSE);
                    end;
                }
                field("In Progress"; "In Progress")
                {

                    trigger OnDrillDown()
                    begin
                        IF IsclearFilter THEN
                            FilterJobTaskEntry(1, FALSE, FALSE, FALSE)
                        ELSE
                            FilterJobTaskEntry(1, TRUE, FALSE, FALSE);
                    end;
                }
                field("In Review"; "In Review")
                {

                    trigger OnDrillDown()
                    begin
                        IF IsclearFilter THEN
                            FilterJobTaskEntry(5, FALSE, FALSE, FALSE)
                        ELSE
                            FilterJobTaskEntry(5, TRUE, FALSE, FALSE);
                    end;
                }
                field("Waiting for Reply"; "Waiting for Reply")
                {

                    trigger OnDrillDown()
                    begin
                        IF IsclearFilter THEN
                            FilterJobTaskEntry(6, FALSE, FALSE, FALSE)
                        ELSE
                            FilterJobTaskEntry(6, TRUE, FALSE, FALSE);
                    end;
                }
            }
            cuegroup(Control2)
            {
                field("On Hold"; "On Hold")
                {

                    trigger OnDrillDown()
                    begin
                        IF IsclearFilter THEN
                            FilterJobTaskEntry(2, FALSE, FALSE, FALSE)
                        ELSE
                            FilterJobTaskEntry(2, TRUE, FALSE, FALSE);
                    end;
                }
                field(Canceled; Canceled)
                {

                    trigger OnDrillDown()
                    begin
                        IF IsclearFilter THEN
                            FilterJobTaskEntry(4, FALSE, FALSE, FALSE)
                        ELSE
                            FilterJobTaskEntry(4, TRUE, FALSE, FALSE);
                    end;
                }
                field(Finished; Finished)
                {

                    trigger OnDrillDown()
                    begin
                        IF IsclearFilter THEN
                            FilterJobTaskEntry(3, FALSE, TRUE, FALSE)
                        ELSE
                            FilterJobTaskEntry(3, TRUE, TRUE, FALSE);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Clear Filter")
            {
                Caption = 'Clear Filter';
                Image = ClearFilter;
                ToolTip = 'Clear Filter';

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                begin
                    IsclearFilter := TRUE;

                    New := FilterJobTaskEntry(0, FALSE, FALSE, TRUE);
                    "In Progress" := FilterJobTaskEntry(1, FALSE, FALSE, TRUE);
                    "On Hold" := FilterJobTaskEntry(2, FALSE, FALSE, TRUE);
                    Finished := FilterJobTaskEntry(3, FALSE, TRUE, TRUE);
                    Canceled := FilterJobTaskEntry(4, FALSE, FALSE, TRUE);
                    "In Review" := FilterJobTaskEntry(5, FALSE, FALSE, TRUE);
                    "Waiting for Reply" := FilterJobTaskEntry(6, FALSE, FALSE, TRUE);
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        DocExchServiceSetup: Record "Doc. Exch. Service Setup";
    begin
        LPMSetup.GET;
        IF IsclearFilter THEN
            EXIT;

        New := FilterJobTaskEntry(0, TRUE, FALSE, TRUE);
        "In Progress" := FilterJobTaskEntry(1, TRUE, FALSE, TRUE);
        "On Hold" := FilterJobTaskEntry(2, TRUE, FALSE, TRUE);
        Finished := FilterJobTaskEntry(3, TRUE, TRUE, TRUE);
        Canceled := FilterJobTaskEntry(4, TRUE, FALSE, TRUE);
        "In Review" := FilterJobTaskEntry(5, TRUE, FALSE, TRUE);
        "Waiting for Reply" := FilterJobTaskEntry(6, TRUE, FALSE, TRUE);
    end;

    trigger OnOpenPage()
    var
        RoleCenterNotificationMgt: Codeunit "Role Center Notification Mgt.";
    begin
    end;

    var
        JobSubTask: Record "Job Sub Task";
        IsclearFilter: Boolean;
        LPMSetup: Record "LPM Setup";
        TempJobSubTask: Record "Job Sub Task" temporary;

    local procedure FilterJobTaskEntry(TaskStatus: Integer; SetUserIdFilter: Boolean; SetDateFilter: Boolean; CountJobSubTask: Boolean): Integer
    var
        Job: Record Job;
        Customer: Record Customer;
        JobSubTaskLines: Page "Job Sub Task Lines";
        UserName: Text;
    begin
        JobSubTask.RESET;
        IF COMPANYNAME <> 'Indi:d AB' THEN BEGIN
            JobSubTask.CHANGECOMPANY(LPMSetup."Company Name");
            Job.CHANGECOMPANY(LPMSetup."Company Name");
            Customer.CHANGECOMPANY(LPMSetup."Company Name");
        END ELSE
            SetUserIdFilter := FALSE;

        JobSubTask.SETRANGE(Status, TaskStatus);
        IF SetUserIdFilter THEN
            JobSubTask.SETRANGE("Assigned By", COPYSTR(USERID, 4, MAXSTRLEN(JobSubTask."Assigned By")));
        IF SetDateFilter THEN
            JobSubTask.SETRANGE("Task End Date", WORKDATE - 30, WORKDATE);
        IF JobSubTask.FINDSET THEN BEGIN
            REPEAT
                IF Job.GET(JobSubTask."Job No.") AND Customer.GET(Job."Bill-to Customer No.") THEN BEGIN
                    IF NOT Customer."Internal Customer" THEN
                        JobSubTask.MARK(TRUE);
                END;
            UNTIL JobSubTask.NEXT = 0;
        END;
        JobSubTask.MARKEDONLY(TRUE);
        IF CountJobSubTask THEN
            EXIT(JobSubTask.COUNT)
        ELSE
            PAGE.RUNMODAL(PAGE::"Job Sub Task Lines", JobSubTask);
    end;
}

