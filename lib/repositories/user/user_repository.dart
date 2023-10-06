import 'package:chat_app_with_laravel/models/app_response.dart';
import 'package:chat_app_with_laravel/models/user_model.dart';
import 'package:chat_app_with_laravel/repositories/core/endpoints.dart';
import 'package:chat_app_with_laravel/repositories/user/base_user_repository.dart';
import 'package:chat_app_with_laravel/utils/dio_client/dio_client.dart';
import 'package:dio/dio.dart';

class UserRepository extends BaseUserRepository {
  final Dio _dioClient;

  UserRepository({
    Dio? dioClient,
  }) : _dioClient = dioClient ?? DioClient().instance;

  @override
  Future<AppResponse<List<UserEntity>>> getUsers() async {
    final response = await _dioClient.get(Endpoints.getUsers);

    return AppResponse<List<UserEntity>>.fromJson(
      response.data,
      (dynamic json) {
        if (response.data['success'] && json != null) {
          return (json as List<dynamic>)
              .map((e) => UserEntity.fromJson(e))
              .toList();
        }
        return [];
      },
    );
  }
}
