pageextension 50051 CustomerPriceGroupsExt extends "Customer Price Groups"
{
    actions
    {
        addafter(SalesPrices)
        {
            action(ResourcePrices)
            {
                Image = Default;
                Caption = 'Resource Prices';
                RunObject = Page "Cust. Job Resource Prices";
                RunPageLink = "Cust. Price Group" = FIELD (Code);
                RunPageView = SORTING ("Cust. Price Group", Type, Code, "Currency Code");
            }
        }
    }
}

