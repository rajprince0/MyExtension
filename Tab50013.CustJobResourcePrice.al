table 50013 "Cust. Job Resource Price"
{

    fields
    {
        field(1; "Cust. Price Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cust. Price Group';
            TableRelation = "Customer Price Group";
        }
        field(2; Type; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            OptionCaption = 'Resource,Group(Resource),All';
            OptionMembers = Resource,"Group(Resource)",All;

            trigger OnValidate()
            begin
                IF Type <> xRec.Type THEN BEGIN
                    Code := '';
                    Description := '';
                END;
            end;
        }
        field(3; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            TableRelation = IF (Type = CONST (Resource)) Resource
            ELSE
            IF (Type = CONST ("Group(Resource)")) "Resource Group";

            trigger OnValidate()
            var
                Res: Record 156;
                ResGrp: Record 152;
            begin
                IF (Code <> '') AND (Type = Type::All) THEN
                    ERROR(Text000Lbl, FIELDCAPTION(Code), FIELDCAPTION(Type), Type);
                CASE Type OF
                    Type::Resource:
                        BEGIN
                            Res.GET(Code);
                            Description := Res.Name;
                        END;
                    Type::"Group(Resource)":
                        BEGIN
                            ResGrp.GET(Code);
                            "Work Type Code" := '';
                            Description := ResGrp.Name;
                        END;
                    Type::All:
                        BEGIN
                            "Work Type Code" := '';
                            Description := '';
                        END;
                END;
            end;
        }
        field(4; "Work Type Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(5; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                IF "Currency Code" <> xRec."Currency Code" THEN BEGIN
                    "Line Discount %" := 0;
                    "Unit Price" := 0;
                END;
            end;
        }
        field(6; "Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';
        }
        field(7; "Line Discount %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Discount %';
        }
        field(8; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Cust. Price Group", Type, "Code", "Work Type Code", "Currency Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000Lbl: Label '%1 cannot be specified when %2 is %3.';
}

