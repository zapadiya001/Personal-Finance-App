class PurchaseCategory {
  final int? id;
  final String name;

  PurchaseCategory({this.id, required this.name});

  factory PurchaseCategory.fromMap(Map<String, dynamic> map) {
    return PurchaseCategory(
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
  