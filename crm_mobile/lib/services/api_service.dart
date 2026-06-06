import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/activity.dart';
import '../models/customer.dart';
import '../models/dashboard_stats.dart';
import '../models/deal.dart';
import '../models/lead.dart';

class ApiService {
  ApiService({
    this.baseUrl = const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://10.0.2.2:8000/api',
    ),
  });

  final String baseUrl;

  Future<CrmWorkspace> fetchWorkspace() async {
    final response = await http
        .get(Uri.parse('$baseUrl/workspace'))
        .timeout(const Duration(seconds: 8));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Backend returned ${response.statusCode}');
    }

    final Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;

    return CrmWorkspace.fromJson(json['data'] as Map<String, dynamic>);
  }
}

class CrmWorkspace {
  const CrmWorkspace({
    required this.stats,
    required this.customers,
    required this.leads,
    required this.deals,
    required this.activities,
  });

  final DashboardStats stats;
  final List<Customer> customers;
  final List<LeadItem> leads;
  final List<Deal> deals;
  final List<ActivityItem> activities;

  factory CrmWorkspace.fromJson(Map<String, dynamic> json) {
    return CrmWorkspace(
      stats: DashboardStats.fromJson(json['stats'] as Map<String, dynamic>),
      customers: _list(json['customers']).map(Customer.fromJson).toList(),
      leads: _list(json['leads']).map(LeadItem.fromJson).toList(),
      deals: _list(json['deals']).map(Deal.fromJson).toList(),
      activities: _list(json['activities']).map(ActivityItem.fromJson).toList(),
    );
  }

  static List<Map<String, dynamic>> _list(Object? value) {
    return (value as List<dynamic>? ?? <dynamic>[])
        .cast<Map<String, dynamic>>();
  }
}
