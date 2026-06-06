class Customer {
  const Customer({
    required this.id,
    required this.name,
    required this.company,
    required this.email,
    required this.phone,
    required this.segment,
    required this.status,
  });

  final int id;
  final String name;
  final String company;
  final String email;
  final String phone;
  final String segment;
  final String status;

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '-',
      company: json['company'] as String? ?? '-',
      email: json['email'] as String? ?? '-',
      phone: json['phone'] as String? ?? '-',
      segment: json['segment'] as String? ?? 'Retail',
      status: json['status'] as String? ?? 'Active',
    );
  }

  static List<Customer> samples() {
    return const <Customer>[
      Customer(
        id: 1,
        name: 'Aditya Pratama',
        company: 'Nusantara Retail',
        email: 'aditya@nusantararetail.id',
        phone: '+62 812 3300 1984',
        segment: 'Enterprise',
        status: 'Active',
      ),
      Customer(
        id: 2,
        name: 'Maya Cahyani',
        company: 'Sagara Logistic',
        email: 'maya@sagaralogistic.id',
        phone: '+62 811 9044 7788',
        segment: 'SMB',
        status: 'Active',
      ),
      Customer(
        id: 3,
        name: 'Rafi Wiratama',
        company: 'Bright Edu',
        email: 'rafi@brightedu.id',
        phone: '+62 857 2199 7701',
        segment: 'Startup',
        status: 'Prospect',
      ),
    ];
  }
}
