import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/liveness_instruction_card.dart';
import '../widgets/liveness_status_widget.dart';

class LivenessGatePage extends StatelessWidget {
  const LivenessGatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              // Navigate to dashboard
              // Navigation handled in main.dart via AuthBloc builder
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Authentication successful!'),
                  backgroundColor: AppColors.success,
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App Logo/Title
                  Text(
                    AppStrings.appName,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Secure Access',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  // Status Widget
                  LivenessStatusWidget(state: state),
                  const SizedBox(height: 32),

                  // Instructions Card
                  if (state is Unauthenticated ||
                      state is AuthVerificationFailed)
                    const LivenessInstructionCard(),

                  const SizedBox(height: 32),

                  // Action Button
                  _buildActionButton(context, state),

                  // Lockout Timer
                  if (state is AuthLocked) ...[
                    const SizedBox(height: 24),
                    Text(
                      'Please wait ${state.remainingSeconds} seconds',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],

                  // Failure Message
                  if (state is AuthVerificationFailed) ...[
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.error.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warning_amber_rounded,
                            color: AppColors.error,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              state.message,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.error),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, AuthState state) {
    if (state is AuthVerifying) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is AuthLocked) {
      return CustomButton(
        text: 'Locked',
        onPressed: null,
        variant: ButtonVariant.secondary,
      );
    }

    if (state is AuthVerificationSuccess) {
      return CustomButton(
        text: 'Success!',
        onPressed: null,
        variant: ButtonVariant.primary,
        icon: Icons.check_circle,
      );
    }

    return CustomButton(
      text: 'Start Verification',
      onPressed: () => _startVerification(context),
      icon: Icons.face,
    );
  }

  void _startVerification(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    authBloc.add(const StartLivenessVerification());

    // Simulate liveness verification
    // In a real app, this would integrate with a liveness detection SDK
    Future.delayed(const Duration(seconds: 2), () {
      // Randomly succeed or fail for demo purposes
      // In production, this would be based on actual liveness detection
      final success = DateTime.now().second % 2 == 0;

      if (success) {
        authBloc.add(const LivenessVerificationSuccess());
      } else {
        authBloc.add(const LivenessVerificationFailure());
      }
    });
  }
}
