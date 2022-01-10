import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

class Signature implements Comparable<Signature> {
  final String user;
  final Timestamp timestamp;

  Signature({
    required this.user,
    required this.timestamp,
  });

  Map toMap() => {'name': user, 'timestamp': timestamp};
  Signature.fromMap(Map signature)
      : user = signature['user'],
        timestamp = signature['timestamp'];

  @override
  int compareTo(Signature other) => timestamp.compareTo(other.timestamp);
}
