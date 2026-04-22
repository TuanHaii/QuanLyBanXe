import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key});
  @override
  Widget build(BuildContext context){
    final colorScheme = Theme.of(context).colorScheme;
    final onSurface = colorScheme.onSurface;

    return Column(
      children: [
        // icon logo boc trong hinh vuong bo goc
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Icon(
            Icons.precision_manufacturing_outlined,
            size: 40,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 24),
        
        // chữ precision có khoảng rộng
        Text(
          'P R E C I S I O N',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: onSurface,
            letterSpacing: 6.0, // Tăng khoảng cách giữa các chữ cái
          ),
        ), 
        const SizedBox(height: 8),
        // slogan
        Text(
          'AUTOMOTIVE INTELLIGENCE',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: onSurface.withValues(alpha:0.7),
            letterSpacing: 2.0, // Tăng khoảng cách giữa các chữ cái
          ),
        )
    ],);
  }
}