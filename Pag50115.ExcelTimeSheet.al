page 50115 "ExcelTimeSheet"
{
    // version Excel

    // EVNKG 170302 New Page

    SourceTable = "TimeSheetManagement";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Client; Client)
                {
                    ApplicationArea = All;
                }
                field("Job Sub Task No."; "Job Sub Task No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                }
                field("Resources Indulged"; "Resources Indulged")
                {
                    ApplicationArea = All;
                }
                field(Budget; Budget)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Utilised Hours"; "Utilised Hours")
                {
                    ApplicationArea = All;
                }
                field("Remaining Hours"; "Remaining Hours")
                {
                    ApplicationArea = All;
                }
                field("Progress Percent"; "Progress Percent")
                {
                    ApplicationArea = All;
                }
                field("Delivery Date"; "Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Resource Progress"; "Resource Progress")
                {
                    ApplicationArea = All;
                }
                field("Estimated Time Required"; "Estimated Time Required")
                {
                    ApplicationArea = All;
                }
                field("Estimated Remaining Time"; "Estimated Remaining Time")
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
    var
        ExcelTS: Record TimeSheetManagement;
    begin
        ExcelTS.GetTaskLines();
        CurrPage.UPDATE(TRUE);
    end;
}

