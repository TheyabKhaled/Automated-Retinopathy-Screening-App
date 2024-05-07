import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? color, loadingColor;
  final TextStyle? style;
  final double? width, height;
  final Icon? icon;
  final bool loading;
  const CustomButton({
    super.key,
    this.onTap,
    this.color,
    this.style,
    this.width,
    this.height,
    required this.text,
    this.icon,
    this.loading = false,
    this.loadingColor,
  });

  @override
  Widget build(BuildContext context) {
    return icon == null
        ? ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              fixedSize: Size(width ?? 100, height ?? 40),
              backgroundColor: color ?? primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: loading
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CircularProgressIndicator(
                        color: loadingColor ?? Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : Text(
                    text,
                    style: style ??
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                  ),
          )
        : ElevatedButton.icon(
            icon: icon!,
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              fixedSize: Size(width ?? 100, height ?? 40),
              backgroundColor: color ?? primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            label: Text(
              text,
              style: style ??
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
            ),
          );
  }
}
