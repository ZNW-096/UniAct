import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_spacing.dart';

class MainShell extends StatelessWidget {
  const MainShell({
    super.key,
    required this.child,
  });

  final Widget child;

  int _selectedIndex(String location) {
    if (location.startsWith('/session')) {
      return 1;
    }
    return 0;
  }

  void _onItemTapped(BuildContext context, int index, String location) {
    final target = index == 0 ? '/home' : '/session';
    if (location == target) {
      return;
    }
    context.go(target);
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final selectedIndex = _selectedIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => _onItemTapped(context, index, location),
        type: BottomNavigationBarType.fixed,
        iconSize: AppSpacing.space24,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: SizedBox(
              width: AppSpacing.minTouchTarget,
              height: AppSpacing.minTouchTarget,
              child: Icon(Icons.home_outlined),
            ),
            activeIcon: SizedBox(
              width: AppSpacing.minTouchTarget,
              height: AppSpacing.minTouchTarget,
              child: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: AppSpacing.minTouchTarget,
              height: AppSpacing.minTouchTarget,
              child: Icon(Icons.timer_outlined),
            ),
            activeIcon: SizedBox(
              width: AppSpacing.minTouchTarget,
              height: AppSpacing.minTouchTarget,
              child: Icon(Icons.timer),
            ),
            label: 'Session',
          ),
        ],
      ),
    );
  }
}