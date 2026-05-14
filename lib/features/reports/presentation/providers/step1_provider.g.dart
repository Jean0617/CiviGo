// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step1_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Step1)
final step1Provider = Step1Provider._();

final class Step1Provider extends $NotifierProvider<Step1, Step1State> {
  Step1Provider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'step1Provider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$step1Hash();

  @$internal
  @override
  Step1 create() => Step1();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Step1State value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Step1State>(value),
    );
  }
}

String _$step1Hash() => r'2cd55ea5774a983f1e51180adaf506ad464338d2';

abstract class _$Step1 extends $Notifier<Step1State> {
  Step1State build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Step1State, Step1State>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Step1State, Step1State>,
              Step1State,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
