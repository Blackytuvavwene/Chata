import 'package:chata/app/calls/recent_calls.dart';
import 'package:chata/app/chat/chat_page.dart';
import 'package:chata/app/chat/recent_chats.dart';
import 'package:chata/app/custom/arimo_text.dart';
import 'package:chata/backend/data/users.dart';
import 'package:chata/global/providers.dart';
import 'package:chata/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

class Home extends HookConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _tabController = useTabController(initialLength: 2);
    final _user = ref.watch(userData);
    final _socket = ref.watch(socketProvider);
    return _user.when(data: (user) {
      return Scaffold(
        appBar: AppBar(
          title: AText(
            text: user.name,
            textColor: Colors.white,
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                icon: Icon(LineIcons.comments),
                child: AText(
                  text: 'Chats',
                  textColor: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(LineIcons.phone),
                child: AText(
                  text: 'Calls',
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            RecentChats(),
            RecentCalls(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _socket.connect();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatPage(),
              ),
            );
          },
          child: const Icon(LineIcons.plus),
        ),
      );
    }, error: (error, stack) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Text('No data loaded'),
        ),
      );
    }, loading: () {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
