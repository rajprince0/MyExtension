page 50077 "Resource List 2"
{
    // version NAVW110.00

    Caption = 'Resource List';
    CardPageID = "Resource Card";
    Editable = false;
    PageType = List;
    SourceTable = Resource;

    layout
    {
        area(content)
        {
            repeater(Control)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies a number for the resource.';
                }
                field(Name; Name)
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies a description of the resource.';
                }
                field(Type; Type)
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies whether the resource is a person or a machine.';
                }
                field("Base Unit of Measure"; "Base Unit of Measure")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the base unit used to measure the resource, such as hour, piece, or kilometer.';
                }
                field("Resource Group No."; "Resource Group No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the resource group that this resource is assigned to.';
                    Visible = false;
                }
                field("Direct Unit Cost"; "Direct Unit Cost")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the direct cost of the resource per unit of measurement.';
                    Visible = false;
                }
                field("Indirect Cost %"; "Indirect Cost %")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies an additional percentage to cover benefits or administrative costs.';
                    Visible = false;
                }
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the cost of one unit of the resource.';
                }
                field("Price/Profit Calculation"; "Price/Profit Calculation")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the relationship between the Unit Cost, Unit Price, and Profit Percentage fields associated with this resource.';
                }
                field("Profit %"; "Profit %")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the percentage that is calculated based on the calculation option that you select in the Price/Profit Calculation field.';
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies either an amount or value that is calculated based on the calculation option you select in the Price/Profit Calculation field.';
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the resource''s general product posting group. It links business transactions made for this resource with the general ledger to account for the value of trade with the resource.';
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the VAT product posting group to which this resource belongs.';
                    Visible = false;
                }
                field("Search Name"; "Search Name")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies an additional name for the resource for searching purposes.';
                }
                field("Default Deferral Template Code"; "Default Deferral Template Code")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Default Deferral Template';
                    ToolTip = 'Specifies the default template that governs how to defer revenues and expenses to the periods when they occurred.';
                }
            }
        }
        area(factboxes)
        {
            part("Resource Statistics FactBox"; "Resource Statistics FactBox")
            {
                ApplicationArea = Jobs;
                SubPageLink = "No." = FIELD ("No."),
                              "Chargeable Filter" = FIELD ("Chargeable Filter"),
                              "Service Zone Filter" = FIELD ("Service Zone Filter"),
                              "Unit of Measure Filter" = FIELD ("Unit of Measure Filter");
                Visible = true;
            }
            part("Resource Details FactBox"; "Resource Details FactBox")
            {
                ApplicationArea = Jobs;
                SubPageLink = "No." = FIELD ("No."),
                              "Chargeable Filter" = FIELD ("Chargeable Filter"),
                              "Service Zone Filter" = FIELD ("Service Zone Filter"),
                              "Unit of Measure Filter" = FIELD ("Unit of Measure Filter");
                Visible = true;
            }
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Resource")
            {
                Caption = '&Resource';
                Image = Resource;
                action(Statistics)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Resource Statistics";
                    RunPageLink = "No." = FIELD ("No.");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST (Resource),
                                  "No." = FIELD ("No.");
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST (156),
                                      "No." = FIELD ("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                        ToolTip = 'View or edit the single set of dimensions that are set up for the selected record.';
                    }
                    action("Dimensions-&Multiple")
                    {
                        AccessByPermission = TableData 348 = R;
                        ApplicationArea = Jobs;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;
                        ToolTip = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.';

                        trigger OnAction()
                        var
                            Res: Record Resource;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SETSELECTIONFILTER(Res);
                            DefaultDimMultiple.SetMultiResource(Res);
                            DefaultDimMultiple.RUNMODAL;
                        end;
                    }
                }
                action("&Picture")
                {
                    ApplicationArea = Jobs;
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Resource Picture";
                    RunPageLink = "No." = FIELD ("No.");
                    ToolTip = 'View or add a picture of the resource, or for example, the company''s logo.';
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Ledger E&ntries';
                    Image = ResourceLedger;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Resource Ledger Entries";
                    RunPageLink = "Resource No." = FIELD ("No.");
                    RunPageView = SORTING ("Resource No.")
                                  ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                action("E&xtended Texts")
                {
                    ApplicationArea = Suite;
                    Caption = 'E&xtended Texts';
                    Image = Text;
                    RunObject = Page 391;
                    RunPageLink = "Table Name" = CONST (Resource),
                                  "No." = FIELD ("No.");
                    RunPageView = SORTING ("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
                    ToolTip = 'View the extended description that is set up.';
                }
                action("Units of Measure")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Units of Measure';
                    Image = UnitOfMeasure;
                    RunObject = Page "Resource Units of Measure";
                    RunPageLink = "Resource No." = FIELD ("No.");
                    ToolTip = 'View or edit the units of measure that are set up for the resource.';
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics CRM';
                Visible = CRMIntegrationEnabled;
                action(CRMGoToProduct)
                {
                    Caption = 'Product';
                    Image = CoupledItem;
                    ToolTip = 'Open the coupled Microsoft Dynamics CRM product.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(RECORDID);
                    end;
                }
                action(CRMSynchronizeNow)
                {
                    AccessByPermission = TableData 5331 = IM;
                    Caption = 'Synchronize Now';
                    Image = Refresh;
                    ToolTip = 'Send updated data to Microsoft Dynamics CRM.';

                    trigger OnAction()
                    var
                        Resource: Record Resource;
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        ResourceRecordRef: RecordRef;
                    begin
                        CurrPage.SETSELECTIONFILTER(Resource);
                        Resource.NEXT;

                        IF Resource.COUNT = 1 THEN
                            CRMIntegrationManagement.UpdateOneNow(Resource.RECORDID)
                        ELSE BEGIN
                            ResourceRecordRef.GETTABLE(Resource);
                            CRMIntegrationManagement.UpdateMultipleNow(ResourceRecordRef);
                        END
                    end;
                }
                group(Coupling)
                {
                    Caption = 'Coupling', Comment = 'Coupling is a noun';
                    Image = LinkAccount;
                    ToolTip = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.';
                    action(ManageCRMCoupling)
                    {
                        AccessByPermission = TableData 5331 = IM;
                        ApplicationArea = Suite;
                        Caption = 'Set Up Coupling';
                        Image = LinkAccount;
                        ToolTip = 'Create or modify the coupling to a Microsoft Dynamics CRM product.';

                        trigger OnAction()
                        var
                            CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        begin
                            CRMIntegrationManagement.DefineCoupling(RECORDID);
                        end;
                    }
                    action(DeleteCRMCoupling)
                    {
                        AccessByPermission = TableData 5331 = IM;
                        ApplicationArea = Suite;
                        Caption = 'Delete Coupling';
                        Enabled = CRMIsCoupledToRecord;
                        Image = UnLinkAccount;
                        ToolTip = 'Delete the coupling to a Microsoft Dynamics CRM product.';

                        trigger OnAction()
                        var
                            CRMCouplingManagement: Codeunit "CRM Coupling Management";
                        begin
                            CRMCouplingManagement.RemoveCoupling(RECORDID);
                        end;
                    }
                }
            }
            group("&Prices")
            {
                Caption = '&Prices';
                Image = Price;
                action(Costs)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Costs';
                    Image = ResourceCosts;
                    RunObject = Page 203;
                    RunPageLink = Type = CONST (Resource),
                                  Code = FIELD ("No.");
                    ToolTip = 'View or change detailed information about costs for the resource.';
                }
                action(Prices)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page 204;
                    RunPageLink = Type = CONST (Resource),
                                  Code = FIELD ("No.");
                    ToolTip = 'View or edit prices for the resource.';
                }
            }
            group("Plan&ning")
            {
                Caption = 'Plan&ning';
                Image = Planning;
                action("Resource &Capacity")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Resource &Capacity';
                    Image = Capacity;
                    RunObject = Page 213;
                    RunPageOnRec = true;
                    ToolTip = 'View this job''s resource capacity.';
                }
                action("Resource Allocated per Service &Order")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Resource Allocated per Service &Order';
                    Image = ViewServiceOrder;
                    RunObject = Page "Res. Alloc. per Service Order";
                    RunPageLink = "Resource Filter" = FIELD ("No.");
                    ToolTip = 'View the service order allocations of the resource.';
                }
                action("Resource A&vailability")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Resource A&vailability';
                    Image = Calendar;
                    RunObject = Page 225;
                    RunPageLink = "No." = FIELD ("No."),
                                  "Unit of Measure Filter" = FIELD ("Unit of Measure Filter"),
                                  "Chargeable Filter" = FIELD ("Chargeable Filter");
                    ToolTip = 'View a summary of resource capacities, the quantity of resource hours allocated to jobs on order, the quantity allocated to service orders, the capacity assigned to jobs on quote, and the resource availability.';
                }
            }
        }
        area(creation)
        {
            action("New Resource Group")
            {
                ApplicationArea = Jobs;
                Caption = 'New Resource Group';
                Image = NewResourceGroup;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page 72;
                RunPageMode = Create;
                ToolTip = 'Create a new resource.';
            }
        }
        area(reporting)
        {
            action("Resource - List")
            {
                ApplicationArea = Jobs;
                Caption = 'Resource - List';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 1101;
                ToolTip = 'View the list of resources.';
            }
            action("Resource Statistics")
            {
                ApplicationArea = Jobs;
                Caption = 'Resource Statistics';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 1105;
                ToolTip = 'View detailed, historical information for the resource.';
            }
            action("Resource Usage")
            {
                ApplicationArea = Jobs;
                Caption = 'Resource Usage';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 1106;
                ToolTip = 'View the resource utilization that has taken place. The report includes the resource capacity, quantity of usage, and the remaining balance.';
            }
            action("Resource - Cost Breakdown")
            {
                ApplicationArea = Jobs;
                Caption = 'Resource - Cost Breakdown';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 1107;
                ToolTip = 'View the direct unit costs and the total direct costs for each resource. Only usage postings are considered in this report. Resource usage can be posted in the resource journal or the job journal.';
            }
            action("Resource - Price List")
            {
                ApplicationArea = Jobs;
                Caption = 'Resource - Price List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 1115;
                ToolTip = 'Shows a list of unit prices for the selected resources. By default, a unit price is based on the price in the Resource Prices window. If there is no valid alternative price, then the unit price from the resource card is used. The report can be used by the company''s salespeople or sent to customers.';
            }
            action("Resource Register")
            {
                ApplicationArea = Jobs;
                Caption = 'Resource Register';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 1103;
                ToolTip = 'View a list of all the resource registers. Every time a resource entry is posted, a register is created. Every register shows the first and last entry numbers of its entries. You can use the information in a resource register to document when entries were posted.';
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Create Time Sheets")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Create Time Sheets';
                    Ellipsis = true;
                    Image = NewTimesheet;
                    ToolTip = 'Create new time sheets for the selected resource.';

                    trigger OnAction()
                    begin
                        CreateTimeSheets;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        CRMIsCoupledToRecord :=
          CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID) AND CRMIntegrationEnabled;
    end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    begin
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        CHANGECOMPANY('Everest Business Solutions AB');
    end;

    var
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
}

