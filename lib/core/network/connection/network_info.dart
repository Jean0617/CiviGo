
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_info.g.dart';

@riverpod
Stream<bool> networkInfo(Ref ref) async* {
  
  final connectivity = Connectivity();

  final initial = await connectivity.checkConnectivity();
  yield !initial.contains(ConnectivityResult.none);
  
  await for (final result in connectivity.onConnectivityChanged) {
    yield !result.contains(ConnectivityResult.none);
  }

}

