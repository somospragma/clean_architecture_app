import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/entities/entity_either.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../shared/domain/models/api_response_model.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/models/user_model.dart';

final AutoDisposeProvider<AuthUsecase> authUsecaseProvider =
    Provider.autoDispose<AuthUsecase>(
        (Ref<AuthUsecase> ref) {
  return AuthUsecase(authRepository: ref.read(authRepositoryProvider));
});

class AuthUsecase {
  AuthUsecase({required this.authRepository});
  final AuthRepositoryImpl authRepository;

  Future<Either<Failure, UserModel>> logIn(
      {required String email, required String password}) async {
    final Either<Failure, ApiResponseModel<UserModel>> response =
        await authRepository.logIn(UserModel(email: email, password: password));

    return response.when((Failure left) async {
      return Left<Failure, UserModel>(left);
    }, (ApiResponseModel<UserModel> right) async {
      return Right<Failure, UserModel>(right.results!);
    });
  }

  Future<Either<Failure, bool>> resetPassword(
      {required String email}) async {
    final Either<Failure, ApiResponseModel<bool>> response =
        await authRepository.resetPassword(UserModel(email: email,));

    return response.when((Failure left) async {
      return Left<Failure, bool>(left);
    }, (ApiResponseModel<bool> right) async {
      return Right<Failure, bool>(right.results!);
    });
  }

  Future<Either<Failure, bool>> signUp(
      {required String email,
      required String password,
      required String name}) async {
    final Either<Failure, ApiResponseModel<bool>> response =
        await authRepository
            .signUp(UserModel(email: email, password: password, name: name));

    return response.when((Failure left) async {
      return Left<Failure, bool>(left);
    }, (ApiResponseModel<bool> right) async {
      return Right<Failure, bool>(right.results!);
    });
  }
}
