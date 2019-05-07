pageextension 50081 ResourceManagerActExt extends "Resource Manager Activities"
{
    layout
    {
        addafter("Unassigned Resource Groups")
        {
            field("Invoices to post"; "Invoices to post")
            {
                ApplicationArea = All;
                DrillDownPageID = "Sales Invoice List";
            }
        }
    }

    trigger OnOpenPage()
    begin
        SETRANGE("User ID Filter", GetResouceNo());
    end;

    local procedure GetResouceNo(): Code[20]
    var
        Resource: Record 156;
    begin
        Resource.SETRANGE("Time Sheet Owner User ID", USERID());
        IF NOT Resource.FINDFIRST() THEN
            EXIT(Resource."No.");
    end;
}

