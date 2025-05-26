class Transfer {
  final int? id;
  final int fromAccountId;
  final int toAccountId;
  final double amount;
  final String date;
  final String? note;

  Transfer({
    this.id,
    required this.fromAccountId,
    required this.toAccountId,
    required this.amount,
    required this.date,
    this.note,
  });

  factory Transfer.fromMap(Map<String, dynamic> map) {
    return Transfer(
      id: map['id'],
      fromAccountId: map['from_account_id'],
      toAccountId: map['to_account_id'],
      amount: map['amount'],
      date: map['date'],
      note: map['note'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'from_account_id': fromAccountId,
      'to_account_id': toAccountId,
      'amount': amount,
      'date': date,
      'note': note,
    };
  }
}
