report 50004 "Add Resource Capacity"
{

    Caption = 'Add Resource Capacity';
    ProcessingOnly = true;

    dataset
    {
        dataitem(ResourceVar; Resource)
        {

            trigger OnAfterGetRecord()
            begin
                AddCapacity();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                    Caption = 'Starting Date';
                    ApplicationArea = all;
                }
                field(EndDate; EndDate)
                {
                    Caption = 'Ending Date';
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        IF StartDate > EndDate THEN
                            ERROR(Text000Lbl);
                    end;
                }
                field(WorkTemplateCode; WorkTemplateCode)
                {
                    Caption = 'Work-Hour Template';
                    LookupPageID = "Work-Hour Templates";
                    TableRelation = "Work-Hour Template";
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        WorkTemplateCodeOnAfterValidat();
                    end;
                }
                field(WorkTemplateRecMonday; WorkTemplateRec.Monday)
                {
                    Caption = 'Monday';
                    MaxValue = 24;
                    MinValue = 0;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        WorkTemplateRecMondayOnAfterVa();
                    end;
                }
                field(WorkTemplateRecTuesday; WorkTemplateRec.Tuesday)
                {
                    Caption = 'Tuesday';
                    MaxValue = 24;
                    MinValue = 0;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        WorkTemplateRecTuesdayOnAfterV();
                    end;
                }
                field(WorkTemplateRecWednesday; WorkTemplateRec.Wednesday)
                {
                    Caption = 'Wednesday';
                    MaxValue = 24;
                    MinValue = 0;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        WorkTemplateRecWednesdayOnAfte();
                    end;
                }
                field(WorkTemplateRecThursday; WorkTemplateRec.Thursday)
                {
                    Caption = 'Thursday';
                    MaxValue = 24;
                    MinValue = 0;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        WorkTemplateRecThursdayOnAfter();
                    end;
                }
                field(WorkTemplateRecFriday; WorkTemplateRec.Friday)
                {
                    Caption = 'Friday';
                    MaxValue = 24;
                    MinValue = 0;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        WorkTemplateRecFridayOnAfterVa();
                    end;
                }
                field(WorkTemplateRecSaturday; WorkTemplateRec.Saturday)
                {
                    Caption = 'Saturday';
                    MaxValue = 24;
                    MinValue = 0;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        WorkTemplateRecSaturdayOnAfter();
                    end;
                }
                field(WorkTemplateRecSunday; WorkTemplateRec.Sunday)
                {
                    Caption = 'Sunday';
                    MaxValue = 24;
                    MinValue = 0;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        WorkTemplateRecSundayOnAfterVa();
                    end;
                }
                field(WeekTotal; WeekTotal)
                {
                    Caption = 'Week Total';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ApplicationArea = all;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        StartDate := 0D;
        EndDate := 0D;
        WorkTemplateCode := '';
    end;

    trigger OnPostReport()
    begin
        IF ChangedDays > 1 THEN
            MESSAGE(Text006Lbl, ChangedDays)
        ELSE
            IF ChangedDays = 1 THEN
                MESSAGE(Text007Lbl, ChangedDays)
            ELSE
                MESSAGE(Text008Lbl);
    end;

    trigger OnPreReport()
    begin
        IF WeekTotal <= 0 THEN
            ERROR(Text001Lbl);

        IF StartDate = 0D THEN
            ERROR(Text002Lbl);

        IF EndDate = 0D THEN
            ERROR(Text003Lbl);

        IF NOT CONFIRM(Text004Lbl, FALSE) THEN
            EXIT;

        IF CompanyInformation.GET() THEN
            IF CompanyInformation."Base Calendar Code" <> '' THEN
                CalendarCustomized :=
                  CalendarMgmt.CustomizedChangesExist(CalChange."Source Type"::Company, '', '', CompanyInformation."Base Calendar Code");
    end;

    var
        CalChange: Record "Customized Calendar Change";
        WorkTemplateRec: Record "Work-Hour Template";
        CompanyInformation: Record "Company Information";
        CalendarMgmt: Codeunit "Calendar Management";
        Text000Lbl: Label 'The starting date is later than the ending date.';
        Text001Lbl: Label 'You must select a work-hour template.';
        Text002Lbl: Label 'You must fill in the Starting Date field.';
        Text003Lbl: Label 'You must fill in the Ending Date field.';
        Text004Lbl: Label 'Do you want to change the capacity for resources?', Comment = 'Do you want to change the capacity for NO No.?';
        Text006Lbl: Label 'The capacity for %1 days was changed successfully.';
        Text007Lbl: Label 'The capacity for %1 day was changed successfully.';
        Text008Lbl: Label 'The capacity change was unsuccessful.';
        WorkTemplateCode: Code[10];
        StartDate: Date;
        EndDate: Date;
        WeekTotal: Decimal;
        TempDate: Date;
        CalendarCustomized: Boolean;
        ChangedDays: Integer;

    procedure SelectCapacity() Hours: Decimal
    begin
        CASE DATE2DWY(TempDate, 1) OF
            1:
                Hours := WorkTemplateRec.Monday;
            2:
                Hours := WorkTemplateRec.Tuesday;
            3:
                Hours := WorkTemplateRec.Wednesday;
            4:
                Hours := WorkTemplateRec.Thursday;
            5:
                Hours := WorkTemplateRec.Friday;
            6:
                Hours := WorkTemplateRec.Saturday;
            7:
                Hours := WorkTemplateRec.Sunday;
        END;
    end;

    procedure SumWeekTotal()
    begin
        WeekTotal := WorkTemplateRec.Monday + WorkTemplateRec.Tuesday + WorkTemplateRec.Wednesday +
          WorkTemplateRec.Thursday + WorkTemplateRec.Friday + WorkTemplateRec.Saturday + WorkTemplateRec.Sunday;
    end;

    local procedure WorkTemplateCodeOnAfterValidat()
    begin
        IF WorkTemplateRec.GET(WorkTemplateCode) THEN;
        SumWeekTotal();
    end;

    local procedure WorkTemplateRecMondayOnAfterVa()
    begin
        SumWeekTotal();
    end;

    local procedure WorkTemplateRecTuesdayOnAfterV()
    begin
        SumWeekTotal();
    end;

    local procedure WorkTemplateRecWednesdayOnAfte()
    begin
        SumWeekTotal();
    end;

    local procedure WorkTemplateRecThursdayOnAfter()
    begin
        SumWeekTotal();
    end;

    local procedure WorkTemplateRecFridayOnAfterVa()
    begin
        SumWeekTotal();
    end;

    local procedure WorkTemplateRecSaturdayOnAfter()
    begin
        SumWeekTotal();
    end;

    local procedure WorkTemplateRecSundayOnAfterVa()
    begin
        SumWeekTotal();
    end;

    local procedure AddCapacity()
    var
        ResCapacityEntry: Record "Res. Capacity Entry";
        ResCapacityEntry2: Record "Res. Capacity Entry";
        TempCapacity: Decimal;
        LastEntry: Decimal;
        Holiday: Boolean;
        NewDescription: Text[50];
    begin
        ResCapacityEntry.RESET();
        ResCapacityEntry.SETCURRENTKEY("Resource No.", Date);
        ResCapacityEntry.SETRANGE("Resource No.", ResourceVar."No.");
        TempDate := StartDate;
        ChangedDays := 0;
        REPEAT
            IF CalendarCustomized THEN
                Holiday :=
                  CalendarMgmt.CheckCustomizedDateStatus(
                    CalChange."Source Type"::Company, '', '', CompanyInformation."Base Calendar Code", TempDate, NewDescription)
            ELSE
                Holiday := CalendarMgmt.CheckDateStatus(CompanyInformation."Base Calendar Code", TempDate, NewDescription);
            //>>EVMC 170111
            //IF NOT Holiday THEN BEGIN
            //<<EVMC 170111
            ResCapacityEntry.SETRANGE(Date, TempDate);
            TempCapacity := 0;
            IF ResCapacityEntry.FIND('-') THEN
                REPEAT
                    TempCapacity := TempCapacity + ResCapacityEntry.Capacity;
                UNTIL ResCapacityEntry.NEXT() = 0;

            ResCapacityEntry2.RESET();
            IF ResCapacityEntry2.FINDLAST() THEN;
            LastEntry := ResCapacityEntry2."Entry No." + 1;
            ResCapacityEntry2.RESET();
            ResCapacityEntry2."Entry No." := LastEntry;
            //>>EVMC 170111
            //ResCapacityEntry2.Capacity := -1 * (TempCapacity - SelectCapacity);
            ResCapacityEntry2.Capacity := -1 * (TempCapacity - SelectCapacityIncHoliday(Holiday));
            //<<EVMC 170111
            ResCapacityEntry2."Resource No." := ResourceVar."No.";
            ResCapacityEntry2."Resource Group No." := ResourceVar."Resource Group No.";
            ResCapacityEntry2.Date := TempDate;
            IF ResCapacityEntry2.INSERT(TRUE) THEN;
            ChangedDays := ChangedDays + 1;
            //>>EVMC 170111
            //END;
            //<<EVMC 170111
            TempDate := TempDate + 1;
        UNTIL TempDate > EndDate;
        COMMIT();
    end;

    procedure SelectCapacityIncHoliday(Holiday: Boolean) Hours: Decimal
    begin
        IF Holiday THEN
            EXIT(0)
        ELSE
            EXIT(SelectCapacity());
    end;

    procedure SetTempDate(LeavePlanEntryDate: Date)
    begin
        WorkTemplateRec.FINDFIRST();
        TempDate := LeavePlanEntryDate;
    end;
}

