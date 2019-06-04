tableextension 51003 "PurchaseHeaderExt" extends "Purchase Header"
{

    procedure SetRelPurchHeader(var NewRelPurchHeader: Record 38)
    begin
        RelPurchHeader := NewRelPurchHeader;
    end;

    procedure GetRelPurchHeader(var NewRelPurchHeader: Record 38)
    begin
        NewRelPurchHeader := RelPurchHeader;
    end;

    var

        RelPurchHeader: Record 38;

}

