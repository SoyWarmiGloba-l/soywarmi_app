import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticatorFirebaseRemoteDataSource {
  AuthenticatorFirebaseRemoteDataSource()
      : _firebaseAuth = FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Future<void> signUp();

  Future<void> signIn({String? email, String? password});
}

class EmailAuthenticatorFirebaseRemoteDataSourceImplementation
    extends AuthenticatorFirebaseRemoteDataSource {
  final storage = const FlutterSecureStorage();
  @override
  Future<void> signIn({String? email, String? password}) async {
    if (email == null || password == null) {
      throw Exception('Error: User and password not provided');
    }

    final result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final userToken = await result.user!.getIdToken();
    final uuid = result.user!.uid;

    await storage.write(key: 'USER_TOKEN', value: userToken);
    await storage.write(key: "UUID", value: uuid);

    if (result.user == null) {
      throw Exception('Error: User not found');
    }
  }

  @override
  Future<void> signUp() {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}

class GoogleAuthenticatorFirebaseRemoteDataSourceImplementation
    extends AuthenticatorFirebaseRemoteDataSource {
  final storage = const FlutterSecureStorage();
  @override
  Future<void> signIn({String? email, String? password}) async {
    try {
      final googleSingIn = GoogleSignIn();
      final googleAccount = await googleSingIn.signIn();

      if (googleAccount == null) {
        throw Exception('Error: Google sign-in was cancelled by the user');
      }

      final googleAuth = await googleAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await _firebaseAuth.signInWithCredential(credential);

      final userToken = await result.user!.getIdToken();
      final uuid = result.user!.uid;

      await storage.write(key: "USER_TOKEN", value: userToken);
      await storage.write(key: "UUID", value: uuid);

    } catch (e) {
      if (e is PlatformException && e.code == 'sign_in_canceled') {
        throw Exception('Error: Google sign-in was cancelled by the user');
      }

      if (e is PlatformException) {
        throw Exception('Platform exception code ${e.code} $e');
      }

      throw Exception('Error: Failed to sign in with Google $e');
    }
  }

  @override
  Future<void> signUp() {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}

