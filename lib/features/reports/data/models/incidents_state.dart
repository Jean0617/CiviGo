class IncidentsState {

  final bool isLoading;
  final List<Map<String, dynamic>> incidents;

  IncidentsState({
    this.isLoading = false,
    this.incidents = const []
  });

  IncidentsState copyWith({
    bool? isLoading,
    List<Map<String, dynamic>>? incidents
  }){
    return IncidentsState(
      isLoading: isLoading ?? this.isLoading,
      incidents: incidents ?? this.incidents
    );
  }

}