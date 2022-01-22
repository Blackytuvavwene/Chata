import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class UsersList extends HookConsumerWidget {
  const UsersList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 100.h,
        maxWidth: 100.w,
      ),
      child: Container(
        color: Colors.white,
        child: Center(
          child: Text('Users List'),
        ),
      ),
    );
  }
}
