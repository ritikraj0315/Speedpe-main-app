import 'package:get/get_connect/http/src/response/response.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/util/app_constants.dart';

class GroupRepo {
  final ApiClient apiClient;

  GroupRepo({required this.apiClient});

  Future<Response> getFollowingApi() async {
    return apiClient.getData(AppConstants.customerGetFollowing);
  }

  Future<Response> getInviteMemberApi({required String grpId}) async {
    return apiClient.postData(AppConstants.customerGetInviteMember, {"group_id": grpId});
  }

  Future<Response> getJoinedGroupApi() async {
    return apiClient.getData(AppConstants.customerGetJoinedGroup);
  }

  Future<Response> createGroupApi(
      {required Map<String, dynamic> data}) async {
    return apiClient.postData(AppConstants.customerCreateGroupUri,
        {"data": data});
  }

  Future<Response> addMemberToGroupApi(
      {required Map<String, dynamic> data}) async {
    return apiClient.postData(AppConstants.customerAddMemberToGroupUri,
        {"data": data});
  }

  Future<Response> sendGroupMessageApi({String? chatId, String? message, required String type, String? question}) async {
    return await apiClient.postData(AppConstants.customerSendGroupMessage,
        {"chat_id": chatId, "message_content": message, "type": type, "question_content": question,});
  }

  Future<Response> getGroupMessagesApi({String? chatId}) async {
    return apiClient.postData(AppConstants.customerGetGroupMessages, {"chat_id": chatId});
  }

  Future<Response> getGroupMembersApi({String? groupId}) async {
    return apiClient.postData(AppConstants.customerGetGroupMembers, {"group_id": groupId.toString()});
  }

  Future<Response> removeMembersApi({String? memberId, String? groupId}) async {
    return apiClient.postData(AppConstants.customerRemoveMember, {"member_id": memberId.toString(), "group_id": groupId.toString()});
  }

  Future<Response> deleteGroupApi({String? groupId}) async {
    return apiClient.postData(AppConstants.customerDeleteGroup, {"group_id": groupId.toString()});
  }

  Future<Response> exitGroupApi({String? groupId}) async {
    return apiClient.postData(AppConstants.customerExitGroup, {"group_id": groupId.toString()});
  }

  Future<Response> promoteAdminApi({String? memberId, String? groupId}) async {
    return apiClient.postData(AppConstants.customerPromoteAdmin, {"member_id": memberId.toString(), "group_id": groupId.toString()});
  }

  Future<Response> getMemberDetailApi({String? groupId}) async {
    return apiClient.postData(AppConstants.customerGetMemberDetail, {"group_id": groupId.toString()});
  }

  Future<Response> getGroupDetailApi({String? groupId}) async {
    return apiClient.postData(AppConstants.customerGetGroupDetail, {"group_id": groupId.toString()});
  }

  Future<Response> changeGroupOpenStatusApi({String? groupId}) async {
    return apiClient.postData(AppConstants.customerChangeGroupOpenStatus, {"group_id": groupId.toString()});
  }

  Future<Response> unsentMessageApi({String? messageId}) async {
    return apiClient.postData(AppConstants.customerUnsentMessage, {"message_id": messageId.toString()});
  }

}
