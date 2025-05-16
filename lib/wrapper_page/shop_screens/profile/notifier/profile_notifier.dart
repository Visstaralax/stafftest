import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../commons/constants.dart';
import '../../../../services/http_service.dart';
import '../model/profile_response.dart';

class ProfileNotifier extends StateNotifier<ProfileResponse>{

  final HttpService<ProfileResponse> _httpService = HttpService(baseUrl: Constants.baseUrl, info: "PROFILE");

  ProfileNotifier() : super(ProfileResponse.init());

  Future<void> fetchUserData() async {
    try {
      ProfileResponse response = await _httpService.fetchData(ProfileResponse.fromJson);
      state = response;
    } catch (e) {
      state = ProfileResponse.error();
      print ("profiel res ERROR!!! ${state.error}");
    }
  }

}