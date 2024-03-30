import 'package:get/get_connect/http/src/response/response.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/util/app_constants.dart';

class SocialMediaRepo {
  final ApiClient apiClient;

  SocialMediaRepo({required this.apiClient});

  Future<Response> getSearchBuddyListApi({String? userName}) async {
    return apiClient
        .postData(AppConstants.customerSearchBuddy, {"username": userName});
  }

  Future<Response> getBuddyProfileApi({String? uniqueId}) async {
    return apiClient
        .postData(AppConstants.customerBuddyProfile, {"unique_id": uniqueId});
  }

  Future<Response> followUserApi({String? followingId}) async {
    return apiClient.postData(
        AppConstants.customerFollowUser, {"following_id": followingId});
  }

  Future<Response> unfollowUserApi({String? followingId}) async {
    return apiClient.postData(
        AppConstants.customerUnfollowUser, {"following_id": followingId});
  }

  Future<Response> sendMessageApi({String? receiverId, String? message, required String type, String? question}) async {
    return await apiClient.postData(AppConstants.customerSendMessage,
        {"receiver_id": receiverId, "message_content": message, "type": type, "question_content": question,});
  }

  Future<Response> getChatsApi() async {
    return apiClient.getData(AppConstants.customerGetChats);
  }

  Future<Response> getMessagesApi({String? chatId}) async {
    return apiClient.postData(AppConstants.customerGetMessages, {"chat_id": chatId});
  }
}
