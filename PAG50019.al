page 50019 "Internal Projects"
{
    // EVSP 180219 New Object

    PageType = List;
    SourceTable = "Internal Projects";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                }
                field(GetJobDescriptions; GetJobDescription())
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    local procedure GetJobDescription(): Text
    var
        Job: Record Job;
    begin
        Job.GET("Job No.");
        EXIT(Job.Description);
    end;
}

