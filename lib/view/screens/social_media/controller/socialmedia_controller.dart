import 'package:get/get.dart';

import '../../../../data/api/api_checker.dart';
import '../../../base/custom_snackbar.dart';
import '../model/chat_model.dart';
import '../repository/socialmedia_repo.dart';
import '../search_buddy/model/search_buddy_model.dart';

class SocialMediaController extends GetxController implements GetxService {
  final SocialMediaRepo socialMediaRepo;

  SocialMediaController({required this.socialMediaRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<SearchBuddyModel>? _buddyList;

  List<SearchBuddyModel>? get buddyList => _buddyList;

  List<ChatModel>? _chatList;

  List<ChatModel>? get chatList => _chatList;

  Future<Response> getSearchBuddyList(String userName) async {
    _isLoading = true;
    update();
    Response response =
        await socialMediaRepo.getSearchBuddyListApi(userName: userName);

    if (response.statusCode == 200) {
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<Response> getBuddyProfile(String? uniqueId) async {
    _isLoading = true;
    //update();
    Response response =
        await socialMediaRepo.getBuddyProfileApi(uniqueId: uniqueId);

    if (response.statusCode == 200) {
      // showCustomSnackBar(response.body['f_name']);
    } else {
      //showCustomSnackBar(response.body);
      ApiChecker.checkApi(response);
    }
    //showCustomSnackBar(response.body['f_name']);
    _isLoading = false;
    update();
    return response;
  }

  Future<Response> followUser(String followingId) async {
    _isLoading = true;
    //update();
    Response response =
        await socialMediaRepo.followUserApi(followingId: followingId);

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

  Future<Response> unfollowUser(String followingId) async {
    _isLoading = true;
    //update();
    Response response =
        await socialMediaRepo.unfollowUserApi(followingId: followingId);

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

  Future<Response> sendMessage(String receiverId, String message, String type, String question) async {
    _isLoading = true;
    //update();
    Response response = await socialMediaRepo.sendMessageApi(
        receiverId: receiverId, message: message, type: type, question: question);

    if (response.statusCode == 200) {
      getChatList(true);
    } else if (response.statusCode == 403) {
      showCustomSnackBar(response.body['message']);
    } else {
      //showCustomSnackBar(response.body['message'].toString());
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return response;
  }

  Future getChatList(bool reload, {bool isUpdate = true}) async {
    if (_chatList == null || reload) {
      _isLoading = true;
      _chatList = null;
      if (isUpdate) {
        update();
      }
    }
    if (_chatList == null) {
      Response response = await socialMediaRepo.getChatsApi();
      if (response.statusCode == 200) {
        _chatList = [];
        response.body.forEach((banner) {
          _chatList!.add(ChatModel.fromJson(banner));
        });
      } else {
        _chatList = [];
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
    }
  }

  Future<Response> getMessagesList(String chatId) async {
    _isLoading = true;
    //update();
    Response response = await socialMediaRepo.getMessagesApi(chatId: chatId);

    if (response.statusCode == 200) {
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return response;
  }
}
