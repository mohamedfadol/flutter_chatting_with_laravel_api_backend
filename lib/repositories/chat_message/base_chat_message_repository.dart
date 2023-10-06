import 'package:chat_app_with_laravel/models/chat_message_model.dart';
import 'package:chat_app_with_laravel/models/requests/create_chat_message_request.dart';

import '../../models/app_response.dart';

abstract class BaseChatMessageRepository {
  Future<AppResponse<List<ChatMessageEntity>>> getChatMessages({
    required int chatId,
    required int page,
  });

  Future<AppResponse<ChatMessageEntity?>> createChatMessage(
    CreateChatMessageRequest request,
    String socketId,
  );
}
