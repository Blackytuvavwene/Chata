import 'package:chata/global/global_values.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:supabase/supabase.dart';

class SocketIOService extends ChangeNotifier {
//declare socket
  IO.Socket? _socket;
  Ref? ref;
  SocketIOService({
    this.ref,
  });

  //connect to socket
  void connect() {
    //create socket
    _socket = IO.io(
      'http://0.0.0.0:3000',
      IO.OptionBuilder()
          .setTransports(
            ['websocket'],
          )
          .disableAutoConnect()
          .build(),
    );
    _socket?.connect();
    _socket?.onConnect((data) => print('connected'));
    print(_socket?.connected);
    _socket?.emit('msg', 'i love you');
  }

  //send message
  void sendMsg({
    String? toUid,
    String? msg,
  }) {
    _socket?.emit(
      'msg',
      {
        'msg': msg,
        'from': getIt.get<SupabaseClient>().auth.currentUser?.id,
        'toUid': toUid,
      },
    );
  }
}
