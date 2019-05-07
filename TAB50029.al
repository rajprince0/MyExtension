table 50029 TimeSheetManagement
{

    LookupPageID = 50007;

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; Client; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(4; "Job Task No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE ("Job No." = FIELD ("Job No."));
        }
        field(5; "Job Sub Task No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Resource No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Resource No.';
            TableRelation = Resource;
        }
        field(8; "Resources Indulged"; Integer)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        field(9; Budget; Decimal)
        {
            DataClassification = CustomerContent;
            BlankZero = true;

        }
        field(10; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionCaption = 'New,In Progress,On Hold,Finished,Canceled';
            OptionMembers = New,"In Progress","On Hold",Finished,Canceled;
        }
        field(11; Type; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            OptionCaption = 'Development,Design,Analysis/Prototyping,Report,Estimation,Review,Training/Learning,Object Upgrade,Data Upgrade,App. Setup,Inst & Config,Research,Meeting';
            OptionMembers = Development,Design,"Analysis/Prototyping","Report",Estimation,Review,"Training/Learning","Object Upgrade","Data Upgrade","App. Setup","Inst & Config",Research,Meeting;
        }
        field(12; "Assigned By"; Text[30])
        {
            DataClassification = CustomerContent;
            TableRelation = Assignee;
        }
        field(13; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14; "Utilised Hours"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Utilised Hours';
            Editable = false;
            TableRelation = "Time Sheet Detail".Quantity WHERE ("Job No." = FIELD ("Job No."),
                                                                "Job Task No." = FIELD ("Job Task No."),
                                                                "Job Sub Task No." = FIELD ("Job Sub Task No."),
                                                                Chargeable = CONST (true));
        }
        field(15; "Remaining Hours"; Decimal)
        {
            DataClassification = CustomerContent;
            BlankZero = false;
        }
        field(16; "Progress Percent"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Delivery Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(18; "Resource Progress"; Decimal)
        {
            DataClassification = CustomerContent;
            BlankZero = false;
        }
        field(19; "Estimated Time Required"; Decimal)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        field(20; "Estimated Remaining Time"; Decimal)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
        }
    }

    keys
    {
        key(Key1; "Job No.", "Job Task No.", "Job Sub Task No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Line No.", "Job Task No.", "Job Sub Task No.", "Resource No.", Budget)
        {
        }
    }

    var
        Text001Lbl: Label 'You cannot change %1  because %2 contains an entry for Job Task No.: %3 and Job Sub Task No.: %4';
        ResourceCount: Integer;
        LineNo: Integer;

    procedure GetTaskLines()
    var
        ExcelTS: Record TimeSheetManagement;
        JobSubTask: Record "Job Sub Task";
        EstimatedTime: Decimal;
    begin
        ExcelTS.DELETEALL();
        JobSubTask.SETCURRENTKEY("Job No.", "Job Task No.", "Job Sub Task No.");
        JobSubTask.SETFILTER("Job No.", '<>55&<>58');
        JobSubTask.SETFILTER(Status, 'New|In Progress');
        IF JobSubTask.FINDSET() THEN
            WITH ExcelTS DO
                REPEAT
                    INIT();
                    LineNo := 10000;
                    "Line No." := LineNo;
                    "Job No." := JobSubTask."Job No.";
                    "Job Task No." := JobSubTask."Job Task No.";
                    "Job Sub Task No." := JobSubTask."Job Sub Task No.";
                    Client := GetJobName(JobSubTask."Job No.");
                    Description := JobSubTask.Description;
                    "Resource No." := JobSubTask."Resource No.";
                    "Resources Indulged" := GetResourceCount(JobSubTask."Job Sub Task No.");
                    Status := JobSubTask.Status;
                    JobSubTask.CALCFIELDS("Utilised Hours");
                    JobSubTask.CALCFIELDS(Budget);
                    Budget := JobSubTask.Budget;
                    "Utilised Hours" := JobSubTask."Utilised Hours";
                    "Remaining Hours" := JobSubTask.Budget - JobSubTask."Utilised Hours";
                    "Delivery Date" := JobSubTask."Delivery Date";
                    "Resource Progress" := JobSubTask."Task Progress";
                    IF (JobSubTask.Status = JobSubTask.Status::"In Progress") AND (JobSubTask."Task Progress" <> 0) THEN BEGIN
                        IF JobSubTask.Budget <> 0 THEN
                            "Progress Percent" := ROUND(JobSubTask."Utilised Hours" / JobSubTask.Budget * 100);
                        EstimatedTime := ROUND(JobSubTask."Utilised Hours" / (JobSubTask."Task Progress" / 100));
                        "Estimated Time Required" := EstimatedTime;
                        "Estimated Remaining Time" := ROUND(EstimatedTime * (100 - JobSubTask."Task Progress") / 100);
                    END;
                    INSERT(TRUE);

                    WITH JobSubTask DO
                        IF GetResourceCount("Job Sub Task No.") > 1 THEN
                            GetBudgetLines("Job No.", "Job Task No.", "Job Sub Task No.", "Delivery Date", Status);

                UNTIL JobSubTask.NEXT() = 0;

    end;

    local procedure GetJobName(JobCode: Code[20]): Text
    var
        Job: Record 167;
    begin
        IF Job.GET(JobCode) THEN
            EXIT(Job.Description);
    end;

    local procedure GetResourceCount(JobTaskCode: Code[20]): Integer
    var
        TaskBudgetEntry: Record 50018;
    begin
        TaskBudgetEntry.SETRANGE("Job Sub Task No.", JobTaskCode);
        EXIT(TaskBudgetEntry.COUNT());
    end;

    local procedure GetBudgetLines(JobNo: Code[20]; JobTaskNo: Code[20]; JobSubTaskNo: Code[20]; Date: Date; StatusTS: Option)
    var
        TaskBudgetEntry: Record 50018;
        ExcelTS: Record 50029;
    begin
        TaskBudgetEntry.SETRANGE("Job Sub Task No.", JobSubTaskNo);
        IF TaskBudgetEntry.FINDSET() THEN
            WITH ExcelTS DO
                REPEAT
                    TaskBudgetEntry.CALCFIELDS("Utilised Hours");
                    IF (TaskBudgetEntry.Budget - TaskBudgetEntry."Utilised Hours") <> 0 THEN BEGIN
                        INIT();
                        LineNo += 10000;
                        "Job No." := JobNo;
                        "Job Task No." := JobTaskNo;
                        "Job Sub Task No." := JobSubTaskNo;
                        "Line No." := LineNo;
                        "Resource No." := TaskBudgetEntry."Resource No.";
                        Budget := TaskBudgetEntry.Budget;
                        "Remaining Hours" := TaskBudgetEntry.Budget - TaskBudgetEntry."Utilised Hours";
                        "Utilised Hours" := TaskBudgetEntry."Utilised Hours";
                        "Delivery Date" := Date;
                        Status := StatusTS;
                        INSERT(TRUE);
                    END;
                UNTIL TaskBudgetEntry.NEXT() = 0;
    end;
}

