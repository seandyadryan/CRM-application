import 'package:flutter/foundation.dart';

import '../models/activity.dart';
import '../models/customer.dart';
import '../models/dashboard_stats.dart';
import '../models/deal.dart';
import '../models/lead.dart';
import '../services/api_service.dart';

class CrmController extends ChangeNotifier {
  CrmController({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  final ApiService apiService;

  bool isLoading = false;
  String? errorMessage;
  int selectedTab = 0;

  DashboardStats stats = DashboardStats.empty();
  List<Customer> customers = <Customer>[];
  List<LeadItem> leads = <LeadItem>[];
  List<Deal> deals = <Deal>[];
  List<ActivityItem> activities = <ActivityItem>[];

  Future<void> loadWorkspace() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final workspace = await apiService.fetchWorkspace();
      stats = workspace.stats;
      customers = workspace.customers;
      leads = workspace.leads;
      deals = workspace.deals;
      activities = workspace.activities;
    } catch (error) {
      errorMessage = 'Data lokal ditampilkan. Hubungkan backend untuk sinkronisasi.';
      _loadSampleData();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void changeTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  void _loadSampleData() {
    customers = Customer.samples();
    leads = LeadItem.samples();
    deals = Deal.samples();
    activities = ActivityItem.samples();
    stats = DashboardStats(
      totalCustomers: customers.length,
      openLeads: leads.length,
      activeDeals: deals.where((deal) => deal.stage != 'Won').length,
      monthlyRevenue: 184500000,
      conversionRate: 42,
    );
  }
}
