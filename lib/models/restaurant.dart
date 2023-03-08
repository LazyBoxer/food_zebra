class Restaurant {
  final String title;
  final String description;
  final String image;
  final List<Dish> menu;

  Restaurant({
    required this.title,
    required this.description,
    required this.image,
    required this.menu,
  });
}

class Dish {
  String name;
  String image;
  double price;

  Dish({required this.name, required this.price, required this.image});
}
