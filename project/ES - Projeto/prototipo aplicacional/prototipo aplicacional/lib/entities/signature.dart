import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue;

class Signature implements Comparable<Signature> {
  final String user;
  final DateTime? timestamp;

  Signature({
    required this.user,
    this.timestamp,
  });

  Signature.fromMap(Map signature)
      : user = signature['user'],
        timestamp = signature['timestamp']?.toDate() ?? DateTime.now();

  Map toMap() => {'user': user, 'timestamp': timestamp ?? FieldValue.serverTimestamp()};

  @override
  int compareTo(Signature other) => timestamp!.compareTo(other.timestamp!);
}
