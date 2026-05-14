
import 'package:civigo/config/app_config/app_config.dart';
import 'package:civigo/features/entities/presentation/widgets/filters_entities.dart';
import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:civigo/features/shared/widgets/text/ui_title_action.dart';
import 'package:civigo/features/shared/widgets/textformfield/ui_text_form_field.dart';
import 'package:flutter/material.dart';

class EntitiesPage extends StatelessWidget {
   
  EntitiesPage({super.key});

  final List<Map> entities = [
    { "title" : "obras publicas", "imagen" : 'assets/7.png', "coloricon" :  Colors.orange, "iconstitle" : Icons.construction, "ubicacion" : "edificio central, planta baja,", "telefono" : "317 066 5989", "correo" : "estamosmelos@gmail.com", "categorias" : ["baches", "acera dañada", "semaforizacion"]},
    { "title" : "aseo urbano", "imagen" : 'assets/8.png',"coloricon" : AppConfig.primaryColor ,"iconstitle" : Icons.recycling_rounded, "ubicacion" : "bajando por donde juancho volteo", "telefono" : "317 066 5989", "correo" : "estamostodaviamasmelos@gmail.com", "categorias" : ["basura", "aguas residuales", "limpieza especial"]},
    { "title" : "gestión del riesgo", "imagen" : 'assets/9.png', "coloricon" : Colors.redAccent, "iconstitle" : Icons.fire_truck_outlined, "ubicacion" : "Avenida Las Américas, sector norte",  "telefono" : "310 000 0000", "correo" : "prevencion@municipio.gov", "categorias" : ["Incendios", "Inundaciones", "Árbol en riesgo", "Abejas"]},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(padding: EdgeInsetsGeometry.only(left: 10, right: 10, top: 29),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UITitleAction(
              title: "ENTIDADES", 
              subTitle: "observa las entidades a continuacion"),
          
            SizedBox(height: 5),

            Row(
             spacing: 5,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [

              Expanded(
               child: UITextFormField(
                hintText: 'Buscar por identificación o nombre...',
                borderRadius: 30,
                focusBorder: Colors.grey.shade400,
                suffixIcon: IconButton(
                 icon: Icon(Icons.search),
                 onPressed: (){}, 
                  ),
                ),
              ),

              IconButton(
               style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                 RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10)
                        )
                       ),
                padding: WidgetStatePropertyAll(EdgeInsets.all(13)),
                backgroundColor: WidgetStatePropertyAll(Colors.black.withAlpha(20))
                      ),
                tooltip: 'Filtros',
                icon: Icon(Icons.filter_alt_outlined, color: Colors.black54, size: 22,),
                onPressed: (){

                 showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, 
                  backgroundColor: Colors.transparent,
                  builder: (context) => const FiltersEntities(),
                 );
                }
              ) 
           ],
          ),
         
         
            SizedBox(height: 20),
            
           ...List.generate(entities.length, (index){
            final Map item = entities[index]; 

            return cardEntities(context, item);
           }
           )

         ]
        ),
       ),
      )
    );
  }
}

Widget cardEntities(BuildContext context, Map item) {
  return Column(
    children: [

      Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [

            Container(
              height: 150,
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(9), topRight: Radius.circular(9)),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child:Image.asset(
                  item["imagen"] ?? 'assets/7.png',
                  fit: BoxFit.cover,
                   )
                  ),
                  
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withAlpha(250)],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 15, left: 15, right: 15,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Icon(item['iconstitle'], size: 30, color: item['coloricon'] ?? Colors.orange),
                        ),

                        const SizedBox(width: 10),
                        Expanded(
                          child: UIText(title: item['title'].toString().toUpperCase(), color: Colors.white, size: 18, bold: true),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 17),
                      const SizedBox(width: 13),
                      UIText(title: item['ubicacion'], size: 15),
                      const Spacer(),
                      const Icon(Icons.edit, size: 17)
                    ],
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 17),
                      const SizedBox(width: 13),
                      UIText(title: item['telefono'], size: 15)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.mail, size: 17),
                      const SizedBox(width: 13),
                      UIText(title: item['correo'], size: 15),
                    ],
                  ),
                  const SizedBox(height: 19),
                  const UIText(title: "Categorías Gestionadas", size: 18, bold: true,),
                  const SizedBox(height: 10),

                  Wrap(
                  spacing: 8.0,
                  runSpacing: 7, 
                  children: (item["categorias"] as List<String>).map((categoria) {
                  final Color baseColor = item["coloricon"] as Color? ?? Colors.grey;

                  return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                   color: baseColor.withAlpha(40),
                   border: Border.all(color: baseColor.withAlpha(50)), 
                   borderRadius: BorderRadius.circular(20), 
                    ),
                  child: UIText(
                   title: categoria.toUpperCase(), 
                   size: 11, 
                   color: Colors.black87,
                        ),
                      );
                    }).toList(),
                   ),
                ],
              ),
            )
          ],
        ),
      ),
    ],
  );
}

