import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';

class TopAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const TopAppBar({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return AppBar(
      toolbarHeight: 72,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          Text('DHINADTS IT SOLUTIONS AND SUPPORT', style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
      actions: [
        IconButton(onPressed: () => context.go('/ai-assistant'), icon: const Icon(Icons.auto_awesome_rounded), tooltip: 'AI Assistant'),
        IconButton(onPressed: () => context.go('/notifications'), icon: const Icon(Icons.notifications_none_rounded), tooltip: 'Notifications'),
        IconButton(
          onPressed: () => ref.read(themeModeProvider.notifier).state = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
          icon: Icon(themeMode == ThemeMode.light ? Icons.dark_mode_rounded : Icons.light_mode_rounded),
          tooltip: 'Theme',
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CircleAvatar(backgroundColor: AppColors.orange.withValues(alpha: 0.14), foregroundColor: AppColors.orange, child: const Icon(Icons.person_rounded)),
        ),
      ],
    );
  }
}
