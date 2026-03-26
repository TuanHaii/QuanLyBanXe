import 'package:flutter/material.dart';

class PrecisionTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool enabled;

  const PrecisionTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.enabled = true,
  });

  @override
  State<PrecisionTextField> createState() => _PrecisionTextFieldState();
}

class _PrecisionTextFieldState extends State<PrecisionTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      validator: widget.validator,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white,
            letterSpacing: 0.5,
      ),
      cursorColor: const Color(0xFF00D4FF),
      cursorWidth: 2,
      decoration: InputDecoration(
        labelText: widget.label.isNotEmpty ? widget.label : null,
        hintText: widget.hint,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF6B7280).withValues(alpha: 0.6),
              letterSpacing: 0.5,
        ),
        labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: _isFocused
                  ? const Color(0xFF00D4FF)
                  : const Color(0xFF9CA3AF),
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
        ),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: _isFocused
                    ? const Color(0xFF00D4FF)
                    : const Color(0xFF6B7280),
                size: 20,
              )
            : null,
        suffixIcon: widget.suffixIcon,
        filled: true,
        fillColor: const Color(0xFF111827).withValues(alpha: 0.6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: const Color(0xFF00D4FF).withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: const Color(0xFF00D4FF).withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF00D4FF),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFEF4444),
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFEF4444),
            width: 2,
          ),
        ),
        errorStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: const Color(0xFFEF4444),
              fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}