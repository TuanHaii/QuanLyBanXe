import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key});
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        // icon logo boc trong hinh vuong bo goc
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFC5D1E0),
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Icon(
            Icons.precision_manufacturing_outlined,
            size: 40,
            color: Color(0xFF12141A),
          ),
        ),
        const SizedBox(height: 24),
        
        // chữ precision có khoảng rộng
        const Text(
          'P R E C I S I O N',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.white,
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
            color: Colors.white.withValues(alpha:0.7),
            letterSpacing: 2.0, // Tăng khoảng cách giữa các chữ cái
          ),
        )
    ],);
  }
}