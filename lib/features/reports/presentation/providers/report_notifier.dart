import 'package:civigo/features/reports/presentation/providers/report_state.dart';
import 'package:flutter_riverpod/legacy.dart';

class ReportNotifier extends StateNotifier<ReportState>{
  ReportNotifier() : super (ReportState());

  void nextStep (){
  if(state.currentStep < state.fullStep - 1){
    state = state.copywith(currentStep: state.currentStep + 1);
   }
  }

  void beforeStep (){
    if(state.currentStep > 0){
      state = state.copywith(currentStep: state.currentStep - 1);
    }
  }

  void reset (){
    state = ReportState();
  }
}
 final reporteProvider = StateNotifierProvider.autoDispose<ReportNotifier, ReportState>((ref) {
  return ReportNotifier();
});


