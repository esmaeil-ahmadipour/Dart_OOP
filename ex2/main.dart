import 'dart:async';

var list = [2, "John", false, 5.5, -7, "Maggie", true];
StreamSubscription streamSubscription;

void main() {
  eventHandler("Hello Flutter!");
  Duration period = Duration(seconds: 2);
  Stream stream = Stream.periodic(period,computation);
  streamSubscription=stream.listen(
      eventHandler,
      onDone: () {
        print('Iam Doing !');
      },
      onError: (err){
        print("Opps! Has an Error.$err");
      },
      cancelOnError: false
  );

}

computation(int i) {
  if (i < list.length) {
    return list[i];
  }
  throw "Not Data!";
}

eventHandler(eventValue) {
  print("Event Value Is: ${eventValue}");
}