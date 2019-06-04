page 99999 "tmp"
{

    layout
    {
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        TimeSheetLine.GET('AS1626', 260000);
        TimeSheetLine.Description := 'Bundles';
        TimeSheetLine.MODIFY();
        MESSAGE('yeah');
    end;

    var
        TimeSheetLine: Record 951;
}

