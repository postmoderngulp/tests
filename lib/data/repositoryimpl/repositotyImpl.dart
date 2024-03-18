// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tests/data/datasource/local_source.dart';
import 'package:tests/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  LocalSource localSource;


  RepositoryImpl({
    required LocalSource Source,
  }) : localSource = Source;


  @override
  void load(List<String> queue) async{
   await localSource.load(queue);
  }

  @override
  Future<List<String>?> unload() async{
   final list =  await localSource.unload();
   return list;
  }

}
