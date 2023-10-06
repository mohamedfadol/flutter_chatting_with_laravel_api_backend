import 'package:chat_app_with_laravel/models/app_response.dart';

import '../../models/user_model.dart';

abstract class BaseUserRepository {
  Future<AppResponse<List<UserEntity>>> getUsers();
}
