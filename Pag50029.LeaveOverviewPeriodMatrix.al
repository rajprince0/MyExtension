page 50029 "Leave Overview Period Matrix"
{
    // version LPM

    // EVAK 170605 New Object
    // EVKK 190226 New Functions: GetCellDataCompany, OnDrillDownCompany and SetCompany; To run the matrix for different companies

    Caption = 'Leave Overview Period Matrix';
    Editable = false;
    PageType = ListPart;
    SourceTable = Resource;

    layout
    {
        area(content)
        {
            repeater(Control)
            {
                Editable = false;
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Resource No.';
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[1];
                    Caption = 'Field1';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(1);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[2];
                    Caption = 'Field2';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(2);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[3];
                    Caption = 'Field3';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(3);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[4];
                    Caption = 'Field4';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(4);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[5];
                    Caption = 'Field5';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(5);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[6];
                    Caption = 'Field6';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[7];
                    Caption = 'Field7';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(7);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[8];
                    Caption = 'Field8';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[9];
                    Caption = 'Field9';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[10];
                    Caption = 'Field10';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[11];
                    Caption = 'Field11';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[12];
                    Caption = 'Field12';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(12);
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[13];
                    Caption = 'Field13';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(13);
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[14];
                    Caption = 'Field14';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(14);
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[15];
                    Caption = 'Field15';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(15);
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[16];
                    Caption = 'Field16';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(16);
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[17];
                    Caption = 'Field17';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(17);
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[18];
                    Caption = 'Field18';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(18);
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[19];
                    Caption = 'Field19';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(19);
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[20];
                    Caption = 'Field20';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(20);
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[21];
                    Caption = 'Field21';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(21);
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[22];
                    Caption = 'Field22';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(22);
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[23];
                    Caption = 'Field23';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(23);
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[24];
                    Caption = 'Field24';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(24);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[25];
                    Caption = 'Field25';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(25);
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[26];
                    Caption = 'Field26';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(26);
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[27];
                    Caption = 'Field27';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(27);
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[28];
                    Caption = 'Field28';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(28);
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[29];
                    Caption = 'Field29';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(29);
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[30];
                    Caption = 'Field30';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(30);
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[31];
                    Caption = 'Field31';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(31);
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[32];
                    Caption = 'Field32';
                    DecimalPlaces = 0 : 5;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(32);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        MATRIX_CurrentColumnOrdinal: Integer;
        MATRIX_NoOfColumns: Integer;
    begin
        //>>EVKK 190226
        IF LPMSetup."Company Name" = 'Everest Business Solutions AB' THEN
            SETFILTER("No.", '<>%1', 'INDID');
        //<<EVKK 190226

        MATRIX_CurrentColumnOrdinal := 1;
        MATRIX_NoOfColumns := ARRAYLEN(MATRIX_CellData);

        WHILE MATRIX_CurrentColumnOrdinal <= MATRIX_NoOfColumns DO BEGIN
            MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
            MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + 1;
        END;
    end;

    trigger OnOpenPage()
    begin
        //>>EVKK 190226
        LPMSetup.GET;
        //<<EVKK 190226
    end;

    var
        MatrixRecords: array[32] of Record Date;
        MATRIX_CellData: array[32] of Decimal;
        MATRIX_ColumnCaption: array[32] of Text[1024];
        ShowCompany: Boolean;
        LPMSetup: Record "LPM Setup";

    procedure Load(MatrixColumns1: array[32] of Text[1024]; var MatrixRecords1: array[32] of Record Date)
    var
        i: Integer;
    begin
        COPYARRAY(MATRIX_ColumnCaption, MatrixColumns1, 1);
        FOR i := 1 TO ARRAYLEN(MatrixRecords) DO
            MatrixRecords[i].COPY(MatrixRecords1[i]);
    end;

    local procedure MatrixOnDrillDown(ColumnID: Integer)
    var
        LeavePlanEntry: Record 50023;
        LeavePlanEntry2: Record 50023;
        LeavePlan: Record 50020;
        LeavePlanEntries: Page 50035;
    begin
        //>>EVKK 190226
        IF ("No." = 'INDID') OR ShowCompany THEN BEGIN
            OnDrillDownCompany(ColumnID);
            EXIT;
        END;
        //<<EVKK 190226
        LeavePlan.SETRANGE("Resource No.", "No.");
        LeavePlan.SETFILTER(Status, '%1|%2', LeavePlan.Status::Submitted, LeavePlan.Status::Approved);
        IF LeavePlan.FINDSET THEN BEGIN
            REPEAT
                LeavePlanEntry.SETRANGE("LeavePlan No.", LeavePlan."No.");
                LeavePlanEntry.SETFILTER(Date, '%1..%2', MatrixRecords[ColumnID]."Period Start", MatrixRecords[ColumnID]."Period End");
                IF LeavePlanEntry.FINDSET THEN
                    REPEAT
                        LeavePlanEntry2 := LeavePlanEntry;
                        LeavePlanEntry2.MARK(TRUE);
                    UNTIL LeavePlanEntry.NEXT = 0;
            UNTIL LeavePlan.NEXT = 0;
        END;

        LeavePlanEntry2.MARKEDONLY(TRUE);

        LeavePlanEntries.SETTABLEVIEW(LeavePlanEntry2);
        LeavePlanEntries.RUN;
    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    begin
        MATRIX_CellData[ColumnID] := GetCellData(ColumnID);
    end;

    local procedure GetCellData(ColumnID: Integer): Decimal
    var
        LeavePlan: Record "Leave Plan";
        TotalHours: Decimal;
    begin
        //>>EVKK 190226
        IF "No." = 'INDID' THEN BEGIN
            GetCellDataCompany(TotalHours, ColumnID);
            EXIT(TotalHours);
        END;

        IF ShowCompany THEN
            LeavePlan.CHANGECOMPANY(LPMSetup."Company Name")
        ELSE
            LeavePlan.CHANGECOMPANY(CURRENTCOMPANY);
        //<<EVKK 190226

        LeavePlan.SETRANGE("Resource No.", "No.");
        LeavePlan.SETFILTER(Status, '%1|%2', LeavePlan.Status::Submitted, LeavePlan.Status::Approved);
        LeavePlan.SETFILTER("Date Filter", '%1..%2', MatrixRecords[ColumnID]."Period Start", MatrixRecords[ColumnID]."Period End");
        IF LeavePlan.FINDSET THEN BEGIN
            REPEAT
                LeavePlan.CALCFIELDS(Hours);
                TotalHours += LeavePlan.Hours;
            UNTIL LeavePlan.NEXT = 0;
        END;

        EXIT(TotalHours);
    end;

    procedure GetCellDataCompany(var TotalHours: Decimal; ColumnID: Integer)
    var
        LeavePlan: Record "Leave Plan";
    begin
        LeavePlan.CHANGECOMPANY(LPMSetup."Company Name");
        LeavePlan.SETFILTER(Status, '%1|%2', LeavePlan.Status::Submitted, LeavePlan.Status::Approved);
        LeavePlan.SETFILTER("Date Filter", '%1..%2', MatrixRecords[ColumnID]."Period Start", MatrixRecords[ColumnID]."Period End");
        IF LeavePlan.FINDSET THEN BEGIN
            REPEAT
                LeavePlan.CALCFIELDS(Hours);
                TotalHours += LeavePlan.Hours;
            UNTIL LeavePlan.NEXT = 0;
        END;
    end;

    local procedure OnDrillDownCompany(ColumnID: Integer)
    var
        LeavePlan: Record "Leave Plan";
        LeavePlanEntry: Record "Leave Plan Entry";
        LeavePlanEntry2: Record "Leave Plan Entry";
    begin
        LeavePlan.CHANGECOMPANY(LPMSetup."Company Name");
        LeavePlanEntry.CHANGECOMPANY(LPMSetup."Company Name");
        LeavePlanEntry2.CHANGECOMPANY(LPMSetup."Company Name");

        IF ShowCompany THEN
            LeavePlan.SETRANGE("Resource No.", "No.");

        LeavePlan.SETFILTER(Status, '%1|%2', LeavePlan.Status::Submitted, LeavePlan.Status::Approved);
        IF LeavePlan.FINDSET THEN BEGIN
            REPEAT
                LeavePlanEntry.SETRANGE("LeavePlan No.", LeavePlan."No.");
                LeavePlanEntry.SETFILTER(Date, '%1..%2', MatrixRecords[ColumnID]."Period Start", MatrixRecords[ColumnID]."Period End");
                IF LeavePlanEntry.FINDSET THEN
                    REPEAT
                        LeavePlanEntry2 := LeavePlanEntry;
                        LeavePlanEntry2.MARK(TRUE);
                    UNTIL LeavePlanEntry.NEXT = 0;
            UNTIL LeavePlan.NEXT = 0;
        END;

        LeavePlanEntry2.MARKEDONLY(TRUE);

        PAGE.RUNMODAL(PAGE::"Leave Plan Entries", LeavePlanEntry2);
    end;

    procedure SetCompany(Show: Boolean)
    begin
        IF Show THEN
            CHANGECOMPANY(LPMSetup."Company Name")
        ELSE
            CHANGECOMPANY(COMPANYNAME);

        ShowCompany := Show;
    end;
}

