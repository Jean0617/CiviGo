import '../../../auth/data/models/slider_item_model.dart';

class SliderState {

  final int currentIndex;
  final List<SliderItemModel> images;
  
  SliderState({
    this.currentIndex = 0,
    this.images = const [],
  });

  SliderState copyWith({
    int? currentIndex,
    List<SliderItemModel>? images,
  }) {
    return SliderState(
      currentIndex: currentIndex ?? this.currentIndex,
      images: images ?? this.images,
    );
  }

}
