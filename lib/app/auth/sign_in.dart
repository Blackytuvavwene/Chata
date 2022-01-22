import 'package:chata/app/auth/sign_up.dart';
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

class SignIn extends HookConsumerWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _auth = ref.watch(authProvider);
    final _email = useTextEditingController();
    final _password = useTextEditingController();
    final _box = GetStorage();
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 100.w,
        maxHeight: 100.h,
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
                      height: 6.h,
                    ),
                    Image.asset('images/chat1.png'),
                    SizedBox(
                      height: 7.h,
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
                      onPressed: () async {
                        final _response = await _auth.signIn(
                          email: _email.text,
                          password: _password.text,
                        );
                        if (_response.error != null) {
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
                          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                        } else {
                          SnackBar _snackBar = SnackBar(
                            padding: const EdgeInsets.all(20),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            content: const AText(
                              text: 'Successfully logged in ',
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                          await _box.write(
                              'user', _response.data?.persistSessionString);
                          //navigate to auth route handler
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AuthRouteManagement(),
                            ),
                          );
                        }
                      },
                      text: 'Sign in',
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AText(
                          text: 'Don\'t have an account?',
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignUp(),
                              ),
                            );
                          },
                          child: const AText(
                            text: 'Create one',
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
