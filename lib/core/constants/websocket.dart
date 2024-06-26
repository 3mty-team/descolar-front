
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocket {
  static WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('wss://websocket.descolar.fr:8000/'),
  );

  static void connect() {
    channel = WebSocketChannel.connect(
      Uri.parse('wss://websocket.descolar.fr:8000/'),
    );
  }

  static void disconnect() {
    channel.sink.close().then((value) {
      print('Diconnected from websocket : $value');
    });
  }
}
