import 'package:civigo/features/home/presentation/constants/slider_items.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/slider_state.dart';

part 'slider_provider.g.dart';

@riverpod
class Slider extends _$Slider {

  @override
  SliderState build() => SliderState(images: sliderItems);

  void setindex(int index) => state = state.copyWith(currentIndex: index);

}