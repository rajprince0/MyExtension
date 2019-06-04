pageextension 50082 "EmailDialogExt" extends "Email Dialog"
{
    layout
    {
        addafter("Attachment Name")
        {
            field("Attachment Name2"; EmailItem."Attachment Name 2")
            {
                ApplicationArea = All;
                Caption = 'Attachment Name 2';
                Visible = HasAttachment2;

            }
        }
    }

    var
        "*EV*": Integer;
        HasAttachment2: Boolean;

        EmailItem: Record 9500;


        //Unsupported feature: Code Modification on "OnOpenPage".

        //Unsupported feature: Code Modification on "SetValues(PROCEDURE 1)".

}

