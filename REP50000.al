report 50000 "Liquidity Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Liquidity Report.rdlc';

    Caption = 'Liquidity Report';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(GLA; 15)
        {
            DataItemTableView = SORTING ("No.")
                                WHERE ("No." = FILTER (1901 .. 1950));
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName())
            {
            }
            // column(CurrReport_PAGENO; CurrReport.PAGENO)
            // {
            // }
            column(USERID; USERID())
            {
            }
            column(DAT; DAT)
            {
            }
            column(GLA__No__; "No.")
            {
            }
            column(GLA_Name; Name)
            {
            }
            column(GLA__Net_Change_; "Net Change")
            {
            }
            column(GLA__Net_Change__Control1100560013; "Net Change")
            {
            }
            column(ACK; ACK)
            {
            }
            column(LikviditetsrapportCaption; LikviditetsrapportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Likvida_medelCaption; Likvida_medelCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Net Change");
                IF "Net Change" <> 0 THEN
                    ACK := ACK + "Net Change";
            end;

            trigger OnPreDataItem()
            begin
                GLA.SETFILTER(GLA."Date Filter", '..%1', DAT);
            end;
        }
        dataitem(CLE; 21)
        {
            DataItemTableView = SORTING (Open, "Due Date")
                                WHERE (Open = CONST (false));
            column(CLE__Document_No__; "Document No.")
            {
            }
            column(CLE__Customer_No__; "Customer No.")
            {
            }
            column(CLE__Remaining_Amt___LCY__; "Remaining Amt. (LCY)")
            {
            }
            column(CLE_Description; Description)
            {
            }
            column(CLE__Due_Date_; FORMAT("Due Date"))
            {
            }
            column(CLE__Remaining_Amt___LCY___Control1100560018; "Remaining Amt. (LCY)")
            {
            }
            column(ACK_Control1100560048; ACK)
            {
            }
            column(KundfordringarCaption; KundfordringarCaptionLbl)
            {
            }
            column(CLE__Due_Date_Caption; FIELDCAPTION("Due Date"))
            {
            }
            column(CLE_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                ACK := ACK + "Remaining Amt. (LCY)";
            end;

            trigger OnPreDataItem()
            begin
                CLE.SETFILTER(CLE."Closed at Date", '%1..', DAT);
            end;
        }
        dataitem(CLEOP; 21)
        {
            DataItemTableView = SORTING (Open, "Due Date")
                                WHERE (Open = CONST (True));
            column(CLEOP__Customer_No__; "Customer No.")
            {
            }
            column(CLEOP__Document_No__; "Document No.")
            {
            }
            column(CLEOP__Remaining_Amt___LCY__; "Remaining Amt. (LCY)")
            {
            }
            column(CLEOP_Description; Description)
            {
            }
            column(CLEOP__Due_Date_; FORMAT("Due Date"))
            {
            }
            column(CLEOP__Remaining_Amt___LCY___Control1100560023; "Remaining Amt. (LCY)")
            {
            }
            column(ACK_Control1100560049; ACK)
            {
            }
            column(OverDueAmount; OverDueAmount)
            {
            }
            column(CLEOP__Due_Date_Caption; FIELDCAPTION("Due Date"))
            {
            }
            column("Kundfordringar__öppna_Caption"; Kundfordringar__öppna_CaptionLbl)
            {
            }
            column("Förfallet_beloppCaption"; Förfallet_beloppCaptionLbl)
            {
            }
            column(CLEOP_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF CLEOP."Due Date" < TODAY() THEN
                    OverDueAmount += "Remaining Amt. (LCY)";

                ACK := ACK + "Remaining Amt. (LCY)";
            end;
        }
        dataitem(VLE; 25)
        {
            DataItemTableView = SORTING (Open, "Due Date")
                                WHERE (Open = CONST (false));
            column(VLE__Original_Amt___LCY__; "Original Amt. (LCY)")
            {
            }
            column(VLE__Due_Date_; FORMAT("Due Date"))
            {
            }
            column(VLE__Document_No__; "Document No.")
            {
            }
            column(VLE_Description; Description)
            {
            }
            column(VLE__Vendor_No__; "Vendor No.")
            {
            }
            column(VLE__Original_Amt___LCY___Control1100560038; "Original Amt. (LCY)")
            {
            }
            column(ACK_Control1100560050; ACK)
            {
            }
            column(VLE__Due_Date_Caption; FIELDCAPTION("Due Date"))
            {
            }
            column("LeverantörsskulderCaption"; LeverantörsskulderCaptionLbl)
            {
            }
            column(VLE_Entry_No_; "Entry No.")
            {
            }
            // column(VLE_VPPackNo; "PEB VP Pack No.")
            // {
            //     IncludeCaption = true;
            // }

            trigger OnAfterGetRecord()
            begin
                ACK := ACK + "Original Amt. (LCY)";
            end;

            trigger OnPreDataItem()
            begin
                VLE.SETFILTER(VLE."Closed at Date", '%1..', DAT);
            end;
        }
        dataitem(VLEOP; 25)
        {
            DataItemTableView = SORTING (Open, "Due Date")
                                WHERE (Open = CONST (true));
            column(VLEOP__Vendor_No__; "Vendor No.")
            {
            }
            column(VLEOP__Original_Amt___LCY__; "Original Amt. (LCY)")
            {
            }
            column(VLEOP__Due_Date_; FORMAT("Due Date"))
            {
            }
            column(VLEOP__Document_No__; "Document No.")
            {
            }
            column(VLEOP_Description; Description)
            {
            }
            column(VLEOP__Original_Amt___LCY___Control1100560037; "Original Amt. (LCY)")
            {
            }
            column(VLEOP__Due_Date_Caption; FIELDCAPTION("Due Date"))
            {
            }
            column("Leverantörsskulder__öppna_Caption"; Leverantörsskulder__öppna_CaptionLbl)
            {
            }
            column(VLEOP_Entry_No_; "Entry No.")
            {
            }
            // column(VLEOP_VPPackNo; "PEB VP Pack No.")
            // {
            //     IncludeCaption = true;
            // }
        }
        dataitem(GLAM; 15)
        {
            DataItemTableView = SORTING ("No.")
                                WHERE ("No." = FILTER (2258 | 2440 | 2611 .. 2645 | 2650 | 2710 | 2940));
            column(GLAM__Net_Change_; "Net Change")
            {
            }
            column(GLAM_Name; Name)
            {
            }
            column(GLAM__No__; "No.")
            {
            }
            column(GLAM__Net_Change__Control1100560056; "Net Change")
            {
            }
            column(ACK_Control1100560057; ACK)
            {
            }
            column(Moms_och_SkattCaption; Moms_och_SkattCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Net Change");
                IF "Net Change" <> 0 THEN
                    ACK := ACK + "Net Change";
            end;

            trigger OnPreDataItem()
            begin
                GLAM.SETFILTER(GLAM."Date Filter", '..%1', DAT);
            end;
        }
        dataitem(PIA; 2000000026)
        {
            DataItemTableView = SORTING (Number)
                                WHERE (Number = CONST (1));
            column(g_decPIA; g_decPIA)
            {
            }
            column(ACK_Control1100560061; ACK)
            {
            }
            column(g_decPIA2; g_decPIA2)
            {
            }
            column(ProjektjournalCaption; ProjektjournalCaptionLbl)
            {
            }
            column("Ej_bokförtCaption"; Ej_bokförtCaptionLbl)
            {
            }
            column("Bokfört_ej_faktureratCaption"; Bokfört_ej_faktureratCaptionLbl)
            {
            }
            column(PIA_Number; Number)
            {
            }

            trigger OnAfterGetRecord()
            var
                l_recJobJournalLine: Record 210;
                l_recJobLedgerEntry: Record 169;
            begin
                IF l_recJobJournalLine.FIND('-') THEN
                    REPEAT
                        g_decPIA += l_recJobJournalLine."Total Price";

                    UNTIL l_recJobJournalLine.NEXT() = 0;

                //l_recJobLedgerEntry.SETRANGE(Open,TRUE);
                l_recJobLedgerEntry.SETRANGE("Source Code", 'PROJJNL');
                IF l_recJobLedgerEntry.FIND('-') THEN
                    REPEAT
                        g_decPIA2 += l_recJobLedgerEntry."Total Price";

                    UNTIL l_recJobLedgerEntry.NEXT() = 0;

                ACK += g_decPIA + g_decPIA2;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DAT; DAT)
                    {
                        Caption = 'Posting Date';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        //ERS 150910 <<
        //DAT:=CALCDATE('-1Y',TODAY);
        DAT := CALCDATE('+<1Å>', TODAY());
        //ERS 150910 >>
    end;

    var
        DAT: Date;
        ACK: Decimal;
        g_decPIA: Decimal;
        g_decPIA2: Decimal;
        OverDueAmount: Decimal;
        LikviditetsrapportCaptionLbl: Label 'Likviditetsrapport';
        CurrReport_PAGENOCaptionLbl: Label 'Sida';
        Likvida_medelCaptionLbl: Label 'Likvida medel';
        KundfordringarCaptionLbl: Label 'Kundfordringar';
        "Kundfordringar__öppna_CaptionLbl": Label 'Kundfordringar (öppna)';
        "Förfallet_beloppCaptionLbl": Label 'Förfallet belopp';
        "LeverantörsskulderCaptionLbl": Label 'Leverantörsskulder';
        "Leverantörsskulder__öppna_CaptionLbl": Label 'Leverantörsskulder (öppna)';
        Moms_och_SkattCaptionLbl: Label 'Moms och Skatt';
        ProjektjournalCaptionLbl: Label 'Projektjournal';
        "Ej_bokförtCaptionLbl": Label 'Ej bokfört';
        "Bokfört_ej_faktureratCaptionLbl": Label 'Bokfört ej fakturerat';
        LastYearLbl: Label 'LY';
}

