import 'package:civigo/features/dashboard/presentation/config/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/route_config/route_paths.dart';
import '../../../shared/widgets/buttons/ui_button.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../utils/icon_mapper.dart';

class MenuPage extends StatelessWidget {

  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          buildHeaderUser(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(color: Colors.grey.shade300,),
          ),

          ...buildMenuItems(),

          const Spacer(),
      
          buttonLogout(context),

          SizedBox(height: 35)
        ],
      ),
    );
  }


  Widget buildHeaderUser() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: 20),
                    
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.blue.withAlpha(50),
              child: Image.asset('assets/avatar/profile_boy.png')
              // Icon(Icons.person, color: Colors.white, size: 30,),
            ),
                    
            const SizedBox(height: 10),
                    
            const UIText(
              title: "Jean Reyes",
              color: Colors.black,
              size: 20,
              bold: true,
            ),
        
            const UIText(
              title: "jcreyes@example.com",
              color: Colors.black45,
              size: 12,
            ),
                
            // Container(
            //   margin: EdgeInsets.only(top: 10),
            //   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            //   decoration: BoxDecoration(
            //     color: Colors.white.withAlpha(70),
            //     borderRadius: BorderRadius.circular(10)
            //   ),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     spacing: 5,
            //     children: [
            //       Icon(Icons.verified_outlined, color: Colors.white, size: 15,),
            //       UIText(title: 'Ciudadano', size: 10, color: Colors.white, bold: true,),
            //     ],
            //   ),
            // ),

            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha(70),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 5,
                children: [
                  Icon(Icons.verified_outlined, color: Colors.blue, size: 15,),
                  UIText(title: 'Administrador', size: 10, color: Colors.blue, bold: true,),
                ],
              ),
            ),

            SizedBox(height: 15,)
                    
          ],
        ),
      ),
    );
  }

  List<Widget> buildMenuItems() {
    return [
      ...menuDashboardItems.map((item) {
        return _menuItem(
          icon: iconMap[item.iconKey] ?? Icons.help_outline,
          title: item.label,
        );
      }),
    ];
  }

  Widget _menuItem({IconData? icon, String title = '', Color color = Colors.black54}) {
    return ListTile(
      onTap: () {},
      selected: true,
      contentPadding: EdgeInsets.only(left: 20, right: 20),
      leading: Icon(icon, color: color),
      title: UIText(
        size: 13,
        title: title,
        color: color,
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 10, color: Colors.grey,),
    );
  }

  Padding buttonLogout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: UIButton(
        title: 'Cerrar sesión',
        expand: true,
        bold: true,
        borderRadius: 15,
        background: Colors.red,
        fontColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15),
        iconAlignmentStart: false,
        icon: Icon(Icons.logout, color: Colors.white, size: 15,),
        onPressed: () => context.go(RoutePaths.homePath),
      ),
    );
  }
}