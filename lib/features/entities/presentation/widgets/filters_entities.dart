
import 'package:civigo/config/app_config/app_config.dart';
import 'package:civigo/features/entities/presentation/widgets/date_range.dart';
import 'package:civigo/features/entities/presentation/widgets/get_category.dart';
import 'package:civigo/features/entities/presentation/widgets/get_state_report.dart';
import 'package:civigo/features/shared/widgets/buttons/ui_button.dart';
import 'package:flutter/material.dart';

class FiltersEntities extends StatelessWidget {
  const FiltersEntities({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6, 
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [

          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Filtros",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView( 
              child: Column ( 
                children: [
                 DateRange(),

                 GetCategory(),

                 GetStateReport(),

                 SizedBox(height: 20),  

                ]
               )
              )
            ),

        Padding(
         padding: const EdgeInsets.all(8.0),
         child: UIButton(
          background: AppConfig.primaryColor.withAlpha(215),
          expand: true,
          title: "aplicar",
          fontColor: Colors.white,
          onPressed: () {}
          )
         )   
        ],
      ),
    );
  }
}