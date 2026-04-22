import 'package:flutter/material.dart';

class PrimaryAuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;

  const PrimaryAuthButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  });
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final startColor = isDark ? colorScheme.primary : colorScheme.primaryContainer;
    final endColor = isDark
        ? colorScheme.primary.withValues(alpha: 0.82)
        : colorScheme.primary;
    final foregroundColor = isDark
        ? colorScheme.onPrimary
        : colorScheme.onPrimaryContainer;

    final borderRadius = BorderRadius.circular(8);
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: isLoading ? null : onTap,
          borderRadius: borderRadius,
          child: InkWell(
            onTap: isLoading ? null : onTap,
            borderRadius: borderRadius,
            child: Ink(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient: LinearGradient(
                  colors: [startColor, endColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: endColor.withValues(alpha: 0.24),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: foregroundColor,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        text,
                        style: TextStyle(
                          color: foregroundColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
