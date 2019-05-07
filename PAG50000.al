page 50000 "Resource Role Center"
{
    // version EV,#2767

    // EVST 150923 New Page
    // EVAK 170509 New Actions : "Leave Plan New" ,"Leave Plan Submitted" ,
    //                           "Leave Plan Approved" ,"Leave Plan Rejected"
    // EVNR 180727 New Action: 'Search Product'
    // EVUK 190314 New Control : "My Tasks @ Indi:d"

    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control)
            {
                part("Resource Activities"; "Resource Activities")
                {

                }
                part("My Tasks @ Indi:d"; "Job Sub Task Cue")
                {
                    Caption = 'My Tasks @ Indi:d';
                }
                part("Resource Overview Chart"; "Resource Overview Chart")
                {

                }
            }
        }
    }

    actions
    {
        area(embedding)
        {
            action("Time Sheets New")
            {
                Caption = 'Time Sheets New';
                RunObject = Page "Time Sheet List";
                RunPageView = WHERE ("Open Exists" = FILTER (false),
                                    "Submitted Exists" = FILTER (false),
                                    "Rejected Exists" = FILTER (False),
                                    "Approved Exists" = FILTER (false));
            }
            action("Time Sheets Open")
            {
                Caption = 'Time Sheets Open';
                RunObject = Page "Time Sheet List";
                RunPageView = WHERE ("Open Exists" = FILTER (true));
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
            action("Job Sub Task Lines")
            {
                Caption = 'Job Sub Task Lines';
                RunObject = Page 50007;
            }
            action("Leave Plan New")
            {
                Caption = 'Leave Plan New';
                RunObject = Page 50022;
                RunPageView = WHERE (Status = CONST (Created));
            }
            action("Leave Plan Submitted")
            {
                Caption = 'Leave Plan Submitted';
                RunObject = Page 50022;
                RunPageView = WHERE (Status = CONST (Submitted));
            }
            action("Leave Plan Approved")
            {
                Caption = 'Leave Plan Approved';
                RunObject = Page 50022;
                RunPageView = WHERE (Status = CONST (Approved));
            }
            action("Leave Plan Rejected")
            {
                Caption = 'Leave Plan Rejected';
                RunObject = Page 50022;
                RunPageView = WHERE (Status = CONST (Rejected));
            }
        }
        area(processing)
        {
            action("Search Product")
            {
                Caption = 'Search Products';
                Image = Sales;
                Promoted = true;
                RunObject = Page "Job Sub Task Cue";
            }
        }
    }

    var
        TotalCount: Decimal;
}

