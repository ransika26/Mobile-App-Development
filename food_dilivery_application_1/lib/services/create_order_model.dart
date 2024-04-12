class Orders {
  final String userId;
  final List<Map<String, dynamic>> items;
  final double totalAmount;
  final DateTime createdAt;

  Orders({
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items,
      'totalAmount': totalAmount,
      'createdAt': createdAt,
    };
  }
}
