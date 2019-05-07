codeunit 50011 SyncCompanyData
{

    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::Job, 'OnAfterModifyEvent', '', false, false)]
    procedure SyncJob(var Rec: Record Job; var xRec: Record Job; RunTrigger: Boolean)
    var
        //CCExchange: Codeunit "CC Exchange";
        RecRef: RecordRef;
        xRecRef: RecordRef;
    begin
        IF Rec.Synch THEN BEGIN
            RecRef.GETTABLE(Rec);
            xRecRef.GETTABLE(xRec);
            //CCExchange.ExchangeData(xRecRef, RecRef, 2);
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Task", 'OnAfterModifyEvent', '', false, false)]
    procedure SyncTaskLinesOnModify(var Rec: Record "Job Task"; var xRec: Record "Job Task"; RunTrigger: Boolean)
    begin
        SyncTaskLines(Rec, xRec, FALSE);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Task", 'OnAfterInsertEvent', '', false, false)]
    procedure SyncTaskLinesOnInsert(var Rec: Record "Job Task"; RunTrigger: Boolean)
    begin
        SyncTaskLines(Rec, Rec, TRUE);
    end;

    procedure SyncTaskLines(Rec: Record "Job Task"; xRec: Record "Job Task"; IsInsert: Boolean)
    var
        Job: Record Job;
        JobTask: Record "Job Task";
        //CCExchange: Codeunit "CC Exchange";
        RecRef: RecordRef;
        xRecRef: RecordRef;
    begin
        Job.GET(Rec."Job No.");

        IF Job.Synch THEN BEGIN
            RecRef.GETTABLE(Rec);
            IF NOT IsInsert THEN
                xRecRef.GETTABLE(xRec)
            ELSE
                xRecRef.GETTABLE(JobTask);
            //CCExchange.ExchangeData(xRecRef, RecRef, 2);
        END;
    end;
}

