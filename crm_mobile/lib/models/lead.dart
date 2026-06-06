class LeadItem {
  const LeadItem({
    required this.id,
    required this.name,
    required this.company,
    required this.source,
    required this.value,
    required this.status,
  });

  final int id;
  final String name;
  final String company;
  final String source;
  final int value;
  final String status;

  factory LeadItem.fromJson(Map<String, dynamic> json) {
    return LeadItem(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '-',
      company: json['company'] as String? ?? '-',
      source: json['source'] as String? ?? 'Website',
      value: json['value'] as int? ?? 0,
      status: json['status'] as String? ?? 'New',
    );
  }

  static List<LeadItem> samples() {
    return const <LeadItem>[
      LeadItem(
        id: 1,
        name: 'Procurement System',
        company: 'Mandala Group',
        source: 'Website',
        value: 72000000,
        status: 'Qualified',
      ),
      LeadItem(
        id: 2,
        name: 'Sales Automation',
        company: 'Bumi Medika',
        source: 'Referral',
        value: 46000000,
        status: 'New',
      ),
      LeadItem(
        id: 3,
        name: 'CRM Migration',
        company: 'Karya Finance',
        source: 'Campaign',
        value: 93500000,
        status: 'Contacted',
      ),
    ];
  }
}
