// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tests/domain/entities/board.dart';
import 'package:tests/domain/usecases/usecase_local.dart';

class OnBoardNotifier extends ChangeNotifier {
  Board? item;
  UseCaseLocalSource _caseLocalSource;
  bool _isLast = false;
  bool _isEmpty = false;
  bool get isLast => _isLast;
  bool get isEmpty => _isEmpty;

  OnBoardNotifier({
    required UseCaseLocalSource caseLocalSource,
  }) : _caseLocalSource = caseLocalSource{
    unload();
  }


  void load(List<String> queue) async{
    _caseLocalSource.loadData(queue);
  }

  void unload () async {
   final boardModel =  await _caseLocalSource.unloadData();
  _isLast = _caseLocalSource.isLast;
  _isEmpty = _caseLocalSource.isEmpty;
  item = boardModel;
  notifyListeners();
  }

  void next() async{
  final boardModel =   await _caseLocalSource.next();
  _isLast = _caseLocalSource.isLast;
  _isEmpty = _caseLocalSource.isEmpty;
   item = boardModel;
  notifyListeners();
  }

}
