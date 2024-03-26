class Product {
  String name;
  double price;
  bool isBought;

  Product({
    required this.name,
    required this.price,
    this.isBought = false,
  });

  factory Product.fromJSON(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'price': price,
    };
  }

  void toggleBought() {
    isBought = !isBought;
  }
}
