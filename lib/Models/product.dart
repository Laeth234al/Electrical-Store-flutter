class Product {
  double price;
  final String id, title, subTitle, description, image;
  List<String> tags;

  Product({
    required this.id,
    required this.price,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.image,
    required this.tags,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"].toString(),
        price: json["price"]?.toDouble(),
        title: json["title"].toString(),
        subTitle: json["subTitle"].toString(),
        description: json["description"].toString(),
        image: json["image"].toString(),
        tags: List<String>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "title": title,
        "subTitle": subTitle,
        "description": description,
        "image": image,
        "tags": List<dynamic>.from(tags.map((x) => x)),
      };
}
