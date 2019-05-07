page 50105 "Job Ledger Entries2"
{
    PageType = List;
    SourceTable = "Job Ledger Entry";
    SourceTableView = WHERE ("Entry Type" = CONST (Usage));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Line Amount (LCY)"; "Line Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Total Price"; "Total Price")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; "Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Job Sub Task No."; "Job Sub Task No.")
                {
                    ApplicationArea = All;
                }
                field("Project ID Harvest"; JobTask."Project ID Harvest")
                {
                    Caption = 'Harvest Projekt ID';
                    ApplicationArea = All;
                }
                field("Task ID Harvest"; JobTask."Task ID Harvest")
                {
                    Caption = 'Harvest Task ID';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Skicka till Harvest")
            {

                Image = Default;
                trigger OnAction()
                begin
                    ReportTimeToHarvest();
                end;
            }
            action("Filter")
            {
                Image = Default;
                trigger OnAction()
                begin
                    FINDSET();
                    REPEAT
                        JobTask.GET("Job No.", "Job Task No.");
                        IF (JobTask."Project ID Harvest" = 1071771) AND (JobTask."Task ID Harvest" = 7292625) THEN
                            MARK(TRUE);
                        IF (JobTask."Project ID Harvest" = 1071771) AND (JobTask."Task ID Harvest" = 7292624) THEN
                            MARK(TRUE);
                        IF (JobTask."Project ID Harvest" = 1071775) AND (JobTask."Task ID Harvest" = 7292624) THEN
                            MARK(TRUE);
                    UNTIL NEXT() = 0;
                    MARKEDONLY(TRUE);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF NOT JobTask.GET("Job No.", "Job Task No.") THEN
            CLEAR(JobTask);
    end;

    var
        JobTask: Record "Job Task";

    local procedure ReportTimeToHarvest()
    var
        JobTask: Record "Job Task";
    begin
        IF CONFIRM('Skicka %1 poster?', TRUE, COUNT()) THEN BEGIN
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
        END;
    end;
}

