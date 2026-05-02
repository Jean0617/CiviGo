
abstract class LocalDataSources {

  Future<void> saveReport (Map<String, dynamic> reportjson);
  Future<Map<String, dynamic>> getlistreports ();

}

class DrifftDataSources implements LocalDataSources {

  @override
  Future<Map<String, dynamic>> getlistreports() {
    
    throw UnimplementedError();
  }

  @override
  Future<void> saveReport(Map<String, dynamic> reportjson) {
    


    throw UnimplementedError();
  }


}