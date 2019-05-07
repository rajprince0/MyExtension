pageextension 50078 AccManagerRoleCenterExt extends "Accounting Manager Role Center"
{
    actions
    {
        addafter("Incoming Documents")
        {
            action("Time Sheets Open")
            {
                Caption = 'Time Sheets Open';
                RunObject = Page "Time Sheet List";
                RunPageView = WHERE ("Submitted Exists" = FILTER (false),
                                     "Rejected Exists" = FILTER (false),
                                     "Approved Exists" = FILTER (false));
            }
            action("Time Sheets Submitted")
            {
                Caption = 'Time Sheets Submitted';
                RunObject = Page "Time Sheet List";
                RunPageView = WHERE ("Submitted Exists" = FILTER (true));
            }
            action("Time Sheets Rejected")
            {
                Caption = 'Time Sheets Rejected';
                RunObject = Page "Time Sheet List";
                RunPageView = WHERE ("Rejected Exists" = FILTER (true));
            }
            action("Time Sheets Approved")
            {
                Caption = 'Time Sheets Approved';
                RunObject = Page "Time Sheet List";
                RunPageView = WHERE ("Approved Exists" = FILTER (true));
            }
        }
    }
}

