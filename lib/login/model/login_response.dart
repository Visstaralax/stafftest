class LoginResponse{
  bool success = false;
  bool error = false;
  String message = "";

  LoginResponse(this.success, this.message, this.error);

  LoginResponse copyWith({
    bool? success,
    String? message,
    bool? error,
  }){
    return LoginResponse(
        success ?? this.success,
        message ?? this.message,
        error ?? this.error
    );
  }

  LoginResponse.empty(){
    LoginResponse(false, "", false);
  }

  factory LoginResponse.decodeJson(Map<String, dynamic> json){
    dynamic loginJson = json['login'];
    return LoginResponse(bool.parse(loginJson['success']), loginJson['message'], false);
  }

  static LoginResponse fromJson(dynamic json){
    return LoginResponse.decodeJson(json);
  }
}