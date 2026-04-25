import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LivenessInstructionCard extends StatelessWidget {
  const LivenessInstructionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Instructions',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInstruction(
            context,
            icon: Icons.light_mode,
            text: 'Ensure good lighting on your face',
          ),
          const SizedBox(height: 12),
          _buildInstruction(
            context,
            icon: Icons.face,
            text: 'Position your face in the center',
          ),
          const SizedBox(height: 12),
          _buildInstruction(
            context,
            icon: Icons.remove_red_eye,
            text: 'Look directly at the camera',
          ),
          const SizedBox(height: 12),
          _buildInstruction(
            context,
            icon: Icons.do_not_disturb_on,
            text: 'Remove glasses or face coverings',
          ),
        ],
      ),
    );
  }

  Widget _buildInstruction(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}
