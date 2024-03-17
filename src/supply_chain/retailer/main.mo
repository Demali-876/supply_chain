import Types "../types";
import Buffer "mo:base/Buffer";

type Order = Types.Order;
type Product = Types.Product;

actor Retailer {
    var inventory: Buffer.Buffer<Product> = Buffer.Buffer<Product>(0);

    public shared func placeOrder(order: Order) : async Text {
        let product: Product = {
            id= order.productId;
            description= "Final Product " # order.productId;
            status= "Available"
        };
        inventory.add(product);

        return "Order " # order.orderId # " completed, product available for sale.";
    };
};
