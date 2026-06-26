import 'package:flutter/material.dart';

import '../constants/assets.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.compact = false, this.onDark = false});

  final bool compact;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final textColor = onDark
        ? Colors.white
        : Theme.of(context).colorScheme.onSurface;
    final labelColor = onDark
        ? Colors.white70
        : Theme.of(context).colorScheme.onSurfaceVariant;
    final logoSize = compact ? 26.0 : 44.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: compact ? logoSize : 50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(compact ? 8 : 12),
                child: Image.asset(
                  AppAssets.logo,
                  height: logoSize,
                  width: logoSize,
                  fit: BoxFit.cover,
                ),
              ),
              if (!compact) ...[
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'DHINADTS',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: labelColor,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (!compact) ...[
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'AI Business Suite',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
