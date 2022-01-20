class Signature implements Comparable<Signature> {
  final String user;
  final DateTime? timestamp;

  Signature({
    required this.user,
    required this.timestamp,
  });

  Signature.fromMap(Map signature)
      : user = signature['user'],
        timestamp = signature['timestamp']?.toDate() ?? DateTime.now();

  Map toMap() => {'user': user, 'timestamp': timestamp};

  @override
  int compareTo(Signature other) => timestamp!.compareTo(other.timestamp!);
}
