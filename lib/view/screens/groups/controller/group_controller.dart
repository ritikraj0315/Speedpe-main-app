import 'package:get/get.dart';

import '../../../../data/api/api_checker.dart';
import '../../../base/custom_snackbar.dart';
import '../../social_media/search_buddy/model/search_buddy_model.dart';
import '../group_details/model/group_member_model.dart';
import '../group_details/model/invite_member_model.dart';
import '../joined_group/model/joined_group_model.dart';
import '../repository/group_repo.dart';
import '../select_members/model/select_member_model.dart';

class GroupController extends GetxController implements GetxService {
  final GroupRepo groupRepo;

  GroupController({required this.groupRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<SearchBuddyModel>? _buddyList;

  List<SearchBuddyModel>? get buddyList => _buddyList;

  List<JoinedGroupModel>? _groupChatList;

  List<JoinedGroupModel>? get groupChatList => _groupChatList;

  List<SelectMemberModel>? _selectMemberList;

  List<SelectMemberModel>? get selectMemberList => _selectMemberList;

  List<InviteMemberModel>? _inviteMemberList;

  List<InviteMemberModel>? get inviteMemberList => _inviteMemberList;

  List<GroupMemberModel>? _groupMemberModel;

  List<GroupMemberModel>? get groupMemberModel => _groupMemberModel;

  Future getFollowingList(bool reload, {bool isUpdate = true}) async {
    if (_selectMemberList == null || reload) {
      _isLoading = true;
      _selectMemberList = null;
      if (isUpdate) {
        update();
      }
    }
    if (_selectMemberList == null) {
      Response response = await groupRepo.getFollowingApi();
      if (response.statusCode == 200) {
        _selectMemberList = [];
        response.body.forEach((members) {
          _selectMemberList!.add(SelectMemberModel.fromJson(members));
        });
      } else {
        _selectMemberList = [];
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
    }
  }

  Future getInviteMemberList(bool reload, String grpId, {bool isUpdate = true}) async {
    if (_inviteMemberList == null || reload) {
      _isLoading = true;
      _inviteMemberList = null;
      if (isUpdate) {
        update();
      }
    }
    if (_inviteMemberList == null) {
      Response response = await groupRepo.getInviteMemberApi(grpId: grpId);
      if (response.statusCode == 200) {
        _inviteMemberList = [];
        response.body.forEach((members) {
          _inviteMemberList!.add(InviteMemberModel.fromJson(members));
        });
      } else {
        _inviteMemberList = [];
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
    }
  }

  Future getJoinedGroupList(bool reload, {bool isUpdate = true}) async {
    if (_groupChatList == null || reload) {
      _isLoading = true;
      _groupChatList = null;
      if (isUpdate) {
        update();
      }
    }
    if (_groupChatList == null) {
      Response response = await groupRepo.getJoinedGroupApi();
      if (response.statusCode == 200) {
        _groupChatList = [];
        response.body.forEach((chats) {
          _groupChatList!.add(JoinedGroupModel.fromJson(chats));
        });
      } else {
        _groupChatList = [];
        showCustomSnackBar(response.body['error']);
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
    }
  }

  List<JoinedGroupModel> getFilteredGroupsList(String type) {
    return groupChatList
        ?.where((groups) =>
    groups.type?.toString().contains(type) ?? false)
        .toList() ??
        [];
  }

  List<JoinedGroupModel> getPaymentsGroupsList(String type) {
    List<JoinedGroupModel> filteredList = getFilteredGroupsList(type);
    return filteredList.reversed.toList();
  }

  List<JoinedGroupModel> getGroupsList(String type) {
    List<JoinedGroupModel> filteredList = getFilteredGroupsList(type);
    return filteredList.reversed.toList();
  }

  Future<Response> createAGroup(List<int> selectedUserIds, String groupName,
      String groupTag, String groupType, String eachAmount) async {
    _isLoading = true;
    //update();

    Map<String, dynamic> requestData = {
      'members_id': selectedUserIds,
      'group_name': groupName,
      'group_tag': groupTag,
      'group_type': groupType,
      'each_amount': eachAmount,
    };

    Response response = await groupRepo.createGroupApi(data: requestData);

    if (response.statusCode == 200) {
      showCustomSnackBar(response.body['message'], isError: false);
    } else if (response.statusCode == 403 &&
        response.body['user_type'] == 'customer') {
      showCustomSnackBar(response.body['message']);
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
    update();
    return response;
  }

  Future<Response> addMemberToGroup(List<int> selectedUserIds, String groupId) async {
    _isLoading = true;
    //update();

    Map<String, dynamic> requestData = {
      'members_id': selectedUserIds,
      'group_id': groupId,
    };

    Response response = await groupRepo.addMemberToGroupApi(data: requestData);

    if (response.statusCode == 200) {
      showCustomSnackBar(response.body['message'], isError: false);
    } else if (response.statusCode == 403 &&
        response.body['user_type'] == 'customer') {
      showCustomSnackBar(response.body['message']);
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
    update();
    return response;
  }

  Future<Response> sendGroupMessage(
      String chatId, String message, String type, String question) async {
    _isLoading = true;
    //update();
    Response response = await groupRepo.sendGroupMessageApi(
        chatId: chatId, message: message, type: type, question: question);

    if (response.statusCode == 200) {
    } else if (response.statusCode == 403) {
      showCustomSnackBar(response.body['message']);
    } else {
      showCustomSnackBar(response.body['message'].toString());
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<Response> getGroupMessagesList(String chatId) async {
    _isLoading = true;
    //update();
    Response response = await groupRepo.getGroupMessagesApi(chatId: chatId);

    if (response.statusCode == 200) {
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<Response> getGroupMembers(String? grpId) async {
    _isLoading = true;
    Response response = await groupRepo.getGroupMembersApi(groupId: grpId);

    if (response.statusCode == 200) {
      _groupMemberModel = [];
      response.body.forEach((members) {
        _groupMemberModel!.add(GroupMemberModel.fromJson(members));
      });
    } else {
      _groupMemberModel = [];
      showCustomSnackBar(response.body['message']);
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<Response> removeMember(String? memberId, String? groupId) async {
    _isLoading = true;
    Response response = await groupRepo.removeMembersApi(memberId: memberId, groupId: groupId);

    if (response.statusCode == 200) {
      showCustomSnackBar(response.body['message'], isError: false);
    } else {
      showCustomSnackBar(response.body['message']);
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<Response> deleteGroup(String? groupId) async {
    _isLoading = true;
    Response response = await groupRepo.deleteGroupApi(groupId: groupId);

    if (response.statusCode == 200) {
      showCustomSnackBar(response.body['message'], isError: false);
      getJoinedGroupList(true);
    } else {
      showCustomSnackBar(response.body['message']);
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<Response> exitGroup(String? groupId) async {
    _isLoading = true;
    Response response = await groupRepo.exitGroupApi(groupId: groupId);

    if (response.statusCode == 200) {
      showCustomSnackBar(response.body['message'], isError: false);
      getJoinedGroupList(true);
    } else {
      showCustomSnackBar(response.body['message']);
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<Response> promoteGroupAdmin(String? memberId, String? groupId) async {
    _isLoading = true;
    Response response = await groupRepo.promoteAdminApi(memberId: memberId, groupId: groupId);

    if (response.statusCode == 200) {
      showCustomSnackBar(response.body['message'], isError: false);
    } else {
      showCustomSnackBar(response.body['message']);
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<Response> getMemberDetails(String? groupId) async {
    _isLoading = true;
    Response response = await groupRepo.getMemberDetailApi(groupId: groupId);

    if (response.statusCode == 200) {
      showCustomSnackBar(response.body['message'], isError: false);
    } else {
      showCustomSnackBar(response.body['message']);
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<Response> getGroupDetails(String? groupId) async {
    _isLoading = true;
    Response response = await groupRepo.getGroupDetailApi(groupId: groupId);

    if (response.statusCode == 200) {
      showCustomSnackBar(response.body['message'], isError: false);
    } else {
      showCustomSnackBar(response.body['message']);
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<Response> changeGroupOpenStatus(String? groupId) async {
    _isLoading = true;
    Response response = await groupRepo.changeGroupOpenStatusApi(groupId: groupId);

    if (response.statusCode == 200) {
      showCustomSnackBar(response.body['message'], isError: false);
    } else {
      showCustomSnackBar(response.body['message']);
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<Response> unsentMessage(String? messageId) async {
    _isLoading = true;
    Response response = await groupRepo.unsentMessageApi(messageId: messageId);

    if (response.statusCode == 200) {
      showCustomSnackBar(response.body['message'], isError: false);
    } else {
      showCustomSnackBar(response.body['message']);
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return response;
  }

}
