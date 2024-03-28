import Types "../types";
import Retailer "canister:retailer";
import Result "mo:base/Result";
actor Distributor {
type Order = Types.Order;
type Result<A, B> = Result.Result<A, B>;
    public shared func fulfillOrder(order: Order) : async Result<Text, Text> {
        let updatedOrder : Order = {
            order with status = "In Transit";
        };
        let orderResult = await Retailer.placeOrder(updatedOrder);
        switch (orderResult) {
            case (#ok(_)) {
                return #ok("Order for Product ID " # order.productId # " is in transit.");
            };
            case (#err(errMsg)) {
                return #err("Failed to place order with Retailer for " # order.productId # ". Error: " # errMsg);
            };
        };
    };
};