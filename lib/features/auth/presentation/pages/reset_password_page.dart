import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/domain/models/error_model.dart';
import '../../../../shared/presentation/atoms/atoms.dart';
import '../../../../shared/presentation/pages/loading_page.dart';
import '../../../../shared/presentation/templates/templates.dart';
import '../../../../shared/presentation/tokens/tokens.dart';
import '../state/reset_password_provider.dart';
import '../state/reset_password_state.dart';

class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLoading = ref.watch(resetPasswordProvider
        .select((ResetPasswordState state) => state.isLoading));

    final ResetPasswordNotifier resetPasswordNotifier =
        ref.read(resetPasswordProvider.notifier);

    ref.listen<AlertModel?>(
        resetPasswordProvider.select((ResetPasswordState state) => state.alert),
        (_, AlertModel? alert) {
      if (alert != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(alert.message!),
            backgroundColor: alert.backgroundColor,
          ),
        );
        resetPasswordNotifier.cleanAlert();
      }
    });

    if (isLoading) {
      return const LoadingPage();
    }

    return MainTemplate(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        floatingActionButton: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.SPACE_L),
          child: Column(
            children: <Widget>[
              const SizedBox(height: Spacing.SPACE_XXL),
              const Text(
                'Reset password',
                style: CustomTextStyle.FONT_STYLE_TITLE,
              ),
              const SizedBox(height: Spacing.SPACE_L),
              const Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s',
                style: CustomTextStyle.FONT_STYLE_DESCRIPTION,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Spacing.SPACE_M),
              CustomInput(
                hintText: 'Enter email',
                onChanged: resetPasswordNotifier.updateEmail,
              ),
              const SizedBox(height: Spacing.SPACE_M),
              CustomButton(
                text: 'Submit',
                onTap: resetPasswordNotifier.resetPassword,
              ),
            ],
          ),
        ));
  }
}
