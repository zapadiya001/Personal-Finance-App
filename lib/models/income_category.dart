class IncomeCategory {
  final int? id;
  final String name;

  IncomeCategory({this.id, required this.name});

  factory IncomeCategory.fromMap(Map<String, dynamic> map) {
    return IncomeCategory(
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
