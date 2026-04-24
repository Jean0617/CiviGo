abstract class HomeRepository {
  
  Future<List> fetchAll(String query);

  Future<Map> fetchById(int id);

  Future<bool> create(Map data);
  
  Future<bool> update(Map data);

  Future<bool> delete(int id);

}