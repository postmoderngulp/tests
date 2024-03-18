// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tests/data/models/board_model.dart';
import 'package:tests/domain/repository/repository.dart';

class UseCaseLocalSource {
  final Repository _repo;
  bool _isLast = false;
  bool _isEmpty = false;
  bool get isLast => _isLast;
  bool get isEmpty => _isEmpty;


  UseCaseLocalSource({
    required Repository repo,
  }) : _repo = repo;

  void loadData(List<String> queue) {
     _repo.load(queue);
  }

   Future<BoardModel?> unloadData() async {
    final data =  await _repo.unload();
      if(
        data!.isNotEmpty
      ){
        if(data.length == 1){
          _isLast = true;
        }
        return BoardModel.fromJson(data.first);
      }
      else if(data.isEmpty){
        _isEmpty  = true;
        return null; 
    }
      return null;
    
  }


  Future<BoardModel?> next() async{
    final data = await _repo.unload();
      data!.removeWhere((element) => element == data.first);
         loadData(data);
    if(
        data.isNotEmpty
      ){
        if(data.length ==1){
          _isLast = true;
        }
        return BoardModel.fromJson(data.first);
      }
      else if(data.isEmpty){
        _isEmpty  = true;
        return null; 
    }
    return null;
  

  }
}
