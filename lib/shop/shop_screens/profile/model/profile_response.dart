class ProfileResponse{
  final String user;
  final String password;
  final String email;

  ProfileResponse({required this.user, required this.password, required this.email});

  factory ProfileResponse.decodeJson(Map<String, dynamic> json){
    dynamic response = json['userData'];
    return ProfileResponse(user: response['user'], password: response['password'], email: response['email']);
  }

  static ProfileResponse fromJson(dynamic json){
    return ProfileResponse.decodeJson(json);
  }
}