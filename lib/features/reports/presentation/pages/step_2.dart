import 'package:civigo/features/shared/widgets/textformfield/ui_text_form_field.dart';
import 'package:flutter/material.dart';
import '../../../shared/widgets/dropdown/ui_dropdown_button.dart';
import '../../../shared/widgets/text/ui_text.dart';

class Step2 extends StatefulWidget {


  Step2({super.key});

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
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

  final List<Map<String, dynamic>> priority = [
    {'id': 1, 'name': 'Baja', 'color': Colors.blue, 'icon': Icons.info_outline},
    {'id': 2, 'name': 'Media', 'color': Colors.orange, 'icon': Icons.warning_amber_rounded},
    {'id': 3, 'name': 'Crítica', 'color': Colors.red, 'icon': Icons.system_security_update_warning_outlined},
  ];

  ValueNotifier<Map<String, dynamic>> selectedPriority = ValueNotifier({});

  @override
  void initState() {
    super.initState();
    selectedPriority.value = priority[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SizedBox(height: 20,),
          
              UIText(
                title: "Vamos a clasificar el reporte.", 
                size: 30,
                bold: true,
                color: Colors.black,
              ),
                
              SizedBox(height: 20),
              
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: UIText(title: 'Clasificación', bold: true, size: 15, color: const Color(0xFF424242), isRequired: true,),
                ),
                subtitle: UIDropdownButton<Map>(
                  hintText: 'Seleccione...',
                  items: clasificaciones,
                  value: clasificaciones[0],
                  itemBuilder: (item) => item['name'] ?? '',
                  onChanged: (value) {},
                ),
              ),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: UIText(title: 'Entidad encargada', bold: true, size: 15, color: const Color(0xFF424242), isRequired: true,),
                ),
                subtitle: UIDropdownButton<Map>(
                  hintText: 'Seleccione...',
                  items: clasificaciones,
                  value: clasificaciones[0],
                  itemBuilder: (item) => item['name'] ?? '',
                  onChanged: (value) {},
                ),
              ),

              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    UIText(title: '¿Ocurre ahora?', bold: true, size: 15, color: const Color(0xFF424242)),

                    Expanded(
                      child: UIRadioGroup<String>(
                        items: const ['No','Si'],
                        value: 'No',
                        direction: Axis.horizontal,
                        labelBuilder: (item) => item,
                        onChanged: (value) {},
                      ),
                    ),
                
                  ],
                ),
              ),

              SizedBox(height: 20),

              UIText(title: 'Prioridad del reporte', bold: true, size: 15, color: const Color(0xFF424242),),
              SizedBox(height: 5),

              ValueListenableBuilder(
                valueListenable: selectedPriority,
                builder: (context, value, child) {
                  return Row(
                    spacing: 10,
                    children: List.generate(priority.length, (i){
                      
                      final Map<String, dynamic> item = priority[i];
                      final bool isSelected = value.isNotEmpty && value['id'] == item['id'];
                  
                      return GestureDetector(
                        onTap: () => selectedPriority.value = item,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected? item['color'] : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: isSelected? null : Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            spacing: 2,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(item['icon'], size: 20, color: isSelected? Colors.white : Colors.grey.shade500,),
                              UIText(title: '${item['name']}', bold: true, size: 16, color: isSelected? Colors.white : Colors.grey.shade500,),
                            ],
                          )
                        ),
                      );
                    })
                  );
                }
              ),

              SizedBox(height: 20),

              UIText(title: 'Descripción', bold: true, size: 15, color: const Color(0xFF424242),),
              SizedBox(height: 5),

              UITextFormField(
                initialValue: 'Se evidencia una situación que afecta el estado y funcionamiento adecuado del entorno comunitario.'
                ' El incidente reportado requiere atención para prevenir posibles riesgos, afectaciones a la movilidad o inconvenientes'
                ' para los habitantes del sector. Se adjunta evidencia fotográfica para facilitar la verificación y gestión correspondiente.',
                hintText: 'Descripción',
                maxLines: 7,
              )
            ],
          ),
        )
      )
      
    );
  }
}

class UICheckboxGroup<T> extends StatelessWidget {

  final List<T> items;

  /// Lista de seleccionados
  final List<T> values;

  /// Retorna la nueva lista seleccionada
  final ValueChanged<List<T>> onChanged;

  /// Texto a mostrar
  final String Function(T item) labelBuilder;

  final Axis direction;

  final WrapAlignment alignment;

  final double spacing;

  final double runSpacing;

  final EdgeInsetsGeometry itemPadding;

  final bool enabled;

  const UICheckboxGroup({
    super.key,
    required this.items,
    required this.values,
    required this.onChanged,
    required this.labelBuilder,
    this.direction = Axis.vertical,
    this.alignment = WrapAlignment.start,
    this.spacing = 10,
    this.runSpacing = 5,
    this.itemPadding = const EdgeInsets.only(right: 10),
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {

    return direction == Axis.horizontal
    ? Wrap(
        alignment: alignment,
        spacing: spacing,
        runSpacing: runSpacing,
        children: items.map(_buildItem).toList(),
      )
    : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map(_buildItem).toList(),
      );
  }

  Widget _buildItem(T item) {

    final isSelected = values.contains(item);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: enabled
          ? () {
            final updatedValues = [...values];
            if (isSelected) {
              updatedValues.remove(item);
            } else {
              updatedValues.add(item);
            }
            onChanged(updatedValues);
          }
        : null,

      child: Padding(
        padding: itemPadding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Checkbox(
              side: BorderSide(),
              value: isSelected,
              activeColor: Colors.blueGrey,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: enabled
                  ? (_) {

                      final updatedValues = [...values];

                      if (isSelected) {
                        updatedValues.remove(item);
                      } else {
                        updatedValues.add(item);
                      }

                      onChanged(updatedValues);
                    }
                  : null,
            ),

            Flexible(
              child: Text(
                labelBuilder(item),

                style: TextStyle(
                  fontSize: 14,

                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.normal,

                  color: enabled
                      ? Colors.black87
                      : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UIRadioGroup<T> extends StatelessWidget {

  final List<T> items;

  final T? value;

  final ValueChanged<T?> onChanged;

  final String Function(T item) labelBuilder;

  final Axis direction;

  final WrapAlignment alignment;

  final double spacing;

  final double runSpacing;

  final EdgeInsetsGeometry itemPadding;

  final bool enabled;

  const UIRadioGroup({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.labelBuilder,
    this.direction = Axis.vertical,
    this.alignment = WrapAlignment.start,
    this.spacing = 10,
    this.runSpacing = 5,
    this.itemPadding = const EdgeInsets.only(right: 10),
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {

    return RadioGroup<T>(
      groupValue: value,
      onChanged: enabled
          ? onChanged
          : (_) {},
      child: direction == Axis.horizontal
          ? Wrap(
              alignment: alignment,
              spacing: spacing,
              runSpacing: runSpacing,
              children: items.map(_buildItem).toList(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map(_buildItem).toList(),
            ),
    );
  }

  Widget _buildItem(T item) {

    final isSelected = item == value;

    return InkWell(
      borderRadius: BorderRadius.circular(12),

      onTap: enabled
          ? () => onChanged(item)
          : null,

      child: Padding(
        padding: itemPadding,

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Radio<T>(
              value: item,
              activeColor: Colors.blueGrey,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),

            Flexible(
              child: Text(
                labelBuilder(item),

                style: TextStyle(
                  fontSize: 14,

                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.normal,

                  color: enabled
                      ? Colors.black87
                      : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
      