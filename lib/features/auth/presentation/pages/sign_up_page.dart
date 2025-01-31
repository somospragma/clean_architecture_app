import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/domain/models/error_model.dart';
import '../../../../shared/presentation/atoms/custom_button.dart';
import '../../../../shared/presentation/atoms/custom_input.dart';
import '../../../../shared/presentation/pages/loading_page.dart';
import '../../../../shared/presentation/templates/templates.dart';
import '../../../../shared/presentation/tokens/custom_text_style.dart';
import '../../../../shared/presentation/tokens/spacing.dart';
import '../state/sign_up_provider.dart';
import '../state/sign_up_state.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLoading = ref
        .watch(signUpProvider.select((SignUpState state) => state.isLoading));

    final SignUpNotifier signUpNotifier = ref.read(signUpProvider.notifier);

    ref.listen<AlertModel?>(
        signUpProvider.select((SignUpState state) => state.alert),
        (_, AlertModel? alert) {
      if (alert != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(alert.message!),
            backgroundColor: alert.backgroundColor,
          ),
        );
        signUpNotifier.cleanAlert();
      }
    });

    if (isLoading) {
      return const LoadingPage();
    }

    return MainTemplate(
      body: Padding(
        padding: const EdgeInsets.all(Spacing.SPACE_M),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sign Up',
              style: CustomTextStyle.FONT_STYLE_TITLE,
            ),
            const SizedBox(height: Spacing.SPACE_M),
            CustomInput(
              hintText: 'Enter name',
              onChanged: signUpNotifier.updateName,
            ),
            const SizedBox(height: Spacing.SPACE_M),
            CustomInput(
                hintText: 'Enter email', onChanged: signUpNotifier.updateEmail),
            const SizedBox(height: Spacing.SPACE_M),
            CustomInput.password(
              hintText: 'Enter password',
              onChanged: signUpNotifier.updatePassword,
            ),
            const SizedBox(height: Spacing.SPACE_XS),
            CustomButton(
              text: 'Sign Up',
              onTap: signUpNotifier.signUp,
            ),
            const SizedBox(height: Spacing.SPACE_XS),
            CustomButton.link(
              text: 'Log In',
              onTap: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
