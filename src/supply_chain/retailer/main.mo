import Types "../types";
import Buffer "mo:base/Buffer";
import Result "mo:base/Result";
type Order = Types.Order;
type Product = Types.Product;
type Result<A, B> = Result.Result<A, B>;
actor Retailer {
    var inventory: Buffer.Buffer<Product> = Buffer.Buffer<Product>(0);

    public shared func placeOrder(order: Order) : async Result<Text,Text> {
        let product: Product = {
            id= order.productId;
            description= "Final Product " # order.productId;
            status= "Available"
        };
        inventory.add(product);
        return #ok("Order " # order.orderId # " completed, product available for sale.");
    };
};
