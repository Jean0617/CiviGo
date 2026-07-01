
import 'package:civigo/features/shared/presentation/providers/ui_alerts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../config/app_config/app_config.dart';
import '../../../../config/route_config/route_paths.dart';
import '../../../shared/domain/app_error.dart';
import '../../../shared/domain/app_error_entity.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../config/menu_items.dart';
import '../utils/icon_mapper.dart';

class DashboardPage extends ConsumerWidget {
  final Widget child;

  const DashboardPage({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = getIndexFromLocation(location);

    final auth = ref.watch(uiAlertsProvider);

    return Scaffold(
      backgroundColor: AppConfig.primaryColor,
      appBar: buildAppBar(context),
      body: buildBody(auth),
      bottomNavigationBar: buildBottonNavigationBar(currentIndex, context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: ListTile(
        minLeadingWidth: 0,
        minTileHeight: 0,
        visualDensity: VisualDensity.compact,
        horizontalTitleGap: 8,
        contentPadding: EdgeInsets.all(0),
        // leading: IconButton(onPressed: ()=> animated.value = !animated.value, icon: Icon(Icons.analytics)),
        leading: Icon(Icons.security_outlined, size: 30, color: Colors.white,),
        title: UIText(title: AppConfig.appName, bold: true, color: Colors.white, size: 23,),
        subtitle: UIText(title: AppConfig.appLema, size: 12, color: Colors.white,),
        trailing: GestureDetector(
          onTap: () => context.go(RoutePaths.profilePath),
          child: Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white70,
              image: DecorationImage(
                image: AssetImage('assets/avatar/profile_boy.png'),
                fit: BoxFit.contain,
              )
            )
          ),
        )
      ),
    );
  }

  SafeArea buildBody(AppErrorEntity? state) {
    return SafeArea(
      child: Stack(
        children: [

          Container(
            // margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(30),
              //   topRight: Radius.circular(30)
              // ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 1)
                )
              ]
            ),
            child: ClipRRect(
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(30),
              //   topRight: Radius.circular(30)
              // ),
              child: child
            )
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child:  state == null? SizedBox.shrink() : AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInCirc,
              width: double.infinity,
              height: 35,
              color: state.type == AppErrorType.warning? Colors.orange : state.type == AppErrorType.success? Colors.green : Colors.black,
              child: Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, color: Colors.white, size: 15,),
                  Flexible(child: UIText(title: state.message, color: Colors.white, bold: true,)),
                ],
              )
            )
          ),
        ],
      )
    );
  }

  Container buildBottonNavigationBar(int currentIndex, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5
          )
        ]
      ),
      child: SalomonBottomBar(
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (i) {
          final item = menuBottomItems[i];
          context.go(item.route);
        },
        items: menuBottomItems.map((item) {
          return SalomonBottomBarItem(
            icon: Icon(iconMap[item.iconKey] ?? Icons.help_outline),
            title: Text(item.label),
            selectedColor: AppConfig.primaryColor,
            unselectedColor: Colors.grey.shade500
          );
        }).toList(),
      ),
    );
  }

  int getIndexFromLocation(String location) {
    return menuBottomItems.indexWhere(
      (item) => location.startsWith(item.route),
    );
  }
}