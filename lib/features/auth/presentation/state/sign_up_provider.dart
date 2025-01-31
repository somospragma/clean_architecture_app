import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/entities/entity_either.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/router/router.dart';
import '../../../../shared/domain/models/error_model.dart';
import '../../../../shared/presentation/tokens/tokens.dart';
import '../../domain/usecases/auth_usecase.dart';
import 'sign_up_state.dart';

final AutoDisposeStateNotifierProvider<SignUpNotifier, SignUpState>
    signUpProvider =
    StateNotifierProvider.autoDispose<SignUpNotifier, SignUpState>(
        (AutoDisposeStateNotifierProviderRef<SignUpNotifier, SignUpState> ref) => SignUpNotifier(
              authUsecase: ref.read(authUsecaseProvider),
              router: ref.read(appRouterProvider),
            ));

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier({
    required this.authUsecase,
    required this.router,
  }) : super(SignUpState());
  final AuthUsecase authUsecase;
  final GoRouter router;

  void cleanAlert() {
    state = state.copyWith();
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  Future<void> signUp() async {
    if (state.email.isEmpty || state.password.isEmpty || state.name.isEmpty) {
      state = state.copyWith(
          alert: AlertModel(
              message: 'All fields are required',
              backgroundColor: CustomColor.ERROR_COLOR));

      return;
    }

    state = state.copyWith(isLoading: true);

    final Either<Failure, bool> response = await authUsecase.signUp(
        email: state.email, password: state.password, name: state.name);
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
              message: 'Successful registration',
              backgroundColor: CustomColor.SUCCESS_COLOR));
    });
  }
}
