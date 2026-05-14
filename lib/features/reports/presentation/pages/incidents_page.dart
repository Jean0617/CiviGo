import 'package:civigo/config/route_config/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_config/app_config.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/container/form_no_data.dart';
import '../../../shared/widgets/popup/ui_popup.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../../../shared/widgets/text/ui_title_action.dart';
import '../../../shared/widgets/textformfield/ui_text_form_field.dart';

class IncidentsPage extends ConsumerStatefulWidget {
  const IncidentsPage({super.key});

  @override
  ConsumerState<IncidentsPage> createState() => _UsersPageState();
}

class _UsersPageState extends ConsumerState<IncidentsPage> {

  int totalPages = 5;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusKeyboard(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                UITitleAction(
                  title: 'INCIDENTES',
                  subTitle: 'Crea y supervisa tus incidencias reportadas.',
                  icon: Icons.campaign_outlined,
                  onTap:() => context.pushNamed(RoutePaths.newIncident)
                ),

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
                      onPressed: () => uIDialog(context, title: 'Filtros', message: 'Seleciione los filtros para realizar las busquedas mas precisas.'),
                    ),
                  ],
                ),

                SizedBox(height: 20),
            
                FormNoData(),
      
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

}



