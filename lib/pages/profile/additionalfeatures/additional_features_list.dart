import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/auth/auth_event.dart';
import '../../../blocs/auth/auth_state.dart';
import '../../../blocs/biometric/biometric_auth_bloc.dart';
import '../../../blocs/biometric/biometric_auth_event.dart';
import '../../../blocs/biometric/biometric_auth_state.dart';
import '../../../utilities/widgets/custom_dialog.dart';
import '../../../utilities/widgets/profile_menu_card.dart';

class AdditionalFeaturesList extends StatelessWidget {
  const AdditionalFeaturesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<BiometricAuthBloc, BiometricAuthState>(
          builder: (context, state) {
            bool isEnabled = false;
            if (state is BiometricSettingLoaded) {
              isEnabled = state.enabled;
            }
            return ProfileMenuCard(
              icon: Icons.event_available_outlined,
              title: isEnabled ? 'Disabled biometric' : 'Enable biometrics',
              subtitle: 'Additional Login Features',
              color: Colors.green,
              onTap: () {
                CustomDialogs.showCustomDialog(
                  context,
                  isEnabled
                      ? "Are you sure you want to disable biometrics?"
                      : "Are your sure?? Do you want to enable the biometrics?",
                  () {
                    context.read<BiometricAuthBloc>().add(
                      isEnabled
                          ? DisableBiometricEvent()
                          : EnableBiometricEvent(),
                    );
                    Navigator.pop(context); // close dialog after confirming
                  },
                );
              },
            );
          },
        ),

        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return ProfileMenuCard(
              icon: Icons.logout_outlined,
              title: 'Logout',

              subtitle: '',
              onTap: () {
                CustomDialogs.showCustomDialog(
                  context,
                  "Are your sure?? Do you want to logout?",
                  () async {
                    context.read<AuthBloc>().add(LogoutRequested());
                  },
                );
              },
            );
          },
        ),

        ProfileMenuCard(
          icon: Icons.settings,
          title: 'Privacy Policy',

          subtitle: 'Related to app',
          onTap: () {
            context.pushNamed('privacypolicy');
          },
        ),
        ProfileMenuCard(
          icon: Icons.exit_to_app_outlined,
          title: 'Exit',
          subtitle: 'Exit from the app',

          onTap: () {
            exit(0);
          },
        ),
      ],
    );
  }
}
