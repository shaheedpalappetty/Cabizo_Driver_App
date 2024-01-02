// import 'package:web_socket_channel/io.dart';

// class WebSocketService {
//   static final WebSocketService _instance = WebSocketService._internal();
//   factory WebSocketService() => _instance;

//   final String _baseUrl = 'http://10.0.2.2:8080/websocket/ws';

//   IOWebSocketChannel? _channel;

//   WebSocketService._internal();

//   void connect() {
//     _channel = IOWebSocketChannel.connect(_baseUrl);
//   }

//   void send(String message) {
//     _channel?.sink.add(message);
//   }

//   Stream<dynamic> get stream => _channel?.stream ?? Stream.empty();
// }
