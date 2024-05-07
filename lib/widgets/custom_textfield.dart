import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool? obscure, next;
  final Widget? suffixIcon;
  final FormFieldValidator? validator;
  final String? initialValue;
  final bool? enabled;
  const CustomTextField({
    super.key,
    required this.label,
    this.maxLines,
    this.minLines,
    this.keyboardType,
    this.contentPadding,
    this.controller,
    this.onChanged,
    this.obscure,
    this.suffixIcon,
    this.validator,
    this.next,
    this.initialValue,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      enabled: enabled,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      obscureText: obscure ?? false,
      textInputAction:
          next ?? false ? TextInputAction.next : TextInputAction.done,
      decoration: InputDecoration(
        hintMaxLines: 1,
        suffixIcon: suffixIcon,
        label: Text(
          label,
          maxLines: 1,
        ),
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 15,
            ),
      ),
    );
  }
}
