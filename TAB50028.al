table 50028 "Deferral Revenue Summary"
{
    Caption = 'Deferral Revenue Summary';

    fields
    {
        field(1; "Purchase Invoice No."; Code[20])
        {
            Caption = 'Purchase Invoice No.';
            Editable = false;
            TableRelation = "Purch. Inv. Header";
        }
        field(2; "Sales Invoice No."; Code[20])
        {
            Caption = 'Sales Invoice No.';
            Editable = false;
            TableRelation = "Sales Invoice Header";
        }
        field(3; "Purchase Amount"; Decimal)
        {
            CalcFormula = - Sum ("G/L Entry".Amount WHERE ("G/L Account No." = FIELD ("Deferral Purch. Account Filter"),
                                                         "Document Type" = CONST (Invoice),
                                                         "Document No." = FIELD ("Purchase Invoice No."),
                                                         "Posting Date" = FIELD ("Date Filter"),
                                                         "Gen. Posting Type" = FILTER (' ')));
            Caption = 'Purchase Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Sales Amount"; Decimal)
        {
            CalcFormula = Sum ("G/L Entry".Amount WHERE ("Document No." = FIELD ("Sales Invoice No."),
                                                        "G/L Account No." = FIELD ("Deferral Sales Account Filter"),
                                                        "Posting Date" = FIELD ("Date Filter"),
                                                        "Document Type" = CONST (Invoice),
                                                        "Gen. Posting Type" = FILTER (' ')));
            Caption = 'Sales Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(6; "Deferral Sales Account Filter"; Code[20])
        {
            Caption = 'Deferral Sales Account Filter';
            FieldClass = FlowFilter;
            TableRelation = "G/L Account"."No.";
        }
        field(7; "Deferral Purch. Account Filter"; Code[20])
        {
            Caption = 'Deferral Purch. Account Filter';
            FieldClass = FlowFilter;
            TableRelation = "G/L Account"."No.";
        }
        field(8; "Purchase Amount To Deduct"; Decimal)
        {
            CalcFormula = - Sum ("G/L Entry".Amount WHERE ("G/L Account No." = FIELD ("Deferral Purch. Account Filter"),
                                                         "Document Type" = CONST (Invoice),
                                                         "Document No." = FIELD ("Purchase Invoice No."),
                                                         "Posting Date" = FIELD ("Date Filter Deduct"),
                                                         "Gen. Posting Type" = FILTER (' ')));
            Caption = 'Purchase Amount To Deduct';
            FieldClass = FlowField;
        }
        field(9; "Sales Amount to Deduct"; Decimal)
        {
            CalcFormula = Sum ("G/L Entry".Amount WHERE ("Document No." = FIELD ("Sales Invoice No."),
                                                        "G/L Account No." = FIELD ("Deferral Sales Account Filter"),
                                                        "Posting Date" = FIELD ("Date Filter Deduct"),
                                                        "Document Type" = CONST (Invoice),
                                                        "Gen. Posting Type" = FILTER (' ')));
            Caption = 'Sales Amount to Deduct';
            FieldClass = FlowField;
        }
        field(10; "Date Filter Deduct"; Date)
        {
            Caption = 'Date Filter Deduct';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Purchase Invoice No.", "Sales Invoice No.")
        {
        }
    }

    fieldgroups
    {
    }
}

