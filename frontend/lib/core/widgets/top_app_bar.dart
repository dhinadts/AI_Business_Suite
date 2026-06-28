import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_language.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../features/associations/providers/associations_provider.dart';

class TopAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const TopAppBar({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final unreadCount = ref.watch(associationsProvider).unreadCount;
    final language = ref.watch(appLanguageProvider);
    return AppBar(
      toolbarHeight: 72,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appTranslate(title, language),
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          Text(
            'DHINADTS IT SOLUTIONS AND SUPPORT',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
      actions: [
        PopupMenuButton<AppLanguage>(
          tooltip: appTranslate('Language', language),
          icon: const Icon(Icons.translate_rounded),
          onSelected: (value) =>
              ref.read(appLanguageProvider.notifier).setLanguage(value),
          itemBuilder: (context) => [
            for (final item in AppLanguage.values)
              PopupMenuItem(
                value: item,
                child: Row(
                  children: [
                    SizedBox(width: 32, child: Text(item.shortLabel)),
                    Text(item.label),
                  ],
                ),
              ),
          ],
        ),
        IconButton(
          onPressed: () => context.go('/ai-assistant'),
          icon: const Icon(Icons.auto_awesome_rounded),
          tooltip: 'AI Assistant',
        ),
        _NotificationAction(count: unreadCount),
        IconButton(
          onPressed: () => context.go('/settings'),
          icon: const Icon(Icons.settings_rounded),
          tooltip: 'Settings',
        ),
        IconButton(
          onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
          icon: Icon(
            themeMode == ThemeMode.light
                ? Icons.dark_mode_rounded
                : Icons.light_mode_rounded,
          ),
          tooltip: 'Theme',
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton.filledTonal(
            onPressed: () => context.go('/profile'),
            icon: const Icon(Icons.person_rounded),
            tooltip: 'Profile',
            style: IconButton.styleFrom(
              backgroundColor: AppColors.orange.withValues(alpha: 0.14),
              foregroundColor: AppColors.orange,
            ),
          ),
        ),
      ],
    );
  }
}

class _NotificationAction extends StatelessWidget {
  const _NotificationAction({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Badge(
      isLabelVisible: count > 0,
      label: Text(count > 99 ? '99+' : '$count'),
      child: IconButton(
        onPressed: () => context.go('/notifications'),
        icon: const Icon(Icons.notifications_none_rounded),
        tooltip: 'Notifications',
      ),
    );
  }
}
