class Purchase {
  final int? id;
  final double amount;
  final String date;
  final int accountId;
  final int categoryId;
  final String? note;

  Purchase({
    this.id,
    required this.amount,
    required this.date,
    required this.accountId,
    required this.categoryId,
    this.note,
  });

  factory Purchase.fromMap(Map<String, dynamic> map) {
    return Purchase(
      id: map['id'],
      amount: map['amount'],
      date: map['date'],
      accountId: map['account_id'],
      categoryId: map['category_id'],
      note: map['note'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date,
      'account_id': accountId,
      'category_id': categoryId,
      'note': note,
    };
  }
}
