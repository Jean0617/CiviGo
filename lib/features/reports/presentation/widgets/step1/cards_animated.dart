import 'package:flutter/material.dart';

import 'animated_incident_card.dart';

class CardsAnimated extends StatelessWidget {
  final bool animate;

  const CardsAnimated({
    super.key,
    required this.animate
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 420,
      child: Stack(
        alignment: Alignment.center,
        children: [
    
          AnimatedIncidentCard(
            animate: animate,
            leftAnimated: 40,
            leftInitial: -250,
            angle: -0.25,
            duration: 700,
            curve: Curves.easeOutBack,
            width: 250,
            height: 300,
            image: 'assets/1.png',
            showContent: false,
          ),
    
          AnimatedIncidentCard(
            animate: animate,
            leftAnimated: 120,
            leftInitial: 250,
            angle: 0.25,
            duration: 900,
            curve: Curves.easeOutBack,
            width: 250,
            height: 300,
            image: 'assets/3.png',
            showContent: false,
          ),
    
          AnimatedIncidentCard(
            animate: animate,
            topAnimated: 20,
            topInitial: 250,
            angle: 0,
            duration: 900,
            curve: Curves.easeInSine,
            width: 250,
            height: 370,
            image: 'assets/2.png',
            showContent: true,
          ),
        ],
      )
    );
  }
}