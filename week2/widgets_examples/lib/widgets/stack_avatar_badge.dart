import 'package:flutter/material.dart';

class StackAvatarBadge extends StatelessWidget {
  const StackAvatarBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: .none,
        children: [
          // Avatar (cercle)
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: .circle,
              color: Colors.blueGrey.shade300,
            ),
            child: const Center(
              child: Text(
                'A',
                style: TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
          ),

          // Badge (statut en ligne)
          Positioned(
            bottom: 6,
            right: 6,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: .circle,
                color: Colors.green,
                border: Border.all(color: Colors.white, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
