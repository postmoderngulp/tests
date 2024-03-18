import 'package:shared_preferences/shared_preferences.dart';
import '../models/board_model.dart';

abstract class LocalSource {
  Future<void> load(List<String> queue);

  Future<List<String>?> unload();

}

class LocalSourceImpl implements LocalSource{
   
  Future<void> load(List<String> queue) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList('queue', queue);
  }


  @override
  Future<List<String>?> unload() async {
     final preferences = await SharedPreferences.getInstance();
    final item = preferences.getStringList('queue');
     List<String> encodes = [];
    if(item == null){
      List<BoardModel> boards = [
        BoardModel(title: 'Quick Delivery At Your Doorstep',
          label: 'Enjoy quick pick-up and delivery to your destination',
          picture: 'first_board',
          width: 346,
          height: 346,),
        BoardModel( title: 'Flexible Payment',
          label:
              'Different modes of payment either before and after delivery without stress',
          picture: 'second_board',
          width: 424,
          height: 316,),
        BoardModel( title: 'Real-time Tracking',
          label:
              'Track your packages/items from the comfort of your home till final destination',
          picture: 'third_board',
          width: 400,
          height: 298,),
      ];
      for(int i = 0; i < boards.length;i++){
        encodes.add(boards[i].toJson());
      }
      await load(encodes);
      await unload();
    }
    return item ?? encodes;
  }
}