import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final User? user;
  final bool isAdmin;
  final String? profileImage;

  AuthUser({this.user, this.isAdmin = false, this.profileImage});

  AuthUser update({
    User? newUser,
    bool? newIsAdmin,
    String? newProfileImage,
  }) =>
      AuthUser(
        user: newUser ?? user,
        isAdmin: newIsAdmin ?? isAdmin,
        profileImage: newProfileImage ?? profileImage,
      );
}
