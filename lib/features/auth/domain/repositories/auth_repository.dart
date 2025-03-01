import 'package:clean_architecture_app/core/entities/entity_either.dart';

import '../../../../core/network/error/failures.dart';
import '../../../../shared/domain/models/api_response_model.dart';
import '../models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, ApiResponseModel<UserModel>>> logIn(UserModel params);

  Future<Either<Failure, ApiResponseModel<bool>>> signUp(UserModel params);

  Future<Either<Failure, ApiResponseModel<bool>>> resetPassword(
      UserModel params);
}
