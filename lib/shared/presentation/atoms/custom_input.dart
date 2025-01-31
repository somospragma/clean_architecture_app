import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.isPassword = false,
  });

  factory CustomInput.password({
    required String hintText,
    required ValueChanged<String> onChanged,
  }) {
    return CustomInput(hintText: hintText, isPassword: true, onChanged: onChanged,);
  }

  final String hintText;
  final bool isPassword;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}
