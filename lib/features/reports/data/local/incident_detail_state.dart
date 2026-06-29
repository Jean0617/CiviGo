class IncidentsState {

  final int amount;
  final int pending;
  final int inProgress;
  final bool isLoading;
  final List<Map<String, dynamic>> incidents;

  IncidentsState({
    this.amount = 0,
    this.pending = 0,
    this.inProgress = 0,
    this.isLoading = false,
    this.incidents = const []
  });

  IncidentsState copyWith({
    int? amount,
    int? pending,
    int? inProgress,
    bool? isLoading,
    List<Map<String, dynamic>>? incidents
  }){
    return IncidentsState(
      amount: amount ?? this.amount,
      pending: pending ?? this.pending,
      inProgress: inProgress ?? this.inProgress,
      incidents: incidents ?? this.incidents,
      isLoading: isLoading ?? this.isLoading,
    );
  }

}