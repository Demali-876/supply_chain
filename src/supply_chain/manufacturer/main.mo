import Types "../types";
import Buffer "mo:base/Buffer";
import Result "mo:base/Result";
import Distributor "canister:distributor";

type Order = Types.Order;
type Product = Types.Product;
type Result<A, B> = Result.Result<A, B>;
actor Manufacturer {
    var inventory: Buffer.Buffer<Product> = Buffer.Buffer(0);
    public shared func startManufacturing(product: Product) : async Result<Text, Text> {
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
                return #ok("Manufactured product and initiated order with for " # productId);
            };
            case (#err(errMsg)) {
                return #err("Failed to initiate order fulfillment with Distributor for " # product.id # ". Error: " # errMsg);
            };
        };
    };
};