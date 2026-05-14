import 'package:civigo/features/shared/widgets/dropdown/ui_dropdown_button.dart';
import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final selectedCategoryProvider = StateProvider<String>((ref) => 'seleccione una categoria');

class GetCategory extends ConsumerWidget {
  GetCategory({super.key});

  final List<Map<String, dynamic>> clasificaciones = [
    {
      'id': 1,
      'name': 'Infraestructura',
    },
    {
      'id': 2,
      'name': 'Seguridad',
    },
    {
      'id': 3,
      'name': 'Movilidad',
    },
    {
      'id': 4,
      'name': 'Servicios públicos',
    },
    {
      'id': 5,
      'name': 'Medio ambiente',
    },
    {
      'id': 6,
      'name': 'Comunidad',
    },
    {
      'id': 7,
      'name': 'Emergencias',
    },
    {
      'id': 8,
      'name': 'Mascotas y animales',
    },
    {
      'id': 9,
      'name': 'Espacio urbano',
    },
    {
      'id': 10,
      'name': 'Otros reportes',
    },
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          Row(
            children: [
              const Icon(Icons.calculate_outlined, size: 18,),
              const SizedBox(width: 10),
              UIText(title: "categoria", size: 18, bold: true),
            ],
          ),
      
          const SizedBox(height: 7),
      
          UIText(
            title: "selecionar tematica",
            color: const Color.fromARGB(255, 128, 127, 127),
          ),
      
          const SizedBox(height: 10), 
      
          ListTile(
                contentPadding: EdgeInsets.zero,
                title: UIDropdownButton<Map>(
                  hintText: 'Seleccione...',
                  items: clasificaciones,
                  value: clasificaciones[0],
                  itemBuilder: (item) => item['name'] ?? '',
                  onChanged: (value) {},
                ),
              ),
        ],
      ),
    );
  }
}