table 50012 "Job Sub Task"
{
    // version EV,EVPK,#1973

    // EVST 150923 New Object
    // EVPK 160722 New function - CheckJobTaskNo
    // EVSP 161007 Calculate only Chargeble hours for "Utilized Hours"
    // EVNKG 161202 New Field : 12 - "Delivery Date"
    // EVST 170125 New Fields: 13 - "Task Start Date"
    //                         14 - "Task End Date"
    //                         15 - "Date Filter"
    //                         16 - "Task Creation Date"
    // EVNKG 170201 New Field : 17 - Progress
    // EVSP 170411 Bug Fix
    // EVPK 171109 New Field: 18 - "Non-Chargeable Hours"
    // EVSP 171122 New Field : 19 - "Resource Filter"
    // EVSP 180202 Bug Fix
    // EVPK 190404 #1973 Added code to make fields mandatory
    //EVARA 190419 #3039 Added Options in Status Field Optionset -"In Review","Waiting for Reply"
    LookupPageID = 50007;

    fields
    {
        field(1; "Job Sub Task No."; Code[20])
        {
        }
        field(2; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(3; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE ("Job No." = FIELD ("Job No."));

            trigger OnValidate()
            begin
                //>>EVPK 160722
                IF ("Job Task No." <> '') AND (xRec."Job Task No." <> "Job Task No.") THEN
                    CheckJobTaskNo;
                //<<EVPK 160722
            end;
        }
        field(4; Description; Text[70])
        {

            trigger OnValidate()
            begin
                //>>EVPK 190404 #1973
                TESTFIELD("Delivery Date");
                TESTFIELD("Assigned By");
                TESTFIELD("Customer Reference");
                //<<EVPK 190404 #1973
            end;
        }
        field(5; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource;
        }
        field(6; Budget; Decimal)
        {
            CalcFormula = Sum ("Task Budget Entry".Budget WHERE ("Job Sub Task No." = FIELD ("Job Sub Task No.")));
            FieldClass = FlowField;

            trigger OnValidate()
            var
                BudgetEntry: Record "Task Budget Entry";
            begin
                BudgetEntry.SETRANGE("Job Sub Task No.", "Job Sub Task No.");
                IF NOT BudgetEntry.FINDFIRST THEN BEGIN
                    BudgetEntry.INIT;
                    BudgetEntry."Entry No." := 0;
                    BudgetEntry."Job Sub Task No." := "Job Sub Task No.";
                    BudgetEntry."Resource No." := "Resource No.";
                    BudgetEntry.Budget := Budget;
                    BudgetEntry.INSERT(TRUE);
                END ELSE BEGIN
                    BudgetEntry."Job Sub Task No." := "Job Sub Task No.";
                    BudgetEntry."Resource No." := "Resource No.";
                    BudgetEntry.Budget := Budget;
                    BudgetEntry.MODIFY(TRUE);
                END;
            end;
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'New,In Progress,On Hold,Finished,Canceled,In Review,Waiting for Reply';
            OptionMembers = New,"In Progress","On Hold",Finished,Canceled,"In Review","Waiting for Reply";
        }
        field(8; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Development,Design,Analysis/Prototyping,Report,Estimation,Review,Training/Learning,Object Upgrade,Data Upgrade,App. Setup,Inst & Config,Research,Meeting';
            OptionMembers = Development,Design,"Analysis/Prototyping","Report",Estimation,Review,"Training/Learning","Object Upgrade","Data Upgrade","App. Setup","Inst & Config",Research,Meeting;
        }
        field(9; "Assigned By"; Text[30])
        {
            TableRelation = Assignee;
        }
        field(10; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(11; "Utilised Hours"; Decimal)
        {
            CalcFormula = Sum ("Time Sheet Detail".Quantity WHERE ("Job No." = FIELD ("Job No."),
                                                                  "Job Task No." = FIELD ("Job Task No."),
                                                                  "Job Sub Task No." = FIELD ("Job Sub Task No."),
                                                                  Chargeable = CONST (true),
                                                                  Date = FIELD ("Date Filter")));
            Caption = 'Utilised Hours';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Time Sheet Detail".Quantity WHERE ("Job No." = FIELD ("Job No."),
                                                                "Job Task No." = FIELD ("Job Task No."),
                                                                "Job Sub Task No." = FIELD ("Job Sub Task No."),
                                                                Chargeable = CONST (true));
        }
        field(12; "Delivery Date"; Date)
        {
        }
        field(13; "Task Start Date"; Date)
        {
            CalcFormula = Min ("Time Sheet Detail".Date WHERE ("Job No." = FIELD ("Job No."),
                                                              "Job Task No." = FIELD ("Job Task No."),
                                                              "Job Sub Task No." = FIELD ("Job Sub Task No.")));
            Caption = 'Task Start Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Task End Date"; Date)
        {
            CalcFormula = Max ("Time Sheet Detail".Date WHERE ("Job No." = FIELD ("Job No."),
                                                              "Job Task No." = FIELD ("Job Task No."),
                                                              "Job Sub Task No." = FIELD ("Job Sub Task No.")));
            Caption = 'Task End Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(16; "Task Creation Date"; Date)
        {
            Caption = 'Task Creation Date';
            Editable = false;
        }
        field(17; "Task Progress"; Decimal)
        {
            Caption = 'Task Progress';
        }
        field(18; "Non-Chargeable Hours"; Decimal)
        {
            CalcFormula = Sum ("Time Sheet Detail".Quantity WHERE ("Job No." = FIELD ("Job No."),
                                                                  "Job Task No." = FIELD ("Job Task No."),
                                                                  "Job Sub Task No." = FIELD ("Job Sub Task No."),
                                                                  Chargeable = CONST (false),
                                                                  Date = FIELD ("Date Filter"),
                                                                  "Resource No." = FIELD ("Resource No.")));
            Caption = 'Non-Chargeable Hours';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Time Sheet Detail".Quantity WHERE ("Job No." = FIELD ("Job No."),
                                                                "Job Task No." = FIELD ("Job Task No."),
                                                                "Job Sub Task No." = FIELD ("Job Sub Task No."),
                                                                Chargeable = CONST (false));
        }
        field(19; "Resource Filter"; Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(20; "Customer Reference"; Code[20])
        {
            Caption = 'Customer Reference';
        }
        field(21; "Estimated Hours"; Decimal)
        {
            Caption = 'Estimated Hours';
        }
    }

    keys
    {
        key(Key1; "Job Sub Task No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Job Sub Task No.", Description, "Resource No.", Status, "Assigned By")
        {
        }
    }

    trigger OnInsert()
    var
        JobsSetup: Record "Jobs Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        JobsSetup.GET;

        IF "Job Sub Task No." = '' THEN BEGIN
            JobsSetup.TESTFIELD("Start Date for Time Bank");
            NoSeriesMgt.InitSeries(JobsSetup."Sub Task Nos.", xRec."No. Series", 0D, "Job Sub Task No.", "No. Series");
        END;

        "Task Creation Date" := TODAY;
    end;

    var
        Text001: Label 'You cannot change %1  because %2 contains an entry for Job Task No.: %3 and Job Sub Task No.: %4';
        TimeSheetLine: Record "Time Sheet Line";

    local procedure AdjAddReportingCurr()
    begin
    end;

    local procedure CheckJobTaskNo()
    begin
        TimeSheetLine.SETRANGE("Job No.", "Job No.");
        TimeSheetLine.SETRANGE("Job Task No.", xRec."Job Task No.");
        TimeSheetLine.SETRANGE("Job Sub Task No.", "Job Sub Task No.");
        IF TimeSheetLine.FINDFIRST THEN
            ERROR(STRSUBSTNO(Text001, FIELDCAPTION("Job Task No."), TimeSheetLine.TABLECAPTION, "Job Task No.", "Job Sub Task No."));
    end;
}

