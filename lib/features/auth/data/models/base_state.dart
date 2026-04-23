class BaseState {

  final List data;
  final bool isSearching; 

  BaseState({
    this.data = const [],
    this.isSearching = false,
  });

  BaseState copyWith({
    List? data,
    bool? isSearching,
  }) {
    return BaseState(
      data: data ?? this.data,
      isSearching: isSearching ?? this.isSearching,
    );
  }

}
