import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/entities/entity_either.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/router/router.dart';
import '../../../../shared/domain/models/error_model.dart';
import '../../../../shared/presentation/tokens/tokens.dart';
import '../../domain/usecases/auth_usecase.dart';
import 'reset_password_state.dart';

final StateNotifierProvider<ResetPasswordNotifier, ResetPasswordState>
    resetPasswordProvider =
    StateNotifierProvider<ResetPasswordNotifier, ResetPasswordState>(
        (StateNotifierProviderRef<ResetPasswordNotifier, ResetPasswordState> ref) => ResetPasswordNotifier(
              authUsecase: ref.read(authUsecaseProvider),
              router: ref.read(appRouterProvider),
            ));

class ResetPasswordNotifier extends StateNotifier<ResetPasswordState> {
  ResetPasswordNotifier({
    required this.authUsecase,
    required this.router,
  }) : super(ResetPasswordState());
  final AuthUsecase authUsecase;
  final GoRouter router;

  void cleanAlert() {
    state = state.copyWith();
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  Future<void> resetPassword() async {
    if (state.email.isEmpty) {
      state = state.copyWith(
          alert: AlertModel(
              message: 'All fields are required',
              backgroundColor: CustomColor.ERROR_COLOR));
      return;
    }

    state = state.copyWith(isLoading: true);

    final Either<Failure, bool> response =
        await authUsecase.resetPassword(email: state.email);
    state = state.copyWith(isLoading: false);
    response.when((Failure left) {
      state = state.copyWith(
          alert: AlertModel(
              message: 'An error has ocurred',
              backgroundColor: CustomColor.ERROR_COLOR));
    }, (bool right) async {
      state = state.reset();
      state = state.copyWith(
          alert: AlertModel(
              message: 'Successfully sent',
              backgroundColor: CustomColor.SUCCESS_COLOR));
    });
  }
}
