import 'dart:async';

/// These are the actions which user can perform
enum CounterAction { Increment, Decrement, Reset }

class CounterBloc {
  /// Stream controller is responsible for input and output
  /// Input will be called as sink and output will be stream
  /// Here we took [int] because our input and output will be integer
  final _stateStreamController = StreamController<int>();

  /// [StreamSink] is responsible for input inside our stream controller
  ///
  /// [Stream] is for output coming out from stream controller
  ///
  /// This is for access this property outside the bloc pattern so outside can only sink and stream
  StreamSink<int> get counterSink => _stateStreamController.sink;

  Stream<int> get counterStream => _stateStreamController.stream;

  /// This is event controller means if user want to increment
  ///
  /// It will listen through and then go to state stream [_stateStreamController]
  final _eventStreamController = StreamController<CounterAction>();

  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;

  Stream<CounterAction> get eventStream => _eventStreamController.stream;

  /// When ever counter bloc created it will call event stream to listen change
  /// It will continuously listing and when detect change call our [_stateStreamController]
  /// Now the stream of event will act as sink for state stream controller
  ///
  CounterBloc() {
    int counter = 0;
    eventStream.listen((event) {
      if (event == CounterAction.Increment) {
        counter++;
      } else if (event == CounterAction.Decrement) {
        counter--;
      } else if (event == CounterAction.Reset){
        counter = 0;
      }
      counterSink.add(counter);
    });
  }
}
