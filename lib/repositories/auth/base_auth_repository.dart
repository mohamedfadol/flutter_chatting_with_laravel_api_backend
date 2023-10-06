import 'package:chat_app_with_laravel/models/requests/login_request.dart';
import 'package:chat_app_with_laravel/models/user_model.dart';

import '../../models/app_response.dart';
import '../../models/requests/register_request.dart';

abstract class BaseAuthRepository {
  Future<AppResponse<AuthUser?>> register(RegisterRequest request);

  Future<AppResponse<AuthUser?>> login(LoginRequest request);

  Future<AppResponse<UserEntity?>> loginWithToken();

  Future<AppResponse> logout();
}
