import 'package:flutter/material.dart';

class PrecisionSecondaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool enabled;

  const PrecisionSecondaryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(12),
        splashColor: const Color(0xFF00D4FF).withValues(alpha: 0.15),
        highlightColor: const Color(0xFF00D4FF).withValues(alpha: 0.08),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF00D4FF).withValues(
                alpha: enabled ? 0.4 : 0.2,
              ),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF1A1F3A).withValues(
              alpha: enabled ? 0.6 : 0.4,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: const Color(0xFF00D4FF).withValues(
                  alpha: enabled ? 0.8 : 0.4,
                ),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: const Color(0xFF00D4FF).withValues(
                        alpha: enabled ? 0.8 : 0.4,
                      ),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}