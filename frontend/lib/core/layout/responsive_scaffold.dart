import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/breakpoints.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../widgets/brand_logo.dart';
import '../widgets/top_app_bar.dart';
import 'navigation_items.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.child,
    this.floatingActionButton,
  });

  final String title;
  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: title,
      floatingActionButton: floatingActionButton,
      child: child,
    );
  }
}

class ResponsiveScaffold extends ConsumerWidget {
  const ResponsiveScaffold({
    super.key,
    required this.title,
    required this.child,
    this.floatingActionButton,
  });

  final String title;
  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizeClass = Breakpoints.of(context);
    final location = GoRouterState.of(context).uri.path;
    final profile = ref.watch(businessProfileProvider);
    final primaryItems = primaryNavItemsForProfile(profile);
    final mobileItems = mobileNavItemsForProfile(profile);
    if (sizeClass == WindowSizeClass.mobile) {
      return BottomNavShell(
        title: title,
        location: location,
        items: mobileItems,
        floatingActionButton: floatingActionButton,
        child: child,
      );
    }
    if (sizeClass == WindowSizeClass.tablet) {
      return TabletNavigationRail(
        title: title,
        location: location,
        items: primaryItems,
        floatingActionButton: floatingActionButton,
        child: child,
      );
    }
    return Scaffold(
      appBar: TopAppBar(title: title),
      floatingActionButton: floatingActionButton,
      body: Row(
        children: [
          SidebarNavigation(location: location, items: primaryItems),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1500),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarNavigation extends ConsumerWidget {
  const SidebarNavigation({
    super.key,
    required this.location,
    required this.items,
  });

  final String location;
  final List<NavItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collapsed = ref.watch(sidebarCollapsedProvider);
    final width = collapsed ? 88.0 : 280.0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: width,
      color: AppColors.navy,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(collapsed ? 8 : 18),
              child: Row(
                children: [
                  Expanded(child: BrandLogo(compact: collapsed, onDark: true)),
                  IconButton(
                    color: Colors.white,
                    constraints: BoxConstraints.tight(
                      Size(collapsed ? 36 : 48, collapsed ? 36 : 48),
                    ),
                    padding: EdgeInsets.zero,
                    onPressed: () =>
                        ref.read(sidebarCollapsedProvider.notifier).state =
                            !collapsed,
                    icon: Icon(
                      collapsed ? Icons.menu_open_rounded : Icons.menu_rounded,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final selected = navIndexForPath(location, items) == index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Material(
                      color: selected
                          ? Colors.white.withValues(alpha: 0.12)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        selected: selected,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        leading: Icon(
                          item.icon,
                          color: selected ? AppColors.orange : Colors.white70,
                        ),
                        title: collapsed
                            ? null
                            : Text(
                                item.label,
                                style: TextStyle(
                                  color: selected
                                      ? Colors.white
                                      : Colors.white70,
                                  fontWeight: selected
                                      ? FontWeight.w800
                                      : FontWeight.w500,
                                ),
                              ),
                        onTap: () => context.go(item.path),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavShell extends StatelessWidget {
  const BottomNavShell({
    super.key,
    required this.title,
    required this.location,
    required this.items,
    required this.child,
    this.floatingActionButton,
  });

  final String title;
  final String location;
  final List<NavItem> items;
  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = navIndexForPath(location, items);
    final size = MediaQuery.sizeOf(context);
    final landscape = size.width > size.height;
    final horizontalPadding = landscape ? 20.0 : 14.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            onPressed: () => context.go('/notifications'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            12,
            horizontalPadding,
            18,
          ),
          child: child,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => context.go(items[index].path),
        destinations: [
          for (final item in items)
            NavigationDestination(icon: Icon(item.icon), label: item.label),
        ],
      ),
    );
  }
}

class TabletNavigationRail extends StatelessWidget {
  const TabletNavigationRail({
    super.key,
    required this.title,
    required this.location,
    required this.items,
    required this.child,
    this.floatingActionButton,
  });

  final String title;
  final String location;
  final List<NavItem> items;
  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = navIndexForPath(location, items);
    return Scaffold(
      appBar: TopAppBar(title: title),
      floatingActionButton: floatingActionButton,
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            labelType: NavigationRailLabelType.selected,
            onDestinationSelected: (index) => context.go(items[index].path),
            destinations: [
              for (final item in items)
                NavigationRailDestination(
                  icon: Icon(item.icon),
                  label: Text(item.label),
                ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
