import Types "../types";
import Retailer "canister:retailer";

type Order = Types.Order;
actor Distributor {
    public shared func fulfillOrder(order: Order) : async Text {
        let updatedOrder = {
            order with status = "In Transit";
        };
        switch (Retailer.placeOrder(updatedOrder)) {
            case (#ok(_)) {
                return "Order for Product ID " # order.productId # " is in transit.";
            };
            case (#err(errMsg)) {
                return "Failed to place order with retailer for " # order.productId # ". Error: " # errMsg;
            };
        };
    };
};