// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Users)
final usersProvider = UsersProvider._();

final class UsersProvider
    extends $AsyncNotifierProvider<Users, List<AuthUserModel>> {
  UsersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usersHash();

  @$internal
  @override
  Users create() => Users();
}

String _$usersHash() => r'1bc495ed702ed380e32697cf37b4a88976d9db7a';

abstract class _$Users extends $AsyncNotifier<List<AuthUserModel>> {
  FutureOr<List<AuthUserModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<AuthUserModel>>, List<AuthUserModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AuthUserModel>>, List<AuthUserModel>>,
              AsyncValue<List<AuthUserModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
