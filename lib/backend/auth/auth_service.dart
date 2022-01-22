import 'package:chata/global/global_values.dart';
import 'package:chata/global/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase/supabase.dart';

class AuthService extends ChangeNotifier {
  //access registered supabase client
  SupabaseClient? client;
// AuthService._();
  final Ref? ref;
  final _auth = getIt.get<SupabaseClient>();
  //access registered get storage

  //get state and pass state to riverpod
  AuthService({this.ref});

  final _box = GetStorage();

  //get user
  User? _user;
  //initialise auth route

  // set user(User user) {
  //   _user = _auth.auth.user();
  //   notifyListeners();
  // }

  User? get user => _auth.auth.user();

  //login user

  Future<GotrueSessionResponse> signIn(
      {String? email, String? password}) async {
    return await _auth.auth.signIn(
      email: email,
      password: password,
    );
  }

  //register user

  Future<GotrueSessionResponse> signUp({
    String? email,
    String? password,
    String? name,
  }) async {
    return await _auth.auth.signUp(email!, password!);
  }

  Future<GotrueSessionResponse> recoverSession({String? session}) async {
    return await _auth.auth.recoverSession(session!);
  }
}
