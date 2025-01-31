import '../../../../shared/domain/models/error_model.dart';

class ResetPasswordState {
  ResetPasswordState({
    this.email = '',
    this.isLoading = false,
    this.alert,
  });

  final String email;
  final bool isLoading;
  final AlertModel? alert;

  ResetPasswordState copyWith({
    String? email,
    bool? isLoading,
    AlertModel? alert,
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      alert: alert ?? this.alert,
    );
  }

  ResetPasswordState reset() {
    return ResetPasswordState();
  }
}
