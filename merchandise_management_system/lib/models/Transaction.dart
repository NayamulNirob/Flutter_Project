import 'package:intl/intl.dart';

class Transaction {
  int? id;
  String? description;
  DateTime? date;
  int? amount;

  // Constructor
  Transaction({this.id, this.description, this.date, this.amount});

  // From JSON Constructor
  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    // Convert the date string into a DateTime object
    date = json['date'] != null ? DateTime.parse(json['date']) : null;
    amount = json['amount'];
  }

  // To JSON Method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    // Format the DateTime object into ISO8601 string
    data['date'] = date != null ? DateFormat('yyyy-MM-ddTHH:mm:ss').format(date!) : null;
    data['amount'] = amount;
    return data;
  }
}
