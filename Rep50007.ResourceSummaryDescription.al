report 50007 "Resource Summary Description"
{

    DefaultLayout = RDLC;
    RDLCLayout = './Resource Summary Description.rdlc';


    dataset
    {
        dataitem(TimeSheetDetail; 952)
        {
            DataItemTableView = WHERE ("Job No." = FILTER (<> '55' & <> '58'),
                                      "Resource No." = FILTER (<> ' '),
                                      Type = FILTER (Job));
            RequestFilterFields = Date, "Job No.";
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(JobNo; "Job No.")
            {
                IncludeCaption = true;
            }
            column(JobTaskNo; "Job Task No.")
            {
                IncludeCaption = true;
            }
            column(JobSubTaskNo; "Job Sub Task No.")
            {
                IncludeCaption = true;
            }
            column(ResourceNo; "Resource No.")
            {
                IncludeCaption = true;
            }
            column(UtilisedHrs; ChQty)
            {
            }
            column(NonChrgblHrs; NChQty)
            {
            }
            column(Chargeable; Chargeable)
            {
            }
            column(Job_Sub_Task__TABLECAPTION__Filters; TableFilters)
            {
            }
            column(TimeSheetDescription; "Time Sheet Description")
            {
            }
            column(Description_TimeSheet; DescriptionTimesheet)
            {
            }
            dataitem(JobSubTask; 50012)
            {
                DataItemLink = "Job Sub Task No." = FIELD ("Job Sub Task No."),
                               "Job No." = FIELD ("Job No."),
                               "Job Task No." = FIELD ("Job Task No.");
                DataItemTableView = SORTING ("Job Sub Task No.")
                                    WHERE ("Job No." = FILTER (<> '55' & <> '58'),
                                          "Resource No." = FILTER (<> ' '));
                column(Budget_Caption; Budget)
                {
                    IncludeCaption = true;
                }
                column(Status_Caption; Status)
                {
                    IncludeCaption = true;
                }
                column(ChargeableCaption; "Utilised Hours")
                {
                    IncludeCaption = true;
                }
                column(NonChargeableCaption; "Non-Chargeable Hours")
                {
                    IncludeCaption = true;
                }
                column(Description; Description)
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord()
                begin
                    DescriptionTimesheet := Description;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(ChQty);
                CLEAR(NChQty);

                IF Chargeable THEN
                    ChQty := ChQty + Quantity
                ELSE
                    NChQty := NChQty + Quantity;

                IF "Job Sub Task No." = '' THEN
                    DescriptionTimesheet := "Time Sheet Description";
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        PageCaptionLbl = 'Page';
        TotalCaptionLbl = 'Total';
        ResourceSummaryLbl = 'Resource Summary Description';
    }

    trigger OnPreReport()
    begin
        TableFilters := JobSubTask.GETFILTERS() + TimeSheetDetail.GETFILTERS();
    end;

    var
        TableFilters: Text[250];
        ResourceNoLbl: Label 'Resource No.';
        JobNoLbl: Label 'Job No.';
        JobTaskNoLbl: Label 'Job Task No.';
        JobSubTaskNoLbl: Label 'Job Sub Task No.';
        CustNameLbl: Label 'Customer Name';
        Budget_CaptionLbl: Label 'Budget';
        Status_CaptionLbl: Label 'Status';
        UtilisedHrsLbl: Label 'Utilised Hours';
        NonChrgblHrsLbl: Label 'Non-Chargeable Hours';
        ChQty: Decimal;
        NChQty: Decimal;
        DescriptionTimesheet: Text;
}

