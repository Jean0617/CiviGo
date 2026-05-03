// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TableController)
final tableControllerProvider = TableControllerProvider._();

final class TableControllerProvider
    extends $NotifierProvider<TableController, int> {
  TableControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tableControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tableControllerHash();

  @$internal
  @override
  TableController create() => TableController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$tableControllerHash() => r'e059a32cb6a5ad20e4530b7d234301b35eb24ddd';

abstract class _$TableController extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
