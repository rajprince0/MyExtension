page 50028 "Deferral Revenue Summary"
{
    Caption = 'Deferral Revenue Summary';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SaveValues = false;
    SourceTable = "Deferral Revenue Summary";
    SourceTableView = SORTING ("Purchase Invoice No.", "Sales Invoice No.")
                      ORDER(Ascending)
                      WHERE ("Purchase Amount" = FILTER (> 0),
                            "Sales Amount" = FILTER (> 0));

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                field("Purchase Account Filter"; PurchAccountFilter)
                {
                    ApplicationArea = All;
                    TableRelation = "G/L Account"."No.";
                    trigger OnValidate()
                    begin
                        SETFILTER("Deferral Purch. Account Filter", PurchAccountFilter);
                        PurchAccountFilter := GETFILTER("Deferral Purch. Account Filter");
                        CurrPage.UPDATE;
                    end;
                }
                field("Sales Account Filter"; SalesAccountFilter)
                {
                    TableRelation = "G/L Account"."No.";
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        SETFILTER("Deferral Sales Account Filter", SalesAccountFilter);
                        SalesAccountFilter := GETFILTER("Deferral Sales Account Filter");
                        CurrPage.UPDATE;
                    end;
                }
                field(DateFilter; DateFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Date Filter';
                    ToolTip = 'Specifies the date interval by which values are filtered.';

                    trigger OnValidate()
                    var
                        TextManagement: Codeunit TextManagement;
                    begin
                        TextManagement.MakeDateFilter(DateFilter);
                        SETFILTER("Date Filter", DateFilter);
                        DateFilter := GETFILTER("Date Filter");
                        CurrPage.UPDATE;
                    end;
                }
                field(DateFilterDeduct; DateFilterDeduct)
                {
                    Caption = 'Date Filter Deduct';
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        TextManagement: Codeunit TextManagement;
                    begin
                        TextManagement.MakeDateFilter(DateFilter);
                        SETFILTER("Date Filter Deduct", DateFilterDeduct);
                        DateFilterDeduct := GETFILTER("Date Filter Deduct");
                        CurrPage.UPDATE;
                    end;
                }
            }
            repeater(Control)
            {
                field("Purchase Invoice No."; "Purchase Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Amount"; "Purchase Amount")
                {
                    ApplicationArea = All;
                }
                field("Purchase Amount To Deduct"; "Purchase Amount To Deduct")
                {
                    ApplicationArea = All;
                }
                field("Sales Invoice No."; "Sales Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Amount"; "Sales Amount")
                {
                    ApplicationArea = All;
                }
                field("Sales Amount to Deduct"; "Sales Amount to Deduct")
                {
                    ApplicationArea = All;
                }
                field("Margin%"; CalcMargin)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        GLSetup.GET;
        SalesAccountFilter := GLSetup."Deferral Sales Account";
        PurchAccountFilter := GLSetup."Deferral Purchase Account";

        SETFILTER("Deferral Purch. Account Filter", PurchAccountFilter);
        SETFILTER("Deferral Sales Account Filter", SalesAccountFilter);
    end;

    var
        GLSetup: Record "General Ledger Setup";
        DateFilter: Text;
        SalesAccountFilter: Text;
        PurchAccountFilter: Text;
        DateFilterDeduct: Text;

    local procedure CalcMargin(): Decimal
    begin
        CALCFIELDS("Purchase Amount", "Sales Amount");
        IF ("Sales Amount" <> 0) AND ("Purchase Amount" <> 0) THEN
            EXIT((("Sales Amount" - "Purchase Amount") / "Sales Amount") * 100);
    end;
}

