import 'package:flutter/material.dart';

class AnimatedIncidentCard extends StatelessWidget {

  final bool animate;
  final double? leftAnimated;
  final double? leftInitial;
  final double? topAnimated;
  final double? topInitial;
  final double angle;
  final int duration;
  final Curve curve;
  final double width;
  final double height;
  final String image;
  final bool showContent;

  const AnimatedIncidentCard({
    super.key,
    required this.animate,
    this.leftAnimated,
    this.leftInitial,
    this.topAnimated,
    this.topInitial,
    required this.angle,
    required this.duration,
    required this.curve,
    required this.width,
    required this.height,
    required this.image,
    required this.showContent,
  });

  @override
  Widget build(BuildContext context) {

    return AnimatedPositioned(
      duration: Duration(milliseconds: duration),
      curve: curve,
      left: animate? leftAnimated : leftInitial,
      top: topAnimated != null? animate ? topAnimated : topInitial : null,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(14),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: !showContent? 
              null
            : 
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      'Reporte ciudadano',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    Text(
                      'Reporta daños en vías, fugas, basuras o cualquier situación que afecte a tu comunidad.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),

                  ],
                ),
              ),
        ),
      ),
    );
  }
}