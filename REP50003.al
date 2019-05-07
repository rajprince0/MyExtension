report 50003 "Detailed Invoice"
{

    DefaultLayout = RDLC;
    RDLCLayout = './Detailed Invoice.rdlc';

    Caption = 'Detailed Invoice';
    PreviewMode = PrintLayout;
    UseRequestPage = true;

    dataset
    {
        dataitem(CompanyInformation; 79)
        {
            DataItemTableView = SORTING ("Primary Key");
            column(Picture; Picture)
            {
            }
            column(Logo; 1)
            {
            }
        }
        dataitem(SalesInvoiceHeader; 112)
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING (Number);
                column(Header00; 1)
                {
                }
                column(DataArray; ArrayData)
                {
                }
                column(Header01; FORMAT(SalesInvoiceHeader."No.") + SLN(Number))
                {
                }
                column(TotalCaptionLbl; TotalCaptionLbl)
                {
                }
                column(ShipDateLbl; ShipmentDateCaption)
                {
                }
                dataitem(SalesInvoiceLine; 113)
                {
                    DataItemLink = "Document No." = FIELD ("No.");
                    DataItemLinkReference = SalesInvoiceHeader;
                    DataItemTableView = SORTING ("Document No.", "Line No.");
                    column(Line00; 1)
                    {
                    }
                    column(Line01; FORMAT("Document No.") + SLN("Line No."))
                    {
                    }
                    column(Line02; "No.")
                    {
                    }
                    column(Line03; "Variant Code")
                    {
                    }
                    column(Line04; Description)
                    {
                    }
                    column(Line05; "Description 2")
                    {
                    }
                    column(Line06; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(Line07; NotInUse)
                    {
                    }
                    column(Line08; "Unit of Measure")
                    {
                    }
                    column(Line09; "Unit Price")
                    {
                        AutoFormatExpression = SalesInvoiceLine.GetCurrencyCode;
                    }
                    column(Line10; "Line Discount %")
                    {
                        DecimalPlaces = 0 : 2;
                    }
                    column(Line11; "Line Discount Amount")
                    {
                        AutoFormatExpression = SalesInvoiceLine.GetCurrencyCode;
                    }
                    column(Line12; "Inv. Discount Amount")
                    {
                        AutoFormatExpression = SalesInvoiceLine.GetCurrencyCode;
                    }
                    column(Line13; "Line Amount")
                    {
                        AutoFormatExpression = SalesInvoiceLine.GetCurrencyCode;
                    }
                    column(Line14; ShipmentDate)
                    {
                    }
                    column(Line15; "Cross-Reference No.")
                    {
                    }
                    column(Line16; NotInUse)
                    {
                    }
                    column(Line17; NotInUse)
                    {
                    }
                    column(Line18; NotInUse)
                    {
                    }
                    column(IsTextLine; IsTextLine)
                    {
                    }
                    column(Sales_Invoice_Line_Job_No_; SalesInvoiceLine."Job No.")
                    {
                    }
                    column(Sales_Invoice_Line_Job_Task_No_; SalesInvoiceLine."Job Task No.")
                    {
                    }
                    column(Sales_Invoice_Line_Type_; SalesInvoiceLine.Type)
                    {
                    }
                    column(TypeInt; TypeInt)
                    {
                    }
                    column(Sales_Invoice_Line_Work_Type_Code_; SalesInvoiceLine."Work Type Code")
                    {
                    }
                    column(JobName; GetJobName())
                    {
                    }
                    column(JobTaskName; GetJobTaskName())
                    {
                    }
                    column(ResourceName; GetResourceName())
                    {
                    }
                    column(Sales_Invoice_Line_Work_Type_Code_Caption; FIELDCAPTION(SalesInvoiceLine."Work Type Code"))
                    {
                    }
                    dataitem(LotSerialNos; 2000000026)
                    {
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = FILTER (1 ..));
                        column(SubLine0000; 1)
                        {
                        }
                        column(SubLine0001; LotSerialNoCap)
                        {
                        }
                        column(SubLine0002; LotSerialNo)
                        {
                        }
                        column(SubLine0003; FD2T(-tItemLedgEntry.Quantity, '0:5', ' ', TRUE))
                        {

                        }
                        column(SubLine0004; NotInUse)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                tItemLedgEntry.FINDFIRST()
                            ELSE
                                tItemLedgEntry.NEXT();

                            // CASE TRUE OF
                            //     (tItemLedgEntry."Lot No." <> '') AND (tItemLedgEntry."Serial No." <> ''):
                            //         BEGIN
                            //             LotSerialNo := tItemLedgEntry."Lot No." + '/' + tItemLedgEntry."Serial No.";
                            //             LotSerialNoCap := t.x('Lot No.') + '/' + t.x('Serial No.');
                            //         END;
                            //     (tItemLedgEntry."Lot No." <> '') AND (tItemLedgEntry."Serial No." = ''):
                            //         BEGIN
                            //             LotSerialNo := tItemLedgEntry."Lot No.";
                            //             LotSerialNoCap := t.x('Lot No.');
                            //         END;
                            //     (tItemLedgEntry."Lot No." = '') AND (tItemLedgEntry."Serial No." <> ''):
                            //         BEGIN
                            //             LotSerialNo := tItemLedgEntry."Serial No.";
                            //             LotSerialNoCap := t.x('Serial No.');
                            //         END;
                            //     (tItemLedgEntry."Lot No." = '') AND (tItemLedgEntry."Serial No." = ''):
                            //         BEGIN
                            //             LotSerialNo := '';
                            //             LotSerialNoCap := '';
                            //         END;
                            // END;
                        end;

                        trigger OnPreDataItem()
                        begin
                            // BaseReports.GetLotSerialNos(DATABASE::"Sales Invoice Line", 0, SalesInvoiceLine."Document No.", '', 0, SalesInvoiceLine."Line No.", tItemLedgEntry);

                            tItemLedgEntry.RESET();
                            IF tItemLedgEntry.COUNT() = 0 THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, tItemLedgEntry.COUNT());
                        end;
                    }
                    dataitem(SalesShipmentBuffer; 2000000026)
                    {
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = FILTER (1 ..));
                        column(SubLine0100; 1)
                        {
                        }
                        column(SubLine0101; FDA2T(tSalesShipmentBuffer."Posting Date", TRUE))
                        {
                        }
                        column(SubLine0102; FD2T(tSalesShipmentBuffer.Quantity, '0:5', ' ', TRUE))
                        {

                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                tSalesShipmentBuffer.FINDFIRST()
                            ELSE
                                tSalesShipmentBuffer.NEXT();
                        end;

                        trigger OnPreDataItem()
                        begin
                            tSalesShipmentBuffer.RESET();
                            tSalesShipmentBuffer.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
                            tSalesShipmentBuffer.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
                            IF tSalesShipmentBuffer.COUNT() <= 1 THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, tSalesShipmentBuffer.COUNT());
                        end;
                    }
                    dataitem(AsmInformation; 2000000026)
                    {
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = FILTER (1 ..));
                        column(SubLine0200; 1)
                        {
                        }
                        column(SubLine0201; FORMAT(tPostedAsmLine."Document No.") + FORMAT(tPostedAsmLine."Line No."))
                        {
                        }
                        column(SubLine0202; tPostedAsmLine."No.")
                        {
                        }
                        column(SubLine0203; tPostedAsmLine.Description)
                        {

                        }
                        column(SubLine0204; tPostedAsmLine.Quantity)
                        {
                        }
                        column(SubLine0205; GetUOMText(tPostedAsmLine."Unit of Measure Code"))
                        {

                        }
                        column(SubLine0206; tPostedAsmLine."Variant Code")
                        {

                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                tPostedAsmLine.FINDFIRST()
                            ELSE
                                tPostedAsmLine.NEXT();
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT DisplayAssemblyInformation THEN
                                CurrReport.BREAK();
                            CLEAR(tPostedAsmLine);
                            AddAsmInformation();
                            tPostedAsmLine.RESET();
                            IF tPostedAsmLine.COUNT() <= 1 THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, tPostedAsmLine.COUNT());
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        // IF "Charge Type" = "Charge Type"::Rounding THEN
                        //     CurrReport.SKIP;
                        //IF Type <> Type::Item THEN
                        //  CLEAR("No.");

                        IsTextLine := (Type = Type::" ");

                        /*
                        tSalesShipmentBuffer.RESET;
                        tSalesShipmentBuffer.SETRANGE("Document No.","Document No.");
                        tSalesShipmentBuffer.SETRANGE("Line No.","Line No.");
                        IF tSalesShipmentBuffer.FINDSET THEN BEGIN
                          IF tSalesShipmentBuffer.COUNT = 1 THEN
                            ShipmentDate := FDA2T(tSalesShipmentBuffer."Posting Date",TRUE)
                          ELSE
                            ShipmentDate := '';
                        END ELSE
                        */
                        ShipmentDate := FDA2T("Shipment Date", TRUE);

                        IF (Type <> Type::" ") AND (Quantity = 0) THEN
                            CurrReport.SKIP();

                        tSalesInvLine := SalesInvoiceLine;
                        IF tSalesInvLine.INSERT() THEN;
                        // IF (NOT tSalesInvLine.GET("Document No.", "Text connected to Line No.")) AND
                        //    (SalesInvLine.GET("Document No.", "Text connected to Line No.")) THEN
                        //     CurrReport.SKIP;

                        // BaseReports.GetVATClauses(tVATClause, SalesInvoiceHeader."Language Code", "VAT Bus. Posting Group", "VAT Prod. Posting Group");

                        TypeInt := Type;

                    end;
                }
                dataitem(VATCounter; 2000000026)
                {
                    DataItemTableView = SORTING (Number)
                                        WHERE (Number = FILTER (1 ..));
                    column(VAT00; 1)
                    {
                    }
                    column(VAT01; FD2T(tVATAmountLine."VAT %", '0:2', ' ', FALSE) + ' %')
                    {

                    }
                    column(VAT02; FD2T(tVATAmountLine."VAT Amount", FormatAmount(), ' ', TRUE))
                    {
                    }
                    column(VAT03; FD2T(tVATAmountLine."VAT Base", FormatAmount(), ' ', TRUE))
                    {
                    }
                    column(VAT04; FD2T(tVATAmountLine."Amount Including VAT", FormatAmount(), ' ', TRUE))
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        tVATAmountLine.GetLine(Number);
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF tVATAmountLine.COUNT() = 1 THEN
                            CurrReport.BREAK();
                        IF TotalVATAmount = 0 THEN
                            CurrReport.BREAK();

                        SETRANGE(Number, 1, tVATAmountLine.COUNT());
                    end;
                }
                dataitem(VATClause; 2000000026)
                {
                    DataItemTableView = SORTING (Number);
                    column(VATC00; 1)
                    {
                    }
                    column(VATC01; tVATClause.Code)
                    {
                    }
                    column(VATC02; tVATClause.Description)
                    {
                    }
                    column(VATC03; DELCHR(tVATClause."Description 2", '<>'))
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN
                            tVATClause.FINDSET()
                        ELSE
                            tVATClause.NEXT();
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF tVATClause.COUNT() = 0 THEN
                            CurrReport.BREAK();

                        SETRANGE(Number, 1, tVATClause.COUNT());
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    // IF OnlyOneCopy OR (Number > 1) THEN
                    //     CopyText := t.x('Copy');
                    // CurrReport.PAGENO := 1;

                    // tSalesInvLine.RESET;
                    // tSalesInvLine.DELETEALL;


                    // // Header Data and Captions
                    // DocMgt.ClearAllTexts;

                    // DocMgt.SetHeaderCaption(t.x('Time Report') + CopyText, 1);
                    // DocMgt.SetHeaderCaption(t.x('Page'), 2);
                    // DocMgt.SetHeaderCaption(t.x('Invoice Line 1...'), 5);
                    // DocMgt.SetHeaderCaption(t.x('Invoice Line 2...'), 6);

                    // // Lines
                    // //>>EVST 150818
                    // //DocMgt.SetHeaderCaption(t.x('No.'),7);
                    // DocMgt.SetHeaderCaption(t.x('Name'), 7);
                    // //<<EVST 150818
                    // DocMgt.SetHeaderCaption(t.x('Description'), 8);
                    // DocMgt.SetHeaderCaption(ShipmentDateCaption, 9);
                    // DocMgt.SetHeaderCaption(t.x('Quantity'), 10);
                    // DocMgt.SetHeaderCaption(t.x('Unit of Measure'), 11);
                    // DocMgt.SetHeaderCaption(t.x('Unit Price'), 12);
                    // DocMgt.SetHeaderCaption(t.x('Discount'), 13);
                    // DocMgt.SetHeaderCaption(t.x('Amount'), 14);

                    // // Header
                    // DocMgt.SetDocHeader(CurrReport.OBJECTID(FALSE), SalesInvoiceHeader, t);

                    // // Totals
                    // DocMgt.SetArrayCaption(t.x('Net Amount'), 14);
                    // DocMgt.SetArrayData(FD2T(TotalAmountExclVAT, FormatAmount, ' ', FALSE), 14);


                    // DocMgt.SetArrayCaption(t.x('VAT Amount'), 15);
                    // DocMgt.SetArrayData(FD2T(TotalVATAmount, FormatAmount, ' ', FALSE), 15);

                    // DocMgt.SetArrayCaption(t.x('VAT %'), 16);
                    // DocMgt.SetArrayData(FD2T(VATProc, '0:2', ' ', TRUE), 16);

                    // DocMgt.SetArrayCaption(t.x('Invoice Rounding'), 17);
                    // DocMgt.SetArrayData(FD2T(TotalRoundingAmount, FormatAmount, ' ', FALSE), 17);

                    // DocMgt.SetArrayCaption(t.x('Total Payment'), 18);
                    // DocMgt.SetArrayData(TotalAmountInclVATTxt, 18);

                    // // Vat

                    // DocMgt.SetHeaderCaption(t.x('VAT Specification'), 15);
                    // DocMgt.SetHeaderCaption(VATProcSpecText, 16);
                    // DocMgt.SetHeaderCaption(t.x('VAT Amount'), 17);
                    // DocMgt.SetHeaderCaption(t.x('VAT Net Amount'), 18);
                    // DocMgt.SetHeaderCaption(t.x('VAT Gross Amount'), 19);

                    // DocMgt.SetHeaderData(FD2T(TotalVATAmount, FormatAmount, ' ', FALSE), 2);
                    // DocMgt.SetHeaderData(FD2T(TotalAmountExclVAT, FormatAmount, ' ', FALSE), 3);
                    // DocMgt.SetHeaderData(FD2T(TotalAmountInclVAT - TotalRoundingAmount, FormatAmount, ' ', FALSE), 4);

                    // // Moms i SEK när momspliktig faktura är i utländsk valuta
                    // DocMgt.SetHeaderData(VATTextLCY, 5);

                    // // Used for Setting Correct Page No.
                    // DocMgt.SetHeaderData(FORMAT(SalesInvoiceHeader."No.") + SLN(Number), 10);

                    // // Inv. Discount
                    // DocMgt.SetArrayCaption(t.x('Invoice Discount Amount'), 19);
                    // DocMgt.SetArrayData(FD2T(-TotalInvDiscAmount, '2:2', ' ', TRUE), 19);

                    // ArrayData := GetArrayData;
                end;

                trigger OnPostDataItem()
                begin
                    //>>EVST 150818
                    //IF NOT CurrReport.PREVIEW THEN
                    //  SalesInvCountPrinted.RUN("Sales Invoice Header");
                    //<<EVST 150818
                end;

                trigger OnPreDataItem()
                begin
                    IF OnlyOneCopy THEN
                        NoOfLoops := 1
                    ELSE BEGIN
                        GLSetup.GET();
                        // IF GLSetup."Invoice Copies" = 0 THEN
                        //     NoOfLoops := BillToCust."Invoice Copies" + 1
                        // ELSE
                        //     NoOfLoops := BillToCust."Invoice Copies" + GLSetup."Invoice Copies" + 1;

                        IF NoOfLoops <= 0 THEN
                            NoOfLoops := 1;
                    END;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // t.SetLanguage("Language Code", CurrReport.OBJECTID(FALSE));

                // IF NOT BillToCust.GET("Bill-to Customer No.") THEN CLEAR(BillToCust);
                // IF NOT Salesperson.GET("Salesperson Code") THEN CLEAR(Salesperson);
                // PaymentTermsDescription := t.GetPaymentTranslations("Payment Terms Code");
                // ShipmentMethodDescription := t.GetShipmentMethodTranslation("Shipment Method Code");

                // SalespersonName := Salesperson.Name;

                // IF "Order No." = '' THEN
                //     t.ClearField("Language Code", 'Order No.');
                // IF "VAT Registration No." = '' THEN
                //     t.ClearField("Language Code", 'VAT Registration No.');

                // SalesInvLine.RESET;
                // SalesInvLine.SETRANGE("Document No.", "No.");
                // SalesInvLine.SETFILTER("Line Discount Amount", '<>0');
                // IF SalesInvLine.ISEMPTY THEN
                //     t.ClearField("Language Code", 'Discount');

                IF "Currency Code" = '' THEN BEGIN
                    CurrencyCode := GLSetup."LCY Code";
                    Currency.InitRoundingPrecision();
                END ELSE BEGIN
                    CurrencyCode := "Currency Code";
                    Currency.GET("Currency Code");
                END;

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW() THEN
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '');

                // Beräkna totaler
                CLEAR(TotalRoundingAmount);
                CLEAR(TotalInvDiscAmount);
                CLEAR(TotalAmountInclVAT);
                CLEAR(TotalAmountExclVAT);
                CLEAR(TotalVATAmount);
                tVATAmountLine2.RESET();
                tVATAmountLine2.DELETEALL();
                tSalesShipmentBuffer.RESET();
                tSalesShipmentBuffer.DELETEALL();
                tVATClause.RESET();
                tVATClause.DELETEALL();

                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document No.", "No.");
                SalesInvLine.SETFILTER("Amount Including VAT", '<>0');
                IF SalesInvLine.FINDSET() THEN
                    REPEAT
                        AddSalesShipmentBufferEntry(SalesInvLine);

                        // IF SalesInvLine."Charge Type" = SalesInvLine."Charge Type"::Rounding THEN BEGIN
                        //     TotalRoundingAmount += SalesInvLine."Amount Including VAT";
                        // END ELSE BEGIN
                        //     tVATAmountLine2.RESET;
                        //     tVATAmountLine2."VAT Identifier" := FORMAT(SalesInvLine."VAT %");
                        //     IF NOT tVATAmountLine2.FIND THEN BEGIN
                        //         tVATAmountLine2."VAT %" := SalesInvLine."VAT %";
                        //         tVATAmountLine2.INSERT;
                        //     END;
                        //     TotalAmountExclVAT += SalesInvLine.Amount;
                        // END;

                        TotalAmountInclVAT += SalesInvLine."Amount Including VAT";
                        TotalVATAmount += (SalesInvLine."Amount Including VAT" - SalesInvLine.Amount);
                        TotalInvDiscAmount += SalesInvLine."Inv. Discount Amount";
                    UNTIL SalesInvLine.NEXT() = 0;

                TotalInvDiscAmount := ROUND(TotalInvDiscAmount, Currency."Amount Rounding Precision");
                TotalAmountInclVATTxt := CurrencyCode + '  ' + FD2T(TotalAmountInclVAT, FormatAmount(), ' ', FALSE);

                // Fyll temp-tabell med momsinformation
                SalesInvLine.CalcVATAmountLines(SalesInvoiceHeader, tVATAmountLine);



                tVATAmountLine.RESET();
                IF tVATAmountLine.FINDSET() THEN
                    REPEAT
                        // Radera ev. öresavrundningsrad
                        IF (TotalRoundingAmount = tVATAmountLine."Amount Including VAT") AND
                           (TotalRoundingAmount = tVATAmountLine."VAT Base")
                        THEN
                            tVATAmountLine.DELETE();
                    UNTIL tVATAmountLine.NEXT() = 0;

                CLEAR(VATProc);
                tVATAmountLine2.RESET();
                IF tVATAmountLine2.COUNT() = 1 THEN BEGIN
                    tVATAmountLine2.FINDFIRST();
                    VATProc := tVATAmountLine2."VAT %";
                END;

                // VATProcSpecText := t.x('VAT %');
                // IF VATProc = 0 THEN
                //     t.ClearField("Language Code", 'VAT %');

                // IF TotalInvDiscAmount = 0 THEN
                //     t.ClearField("Language Code", 'Invoice Discount Amount');

                // BaseReports.FormatShipmentDateCaption(t, ShipmentDateCaption);

                // // Moms i SEK när momspliktig faktura är i utländsk valuta
                // IF (NOT ("Currency Factor" IN [0, 1])) AND (TotalVATAmount <> 0) THEN BEGIN
                //     TotalVATAmountLCY := CurrExchangeRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", TotalVATAmount, "Currency Factor");
                //     VATTextLCY := STRSUBSTNO(t.x('VAT Amount in %1 %2'), GLSetup."LCY Code", FD2T(TotalVATAmountLCY, GLSetup."Amount Decimal Places", ' ', FALSE)) +
                //       ' ' + STRSUBSTNO(t.x('Exchange Rate %1'), FD2T(ROUND(1 / "Currency Factor", 0.00001), '0:5', ' ', FALSE));
                // END ELSE
                //     VATTextLCY := '';
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(OnlyOneCopyReq; OnlyOneCopyReq)
                    {
                        Caption = 'Only one Copy';
                        ApplicationArea = all;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = all;
                    }
                    field("Display Asm Information"; DisplayAssemblyInformation)
                    {
                        Caption = 'Show Assembly Components';
                        Visible = false;
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnClosePage()
        begin
            OnlyOneCopy := OnlyOneCopyReq;
        end;

        trigger OnOpenPage()
        begin
            LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';

            LogInteractionEnable := LogInteraction;
            OnlyOneCopyReq := FALSE;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF SalesInvoiceHeader.ISEMPTY() THEN
            CurrReport.QUIT();
        GLSetup.GET();
    end;

    var
        Salesperson: Record "Salesperson/Purchaser";
        GLSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        tSalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        tPostedAsmLine: Record "Posted Assembly Line" temporary;
        tVATAmountLine: Record "VAT Amount Line" temporary;
        tVATAmountLine2: Record "VAT Amount Line" temporary;
        SalesInvLine: Record "Sales Invoice Line";
        tSalesInvLine: Record "Sales Invoice Line" temporary;
        CurrExchangeRate: Record "Currency Exchange Rate";
        BillToCust: Record Customer;
        tItemLedgEntry: Record "Item Ledger Entry" temporary;
        tVATClause: Record "VAT Clause" temporary;
        SegManagement: Codeunit SegManagement;
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        // BaseMgt: Codeunit 12047960;
        // DocMgt: Codeunit 12047969;
        // BaseReports: Codeunit 12047963;
        NotInUse: Text;
        SalespersonName: Text;
        PaymentTermsDescription: Text;
        ShipmentMethodDescription: Text;
        CurrencyCode: Text;
        CopyText: Text;
        ShipmentDateCaption: Text;
        ShipmentDate: Text;
        LogInteraction: Boolean;
        OnlyOneCopy: Boolean;
        OnlyOneCopyReq: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        NoOfLoops: Integer;
        TotalRoundingAmount: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountExclVAT: Decimal;
        TotalVATAmount: Decimal;
        TotalVATAmountLCY: Decimal;
        TotalAmountInclVATTxt: Text;
        VATProc: Decimal;
        VATTextLCY: Text;
        IsTextLine: Boolean;
        DisplayAssemblyInformation: Boolean;
        VATProcSpecText: Text;
        LotSerialNo: Text;
        LotSerialNoCap: Text;
        ArrayData: Text;
        TypeInt: Integer;
        TotalCaptionLbl: Label 'Total';

    procedure GetArrayData(): Text
    begin
        // BaseReports.PlaceAddressLeftOrRight(CurrReport.OBJECTID(FALSE),
        //                                           "Sales Invoice Header",
        //                                           LeftCaption,
        //                                           RightCaption,
        //                                           LeftAddress,
        //                                           RightAddress);

        // DocMgt.SetHeaderCaption(t.x(LeftCaption), 3);
        // DocMgt.SetHeaderCaption(t.x(RightCaption), 4);

        // WITH "Sales Invoice Header" DO BEGIN
        //     EXIT(DocMgt.GetArrayData(SourceType::Customer,
        //                         "Bill-to Customer No.",
        //                         "Currency Code",
        //                         "Bill-to Country/Region Code",
        //                         "Language Code",
        //                         CurrReport.OBJECTID(FALSE),
        //                         LeftAddress,
        //                         RightAddress
        //                         ));
        // END;
    end;

    procedure FD2T(pDecValue: Decimal; pDecimalPlaces: Text; p1000Character: Text; pBlankZero: Boolean): Text
    begin
        // EXIT(BaseReports.Dec2Text(pDecValue, pDecimalPlaces, p1000Character, pBlankZero));
    end;

    procedure FDA2T(pDate: Date; pShortDate: Boolean): Text
    begin
        // EXIT(BaseReports.Date2Text(pDate, pShortDate));
    end;

    procedure FormatUnitPrice(): Text
    begin
        EXIT(Currency."Unit-Amount Decimal Places");
    end;

    procedure FormatAmount(): Text
    begin
        EXIT(Currency."Amount Decimal Places");
    end;

    procedure SLN(pLineNo: Integer): Text
    // var
    //     BaseReports: Codeunit 12047963;
    begin
        // EXIT(BaseReports.SetDocLineNo(pLineNo));
    end;

    procedure GetUOMText(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record 204;
    begin
        IF NOT UnitOfMeasure.GET(UOMCode) THEN
            EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
    end;

    procedure AddSalesShipmentBufferEntry(pSalesInvLine: Record 113)
    var
        ValueEntry: Record 5802;
        ItemLedgerEntry: Record 32;
    begin
        WITH pSalesInvLine DO BEGIN
            IF Type <> Type::Item THEN
                EXIT;
            IF "No." = '' THEN
                EXIT;

            ValueEntry.RESET();
            ValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Document No.", "Document Line No.");
            ValueEntry.SETRANGE("Document Type", ValueEntry."Document Type"::"Sales Invoice");
            ValueEntry.SETRANGE("Document No.", "Document No.");
            ValueEntry.SETRANGE("Document Line No.", "Line No.");
            ValueEntry.SETFILTER("Invoiced Quantity", '<>0');
            IF ValueEntry.FINDFIRST() THEN
                REPEAT
                    ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.");
                    tSalesShipmentBuffer.RESET();
                    tSalesShipmentBuffer.SETRANGE("Document No.", "Document No.");
                    tSalesShipmentBuffer.SETRANGE("Line No.", "Line No.");
                    tSalesShipmentBuffer.SETRANGE("Posting Date", ItemLedgerEntry."Posting Date");
                    IF NOT tSalesShipmentBuffer.FINDFIRST() THEN BEGIN
                        tSalesShipmentBuffer."Document No." := "Document No.";
                        tSalesShipmentBuffer."Line No." := "Line No.";
                        tSalesShipmentBuffer."Entry No." := ValueEntry."Entry No.";
                        tSalesShipmentBuffer.Quantity := -ItemLedgerEntry.Quantity;
                        tSalesShipmentBuffer."Posting Date" := ItemLedgerEntry."Posting Date";
                        tSalesShipmentBuffer.INSERT();
                    END ELSE BEGIN
                        tSalesShipmentBuffer.Quantity += -ItemLedgerEntry.Quantity;
                        tSalesShipmentBuffer.MODIFY();
                    END;
                UNTIL ValueEntry.NEXT() = 0;
        END;
    end;

    procedure AddAsmInformation()
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        tPostedAsmLine.DELETEALL();
        IF SalesInvoiceLine.Type <> SalesInvoiceLine.Type::Item THEN
            EXIT;
        WITH ValueEntry DO BEGIN
            SETCURRENTKEY("Document No.");
            SETRANGE("Document No.", SalesInvoiceLine."Document No.");
            SETRANGE("Document Type", "Document Type"::"Sales Invoice");
            SETRANGE("Document Line No.", SalesInvoiceLine."Line No.");
            SETRANGE(Adjustment, FALSE);
            IF NOT FINDSET() THEN
                EXIT;
        END;
        REPEAT
            IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN
                IF ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" THEN BEGIN
                    SalesShipmentLine.GET(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    IF SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) THEN BEGIN
                        PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                        IF PostedAsmLine.FINDSET() THEN
                            REPEAT
                                TreatAsmLineBuffer(PostedAsmLine);
                            UNTIL PostedAsmLine.NEXT() = 0;
                    END;
                END;
        UNTIL ValueEntry.NEXT() = 0;
    end;

    procedure TreatAsmLineBuffer(PostedAsmLine: Record 911)
    begin
        CLEAR(tPostedAsmLine);
        tPostedAsmLine.SETRANGE(Type, PostedAsmLine.Type);
        tPostedAsmLine.SETRANGE("No.", PostedAsmLine."No.");
        tPostedAsmLine.SETRANGE("Variant Code", PostedAsmLine."Variant Code");
        tPostedAsmLine.SETRANGE(Description, PostedAsmLine.Description);
        tPostedAsmLine.SETRANGE("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        IF tPostedAsmLine.FINDFIRST() THEN BEGIN
            tPostedAsmLine.Quantity += PostedAsmLine.Quantity;
            tPostedAsmLine.MODIFY();
        END ELSE BEGIN
            CLEAR(tPostedAsmLine);
            tPostedAsmLine := PostedAsmLine;
            tPostedAsmLine.INSERT();
        END;
    end;

    local procedure GetJobName(): Text[50]
    var
        Job: Record 167;
    begin
        IF Job.GET(SalesInvoiceLine."Job No.") THEN BEGIN
            IF Job."External Description" <> '' THEN
                EXIT(Job."External Description");

            EXIT(Job.Description);
        END;
    end;

    local procedure GetJobTaskName(): Text[50]
    var
        JobTask: Record "Job Task";
    begin
        IF JobTask.GET(SalesInvoiceLine."Job No.", SalesInvoiceLine."Job Task No.") THEN
            EXIT(JobTask.Description);
    end;

    local procedure GetResourceName(): Text[50]
    var
        Resource: Record Resource;
    begin
        IF Resource.GET(SalesInvoiceLine."No.") THEN
            EXIT(Resource.Name);
    end;
}

