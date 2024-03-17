import Types "../types";
import Manufacturer "canister:manufacturer";
type Product = Types.Product;
type Result = Types.Result;

actor Supplier {
    public shared func provideProductInfo(productId: Text) : async Result<Text, Text> {
        let product = Product {
            id = productId;
            description = "A new product";
            status = "Ready for manufacturing";
        };
        switch (await Manufacturer.startManufacturing(product)) {
            case (#ok(_)) {
                return #ok("Product info sent to Manufacturer for " # productId);
            };
            case (#err(errMsg)) {
                return #err("Failed to send product info to Manufacturer for " # productId # ". Error: " # errMsg);
            };
        };
    };
};