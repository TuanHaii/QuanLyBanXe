import 'package:flutter/material.dart';

class PrecisionPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool enabled;

  const PrecisionPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (isLoading || !enabled) ? null : onPressed,
        borderRadius: BorderRadius.circular(12),
        splashColor: const Color(0xFF00D4FF).withValues(alpha: 0.2),
        highlightColor: const Color(0xFF00D4FF).withValues(alpha: 0.1),
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1E90FF).withValues(
                  alpha: (isLoading || !enabled) ? 0.5 : 1.0,
                ),
                const Color(0xFF00D4FF).withValues(
                  alpha: (isLoading || !enabled) ? 0.5 : 1.0,
                ),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              if (enabled && !isLoading)
                BoxShadow(
                  color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withValues(alpha: 0.8),
                      ),
                      strokeWidth: 2.5,
                    ),
                  )
                : Text(
                    label,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}