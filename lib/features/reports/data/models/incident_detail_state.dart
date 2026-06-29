class IncidentDetailState {

  final bool isLoading;
  final Map<String, dynamic> incident;

  IncidentDetailState({
    this.isLoading = false,
    this.incident = const {}
  });

  IncidentDetailState copyWith({
    bool? isLoading,
    Map<String, dynamic>? incident
  }){
    return IncidentDetailState(
      incident: incident ?? this.incident,
      isLoading: isLoading ?? this.isLoading,
    );
  }

}