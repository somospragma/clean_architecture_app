import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/entities/entity_either.dart';
import '../../../../core/network/dio_network.dart';
import '../../../../core/network/error/exceptions.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/utils/constants/network_paths.dart';
import '../../../../shared/domain/models/api_response_model.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';

final Provider<AuthRepositoryImpl> authRepositoryProvider =
    Provider<AuthRepositoryImpl>((Ref<AuthRepositoryImpl> ref) {
  return AuthRepositoryImpl();
});

class AuthRepositoryImpl implements AuthRepository{
  Dio dio = DioNetwork.appAPI;

  @override
  Future<Either<Failure, ApiResponseModel<UserModel>>> logIn(
      UserModel params) async {
    try {
      final Response<Map<String, dynamic>> result =
          await dio.post(getLogInPath(), data: params.toJson());

      return Right<Failure, ApiResponseModel<UserModel>>(
          ApiResponseModel<UserModel>(
              status: result.statusCode.toString(),
              results: UserModel.fromJson(result.data!)));
    } on ServerException catch (e) {
      return Left<Failure, ApiResponseModel<UserModel>>(
          ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left<Failure, ApiResponseModel<UserModel>>(
        const ServerFailure('error', -1),
      );
    }
  }

  @override
  Future<Either<Failure, ApiResponseModel<bool>>> signUp(
      UserModel params) async {
    try {
      final Response<Map<String, dynamic>> result =
          await dio.post(getSignUpPath(), data: params.toJson());
      return Right<Failure, ApiResponseModel<bool>>(
          ApiResponseModel<bool>(
              status: result.statusCode.toString(),
              results: result.data?['success'] as bool));
    } on ServerException catch (e) {
      return Left<Failure, ApiResponseModel<bool>>(
          ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left<Failure, ApiResponseModel<bool>>(
        const ServerFailure('error', -1),
      );
    }
  }

  @override
  Future<Either<Failure, ApiResponseModel<bool>>> resetPassword(
      UserModel params) async {
    try {
      final Response<Map<String, dynamic>> result =
          await dio.post(getResetPasswordPath(), data: params.toJson());

      return Right<Failure, ApiResponseModel<bool>>(ApiResponseModel<bool>(
          status: result.statusCode.toString(),
          results: result.data?['success'] as bool));
    } on ServerException catch (e) {
      return Left<Failure, ApiResponseModel<bool>>(
          ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left<Failure, ApiResponseModel<bool>>(
        const ServerFailure('error', -1),
      );
    }
  }
}
