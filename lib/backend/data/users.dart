import 'dart:convert';

import 'package:chata/global/global_values.dart';
import 'package:chata/models/users_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase/supabase.dart';

class Users extends ChangeNotifier {
  final _db = getIt.get<SupabaseClient>();

  final Ref? ref;
  Users({this.ref});

  Future getUsers() async {
    return _db.from('Users').stream().execute();
  }

  //get user by id
  Future<UserModel> getUserById() async {
    final _data = await _db
        .from('Users')
        .select()
        .eq('uid', _db.auth.currentUser?.id)
        .single()
        .execute();

    Map<String, dynamic> _user = _data.data;

    return UserModel.fromJson(_user);
  }
}
