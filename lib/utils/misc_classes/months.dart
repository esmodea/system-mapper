enum Months {
  january(displayName: 'Jan'),
  february(displayName: 'Feb'),
  march(displayName: 'Mar'),
  april(displayName: 'Apr'),
  may(displayName: 'May'),
  june(displayName: 'Jun'),
  july(displayName: 'Jul'),
  august(displayName: 'Aug'),
  september(displayName: 'Sep'),
  october(displayName: 'Oct'),
  november(displayName: 'Nov'),
  december(displayName: 'Dec');

  final String displayName;
  const Months({required this.displayName});

  static Months fromDateTime(DateTime? time) {
    return Months.values[(time?.month ?? DateTime.now().month) - 1];
  }
}
