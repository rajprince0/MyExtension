page 50101 "Time Sheet Lines"
{
    Editable = false;
    PageType = List;
    SourceTable = "Time Sheet Detail";
    SourceTableView = SORTING ("Time Sheet No.", "Time Sheet Line No.", Date)
                      WHERE (Type = CONST (Job),
                            "Job No." = FILTER (<> 55 & <> 58),
                            "Chargeable" = CONST (true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                }
                field("Job Sub Task No."; "Job Sub Task No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        TotalQuantity += Quantity;
    end;

    trigger OnOpenPage()
    begin
        SETFILTER(Date, '%1..%2', DMY2DATE(1, DATE2DMY(TODAY(), 2), DATE2DMY(TODAY(), 3)), TODAY());
    end;

    var
        TotalQuantity: Decimal;
}

