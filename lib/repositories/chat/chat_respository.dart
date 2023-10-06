import 'package:chat_app_with_laravel/models/chat_model.dart';
import 'package:chat_app_with_laravel/repositories/chat/base_chat_repository.dart';
import 'package:chat_app_with_laravel/repositories/core/endpoints.dart';
import 'package:chat_app_with_laravel/utils/dio_client/dio_client.dart';
import 'package:dio/dio.dart';

import '../../models/app_response.dart';
import '../../models/requests/create_chat_request.dart';

class ChatRepository extends BaseChatRepository {
  final Dio _dioClient;

  ChatRepository({
    Dio? dioClient,
  }) : _dioClient = dioClient ?? DioClient().instance;

  @override
  Future<AppResponse<ChatEntity?>> createChat(CreateChatRequest request) async {
    final response =
        await _dioClient.post(Endpoints.createChat, data: request.toJson());

    return AppResponse<ChatEntity?>.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? ChatEntity.fromJson(json)
          : null,
    );
  }

  @override
  Future<AppResponse<List<ChatEntity>>> getChats() async {
    final response = await _dioClient.get(Endpoints.getChats);

    return AppResponse<List<ChatEntity>>.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? (json as List<dynamic>).map((e) => ChatEntity.fromJson(e)).toList()
          : [],
    );
  }

  @override
  Future<AppResponse<ChatEntity?>> getSingleChat(int chatId) async {
    final response = await _dioClient.get("${Endpoints.getSingleChat}$chatId");

    return AppResponse<ChatEntity?>.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? ChatEntity.fromJson(json)
          : null,
    );
  }
}
