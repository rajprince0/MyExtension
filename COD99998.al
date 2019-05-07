codeunit 99998 "Check Job Ledger Entry"
{

    trigger OnRun()
    begin

        EverestEntry.CHANGECOMPANY('Everest Business Solutions AB');
        IndidEntry.CHANGECOMPANY('Indi:d AB');
        NonExisting.CHANGECOMPANY('Indi:d AB');

        IndidEntry.SETRANGE("Posting Date", 20171201D, 20171231D);
        IF IndidEntry.FINDSET() THEN
            REPEAT
                EverestEntry.SETRANGE("Posting Date", IndidEntry."Posting Date");
                EverestEntry.SETRANGE("Job No.", IndidEntry."Job No.");
                EverestEntry.SETRANGE(Quantity, IndidEntry.Quantity);
                EverestEntry.SETRANGE(Chargeable, IndidEntry.Chargeable);
                IF EverestEntry.ISEMPTY() THEN BEGIN
                    NonExisting.TRANSFERFIELDS(IndidEntry);
                    NonExisting.INSERT();
                END;
            UNTIL IndidEntry.NEXT() = 0;
    end;

    var
        IndidEntry: Record "Job Ledger Entry";
        EverestEntry: Record "Job Ledger Entry";
        NonExisting: Record "Job Ledger Entry Cross Comp";
}

