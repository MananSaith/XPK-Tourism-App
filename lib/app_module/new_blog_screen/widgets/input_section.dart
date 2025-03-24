import 'package:flutter/material.dart';

class InputSection extends StatelessWidget {
  final String? nameHint;
  final String descriptionHint;

  const InputSection({
    super.key,
    this.nameHint,
    required this.descriptionHint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (nameHint != null) ...[
          TextField(
            decoration: InputDecoration(
              hintText: nameHint,
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
        TextField(
          decoration: InputDecoration(
            hintText: descriptionHint,
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          maxLines: 4,
        ),
      ],
    );
  }
}
