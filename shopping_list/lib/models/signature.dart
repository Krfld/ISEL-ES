import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

class Signature implements Comparable<Signature> {
  final String user;
  final Timestamp timestamp;

  Signature({
    required this.user,
    required this.timestamp,
  });

  Signature.fromMap(Map signature)
      : user = signature['user'],
        timestamp = signature['timestamp'];

  Map toMap() => {'user': user, 'timestamp': timestamp};

  @override
  int compareTo(Signature other) => timestamp.compareTo(other.timestamp);
}
