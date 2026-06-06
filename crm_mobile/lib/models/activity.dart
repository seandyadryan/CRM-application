class ActivityItem {
  const ActivityItem({
    required this.id,
    required this.title,
    required this.contact,
    required this.type,
    required this.dueAt,
    required this.isDone,
  });

  final int id;
  final String title;
  final String contact;
  final String type;
  final String dueAt;
  final bool isDone;

  factory ActivityItem.fromJson(Map<String, dynamic> json) {
    return ActivityItem(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '-',
      contact: json['contact'] as String? ?? '-',
      type: json['type'] as String? ?? 'Call',
      dueAt: json['due_at'] as String? ?? '-',
      isDone: json['is_done'] as bool? ?? false,
    );
  }

  static List<ActivityItem> samples() {
    return const <ActivityItem>[
      ActivityItem(
        id: 1,
        title: 'Follow up proposal',
        contact: 'Aditya Pratama',
        type: 'Call',
        dueAt: 'Today, 10:30',
        isDone: false,
      ),
      ActivityItem(
        id: 2,
        title: 'Demo pipeline report',
        contact: 'Maya Cahyani',
        type: 'Meeting',
        dueAt: 'Today, 14:00',
        isDone: false,
      ),
      ActivityItem(
        id: 3,
        title: 'Send renewal quotation',
        contact: 'Rafi Wiratama',
        type: 'Email',
        dueAt: 'Tomorrow',
        isDone: true,
      ),
    ];
  }
}
