class Workshop {
  final String id;
  final String title;
  final String categoryId;
  final String duration;
  final double price;
  final double? discountPrice;
  final String imageUrl;

  Workshop({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.duration,
    required this.price,
    this.discountPrice,
    required this.imageUrl,
  });
}
