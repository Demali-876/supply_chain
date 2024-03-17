import Types "../types";
import Buffer "mo:base/Buffer";
import Distributor "canister:distributor";

type Order = Types.Order;
type Product = Types.Product;
actor Manufacturer {
    var inventory: Buffer.Buffer<Product> = Buffer.Buffer(0);
    public shared func startManufacturing(product: Product) : async Text {
        // Simulate manufacturing process and update product status
        let manufacturedProduct = {
            product with status = "Manufactured";
            };
        inventory.add( manufacturedProduct);
        let order = Order {
            orderId = "order-" # product.id;
            productId = product.id;
            quantity = 1; // Simplification 
            status = "In Progress";
        };
        switch (await Distributor.fulfillOrder(order)) {
            case (#ok(_)) {
                return "Manufactured product and initiated order for " # productId;
            };
            case (#err(errMsg)) {
                return "Failed to send initiate order fulfillment to Distributor for " # productId # ". Error: " # errMsg;
            };
        };
    };
};