import 'package:flutter/material.dart';
import '../../../shared/widgets/dropdown/ui_dropdown_button.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../widgets/widgets.dart';

class Step1 extends StatelessWidget {

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

  final priority = [
    {'id': 'baja', 'name':'Baja'},
    {'id': 'media', 'name':'Media'},
    {'id': 'alta', 'name':'Alta'},
    {'id': 'crítica', 'name':'Crítica'},
  ];
   
  Step1({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SizedBox(height: 20,),
          
              UIText(
              title: "Comenzemos eligiendo una clasificacion para tu reporte", 
              size: 30,
              bold: true,
              color: Color(0xFF0A214D),
              ),
                
              SizedBox(height: 20),
              
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: UIText(title: 'Clasificación', bold: true, size: 15, color: const Color(0xFF424242)),
                ),
                subtitle: UIDropdownButton<Map>(
                  hintText: 'Seleccione...',
                  items: clasificaciones,
                  value: clasificaciones[0],
                  itemBuilder: (item) => item['name'] ?? '',
                  onChanged: (value) {},
                ),
              ),

              SizedBox(height: 10),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 10,
                children: [

                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 13.0),
                        child: UIText(title: '¿Ocurre ahora?', bold: true, size: 15, color: const Color(0xFF424242)),
                      ),
                      subtitle: UIRadioGroup<String>(
                        items: const ['No','Si'],
                        value: 'No',
                        direction: Axis.horizontal,
                        labelBuilder: (item) => item,
                        onChanged: (value) {},
                      ),
                    )
                  ),

                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: UIText(title: 'Prioridad', bold: true, size: 15, color: const Color(0xFF424242)),
                      ),
                      subtitle: UIDropdownButton<Map>(
                        hintText: 'Seleccione...',
                        items: priority,
                        value: priority[0],
                        itemBuilder: (item) => item['name'] ?? '',
                        onChanged: (value) {},
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        )
      )
      
    );
  }
}

class UICheckbox extends StatelessWidget {

  final bool value;
  final ValueChanged<bool?> onChanged;

  final String? title;
  final Widget? titleWidget;

  final Color activeColor;
  final Color checkColor;
  final double borderRadius;

  final EdgeInsetsGeometry padding;

  final bool enabled;

  const UICheckbox({
    super.key,
    required this.value,
    required this.onChanged,

    this.title,
    this.titleWidget,

    this.activeColor = Colors.blue,
    this.checkColor = Colors.white,
    this.borderRadius = 6,

    this.padding = EdgeInsets.zero,

    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: enabled
          ? () => onChanged(!value)
          : null,

      child: Padding(
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// CHECKBOX
            Transform.scale(
              scale: 1.0,
              child: Checkbox(
                value: value,
                onChanged: enabled ? onChanged : null,

                activeColor: activeColor,
                checkColor: checkColor,

                side: BorderSide(
                  color: Colors.grey.shade400,
                  width: 1.2,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),

                visualDensity: VisualDensity.compact,

                materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap,
              ),
            ),

            /// TITLE
            if (title != null || titleWidget != null)
              Flexible(
                child: titleWidget ??
                    Text(
                      title!,
                      style: TextStyle(
                        fontSize: 14,
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
      