import Types "../types";
import Buffer "mo:base/Buffer";
import Result "mo:base/Result";
import Distributor "canister:distributor";


actor Manufacturer {
type Order = Types.Order;
type Product = Types.Product;
type Result<A, B> = Result.Result<A, B>;
    var inventory: Buffer.Buffer<Product> = Buffer.Buffer(0);
    public shared func startManufacturing(product: Product) : async Result<Text, Text> {
        // Simulate manufacturing process and update product status
        let manufacturedProduct = {
            product with status = "Manufactured";
            };
        inventory.add(manufacturedProduct);
        let order : Order = {
            orderId = "order-" # product.id;
            productId = product.id;
            quantity = 1; // Simplification
            status = "In Progress";
        };
        let fullfillOrderResult = await Distributor.fulfillOrder(order);
        switch (fullfillOrderResult) {
            case (#ok(_)) {
                return #ok("Manufactured product and initiated order with for " # order.orderId);
            };
            case (#err(errMsg)) {
                return #err("Failed to initiate order fulfillment with Distributor for " # product.id # ". Error: " # errMsg);
            };
        };
    };
};