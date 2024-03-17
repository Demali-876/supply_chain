import Result "mo:base/Result";
module{
public type Result<A, B> = Result.Result<A, B>;
public type Product = {
    id: Text;
    description: Text;
    status: Text;
    };

public type Order = {
    orderId: Text;
    productId: Text;
    quantity: Nat;
    status: Text;
    };
};