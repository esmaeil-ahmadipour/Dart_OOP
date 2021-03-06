import 'dart:async';

enum Event { addItem, removeItem, removeAll }

class Item{

  String name;
  String description;
  double price;

  Item({this.name, this.description, this.price});

  @override
  String toString() {
    return 'Item : ${this.name}';
  }
}


class ShoppingCartBloc {
  List<Item> _state;
  StreamController<List<Item>> _streamController;


  ShoppingCartBloc() {
    _state = <Item>[];
    _streamController = StreamController<List<Item>>.broadcast();
  }

  Stream<List<Item>> getStream() {
    return _streamController.stream;
  }

  void On(Event event , [Item item]) {
    switch (event) {
      case Event.addItem:
        {
          _state.add(item);
        }
        break;

      case Event.removeItem:
        {
          _state.remove(item);
        }
        break;

      case Event.removeAll:
        {
          _state.clear();
        }
        break;
    }
    _streamController.add(_state.toList());
  }
}

void main() {
  var stateMachine = ShoppingCartBloc();

  stateMachine.getStream().listen((onData){
    print("Item's Qty==> ${onData.length}");
  });

  stateMachine.getStream().listen((onData){
    print("Cart Item's==> ");
    for (var i = 0; i < onData.length; ++i) {
      print("\t $i - ${onData[i]}");
      
    }
  });

  var selectedItem = Item(name: "Suger",description: "One Kilo",price: 3.5);

  stateMachine.On(Event.addItem,Item(name: "Banana",description: "One Box",price: 1.5));

  stateMachine.On(Event.removeAll);

  stateMachine.On(Event.addItem,Item(name: "Milk",description: "One Box",price: 1.5));
  stateMachine.On(Event.addItem,Item(name: "Egg",description: "One Dozen",price: 2.5));
  stateMachine.On(Event.addItem,selectedItem);
  stateMachine.On(Event.addItem,Item(name: "Apple",description: "One Kilo",price: 7.5));

  stateMachine.On(Event.removeItem,selectedItem);


}
