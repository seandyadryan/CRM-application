class Deal {
  const Deal({
    required this.id,
    required this.title,
    required this.customer,
    required this.stage,
    required this.amount,
    required this.probability,
  });

  final int id;
  final String title;
  final String customer;
  final String stage;
  final int amount;
  final int probability;

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '-',
      customer: json['customer'] as String? ?? '-',
      stage: json['stage'] as String? ?? 'Proposal',
      amount: json['amount'] as int? ?? 0,
      probability: json['probability'] as int? ?? 0,
    );
  }

  static List<Deal> samples() {
    return const <Deal>[
      Deal(
        id: 1,
        title: 'Enterprise CRM Rollout',
        customer: 'Nusantara Retail',
        stage: 'Negotiation',
        amount: 115000000,
        probability: 74,
      ),
      Deal(
        id: 2,
        title: 'Helpdesk Integration',
        customer: 'Sagara Logistic',
        stage: 'Proposal',
        amount: 38000000,
        probability: 51,
      ),
      Deal(
        id: 3,
        title: 'Analytics Add-on',
        customer: 'Bright Edu',
        stage: 'Won',
        amount: 29500000,
        probability: 100,
      ),
    ];
  }
}
