import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staffseidorapptest/login/model/login_response.dart';
import 'package:staffseidorapptest/services/http_service.dart';

import '../../commons/constants.dart';

class LoginNotifier extends StateNotifier<LoginResponse>{

  final HttpService<LoginResponse> _httpService = HttpService(baseUrl: Constants.baseUrl, info: "LOGIN");
  LoginNotifier() : super(LoginResponse.empty());

  Future<void> makeLogin(String user, String password) async {
      if (user.isEmpty || password.isEmpty){
          final result = LoginResponse.empty();
          result.error = true;
          final errorText = "Rellena los datos";
          state = state.copyWith(success: false, message: errorText, error: true);
      } else {
          _httpService.params = {
            'user': user,
            'password': password
          };
          LoginResponse result = await _httpService.fetchData(LoginResponse.fromJson);
          if (result.success){
            state = result.copyWith(message: "");
          } else {
            state = result.copyWith(message: "Datos no correctos");
          }

      }
  }
}