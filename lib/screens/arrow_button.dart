import 'package:flutter/material.dart';
import 'role_selection_screen.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      tooltip: 'Back to Role Selection',
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const RoleSelectionScreen(),
          ),
          (route) => false,
        );
      },
    );
  }
}