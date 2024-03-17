module{
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