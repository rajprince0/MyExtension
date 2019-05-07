codeunit 50000 "Update Job Sub Task on TSD"
{

    trigger OnRun()
    begin
        IF TSL.FINDSET(FALSE) THEN
            REPEAT
                TSD.SETRANGE("Time Sheet No.", TSL."Time Sheet No.");
                TSD.SETRANGE("Time Sheet Line No.", TSL."Line No.");
                IF TSD.FINDSET(TRUE) THEN
                    REPEAT
                        IF TSD."Job Sub Task No." = ' ' THEN
                            TSD."Job Sub Task No." := TSL."Job Sub Task No.";
                        IF TSH.GET(TSL."Time Sheet No.") THEN
                            IF TSD."Resource No." = '' THEN
                                TSD."Resource No." := TSH."Resource No.";
                        TSD.MODIFY();
                    UNTIL TSD.NEXT() = 0;
            UNTIL TSL.NEXT() = 0;
    end;

    var
        TSH: Record "Time Sheet Header";
        TSL: Record "Time Sheet Line";
        TSD: Record "Time Sheet Detail";
}

