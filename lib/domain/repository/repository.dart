abstract class Repository {
  void load(List<String> queue);

  Future<List<String>?> unload();
} 