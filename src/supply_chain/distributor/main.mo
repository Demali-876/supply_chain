import Types "../types";
import Retailer "canister:retailer";
import Result "mo:base/Result";
type Order = Types.Order;
type Result<A, B> = Result.Result<A, B>;
actor Distributor {
    public shared func fulfillOrder(order: Order) : async Result<Text, Text> {
        let updatedOrder = {
            order with status = "In Transit";
        };
        switch (await Retailer.placeOrder(updatedOrder)) {
            case (#ok(_)) {
                return #ok("Order for Product ID " # order.productId # " is in transit.");
            };
            case (#err(errMsg)) {
                return #err("Failed to place order with Retailer for " # order.productId # ". Error: " # errMsg);
            };
        };
    };
};