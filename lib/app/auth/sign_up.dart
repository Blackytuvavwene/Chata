import 'package:chata/app/auth/sign_in.dart';
import 'package:chata/app/custom/arimo_text.dart';
import 'package:chata/app/custom/custom_elevated_button.dart';
import 'package:chata/backend/auth/auth_service.dart';
import 'package:chata/global/global_values.dart';
import 'package:chata/global/providers.dart';
import 'package:chata/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase/supabase.dart';

class SignUp extends HookConsumerWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _auth = ref.watch(authProvider);
    final _email = useTextEditingController();
    final _password = useTextEditingController();
    final _name = useTextEditingController();
    final _box = GetStorage();
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 100.h,
        maxWidth: 100.w,
      ),
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(
                  5.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Image.asset('images/chat2.png'),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      controller: _name,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      controller: _email,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      controller: _password,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomElevatedButton(
                        text: 'Create an account',
                        onPressed: () async {
                          final _response = await _auth.signUp(
                            email: _email.text,
                            password: _password.text,
                          );
                          if (_response.error == null) {
                            SnackBar _snackBar = SnackBar(
                              padding: const EdgeInsets.all(20),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              content: AText(
                                text: 'Success ${_response.toString()}',
                              ),
                            );
                            await getIt
                                .get<SupabaseClient>()
                                .from('Users')
                                .insert(
                              [
                                {
                                  'name': _name.text,
                                  'uid': _response.user?.id,
                                  'email': _email.text,
                                },
                              ],
                            ).execute();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_snackBar);
                            await _box.write(
                                'user', _response.data?.persistSessionString);
                            //navigate to auth route handler
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AuthRouteManagement(),
                              ),
                            );
                          } else {
                            SnackBar _snackBar = SnackBar(
                                padding: const EdgeInsets.all(20),
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                content: AText(
                                  textColor: Colors.white,
                                  text: 'Error ${_response.error?.message}',
                                ));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_snackBar);
                          }
                        }),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AText(
                          text: 'Already have an account?',
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignIn(),
                              ),
                            );
                          },
                          child: const AText(
                            text: 'Sign in',
                            textColor: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
