report 50012 "Resource Summary with Date"
{

    DefaultLayout = RDLC;
    RDLCLayout = './Resource Summary with Date.rdlc';

    Caption = 'Resource Summary';

    dataset
    {
        dataitem(TimeSheetDetail; 952)
        {
            DataItemTableView = SORTING ("Time Sheet No.", "Time Sheet Line No.", Date)
                                WHERE ("Resource No." = FILTER (<> ' '));
            RequestFilterFields = Date, "Resource No.";
            column(ResourceNo; "Resource No.")
            {
                IncludeCaption = true;
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
            column(ResourceName; Resource.Name)
            {
            }
            column(CustomerName; GetJobName())
            {
            }
            column(DateTS; Date)
            {
            }
            column(UtilisedHrs; ChQty)
            {
            }
            column(NonChrgblHrs; NChQty)
            {
            }
            column(TotWrkHrs; TotWrkHrsLbl)
            {
            }
            column(TotWorkingHour; TotWorkingHour)
            {
            }
            column(Chargeable; Chargeable)
            {
            }
            column(ShowDetails; ShowTaskDetails)
            {
            }
            column(ShowResDetails; ShowResourceDetails)
            {
            }
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(CustName; JobSubTask.Description)
            {
                IncludeCaption = true;
            }
            column(Budget; JobSubTask.Budget)
            {
                IncludeCaption = true;
            }
            column(Status; JobSubTask.Status)
            {
                IncludeCaption = true;
            }
            column(Job_Sub_Task__TABLECAPTION__Filters; TableFilters)
            {
            }
            column(WrkHrs; WrkHrsLbl)
            {
            }
            column(UtilizedPer; UtilizedPerLbl)
            {
            }
            column(NonChrgPer; NonChrgPerLbl)
            {
            }

            trigger OnAfterGetRecord()
            var
                Cust: Record 18;
                Job: Record 167;
            begin
                CLEAR(ChQty);
                CLEAR(NChQty);
                CLEAR(TotWorkingHour);

                IF JobSubTask.GET("Job Sub Task No.") THEN
                    JobSubTask.CALCFIELDS(Budget);

                Resource.GET("Resource No.");

                IF Job.GET("Job No.") THEN
                    IF Cust.GET(Job."Bill-to Customer No.") THEN

                        IF (NOT Cust."Internal Customer") AND Chargeable THEN
                            ChQty := ChQty + Quantity
                        ELSE
                            NChQty := NChQty + Quantity;

                TotWorkingHour += ChQty + NChQty;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowResourceDetails; ShowResourceDetails)
                    {
                        Caption = 'Show Resource Details';
                        ApplicationArea = all;

                        trigger OnValidate()
                        begin
                            IF ShowResourceDetails THEN
                                ShowTaskDetails := FALSE;
                        end;
                    }
                    field(ShowTaskDetails; ShowTaskDetails)
                    {
                        Caption = 'Show Task Details';
                        ApplicationArea = all;

                        trigger OnValidate()
                        begin
                            IF ShowTaskDetails THEN
                                ShowResourceDetails := FALSE;
                        end;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        PageCaptionLbl = 'Page';
        TotalCaptionLbl = 'Total';
        ResourceSummaryLbl = 'Resource Summary';
        GrandTotalLbl = 'Grand Total';
        UtilisedHourLbl = 'Utilised Hours';
        NonChargeableLbl = 'Non-Chargeable Hours';
        DescriptionLbl = 'Description';
        BudgetLbl = 'Budget';
        StatusLbl = 'Status';
    }

    trigger OnPreReport()
    begin
        TableFilters := TimeSheetDetail.GetFilters();
    end;

    var
        JobSubTask: Record "Job Sub Task";
        Resource: Record Resource;
        ResourceNoLbl: Label 'Resource No.';
        JobNoLbl: Label 'Job No.';
        JobTaskNoLbl: Label 'Job Task No.';
        JobSubTaskNoLbl: Label 'Job Sub Task No.';
        CustNameLbl: Label 'Customer Name';
        Budget_CaptionLbl: Label 'Budget';
        Status_CaptionLbl: Label 'Status';
        UtilisedHrsLbl: Label 'Utilised Hours';
        NonChrgblHrsLbl: Label 'Non-Chargeable Hours';
        ShowTaskDetails: Boolean;
        ShowResourceDetails: Boolean;
        TableFilters: Text[250];
        ChQty: Decimal;
        NChQty: Decimal;
        TotWorkingHour: Decimal;
        WrkHrsLbl: Label 'Working Hours';
        UtilizedPerLbl: Label 'Utiilized %';
        NonChrgPerLbl: Label 'Non Charg. %';
        TotWrkHrsLbl: Label 'Total Working Hours';

    local procedure GetJobName(): Text
    var
        Job: Record Job;
    begin
        IF Job.GET(TimeSheetDetail."Job No.") THEN
            EXIT(Job.Description);
    end;
}

