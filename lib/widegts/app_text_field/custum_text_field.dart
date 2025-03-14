import 'package:flutter/material.dart';
import 'package:xpk/widegts/app_text/textwidget.dart';

class CustomTextField extends StatelessWidget {
  final String? text; // Required field for the label/title
  final String? hintText; // Optional placeholder text
  final String? labelText; // Optional label text
  final TextEditingController? controller; // Controller for text
  final Widget? prefixIcon; // Optional prefix icon
  final Widget? trailingIcon; // Optional trailing icon
  final Color? borderColor; // Border color
  final double? borderRadius; // Border radius
  final Color? backgroundColor; // Background color
  final ValueChanged<String>? onChanged; // Callback for text change
  final String? Function(String?)? validator; // Validation function
  final TextInputType? keyboardType; // Input type (e.g., email, number)
  final bool isPassword; // Whether the field hides input (password)
  final TextInputAction? textInputAction; // Action button on keyboard
  final FocusNode? focusNode; // Focus node to control the focus
  final FocusNode? nextFocusNode; // Focus node for the next field (optional)
  final ValueChanged<String>?
      onFieldSubmitted; // Callback when the field is submitted
  final Color? hintTextColor; // Color for the hint text
  final double? height; // Optional height for the text field
  final double? width; // Optional width for the text field
  final int? maxLines; // Optional max lines for the text field
  final int? minLines; // Optional min lines for the text field
  final GestureTapCallback? onTap; // Optional onTap callback function

  const CustomTextField({
    super.key,
    this.text, // Always required
    this.hintText, // Optional
    this.labelText, // Optional
    this.controller,
    this.prefixIcon,
    this.trailingIcon,
    this.borderColor = Colors.grey, // Default border color
    this.borderRadius = 8.0, // Default border radius
    this.backgroundColor = Colors.white, // Default background color
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text, // Default to text input
    this.isPassword = false, // Default to non-password
    this.textInputAction = TextInputAction.next, // Default to next action
    this.focusNode, // Custom focus node for this field
    this.nextFocusNode, // Focus node for the next field
    this.onFieldSubmitted, // Callback for field submission
    this.hintTextColor, // Optional hintTextColor
    this.height, // Optional height
    this.width, // Optional width
    this.maxLines, // Optional max lines
    this.minLines, // Optional min lines
    this.onTap, // Optional onTap callback
  });

  @override
  Widget build(BuildContext context) {
    final defaultHeight =
        MediaQuery.of(context).size.height * 0.08; // Default height
    final defaultWidth = MediaQuery.of(context).size.width; // Default width

    // Set maxLines to 1 if the field is a password field
    final effectiveMaxLines = isPassword ? 1 : (maxLines ?? 1);
    final effectiveMinLines = minLines ?? 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (text != null) TextWidget(text: text!, fSize: 16),
        SizedBox(height: defaultHeight * 0.01),
        Container(
          height: height ?? defaultHeight, // Use provided height or default
          width: width ?? defaultWidth, // Use provided width or default
          //padding: const EdgeInsets.symmetric(horizontal: 4),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: isPassword,
            onChanged: onChanged,
            validator: validator,
            focusNode: focusNode, // Set the current field's focus node
            textInputAction: textInputAction, // Set the action on the keyboard

            onFieldSubmitted: (value) {
              // Call the passed callback when the field is submitted
              if (onFieldSubmitted != null) {
                onFieldSubmitted!(value); // Call the callback function
              }
              // Move focus to the next field when the action button is pressed
              if (nextFocusNode != null) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            },
            maxLines: effectiveMaxLines, // Set the max lines dynamically
            minLines: effectiveMinLines, // Set the min lines
            onTap: onTap, // Apply the onTap callback if provided
            decoration: InputDecoration(
              hintText: hintText, // Displays hintText only if provided
              labelText: labelText, // Displays labelText only if provided
              prefixIcon: prefixIcon,
              suffixIcon: trailingIcon,
              filled: true,
              fillColor: backgroundColor, // Apply background color
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
                borderSide: BorderSide(
                  color: borderColor!, // Use default or provided border color
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
                borderSide: BorderSide(
                  color: borderColor!,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
                borderSide: BorderSide(
                  color: borderColor ?? Theme.of(context).primaryColor,
                  width: 2.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                gapPadding: 4,
                borderRadius: BorderRadius.circular(borderRadius!),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.5,
                ),
              ),
              hintStyle: TextStyle(
                color: hintTextColor ?? Colors.grey, // Apply hint text color
              ),
            ),
          ),
        ),
      ],
    );
  }
}
