import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecentChats extends HookConsumerWidget {
  const RecentChats({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      child: Center(child: Text('RecentChats')),
    );
  }
}
