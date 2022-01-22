import 'package:chata/backend/auth/auth_service.dart';
import 'package:chata/backend/data/sockect.dart';
import 'package:chata/backend/data/users.dart';
import 'package:chata/models/users_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//declare provider for auth service
final authProvider = ChangeNotifierProvider<AuthService>((ref) {
  return AuthService(ref: ref);
});

//declare provider for users
final usersProvider = ChangeNotifierProvider<Users>((ref) {
  return Users(ref: ref);
});

//declare provider for users to fecth data for logged in user
final userData = FutureProvider<UserModel>((ref) {
//fetch user data
  final _data = ref.watch(usersProvider);
  final _userdata = _data.getUserById();
  return _userdata;
});

//declare provider to connect to socket
final socketProvider = ChangeNotifierProvider<SocketIOService>((ref) {
  return SocketIOService(ref: ref);
});
