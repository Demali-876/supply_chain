import Types "../types";
import Buffer "mo:base/Buffer";
import Result "mo:base/Result";
type Order = Types.Order;
type Product = Types.Product;
type Result<A, B> = Result.Result<A, B>;
actor Retailer {
    var inventory: Buffer.Buffer<Product> = Buffer.Buffer<Product>(0);
    let maxInventorySize: Nat = 100; // limit so that cycles limit per message is never surpassed
    public shared func placeOrder(order: Order) : async Result<Text,Text> {
        if (inventory.size() >= maxInventorySize) {
            return #err("Failed to place order for Product ID " # order.productId # ". Inventory full.");
        } else {
            let product: Product = {
                id = order.productId;
                description = "Final Product " # order.productId;
                status = "Available";
            };
            inventory.add(product);
            return #ok("Order " # order.orderId # " completed, product available for sale.");
        };
    };
};

