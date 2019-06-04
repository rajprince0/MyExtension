pageextension 50061 "UserSetupExt" extends "User Setup"
{

    layout
    {
        addafter("Time Sheet Admin.")
        {
            field("E-Mail"; "E-Mail")
            {
                ApplicationArea = All;
            }
        }
    }
}

