import Types "../types";
import Result "mo:base/Result";
import Manufacturer "canister:manufacturer";

type Product = Types.Product;
type Result<A, B> = Result.Result<A, B>;

actor Supplier {
    public shared func provideProductInfo(productId: Text) : async Result<Text, Text> {
        let product : Product = {
            id = productId;
            description = "A new product";
            status = "Ready for manufacturing";
        };
        let manufactureResult = await Manufacturer.startManufacturing(product);
        switch (manufactureResult) {
            case (#ok(_)) {
                return #ok("Product info sent to Manufacturer for " # productId);
            };
            case (#err(errMsg)) {
                return #err("Failed to send product info to Manufacturer for " # productId # ". Error: " # errMsg);
            };
        };
    };
};