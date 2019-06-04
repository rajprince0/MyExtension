page 50007 "Job Sub Task Lines"
{
    // version NAVW18.00,EVAK,EVPK,#1973,#3039

    // EVSP 151209 New Object
    // EVNKG 161202 New Page Field : "Delivery Date"
    // EVST 170125 New Fields: "Task Start Date", "Task End Date", "Task Creation Date"
    // EVNKG 170201 New Page Field : Progress
    // EVPK 171108 New Field: "Non-Chargeable Hours"
    // EVAK 171115 New Action : "Modified Objects List"
    // EVAK 171123 Visibility Property of the Control System Part "RecordLinks" is changed to TRUE
    // EVPK 180816 #1973 Added card page, Changed property InsertAllowed -> No and RefreshOnActivate -> Yes
    // EVARA 190419 Added New Function: SetStyle()
    //                                  Notes Visibility makes true


    Caption = 'Job Sub Task Lines';
    DataCaptionFields = "Job Task No.";
    PageType = List;
    SaveValues = true;
    SourceTable = "Job Sub Task";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Job Sub Task No."; "Job Sub Task No.")
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                }
                field("Customer Name"; GetJobName())
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                    Caption = 'Customer Name';
                }
                field("Job Task No."; "Job Task No.")
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                }
                field("Customer Reference"; "Customer Reference")
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                }
                field("Resource No."; "Resource No.")
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                }
                field("Estimated Hours"; "Estimated Hours")
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Budget; Budget)
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Assigned By"; "Assigned By")
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Utilised Hours"; "Utilised Hours")
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                }
                field("Remaining Hours"; Budget - "Utilised Hours")
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                    Caption = 'Remaining Hours';
                }
                field("Non-Chargeable Hours"; "Non-Chargeable Hours")
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Task Progress"; "Task Progress")
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                }
                field("Delivery Date"; "Delivery Date")
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                }
                field("Task Creation Date"; "Task Creation Date")
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                }
                field("Task Start Date"; "Task Start Date")
                {
                    StyleExpr = StyleValue;
                    ApplicationArea = All;
                }
                field("Task End Date"; "Task End Date")
                {
                    StyleExpr = StyleValue;
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
        area(processing)
        {

        }
    }

    trigger OnAfterGetRecord()
    begin
        CLEAR(StyleValue);
        StyleValue := SetStyle;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Job No." := GETFILTER("Job No.");
        "Job Task No." := GETFILTER("Job Task No.");
        "Resource No." := GETFILTER("Resource No.");
    end;

    var
        [InDataSet]
        OtherCompanyName: Text;
        StyleValue: Text;

    local procedure GetJobName(): Text
    var
        Job: Record Job;
    begin
        IF Job.GET("Job No.") THEN
            EXIT(Job.Description);
    end;

    local procedure SetStyle(): Text
    begin
        IF Status = Status::Finished THEN
            EXIT('');

        IF Status = Status::"On Hold" THEN
            EXIT('Subordinate');

        IF (("Delivery Date" <> 0D) AND ("Delivery Date" < TODAY)) THEN
            EXIT('Attention');

        CASE Status OF
            Status::New:
                EXIT('StandardAccent');
            Status::"In Review":
                EXIT('Favorable');
            Status::"Waiting for Reply":
                EXIT('Ambiguous');
            ELSE
                EXIT('');
        END;
    end;
}

