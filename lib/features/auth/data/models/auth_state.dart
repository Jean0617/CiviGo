class AuthState {

  final List data;
  final bool isSearching; 

  AuthState({
    this.data = const [],
    this.isSearching = false,
  });

  AuthState copyWith({
    List? data,
    bool? isSearching,
  }) {
    return AuthState(
      data: data ?? this.data,
      isSearching: isSearching ?? this.isSearching,
    );
  }

}
