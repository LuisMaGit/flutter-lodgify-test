import 'package:flutter/material.dart';

class BaseVM<State> extends ChangeNotifier {
  late State _state;
  State get state => _state;

  BaseVM(State init){
    _state = init;
  }

  set setState(State state) {
    _state = state;
    notifyListeners();
  }

}