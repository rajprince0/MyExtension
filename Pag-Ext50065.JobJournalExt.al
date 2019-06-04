pageextension 50065 "JobJournalExt" extends "Job Journal"
{
    layout
    {
        addafter("Document Date")
        {
            field(Chargeable; Chargeable)
            {
                ApplicationArea = All;
            }
        }
        addafter("Job No.")
        {
            field("Job Name"; GetJobName())
            {
                ApplicationArea = All;
                Caption = 'Job Name';
                Editable = false;
                Visible = false;
            }
        }
        addafter("Job Task No.")
        {
            field("Job Sub Task No."; "Job Sub Task No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(SuggestLinesFromTimeSheets)
        {
            action("Suggest Lines from Indi:d")
            {
                Caption = 'Suggest Lines from Indi:d';
                Promoted = true;
                PromotedCategory = Process;
                Image = Default;

                trigger OnAction()
                var
                    SuggestJobJnLine: Report 50001;
                begin
                    SuggestJobJnLine.SetJobJnlLine(Rec);
                    SuggestJobJnLine.RUN();
                end;
            }
            action("Report time to Harvest (Star Republic)")
            {
                Caption = 'Report time to Harvest (Star Republic)';
                Image = Default;

                trigger OnAction()
                begin
                    ReportTimeToHarvest();
                end;
            }
        }
    }

    var
        JobName: Text;

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

        // Rec.FINDSET();
        // REPEAT
        //     JobTask.GET("Job No.", "Job Task No.");

        //     CLEAR(XMLMgmt);
        //     XMLMgmt.Init('request');

        //     XMLMgmt.AddTextParam('notes', Description);
        //     XMLMgmt.AddDecParam('hours', Quantity);
        //     XMLMgmt.AddDecParam('project_id', JobTask."Project ID Harvest");
        //     XMLMgmt.AddDecParam('task_id', JobTask."Task ID Harvest");
        //     XMLMgmt.AddTextParam('spent_at', FORMAT("Posting Date", 0, 9));

        //     //Second parameter is login:password and then base64-encoded (https://www.base64encode.org/)
        //     CASE "No." OF
        //         'DK':
        //             XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'ZGFuLmthcmxzc29uQGV2ZXJlc3Quc2U6c3BvcnRiaWw=');
        //         'GC':
        //             XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'Z3VzdGFmLmNhdmFsbGluQGV2ZXJlc3Quc2U6R3VzdGFmMTE=');
        //         'JC':
        //             XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'am9uYXMuY2FybGJlcmdAZXZlcmVzdC5zZTpuZWxsaW90MjAxNg==');
        //         'LL':
        //             XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'am9uYXMuY2FybGJlcmdAZXZlcmVzdC5zZTpuZWxsaW90MjAxNg==');
        //         'INDID':
        //             XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'am9uYXMuY2FybGJlcmdAZXZlcmVzdC5zZTpuZWxsaW90MjAxNg==');
        //         'WÅ':
        //             XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'am9uYXMuY2FybGJlcmdAZXZlcmVzdC5zZTpuZWxsaW90MjAxNg==');
        //         'NK':
        //             XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'am9uYXMuY2FybGJlcmdAZXZlcmVzdC5zZTpuZWxsaW90MjAxNg==');
        //         'PES':
        //             XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'am9uYXMuY2FybGJlcmdAZXZlcmVzdC5zZTpuZWxsaW90MjAxNg==');
        //         ELSE
        //             ERROR('Add case %1', USERID);
        //     END;
        // UNTIL Rec.NEXT = 0;
    end;
}

