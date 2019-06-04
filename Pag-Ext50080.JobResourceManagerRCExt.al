pageextension 50080 "JobResourceManagerRCExt" extends "Job Resource Manager RC"
{
    layout
    {
        addfirst(Control1900724808)
        {
            part("Resource Activities"; 50011)
            {
            }
        }
        addafter(Control18)
        {
            part("Generic Chart"; 1390)
            {
                AccessByPermission = TableData 84 = R;
            }
            part("Trial Balance"; 1393)
            {
                AccessByPermission = TableData 17 = R;
            }

        }
    }
    actions
    {
        addafter("Resource - Cost &Breakdown")
        {
            action("Liquidity Report")
            {
                Caption = 'Liquidity Report';
                Image = "Report";
                RunObject = Report 50000;
            }
            action("Resource Billability")
            {
                Caption = 'Resource Billablility';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "Resource Summary";
            }
        }
        addafter("Manager Time Sheets")
        {
            action("Leave Plan New")
            {
                Image = Default;
                Caption = 'Leave Plan New';
                RunObject = Page "Leave Plan List";
                RunPageView = WHERE (Status = CONST (Created));
            }
            action("Leave Plan Submitted")
            {
                Image = Default;
                Caption = 'Leave Plan Submitted';
                RunObject = Page "Leave Plan List";
                RunPageView = WHERE (Status = CONST (Submitted));
            }
            action("Leave Plan Approved")
            {
                Image = Default;
                Caption = 'Leave Plan Approved';
                RunObject = Page "Leave Plan List";
                RunPageView = WHERE (Status = CONST (Approved));
            }
            action("Leave Plan Rejected")
            {
                Image = Default;
                Caption = 'Leave Plan Rejected';
                RunObject = Page "Leave Plan List";
                RunPageView = WHERE (Status = CONST (Rejected));
            }
            action("<Page Manage Leave Plan List>")
            {
                Image = Default;
                Caption = 'Manager Leave Plans';
                RunObject = Page 50031;
                RunPageView = WHERE (Status = FILTER (<> Created));
            }
            action("Sales Invoices")
            {
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page 9301;
            }
            action("Posted Sales Invoices")
            {
                Caption = 'Posted Sales Invoices';
                Image = Invoice;
                RunObject = Page 143;
            }
            action("Sales Credit Memos")
            {
                Caption = 'Sales Credit Memos';
                Image = CreditMemo;
                RunObject = Page 9302;
            }
            action("Posted Sales Credit Memos")
            {
                Caption = 'Posted Sales Credit Memos';
                Image = CreditMemo;
                RunObject = Page 144;
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page 22;
            }
            action("Resource Time Bank")
            {
                Image = Default;
                Caption = 'Resource Time Bank';
                RunObject = Page "Resource Time Bank";
            }
        }
        addafter("Create Time Sheets")
        {
            action("Add Resource Capacity")
            {
                Caption = 'Add Resource Capacity';
                Image = Capacity;
                RunObject = Report 50004;
            }
            action("Job Journal")
            {
                Caption = 'Job Journal';
                Image = Journals;
                RunObject = Page 201;
            }
            action("Job Sub Task Lines")
            {
                Caption = 'Job Sub Task Lines';
                Image = JobLines;
                RunObject = Page 50007;
            }
            action("Billing Summary")
            {
                Caption = 'Billing Summary';
                Image = Invoice;
                RunObject = Page 50112;
            }
        }
    }
}

