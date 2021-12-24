import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

class Signature implements Comparable<Signature> {
  final String name;
  final Timestamp timestamp;

  Signature(this.name, this.timestamp);

  Map toMap() => {'name': name, 'timestamp': timestamp};
  Signature.fromMap(Map signature)
      : name = signature['name'],
        timestamp = signature['timestamp'];

  @override
  int compareTo(Signature other) => timestamp.compareTo(other.timestamp);
}
