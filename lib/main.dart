import 'package:chata/app/auth/sign_in.dart';
import 'package:chata/app/chat/chat_page.dart';
import 'package:chata/app/home/home.dart';
import 'package:chata/backend/auth/auth_service.dart';
import 'package:chata/global/global_values.dart';
import 'package:chata/global/providers.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase/supabase.dart';
import 'config_nonweb.dart' if (dart.library.html) 'config_web.dart';
import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureApp();
  getIt.registerSingleton<SupabaseClient>(
      SupabaseClient(supabaseUrl, supabaseKey));

  // var jip = xmpp.Jid.fromFullJid(jixUser);
  // var connect = xmpp.Connection(jip.,);

  await GetStorage.init();
  //await setupLocator();

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthRouteManagement(),
      );
    });
  }
}

class AuthRouteManagement extends StatefulWidget {
  const AuthRouteManagement({Key? key}) : super(key: key);

  @override
  _AuthRouteManagementState createState() => _AuthRouteManagementState();
}

class _AuthRouteManagementState extends State<AuthRouteManagement> {
  final AuthService _auth = AuthService();
  @override
  void initState() {
    checkSession();
    super.initState();
  }

  checkSession() async {
    Future.delayed(const Duration(seconds: 5), () async {
      var _box = GetStorage();
      var _session = _box.read('user');
      if (_session == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const SignIn(),
          ),
        );
      } else {
        final _response = await _auth.recoverSession(session: _session);
        await _box.write('user', _response.data?.persistSessionString);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const Home(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
