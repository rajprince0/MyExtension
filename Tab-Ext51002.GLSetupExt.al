tableextension 51002 "GLSetupExt" extends "General Ledger Setup"
{
    // version NAVW110.00.00.14199,NAVSE10.00.00.14199,PE6.00

    // #1..13
    // 
    // EVUK 190328 New Fields: 50001,50002 - Deferral Sales Account,Deferral Purchase Account
    fields
    {
        field(50001; "Deferral Sales Account"; Code[20])
        {
            Caption = 'Deferral Sales Account';
            Description = 'EVUK';
            TableRelation = "G/L Account"."No.";
        }
        field(50002; "Deferral Purchase Account"; Code[20])
        {
            Caption = 'Deferral Purchase Account';
            Description = 'EVUK';
            TableRelation = "G/L Account"."No.";
        }
    }
}

