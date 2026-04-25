import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/auth_state.dart';

class LivenessStatusWidget extends StatelessWidget {
  final AuthState state;

  const LivenessStatusWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _getBackgroundColor().withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(child: _buildContent(context)),
    );
  }

  Color _getBackgroundColor() {
    if (state is AuthVerifying) {
      return AppColors.primary.withOpacity(0.1);
    } else if (state is AuthVerificationSuccess) {
      return AppColors.success.withOpacity(0.1);
    } else if (state is AuthVerificationFailed) {
      return AppColors.error.withOpacity(0.1);
    } else if (state is AuthLocked) {
      return AppColors.error.withOpacity(0.15);
    }
    return Colors.grey.withOpacity(0.1);
  }

  Widget _buildContent(BuildContext context) {
    if (state is AuthVerifying) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          const SizedBox(height: 16),
          Text(
            'Verifying...',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    if (state is AuthVerificationSuccess) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            AppConstants.successAnimation,
            width: 120,
            height: 120,
            repeat: false,
          ),
          const SizedBox(height: 16),
          Text(
            'Verification Successful!',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    if (state is AuthVerificationFailed) {
      final failedState = state as AuthVerificationFailed;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cancel, size: 80, color: AppColors.error),
          const SizedBox(height: 16),
          Text(
            'Verification Failed',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Attempt ${failedState.failureCount} of 3',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ],
      );
    }

    if (state is AuthLocked) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lock_clock, size: 80, color: AppColors.error),
          const SizedBox(height: 16),
          Text(
            'Account Locked',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Too many failed attempts',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ],
      );
    }

    // Default state (Unauthenticated)
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.face, size: 80, color: Colors.grey[400]),
        const SizedBox(height: 16),
        Text(
          'Ready to Verify',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
