table 50051 "Job Sub Task Cue"
{
    // version #2767

    // EVUK 190313 New Object

    Caption = 'Job Sub Task Cue';
    DrillDownPageID = 50007;
    LookupPageID = 50007;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; New; Integer)
        {
            Caption = 'New';
            Editable = false;
        }
        field(3; "In Progress"; Integer)
        {
            Caption = 'In Progress';
            Editable = false;
        }
        field(4; "On Hold"; Integer)
        {
            Caption = 'On Hold';
            Editable = false;
        }
        field(5; Finished; Integer)
        {
            Caption = 'Finished';
            Editable = false;
        }
        field(6; Canceled; Integer)
        {
            Caption = 'Canceled';
            Editable = false;
        }
        field(7; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(8; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }

        field(9; "In Review"; Integer)
        {
            Caption = 'In Review';
            Editable = false;
        }
        field(10; "Waiting for Reply"; Integer)
        {
            Caption = 'Waiting for Reply';
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

