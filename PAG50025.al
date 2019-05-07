page 50025 "Job Sub Task Card"
{
    // version #1973

    // EVPK 190404 #1973 New Object

    Caption = 'Job Sub Task Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Job Sub Task";

    layout
    {
        area(content)
        {
            group(Control)
            {
                field("Job Sub Task No."; "Job Sub Task No.")
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                }
                field(JobName; GetJobName)
                {
                    ApplicationArea = All;
                    Caption = 'Customer Name';
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Reference"; "Customer Reference")
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
                field(Budget; Budget)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Assigned By"; "Assigned By")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field("Utilised Hours"; "Utilised Hours")
                {
                    ApplicationArea = All;
                }
                field("Non-Chargeable Hours"; "Non-Chargeable Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Non-Chargeable Hours';
                }
                field("Remaining Hours"; Budget - "Utilised Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Remaining Hours';
                }
                field("Task Progress"; "Task Progress")
                {
                    ApplicationArea = All;
                }
                field("Delivery Date"; "Delivery Date")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Task Creation Date"; "Task Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Task Start Date"; "Task Start Date")
                {
                    ApplicationArea = All;
                }
                field("Task End Date"; "Task End Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
            }
            systempart(Notes; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF ("Job Sub Task No." = '') THEN
            EXIT;

        IF ("Assigned By" <> '') AND ("Delivery Date" <> 0D) AND ("Customer Reference" <> '') THEN
            EXIT;

        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN BEGIN
            IF NOT CONFIRM(Text00) THEN BEGIN
                TESTFIELD("Assigned By");
                TESTFIELD("Delivery Date");
                TESTFIELD("Customer Reference");
            END;
        END;
    end;

    var
        Text00: Label 'Do you want to discard the changes';

    local procedure GetJobName(): Text
    var
        Job: Record Job;
    begin
        IF Job.GET("Job No.") THEN
            EXIT(Job.Description);
    end;
}

