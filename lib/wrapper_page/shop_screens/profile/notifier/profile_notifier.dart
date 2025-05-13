import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/http_service.dart';
import '../model/profile_response.dart';

class ProfileNotifier extends Notifier<ProfileResponse>{

  final HttpService<ProfileResponse> _httpService = HttpService(baseUrl: "https://www.google.es", info: "LOAD_PROFILE");
  @override
  ProfileResponse build() {
    return ProfileResponse(user: "", password: "", email: "");
  }

  Future<void> fetchUserData() async {
      ProfileResponse response = await _httpService.fetchData(ProfileResponse.fromJson);
      state = response;
  }

}