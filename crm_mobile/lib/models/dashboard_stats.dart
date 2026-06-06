class DashboardStats {
  const DashboardStats({
    required this.totalCustomers,
    required this.openLeads,
    required this.activeDeals,
    required this.monthlyRevenue,
    required this.conversionRate,
  });

  final int totalCustomers;
  final int openLeads;
  final int activeDeals;
  final int monthlyRevenue;
  final int conversionRate;

  factory DashboardStats.empty() {
    return const DashboardStats(
      totalCustomers: 0,
      openLeads: 0,
      activeDeals: 0,
      monthlyRevenue: 0,
      conversionRate: 0,
    );
  }

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalCustomers: json['total_customers'] as int? ?? 0,
      openLeads: json['open_leads'] as int? ?? 0,
      activeDeals: json['active_deals'] as int? ?? 0,
      monthlyRevenue: json['monthly_revenue'] as int? ?? 0,
      conversionRate: json['conversion_rate'] as int? ?? 0,
    );
  }
}
