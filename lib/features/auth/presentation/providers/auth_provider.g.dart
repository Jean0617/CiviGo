// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Auth)
final authProvider = AuthProvider._();

final class AuthProvider extends $NotifierProvider<Auth, BaseState> {
  AuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  Auth create() => Auth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseState>(value),
    );
  }
}

String _$authHash() => r'00333393cb8550d46f278f26ff7aaf21a92b2b19';

abstract class _$Auth extends $Notifier<BaseState> {
  BaseState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<BaseState, BaseState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BaseState, BaseState>,
              BaseState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
