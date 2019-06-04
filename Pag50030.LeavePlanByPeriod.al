page 50030 "Leave Plan By Period"
{
    // version LPM

    // EVAK 170522 New Object
    // EVKK 190225 New Field: "Company"

    Caption = 'Leave Plan By Period';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SaveValues = true;
    SourceTable = "Leave Plan";

    layout
    {
        area(content)
        {
            group("Matrix Options")
            {
                Caption = 'Matrix Options';
                field(ViewBy; PeriodType)
                {
                    ApplicationArea = All;
                    Caption = 'View by';
                    OptionCaption = 'Day,Week,Month,Quarter,Year';

                    trigger OnValidate()
                    begin
                        SetColumns(SetWanted::Initial);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field(ColumnSet; ColumnSet)
                {
                    ApplicationArea = All;
                    Caption = 'Column Set';
                    Editable = false;
                    Visible = false;
                }
                field(Company; Company)
                {
                    ApplicationArea = All;
                    CaptionClass = txtMyCaption;
                    Caption = 'Company';

                    trigger OnValidate()
                    begin
                        CurrPage.LeavePlanMatrix.PAGE.SetCompany(Company);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            part(LeavePlanMatrix; 50029)
            {
                Caption = 'Leave Plan Matrix';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Previous Set")
            {
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Previous Set';

                trigger OnAction()
                begin
                    SetColumns(SetWanted::Previous);
                end;
            }
            action("Next Set")
            {
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Next Set';

                trigger OnAction()
                begin
                    SetColumns(SetWanted::Next);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.LeavePlanMatrix.PAGE.Load(MatrixColumnCaptions, MatrixRecords);
    end;

    trigger OnOpenPage()
    begin
        //>>EVKK 190225
        CLEAR(Company);

        IF LPMSetup.GET THEN
            txtMyCaption := Text0001 + LPMSetup."Company Name";
        //<<EVKK 190225

        SetColumns(SetWanted::Initial);
    end;

    var
        MatrixRecords: array[32] of Record Date;
        MatrixColumnCaptions: array[32] of Text[1024];
        ColumnSet: Text[1024];
        PKFirstRecInCurrSet: Text[100];
        CurrSetLength: Integer;
        SetWanted: Option Initial,Previous,Same,Next;
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        LPMSetup: Record "LPM Setup";
        Company: Boolean;
        txtMyCaption: Text;
        Text0001: Label 'Show ';

    procedure SetColumns(SetWanted: Option Initial,Previous,Same,Next)
    var
        MatrixMgt: Codeunit "Matrix Management";
    begin
        MatrixMgt.GeneratePeriodMatrixData(SetWanted, 32, FALSE, PeriodType, '',

          PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, MatrixRecords);
    end;
}

