import 'package:cement_flutter/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:cement_flutter/screens/profile/components/SignoutModal.dart';

class Sidebar extends StatefulWidget {
  final String avatarUrl;
  final String cityName;
  final String userName;

  const Sidebar({
    Key? key,
    required this.avatarUrl,
    required this.cityName,
    required this.userName,
  }) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool isStatisticsExpanded = false;
  bool isClientsExpanded = false;
  bool isSettingsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Container(
                width: constraints.maxWidth < 600 ? double.infinity : 256,
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Info Section
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 24),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage:
                                Image.asset(widget.avatarUrl).image,
                            backgroundColor: Colors.grey[200],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.cityName.toUpperCase(),
                                  style: const TextStyle(
                                    color: Color(0xFF757575),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  widget.userName,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                        color: Color(0xFFF6F6F6), height: 32, thickness: 1),

                    // Navigation Items
                    _buildNavItem(
                      icon: Icons.home,
                      label: 'Accueil',
                      onTap: () => Navigator.pushNamed(context, Routes.home),
                    ),
                    const SizedBox(height: 16),

                    // Profile Section
                    _buildNavItem(
                      icon: Icons.person,
                      label: 'Profile',
                      onTap: () => Navigator.pushNamed(context, Routes.profile),
                    ),
                    const SizedBox(height: 16),

                    // Maps Section
                    _buildNavItem(
                      icon: Icons.map,
                      label: 'Maps',
                      onTap: () => Navigator.pushNamed(context, Routes.maps),
                    ),
                    const SizedBox(height: 16),

                    // Clients Dropdown
                    _buildDropdownItem(
                      icon: Icons.people,
                      label: 'Clients',
                      isExpanded: isClientsExpanded,
                      onToggle: () => setState(() {
                        isClientsExpanded = !isClientsExpanded;
                      }),
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, Routes.CreateClientPage),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text('Ajouter un client'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Products
                    _buildNavItem(
                      icon: Icons.shopping_cart,
                      label: 'Produits',
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.products_screen),
                    ),
                    const SizedBox(height: 16),

                    // Visits
                    _buildNavItem(
                      icon: Icons.calendar_today,
                      label: 'Visites',
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.calendar_screen),
                    ),
                    const SizedBox(height: 16),

                    // Statistics Dropdown
                    _buildDropdownItem(
                      icon: Icons.bar_chart,
                      label: 'Statistiques',
                      isExpanded: isStatisticsExpanded,
                      onToggle: () => setState(() {
                        isStatisticsExpanded = !isStatisticsExpanded;
                      }),
                      children: [
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.historyStat),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text('Historique'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.rateStat),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text('Taux'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.stats_page),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text('Statistiques'),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                        color: Color(0xFFF6F6F6), height: 32, thickness: 1),

                    // Settings Dropdown
                    _buildDropdownItem(
                      icon: Icons.settings,
                      label: 'Paramètres',
                      isExpanded: isSettingsExpanded,
                      onToggle: () => setState(() {
                        isSettingsExpanded = !isSettingsExpanded;
                      }),
                      children: [
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.settings),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text('Paramètres'),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),

                    // Logout Section
                    const Divider(
                        color: Color(0xFFF6F6F6), height: 32, thickness: 1),
                    _buildNavItem(
                      icon: Icons.logout,
                      label: 'Déconnexion',
                      isLogout: true,
                      onTap: () => _showSignOutDialog(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    bool isLogout = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: isLogout ? const Color(0xFFD55F5A) : const Color(0xFF757575),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isLogout
                    ? const Color(0xFFD55F5A)
                    : const Color(0xFF757575),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownItem({
    required IconData icon,
    required String label,
    required bool isExpanded,
    required VoidCallback onToggle,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onToggle,
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF757575)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: const Color(0xFF757575),
              ),
            ],
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 36, top: 8),
            child: Column(children: children),
          ),
      ],
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SignOutDialog(
            onCancel: () => Navigator.pop(context),
            onConfirm: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Déconnecté avec succès !')),
              );
            },
          ),
        );
      },
    );
  }
}
