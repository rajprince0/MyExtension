pageextension 50072 "TimeSheetExt" extends "Time Sheet"
{
    layout
    {

        addafter("Job No.")
        {
            field("Job Description"; "Job Description")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Job Task No.")
        {
            field("Job Task Description"; "Job Task Description")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Job Sub Task No."; "Job Sub Task No.")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CurrPage.SAVERECORD();
                end;

            }
        }
        addafter(ActivityDetailsFactBox)
        {
            part("Billing Summary"; 50110)
            {
                Caption = 'Billing Summary';
                SubPageLink = "No." = FIELD ("Time Sheet No.");
                SubPageView = SORTING ("No.");
                Visible = false;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetUpNewLine();
    end;

}

