import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soywarmi_app/data/model/user_model_auth.dart';

import 'http_headers_global.dart';

abstract class AuthenticationFirebaseRemoteDataSource {
  Stream<bool> get isAuthenticated;

  Future<UserModelAuth?> get user;

  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();
}

class AuthenticationFirebaseRemoteDataSourceImplementation
    extends AuthenticationFirebaseRemoteDataSource {
  AuthenticationFirebaseRemoteDataSourceImplementation()
      : _firebaseAuth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn();

  final FirebaseAuth _firebaseAuth;

  final GoogleSignIn _googleSignIn;

  final storage = const FlutterSecureStorage();
  final endPoint = dotenv.env['API_ENDPOINT'];

  @override
  Stream<bool> get isAuthenticated async* {
    yield _firebaseAuth.currentUser != null;
    await for (final _ in _firebaseAuth.authStateChanges()) {
      yield _firebaseAuth.currentUser != null;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Error: Failed to sign out');
    }
  }

  @override
  Future<UserModelAuth?> get user async {
    final user = _firebaseAuth.currentUser;
    print('User token ${await user?.getIdToken()}');
    if (user != null) {
      final token=await user.getIdToken();
      final uuid=user.uid;
      await storage.write(key: "UUID", value: uuid);
      await storage.write(key: 'USER_TOKEN', value: token);
      final req = await HttpHeadersGlobal.headerGetHttpWithToken(
          token, '$endPoint/api/v1/get_my_account');
      await storage.write(key: "my_account", value: jsonEncode(jsonDecode(req.body)["data"]));

      return UserModelAuth(
        id: user.uid,
        email: user.email!,
        password: '',
        rol: '',
      );
    }

    return null;
  }
}
