page 50031 "Manage Leave Plan List"
{
    // version LPM

    // EVAK 170519 New Object

    Caption = 'Manager Leave Plan List';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Leave Plan";
    SourceTableView = WHERE (Status = FILTER (<> Created));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = All;
                }
                field("Cause of Absence"; "Cause of Absence")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Hours; Hours)
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Leave Plan Entries";
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Approver User ID"; "Approver User ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Apply Date"; "Apply Date")
                {
                    ApplicationArea = All;
                    Caption = 'Apply Date';
                    Visible = true;
                }
                field("Approve Date"; "Approve Date")
                {
                    ApplicationArea = All;
                    Caption = 'Approve Date';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Reopen)
            {
                Caption = 'Re&open';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                var
                    LeaveMgt: Codeunit 50020;
                begin
                    LeaveMgt.ReopenApproved(Rec);
                end;
            }
            action(Approve)
            {
                Caption = '&Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    LeaveMgt: Codeunit 50020;
                begin
                    LeaveMgt.Approve(Rec);
                end;
            }
            action(Reject)
            {
                Caption = '&Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    LeaveMgt: Codeunit 50020;
                begin
                    LeaveMgt.Reject(Rec);
                end;
            }
            action(Overview)
            {
                Caption = 'Overview';
                Image = ShowMatrix;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PAGE.RUN(PAGE::"Leave Plan By Period");
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        FilterLeavePlan(FIELDNO("Approver User ID"));
    end;
}

