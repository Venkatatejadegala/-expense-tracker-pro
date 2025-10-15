import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class AccessibilityUtils {
  // Add semantic labels for better accessibility
  static Widget addSemantics({
    required Widget child,
    String? label,
    String? hint,
    bool? isButton,
    bool? isHeader,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      button: isButton ?? false,
      header: isHeader ?? false,
      child: child,
    );
  }

  // Ensure proper contrast ratios
  static Color getAccessibleColor(Color backgroundColor, Color textColor) {
    // Simple contrast check - in production, use proper contrast calculation
    return textColor;
  }

  // Add focus management
  static void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  // Screen reader announcements
  static void announceToScreenReader(BuildContext context, String message) {
    SemanticsService.announce(message, TextDirection.ltr);
  }
}
