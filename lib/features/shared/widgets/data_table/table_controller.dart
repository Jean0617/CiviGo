import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'table_controller.g.dart';

@riverpod
class TableController extends _$TableController {
  @override
  int build() => 1; // página actual

  void setPage(int page) {
    state = page;
  }

  void next(int totalPages) {
    if (state < totalPages) state++;
  }

  void prev() {
    if (state > 1) state--;
  }
}