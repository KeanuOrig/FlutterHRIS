import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final List<NavItem> navItems;
  final String currentRoute;

  const Navbar({
    super.key,
    required this.navItems,
    required this.currentRoute
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[300],
      selectedItemColor: Colors.blue[700],
      unselectedItemColor: Colors.grey[600],
      type: BottomNavigationBarType.fixed,
      items: navItems
          .map((item) => BottomNavigationBarItem(
                label: item.title,
                icon: Icon(item.icon)
              ))
          .toList(),
      currentIndex: navItems.indexWhere((item) => item.route == currentRoute),
      onTap: (index) {
        if (navItems[index].route != currentRoute) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                return navItems[index].page;
              },
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        }
      },
    );
  }
}

class NavItem {
  final String title;
  final String route;
  final IconData icon;
  final Widget page;

  NavItem({
    required this.title,
    required this.route,
    required this.icon,
    required this.page,
  });
}
