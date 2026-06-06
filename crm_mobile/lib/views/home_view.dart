import 'package:flutter/material.dart';

import '../controllers/crm_controller.dart';
import '../models/activity.dart';
import '../models/customer.dart';
import '../models/deal.dart';
import '../models/lead.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.controller});

  final CrmController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final pages = <Widget>[
          DashboardPage(controller: controller),
          CustomersPage(customers: controller.customers),
          LeadsPage(leads: controller.leads),
          DealsPage(deals: controller.deals),
          ActivitiesPage(activities: controller.activities),
        ];

        return Scaffold(
          body: SafeArea(child: pages[controller.selectedTab]),
          bottomNavigationBar: NavigationBar(
            selectedIndex: controller.selectedTab,
            onDestinationSelected: controller.changeTab,
            destinations: const <NavigationDestination>[
              NavigationDestination(
                icon: Icon(Icons.space_dashboard_outlined),
                selectedIcon: Icon(Icons.space_dashboard),
                label: 'Dashboard',
              ),
              NavigationDestination(
                icon: Icon(Icons.groups_outlined),
                selectedIcon: Icon(Icons.groups),
                label: 'Customers',
              ),
              NavigationDestination(
                icon: Icon(Icons.lightbulb_outline),
                selectedIcon: Icon(Icons.lightbulb),
                label: 'Leads',
              ),
              NavigationDestination(
                icon: Icon(Icons.handshake_outlined),
                selectedIcon: Icon(Icons.handshake),
                label: 'Deals',
              ),
              NavigationDestination(
                icon: Icon(Icons.task_alt_outlined),
                selectedIcon: Icon(Icons.task_alt),
                label: 'Activity',
              ),
            ],
          ),
        );
      },
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.controller});

  final CrmController controller;

  @override
  Widget build(BuildContext context) {
    final stats = controller.stats;

    return RefreshIndicator(
      onRefresh: controller.loadWorkspace,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const HeaderBlock(),
                  if (controller.errorMessage != null)
                    SyncBanner(message: controller.errorMessage!),
                  const SizedBox(height: 18),
                  GridLayout(
                    children: <Widget>[
                      StatCard(
                        label: 'Customers',
                        value: stats.totalCustomers.toString(),
                        icon: Icons.groups,
                        color: const Color(0xFF2563EB),
                      ),
                      StatCard(
                        label: 'Open Leads',
                        value: stats.openLeads.toString(),
                        icon: Icons.lightbulb,
                        color: const Color(0xFF14B8A6),
                      ),
                      StatCard(
                        label: 'Active Deals',
                        value: stats.activeDeals.toString(),
                        icon: Icons.handshake,
                        color: const Color(0xFFF59E0B),
                      ),
                      StatCard(
                        label: 'Conversion',
                        value: '${stats.conversionRate}%',
                        icon: Icons.trending_up,
                        color: const Color(0xFFEF4444),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  RevenueCard(amount: stats.monthlyRevenue),
                  const SizedBox(height: 18),
                  SectionHeader(
                    title: 'Pipeline',
                    action: '${controller.deals.length} deals',
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            sliver: SliverList.separated(
              itemCount: controller.deals.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return DealTile(deal: controller.deals[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderBlock extends StatelessWidget {
  const HeaderBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'CRM Application',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 4),
              Text(
                'Sales workspace for customers, leads, and deals',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          tooltip: 'Search',
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}

class SyncBanner extends StatelessWidget {
  const SyncBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.info_outline, color: Color(0xFFD97706)),
          const SizedBox(width: 10),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}

class GridLayout extends StatelessWidget {
  const GridLayout({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width >= 700 ? 4 : 2;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: width >= 700 ? 1.15 : 0.95,
      children: children,
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(icon, color: color, size: 26),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(label, style: const TextStyle(color: Color(0xFF64748B))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RevenueCard extends StatelessWidget {
  const RevenueCard({super.key, required this.amount});

  final int amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF0F172A),
        ),
        child: Row(
          children: <Widget>[
            const Icon(Icons.payments, color: Color(0xFF5EEAD4), size: 32),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Monthly revenue',
                    style: TextStyle(color: Color(0xFFCBD5E1)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    rupiah(amount),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key, required this.customers});

  final List<Customer> customers;

  @override
  Widget build(BuildContext context) {
    return EntityListPage(
      title: 'Customers',
      subtitle: 'Manage accounts and active contacts',
      children: customers
          .map(
            (customer) => ListCard(
              icon: Icons.business,
              title: customer.company,
              subtitle: '${customer.name} • ${customer.segment}',
              trailing: customer.status,
            ),
          )
          .toList(),
    );
  }
}

class LeadsPage extends StatelessWidget {
  const LeadsPage({super.key, required this.leads});

  final List<LeadItem> leads;

  @override
  Widget build(BuildContext context) {
    return EntityListPage(
      title: 'Leads',
      subtitle: 'Qualify new opportunities',
      children: leads
          .map(
            (lead) => ListCard(
              icon: Icons.lightbulb,
              title: lead.name,
              subtitle: '${lead.company} • ${rupiah(lead.value)}',
              trailing: lead.status,
            ),
          )
          .toList(),
    );
  }
}

class DealsPage extends StatelessWidget {
  const DealsPage({super.key, required this.deals});

  final List<Deal> deals;

  @override
  Widget build(BuildContext context) {
    return EntityListPage(
      title: 'Deals',
      subtitle: 'Track revenue pipeline',
      children: deals.map((deal) => DealTile(deal: deal)).toList(),
    );
  }
}

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key, required this.activities});

  final List<ActivityItem> activities;

  @override
  Widget build(BuildContext context) {
    return EntityListPage(
      title: 'Activities',
      subtitle: 'Follow ups and meetings',
      children: activities
          .map(
            (activity) => ListCard(
              icon: activity.isDone ? Icons.check_circle : Icons.schedule,
              title: activity.title,
              subtitle: '${activity.contact} • ${activity.dueAt}',
              trailing: activity.type,
            ),
          )
          .toList(),
    );
  }
}

class EntityListPage extends StatelessWidget {
  const EntityListPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      itemCount: children.length + 1,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SectionTitle(title: title, subtitle: subtitle),
          );
        }

        return children[index - 1];
      },
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: Color(0xFF64748B))),
            ],
          ),
        ),
        IconButton.filled(
          tooltip: 'Add',
          onPressed: () {},
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, required this.action});

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
        Text(action, style: const TextStyle(color: Color(0xFF64748B))),
      ],
    );
  }
}

class DealTile extends StatelessWidget {
  const DealTile({super.key, required this.deal});

  final Deal deal;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    deal.title,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                Chip(label: Text(deal.stage), visualDensity: VisualDensity.compact),
              ],
            ),
            const SizedBox(height: 8),
            Text(deal.customer, style: const TextStyle(color: Color(0xFF64748B))),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: deal.probability / 100,
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(child: Text(rupiah(deal.amount))),
                Text('${deal.probability}%'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        minVerticalPadding: 14,
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFEFF6FF),
          foregroundColor: const Color(0xFF2563EB),
          child: Icon(icon),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(subtitle),
        trailing: Text(
          trailing,
          style: const TextStyle(
            color: Color(0xFF0F766E),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

String rupiah(int amount) {
  final value = amount.toString();
  final buffer = StringBuffer();

  for (var index = 0; index < value.length; index++) {
    final reverseIndex = value.length - index;
    buffer.write(value[index]);
    if (reverseIndex > 1 && reverseIndex % 3 == 1) {
      buffer.write('.');
    }
  }

  return 'Rp $buffer';
}
