import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavItem>? customItems;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    this.customItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = customItems ?? _defaultItems;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // White Surface
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 65,
          child: Row(
            children: items.asMap().entries.map((entry) {
              int index = entry.key;
              BottomNavItem item = entry.value;
              bool isSelected = currentIndex == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isSelected ? item.activeIcon : item.icon,
                          color: isSelected
                              ? Color(0xFF4CAF50) // Primary Green
                              : Color(0xFF9E9E9E), // Grey
                          size: 24,
                        ),
                        SizedBox(height: 4),
                        Text(
                          item.label,
                          style: TextStyle(
                            color: isSelected
                                ? Color(0xFF4CAF50) // Primary Green
                                : Color(0xFF9E9E9E), // Grey
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  List<BottomNavItem> get _defaultItems => [
    BottomNavItem(
      icon: Icons.receipt_long_outlined,
      activeIcon: Icons.receipt_long,
      label: 'Records',
    ),
    BottomNavItem(
      icon: Icons.analytics_outlined,
      activeIcon: Icons.analytics,
      label: 'Analysis',
    ),
    BottomNavItem(
      icon: Icons.calculate_outlined,
      activeIcon: Icons.calculate,
      label: 'Budgets',
    ),
    BottomNavItem(
      icon: Icons.account_balance_outlined,
      activeIcon: Icons.account_balance,
      label: 'Accounts',
    ),
    BottomNavItem(
      icon: Icons.category_outlined,
      activeIcon: Icons.category,
      label: 'Categories',
    ),
  ];
}

class BottomNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

// Alternative Material Design Bottom Navigation Bar
class MaterialBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavItem>? customItems;

  const MaterialBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    this.customItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = customItems ?? _defaultItems;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF4CAF50), // Primary Green
        unselectedItemColor: Color(0xFF9E9E9E), // Grey
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 0,
        items: items.map((item) => BottomNavigationBarItem(
          icon: Icon(item.icon),
          activeIcon: Icon(item.activeIcon),
          label: item.label,
        )).toList(),
      ),
    );
  }

  List<BottomNavItem> get _defaultItems => [
    BottomNavItem(
      icon: Icons.receipt_long_outlined,
      activeIcon: Icons.receipt_long,
      label: 'Records',
    ),
    BottomNavItem(
      icon: Icons.analytics_outlined,
      activeIcon: Icons.analytics,
      label: 'Analysis',
    ),
    BottomNavItem(
      icon: Icons.calculate_outlined,
      activeIcon: Icons.calculate,
      label: 'Budgets',
    ),
    BottomNavItem(
      icon: Icons.account_balance_outlined,
      activeIcon: Icons.account_balance,
      label: 'Accounts',
    ),
    BottomNavItem(
      icon: Icons.category_outlined,
      activeIcon: Icons.category,
      label: 'Categories',
    ),
  ];
}

// Modern Floating Bottom Navigation with Pills