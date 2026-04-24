import 'package:carousel_slider/carousel_slider.dart';
import 'package:civigo/features/home/presentation/providers/slider_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/data/models/slider_item_model.dart';
import '../../data/models/slider_state.dart';

class ElegantSlider extends ConsumerStatefulWidget {
  const ElegantSlider({super.key});

  @override
  ElegantSliderState createState() => ElegantSliderState();
}

class ElegantSliderState extends ConsumerState<ElegantSlider> {

  @override
  Widget build(BuildContext context) {
    
    final sliderState = ref.watch(sliderProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          spacing: 10,
          children: [

            /// Carrusel ocupa casi todo el alto disponible
            Expanded(
              child: CarouselSlider.builder(
                itemCount: sliderState.images.length,
                itemBuilder: (context, index, realIndex) {

                  final image = sliderState.images[index];

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Stack(
                      children: [

                        // imagenes
                        buildImages(image),

                        // Difuminado para el texto
                        buildBlurred(),

                        // Texto
                        buildTextImg(image)
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  height: constraints.maxHeight,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  autoPlayInterval: const Duration(seconds: 7),
                  onPageChanged: (index, reason) => ref.read(sliderProvider.notifier).setindex(index)
                ),
              ),
            ),

            // Indicadores
            indicators(sliderState),

          ],
        );
      },
    );
  }

  Positioned buildImages(SliderItemModel image) {
    return Positioned.fill(
      child: Image.asset(
        image.image,
        fit: BoxFit.cover,
      ),
    );
  }

  Positioned buildBlurred() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 135,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black,
            ],
          ),
        ),
      ),
    );
  }

  Positioned buildTextImg(SliderItemModel image) {
    return Positioned(
      bottom: 25,
      left: 20,
      right: 20,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            image.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            image.subtitle,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Row indicators(SliderState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: state.images.asMap().entries.map((entry) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: state.currentIndex == entry.key ? 22 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: state.currentIndex == entry.key
                ? Colors.black
                : Colors.grey.shade400,
          ),
        );
      }).toList(),
    );
  }
}