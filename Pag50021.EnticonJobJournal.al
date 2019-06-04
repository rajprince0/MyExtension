page 50021 "Enticon Job Journal"
{
    // version EVSP

    // EVSP 150813 New Field : "Job Sub Task No."
    // EVDK 150814 Changed function ReportTimeToHarvest() to use table Job Task instead of Funktionsområde
    // EVAK 161024 New Field : Job Name

    AutoSplitKey = true;
    Caption = 'Job Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Job Journal Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the related job.';

                    trigger OnValidate()
                    begin
                        JobJnlManagement.GetNames(Rec, JobDescription, AccName);
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the related job task number.';
                }
                field("No."; "No.")
                {
                    ApplicationArea = Jobs;
                    Caption = 'No.';
                    ToolTip = 'Specifies the resource, item, or general ledger account number that this entry applies to. The No. must correspond to your selection in the Type field. Choose the field to see the available accounts.';

                    trigger OnValidate()
                    begin
                        JobJnlManagement.GetNames(Rec, JobDescription, AccName);
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the name of the resource, item, or general ledger account to which this entry applies. You can change the description.';
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number of units of the job journal''s No. field, that is, either the resource, item, or G/L account number, that applies. If you later change the value in the No. field, the quantity does not change on the journal line.';
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Work Type Code"; "Work Type Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        JobJnlManagement.GetNames(Rec, JobDescription, AccName);
    end;

    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveJobJnlLine: Codeunit "Job Jnl. Line-Reserve";
    begin
        COMMIT();
        IF NOT ReserveJobJnlLine.DeleteLineConfirm(Rec) THEN
            EXIT(FALSE);
        ReserveJobJnlLine.DeleteLine(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetUpNewLine(xRec);
        CLEAR(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    var
        JobsSetup: Record "Jobs Setup";
        JobJournalBatch: Record "Job Journal Batch";
    begin
        JobsSetup.GET();
        JobsSetup.TESTFIELD("Enticon Batch Name");
        JobJournalBatch.SETRANGE(Name, JobsSetup."Enticon Batch Name");
        JobJournalBatch.FINDFIRST();

        CurrentJnlBatchName := JobsSetup."Enticon Batch Name";
        SETFILTER("Journal Template Name", JobJournalBatch."Journal Template Name");
        JobJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        JobJnlManagement: Codeunit JobJnlManagement;
        ReportPrint: Codeunit 228;
        JobDescription: Text[50];
        AccName: Text[50];
        CurrentJnlBatchName: Code[10];
        ShortcutDimCode: array[8] of Code[20];
        JobName: Text;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD();
        JobJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ReportTimeToHarvest()
    var
        JobTask: Record "Job Task";
    begin
        Rec.FINDSET();
        REPEAT
            JobTask.GET("Job No.", "Job Task No.");
            JobTask.TESTFIELD(JobTask."Project ID Harvest");
            JobTask.TESTFIELD(JobTask."Task ID Harvest");
        UNTIL Rec.NEXT() = 0;

        Rec.FINDSET();
        REPEAT
            JobTask.GET("Job No.", "Job Task No.");

            // CLEAR(XMLMgmt);
            // XMLMgmt.Init('request');

            // XMLMgmt.AddTextParam('notes', Description);
            // XMLMgmt.AddDecParam('hours', Quantity);
            // XMLMgmt.AddDecParam('project_id', JobTask."Project ID Harvest");
            // XMLMgmt.AddDecParam('task_id', JobTask."Task ID Harvest");
            // XMLMgmt.AddTextParam('spent_at', FORMAT("Posting Date", 0, 9));

            // //Second parameter is login:password and then base64-encoded (https://www.base64encode.org/)
            // CASE "No." OF
            //     'DK':
            //         XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'ZGFuLmthcmxzc29uQGV2ZXJlc3Quc2U6c3BvcnRiaWw=');
            //     'GC':
            //         XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'Z3VzdGFmLmNhdmFsbGluQGV2ZXJlc3Quc2U6R3VzdGFmMTE=');
            //     'JC':
            //         XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'am9uYXMuY2FybGJlcmdAZXZlcmVzdC5zZTpuZWxsaW90MjAxNg==');
            //     'LL':
            //         XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'am9uYXMuY2FybGJlcmdAZXZlcmVzdC5zZTpuZWxsaW90MjAxNg==');
            //     'INDID':
            //         XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'am9uYXMuY2FybGJlcmdAZXZlcmVzdC5zZTpuZWxsaW90MjAxNg==');
            //     'WÅ':
            //         XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'am9uYXMuY2FybGJlcmdAZXZlcmVzdC5zZTpuZWxsaW90MjAxNg==');
            //     'NK':
            //         XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'am9uYXMuY2FybGJlcmdAZXZlcmVzdC5zZTpuZWxsaW90MjAxNg==');
            //     'PES':
            //         XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'am9uYXMuY2FybGJlcmdAZXZlcmVzdC5zZTpuZWxsaW90MjAxNg==');
            //     ELSE
            //         ERROR('Add case %1', USERID);
            // END;
        UNTIL Rec.NEXT() = 0;
    end;
}

