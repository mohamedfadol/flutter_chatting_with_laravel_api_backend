import 'package:chat_app_with_laravel/models/app_response.dart';
import 'package:chat_app_with_laravel/models/chat_model.dart';
import 'package:chat_app_with_laravel/models/requests/create_chat_request.dart';

abstract class BaseChatRepository {
  Future<AppResponse<List<ChatEntity>>> getChats();

  Future<AppResponse<ChatEntity?>> createChat(CreateChatRequest request);

  Future<AppResponse<ChatEntity?>> getSingleChat(int chatId);
}
