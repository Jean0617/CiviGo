import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/step1_state.dart';

part 'step1_provider.g.dart';

@riverpod
class Step1 extends _$Step1 {
  
  @override
  Step1State build() => Step1State();

  void setAnimate(bool value) {
    state = state.copyWith(animate: value);
  }

  void setOpenCamera(bool value) {
    state = state.copyWith(isOpeningCamera: value);
  }
}


