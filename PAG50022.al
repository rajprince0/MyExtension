page 50022 "Leave Plan List"
{
    // version LPM

    // EVAK 170519 New Object

    Caption = 'Leave Plan List';
    CardPageID = "Leave Plan Card";
    DelayedInsert = true;
    Editable = false;
    PageType = List;
    SourceTable = "Leave Plan";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                    Caption = 'Status';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
            }
            action(Submit)
            {
                Caption = '&Submit';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    LeaveMgt: Codeunit 50020;
                begin
                    LeaveMgt.Submit(Rec);
                end;
            }
            action(Reopen)
            {
                Caption = '&Reopen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    LeaveMgt: Codeunit 50020;
                begin
                    LeaveMgt.ReopenSubmitted(Rec);
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
        FilterLeavePlan(FIELDNO("Owner User ID"));
    end;
}

