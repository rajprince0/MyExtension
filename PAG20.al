pageextension 50052 GeneralLedgerEntriesExt extends "General Ledger Entries"
{
    layout
    {
        addafter("Gen. Prod. Posting Group")
        {
            field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
}

