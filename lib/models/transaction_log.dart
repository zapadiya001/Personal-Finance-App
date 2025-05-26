class TransactionLog {
  final int? id;
  final String type; // income, purchase, transfer
  final int relatedId;
  final String date;
  final String? description;

  TransactionLog({
    this.id,
    required this.type,
    required this.relatedId,
    required this.date,
    this.description,
  });

  factory TransactionLog.fromMap(Map<String, dynamic> map) {
    return TransactionLog(
      id: map['id'],
      type: map['type'],
      relatedId: map['related_id'],
      date: map['date'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'related_id': relatedId,
      'date': date,
      'description': description,
    };
  }
}
