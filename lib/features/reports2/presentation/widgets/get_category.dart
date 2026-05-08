import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final selectedCategoryProvider = StateProvider<String>((ref) => 'seleccione una categoria');

class GetCategory extends ConsumerWidget {
  GetCategory({super.key});

  final List<String> categorias = [
    'seleccione una categoria',
    'Infraestructura Vial',
    'Alumbrado Público',
    'Gestión de Residuos',
    'Parques y Jardines',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              const Icon(Icons.calculate_outlined),
              const SizedBox(width: 10),
              UIText(title: "categoria", size: 20, bold: true),
            ],
          ),

          const SizedBox(height: 20),

          UIText(
            title: "selecionar tematica",
            color: const Color.fromARGB(255, 128, 127, 127),
          ),

          const SizedBox(height: 10), 

          DropdownButtonFormField<String>(
            initialValue: selectedCategory,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF8F9FD),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black12),
              ),
            ),

            items: categorias.map((String categoria) {
              return DropdownMenuItem<String>(
                value: categoria,
                child: Text(categoria),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                ref.read(selectedCategoryProvider.notifier).state = newValue;
              }
            },
          ),
        ],
      ),
    );
  }
}