class Step1State {
  final bool animate;
  final bool isOpeningCamera;

  Step1State({  
    this.animate = false,
    this.isOpeningCamera = false
  });

  Step1State copyWith({  
    bool? animate,
    bool? isOpeningCamera
  }){
    return Step1State(
      animate: animate ?? this.animate ,
      isOpeningCamera: isOpeningCamera ?? this.isOpeningCamera 
    );
  }
}