tableextension 51005 "ReportSelectionsExt" extends "Report Selections"
{
    fields
    {
        field(50000; "Attachment Report ID"; Integer)
        {
            Caption = 'Attachment Report ID';
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object ID" WHERE ("Object Type" = CONST (Report));
        }
    }

    //Unsupported feature: Variable Insertion (Variable: **EV**) (VariableCollection) on "SendEmailDirectly(PROCEDURE 50)".


    //Unsupported feature: Variable Insertion (Variable: AttachmentFilePath) (VariableCollection) on "SendEmailDirectly(PROCEDURE 50)".

    //Unsupported feature: Code Modification on "SendEmailDirectly(PROCEDURE 50)".


    //Unsupported feature: Code Modification on "CopyToReportSelection(PROCEDURE 49)".


    local procedure "*EV*"()
    begin
    end;

    local procedure GetAttachmentID(ReportUsage: Integer): Integer
    var
        ReportSelections: Record 77;
    begin
        ReportSelections.SETRANGE(Usage, ReportUsage);
        ReportSelections.SETFILTER("Attachment Report ID", '<>%1', 0);
        IF ReportSelections.FINDFIRST() THEN
            EXIT(ReportSelections."Attachment Report ID");
    end;
}

