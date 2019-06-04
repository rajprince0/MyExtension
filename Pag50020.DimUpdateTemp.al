page 50020 "Dim Update Temp"
{
    PageType = List;
    SourceTable = "Dimension Set Entry";
    SourceTableView = WHERE ("Dimension Name" = CONST ('Objekt'), "Dimension Value Code" = FILTER ('NK | RS | JC | AS | EVEREST'));

    layout
    {
        area(content)
        {
            field("Insert to Entry No."; EntryNo)
            {
                ApplicationArea = All;
                Caption = 'Insert to Entry No.';
                TableRelation = "G/L Entry";
            }
            repeater(Group)
            {
                field("Dimension Set ID"; "Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("Dimension Code"; "Dimension Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension Value Code"; "Dimension Value Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension Value ID"; "Dimension Value ID")
                {
                    ApplicationArea = All;
                }
                field("Dimension Name"; "Dimension Name")
                {
                    ApplicationArea = All;
                }
                field("Dimension Value Name"; "Dimension Value Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Infoga dimension")
            {
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    GLEntry.GET(EntryNo);
                    IF CONFIRM('Vill du uppdatera med %1 i löpnr %2?', TRUE, "Dimension Value Name", GLEntry."Entry No.") THEN BEGIN
                        GLEntry."Global Dimension 2 Code" := "Dimension Value Code";
                        GLEntry."Dimension Set ID" := "Dimension Set ID";
                        GLEntry.MODIFY();
                    END;
                end;
            }
        }
    }

    var
        GLEntry: Record "G/L Entry";
        EntryNo: Integer;
}

