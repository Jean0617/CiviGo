class ReportState {
  final int currentStep;
  final int fullStep;


  ReportState({
    this.currentStep = 0,
    this.fullStep = 3,

  });

  ReportState copywith ({
    int? currentStep,
  }){
    return ReportState(
    currentStep: currentStep ?? this.currentStep
    );
  }
  

}