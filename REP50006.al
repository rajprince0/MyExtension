report 50006 "Time Sheet Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Time Sheet Details.rdlc';

    dataset
    {
        dataitem(TimeSheetDetail; 952)
        {
            DataItemTableView = SORTING ("Time Sheet No.", "Time Sheet Line No.", Date)
                                WHERE (Type = CONST (Job),
                                      "Job No." = FILTER (<> '55' & <> '58'),
                                      Chargeable = CONST (true));
            column(TimeSheetNo_TimeSheetDetail; TimeSheetDetail."Time Sheet No.")
            {
            }
            column(TimeSheetLineNo_TimeSheetDetail; TimeSheetDetail."Time Sheet Line No.")
            {
            }
            column(Date_TimeSheetDetail; TimeSheetDetail.Date)
            {
            }
            column(Type_TimeSheetDetail; TimeSheetDetail.Type)
            {
            }
            column(ResourceNo_TimeSheetDetail; TimeSheetDetail."Resource No.")
            {
            }
            column(JobNo_TimeSheetDetail; TimeSheetDetail."Job No.")
            {
            }
            column(JobTaskNo_TimeSheetDetail; TimeSheetDetail."Job Task No.")
            {
            }
            column(CauseofAbsenceCode_TimeSheetDetail; TimeSheetDetail."Cause of Absence Code")
            {
            }
            column(ServiceOrderNo_TimeSheetDetail; TimeSheetDetail."Service Order No.")
            {
            }
            column(ServiceOrderLineNo_TimeSheetDetail; TimeSheetDetail."Service Order Line No.")
            {
            }
            column(Quantity_TimeSheetDetail; TimeSheetDetail.Quantity)
            {
            }
            column(PostedQuantity_TimeSheetDetail; TimeSheetDetail."Posted Quantity")
            {
            }
            column(AssemblyOrderNo_TimeSheetDetail; TimeSheetDetail."Assembly Order No.")
            {
            }
            column(AssemblyOrderLineNo_TimeSheetDetail; TimeSheetDetail."Assembly Order Line No.")
            {
            }
            column(Status_TimeSheetDetail; TimeSheetDetail.Status)
            {
            }
            column(Posted_TimeSheetDetail; TimeSheetDetail.Posted)
            {
            }
            column(Chargeable_TimeSheetDetail; TimeSheetDetail.Chargeable)
            {
            }
            column(JobSubTaskNo_TimeSheetDetail; TimeSheetDetail."Job Sub Task No.")
            {
            }
            column(JobDescription_TimeSheetDetail; TimeSheetDetail."Job Description")
            {
            }
            column(JobTaskDescription_TimeSheetDetail; TimeSheetDetail."Job Task Description")
            {
            }
            column(TimeSheetDescription_TimeSheetDetail; TimeSheetDetail."Time Sheet Description")
            {
            }
            column(WorkTypeCode_TimeSheetDetail; TimeSheetDetail."Work Type Code")
            {
            }

            trigger OnPreDataItem()
            begin
                SETFILTER(Date, '%1..%2', DMY2DATE(1, DATE2DMY(TODAY(), 2), DATE2DMY(TODAY(), 3)), TODAY());
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
    }
}

