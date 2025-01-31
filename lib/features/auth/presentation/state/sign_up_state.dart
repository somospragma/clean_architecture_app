import '../../../../shared/domain/models/error_model.dart';

class SignUpState {

  SignUpState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.alert,
  });
  final String name;
  final String email;
  final String password;
  final bool isLoading;
  final AlertModel? alert;

  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    bool? isLoading,
    AlertModel? alert,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      alert: alert ?? this.alert
    );
  }

  SignUpState reset() {
    return SignUpState();
  }
}
