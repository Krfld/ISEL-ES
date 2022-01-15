import 'package:cloud_firestore/cloud_firestore.dart';

class Signature implements Comparable<Signature> {
  final String user;
  final Timestamp? timestamp;

  Signature({
    required this.user,
    this.timestamp,
  });

  Signature.fromMap(Map signature)
      : user = signature['user'],
        timestamp = signature['timestamp'] ?? Timestamp.now();

  Map toMap() => {'user': user, 'timestamp': timestamp ?? FieldValue.serverTimestamp()};

  @override
  int compareTo(Signature other) => timestamp!.compareTo(other.timestamp!);
}
