class ProfileResponse{
  final String user;
  final String password;
  final String email;
  final bool error;

  ProfileResponse({required this.user, required this.password, required this.email, required this.error});

  factory ProfileResponse.decodeJson(Map<String, dynamic> json){
    dynamic response = json['userData'];
    return ProfileResponse(user: response['user'], password: response['password'], email: response['email'], error: false);
  }

  factory ProfileResponse.init(){
    return ProfileResponse(user: "", password: "", email: "", error: false);
  }

  factory ProfileResponse.error() => ProfileResponse(
    user: '',
    password: '',
    email: '',
    error: true
  );

  static ProfileResponse fromJson(dynamic json){
    return ProfileResponse.decodeJson(json);
  }
}