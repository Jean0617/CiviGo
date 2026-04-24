// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Slider)
final sliderProvider = SliderProvider._();

final class SliderProvider extends $NotifierProvider<Slider, SliderState> {
  SliderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sliderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sliderHash();

  @$internal
  @override
  Slider create() => Slider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SliderState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SliderState>(value),
    );
  }
}

String _$sliderHash() => r'98787814f6920dff47b32bc34597fd79ab4c3536';

abstract class _$Slider extends $Notifier<SliderState> {
  SliderState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SliderState, SliderState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SliderState, SliderState>,
              SliderState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
