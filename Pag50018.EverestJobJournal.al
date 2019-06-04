page 50018 "Everest Job Journal"
{
    // version EVPK

    // EVPK 161206 New Object
    // EVSP 170207 Save Filter after posting

    AutoSplitKey = true;
    Caption = 'Everest Job Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SaveValues = true;
    SourceTable = 210;

    layout
    {
        area(content)
        {
            repeater(Content1)
            {
                field("Line Type"; "Line Type")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Chargeable; Chargeable)
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate();
                    begin
                        JobJnlManagement.GetNames(Rec, JobDescription, AccName);
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Job Name"; GetJobName())
                {
                    ApplicationArea = All;
                    Caption = 'Job Name';
                    Editable = false;
                    Visible = false;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("Job Sub Task No."; "Job Sub Task No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    trigger OnValidate();
                    begin
                        JobJnlManagement.GetNames(Rec, JobDescription, AccName);
                    end;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate();
                    begin
                        JobJnlManagement.GetNames(Rec, JobDescription, AccName);
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Job Planning Line No."; "Job Planning Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Variant Code"; "Variant Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }


                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (3),
                                                                  "Dimension Value Type" = CONST (Standard),
                                                                  "Blocked" = CONST (false));
                    Visible = false;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (4),
                                                                  "Dimension Value Type" = CONST (Standard),
                                                                  "Blocked" = CONST (false));
                    Visible = false;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (5),
                                                                  "Dimension Value Type" = CONST (Standard),
                                                                  "Blocked" = CONST (false));
                    Visible = false;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (6),
                                                                  "Dimension Value Type" = CONST (Standard),
                                                                  "Blocked" = CONST (false));
                    Visible = false;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (7),
                                                                  "Dimension Value Type" = CONST (Standard),
                                                                  "Blocked" = CONST (false));
                    Visible = false;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (8),
                                                                  "Dimension Value Type" = CONST (Standard),
                                                                  "Blocked" = CONST (false));
                    Visible = false;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; "Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Work Type Code"; "Work Type Code")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnAssistEdit();
                    var
                        ChangeExchangeRate: Page "Change Exchange Rate";
                    begin
                        ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date");
                        IF ChangeExchangeRate.RUNMODAL() = ACTION::OK THEN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());

                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Remaining Qty."; "Remaining Qty.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Direct Unit Cost (LCY)"; "Direct Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Total Cost"; "Total Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Cost (LCY)"; "Total Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Unit Price (LCY)"; "Unit Price (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line Amount"; "Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Line Amount (LCY)"; "Line Amount (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Total Price"; "Total Price")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Total Price (LCY)"; "Total Price (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Applies-to Entry"; "Applies-to Entry")
                {
                    ApplicationArea = All;
                }
                field("Applies-from Entry"; "Applies-from Entry")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Transport Method"; "Transport Method")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Time Sheet No."; "Time Sheet No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Time Sheet Line No."; "Time Sheet Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Time Sheet Date"; "Time Sheet Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            group(Control1)
            {
                fixed(FixedControl)
                {
                    group("Job Description")
                    {
                        Caption = 'Job Description';
                        field(JobDescription; JobDescription)
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                    }
                    group("Account Name")
                    {
                        Caption = 'Account Name';
                        field(AccName; AccName)
                        {
                            ApplicationArea = All;
                            Caption = 'Account Name';
                            Editable = false;
                        }
                    }
                    group("Total Quantity")
                    {
                        Caption = 'Total Quantity';
                        field("<Total Quantity>"; TotalQuantity + "Quantity (Base)" - xRec."Quantity (Base)")
                        {
                            ApplicationArea = All;
                            AutoFormatType = 1;
                            Caption = 'Total Quantity';
                            Visible = TotalQuantityVisible;
                        }
                    }
                    group("Total Line Amount")
                    {
                        Caption = 'Total Line Amount';
                        field("<Total Line Amount>"; TotalLineAmount + "Line Amount (LCY)" - xRec."Line Amount (LCY)")
                        {
                            ApplicationArea = All;
                            AutoFormatType = 1;
                            Caption = 'Total Line Amount';
                            Visible = TotalLineAmountVisible;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction();
                    begin
                        ShowDimensions();
                        CurrPage.SAVERECORD();
                    end;
                }
                action(ItemTrackingLines)
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction();
                    begin
                        OpenItemTrackingLines(FALSE);
                    end;
                }
            }
            group("&Job")
            {
                Caption = '&Job';
                Image = Job;
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Job Card";
                    RunPageLink = "No." = FIELD ("Job No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    RunObject = Page "Job Ledger Entries";
                    RunPageLink = "Job No." = FIELD ("Job No.");
                    RunPageView = SORTING ("Job No.", "Posting Date");
                    ShortCutKey = 'Ctrl+F7';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(CalcRemainingUsage)
                {
                    Caption = 'Calc. Remaining Usage';
                    Ellipsis = true;
                    Image = CalculateRemainingUsage;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    var
                        JobCalcRemainingUsage: Report "Job Calc. Remaining Usage";

                    begin
                        TESTFIELD("Journal Template Name");
                        TESTFIELD("Journal Batch Name");
                        CLEAR(JobCalcRemainingUsage);
                        JobCalcRemainingUsage.SetBatch("Journal Template Name", "Journal Batch Name");
                        JobCalcRemainingUsage.SetDocNo("Document No.");
                        JobCalcRemainingUsage.RUNMODAL();
                    end;
                }
                action(SuggestLinesFromTimeSheets)
                {
                    Caption = 'Suggest Lines from Time Sheets';
                    Ellipsis = true;
                    Image = SuggestLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    var
                        SuggestJobJnlLines: Report "Suggest Job Jnl. Lines";
                    begin
                        SuggestJobJnlLines.SetJobJnlLine(Rec);
                        SuggestJobJnlLines.RUNMODAL();
                    end;
                }
                action("Suggest Lines from Indi:d")
                {
                    Caption = 'Suggest Lines from Indi:d';
                    Promoted = true;
                    Image = Default;
                    PromotedCategory = Process;

                    trigger OnAction();
                    var
                        SuggestJobJnLine: Report "Suggest Job Jnl. Lines";
                    begin
                        SuggestJobJnLine.SetJobJnlLine(Rec);
                        SuggestJobJnLine.RUN();
                    end;
                }
                action("Report time to Harvest (Star Republic)")
                {
                    Caption = 'Report time to Harvest (Star Republic)';
                    Image = Default;

                    trigger OnAction();
                    begin
                        ReportTimeToHarvest();
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Reconcile)
                {
                    Caption = 'Reconcile';
                    Image = Reconcile;
                    ShortCutKey = 'Ctrl+F11';

                    trigger OnAction();
                    begin
                        JobJnlReconcile.SetJobJnlLine(Rec);
                        JobJnlReconcile.RUN();
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction();
                    begin
                        ReportPrint.PrintJobJnlLine(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction();
                    var
                        JobJnlPost: Codeunit "Job Jnl.-Post";
                    begin
                        // JobJnlPost.PostingByJob;
                        JobJnlPost.RUN(Rec);
                        CurrPage.UPDATE(FALSE);
                        SETRANGE("Job No.", JobNo);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction();
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Job Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        JobJnlManagement.GetNames(Rec, JobDescription, AccName);
        UpdateQuantity(Rec, xRec, TotalQuantity, ShowTotalQuantity);
        UpdateLineAmount(Rec, xRec, TotalLineAmount, ShowTotalLineAmount);
    end;

    trigger OnAfterGetRecord();
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnInit();
    begin
        TotalQuantityVisible := TRUE;
        TotalLineAmountVisible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        UpdateQuantity(Rec, xRec, TotalQuantity, ShowTotalQuantity);
        UpdateLineAmount(Rec, xRec, TotalLineAmount, ShowTotalLineAmount);
    end;

    trigger OnOpenPage();
    begin
        SETRANGE("Job No.", JobNo);
    end;

    var
        JobJnlManagement: Codeunit JobJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        JobJnlReconcile: Page "Job Journal Reconcile";
        JobDescription: Text[50];
        AccName: Text[50];
        CurrentJnlBatchName: Code[10];
        ShortcutDimCode: array[8] of Code[20];
        JobName: Text;
        TotalQuantityVisible: Boolean;
        TotalLineAmountVisible: Boolean;
        ShowTotalQuantity: Boolean;
        ShowTotalLineAmount: Boolean;
        TotalQuantity: Decimal;
        TotalLineAmount: Decimal;
        JobNo: Code[20];

    local procedure CurrentJnlBatchNameOnAfterVali();
    begin
        CurrPage.SAVERECORD();
        JobJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ReportTimeToHarvest();
    var
        // XMLMgmt : Codeunit "12058101";
        // Node2 : Automation "{F5078F18-C551-11D3-89B9-0000F81FE221} 6.0:{2933BF80-7B36-11D2-B20E-00C04F983E60}:'Microsoft XML, v6.0'.IXMLDOMNode";
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
        //   JobTask.GET("Job No.","Job Task No.");

        //   CLEAR(XMLMgmt);
        //   XMLMgmt.Init('request');

        //   XMLMgmt.AddTextParam('notes', Description);
        //   XMLMgmt.AddDecParam('hours', Quantity);
        //   XMLMgmt.AddDecParam('project_id', JobTask."Project ID Harvest");
        //   XMLMgmt.AddDecParam('task_id', JobTask."Task ID Harvest");
        //   XMLMgmt.AddTextParam('spent_at', FORMAT("Posting Date", 0, 9));

        //   //Second parameter is login:password and then base64-encoded (https://www.base64encode.org/)
        //   CASE "No." OF
        //     'DK':
        //       XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'ZGFuLmthcmxzc29uQGV2ZXJlc3Quc2U6c3BvcnRiaWw=');
        //     'GC' :
        //       XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'Z3VzdGFmLmNhdmFsbGluQGV2ZXJlc3Quc2U6R3VzdGFmMTE=');
        //     'JC' :
        //       XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'am9uYXMuY2FybGJlcmdAZXZlcmVzdC5zZTpuZWxsaW90MjAxNg==');
        //      'LL' :
        //       XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'am9uYXMuY2FybGJlcmdAZXZlcmVzdC5zZTpuZWxsaW90MjAxNg==');
        //      'INDID' :
        //       XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'am9uYXMuY2FybGJlcmdAZXZlcmVzdC5zZTpuZWxsaW90MjAxNg==');
        //     'WÅ' :
        //       XMLMgmt.Send('https://starrepublic.harvestapp.com/daily/add', 'am9uYXMuY2FybGJlcmdAZXZlcmVzdC5zZTpuZWxsaW90MjAxNg==');
        //   ELSE
        //     ERROR('Add case %1', USERID);
        //   END;
        // UNTIL Rec.NEXT = 0;
    end;

    local procedure UpdateQuantity(var JobJnlLine: Record "Job Journal Line"; LastJobJnlLine: Record "Job Journal Line"; var TotalQuantity: Decimal; var ShowTotalQuantity: Boolean);
    var
        TempJobJnlLine: Record "Job Journal Line";
    begin
        TempJobJnlLine.COPYFILTERS(JobJnlLine);
        ShowTotalQuantity := TempJobJnlLine.CALCSUMS("Quantity (Base)");
        IF ShowTotalQuantity THEN BEGIN
            TotalQuantity := TempJobJnlLine."Quantity (Base)";
            IF JobJnlLine."Line No." = 0 THEN
                TotalQuantity := TotalQuantity + LastJobJnlLine."Quantity (Base)";
        END;
        TotalQuantityVisible := ShowTotalQuantity;
    end;

    local procedure UpdateLineAmount(var JobJnlLine: Record "Job Journal Line"; LastJobJnlLine: Record "Job Journal Line"; var TotalLineAmount: Decimal; var ShowTotalLineAmount: Boolean);
    var
        TempJobJnlLine: Record "Job Journal Line";
    begin
        TempJobJnlLine.COPYFILTERS(JobJnlLine);
        ShowTotalLineAmount := TempJobJnlLine.CALCSUMS("Line Amount (LCY)");
        IF ShowTotalLineAmount THEN BEGIN
            TotalLineAmount := TempJobJnlLine."Line Amount (LCY)";
            IF JobJnlLine."Line No." = 0 THEN
                TotalLineAmount := TotalLineAmount + LastJobJnlLine."Line Amount (LCY)";
        END;
        TotalLineAmountVisible := ShowTotalLineAmount;
    end;

    procedure SetJobNo(NewJobNo: Code[20]);
    begin
        JobNo := NewJobNo;
    end;
}

