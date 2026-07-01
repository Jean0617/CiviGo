import 'package:civigo/config/route_config/route_paths.dart';
import 'package:civigo/features/dashboard/presentation/models/menu_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_config/app_config.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/buttons/ui_button.dart';
import '../../../shared/widgets/container/form_no_data.dart';
import '../../../shared/widgets/data_table/action_button.dart';
import '../../../shared/widgets/data_table/column_config.dart';
import '../../../shared/widgets/data_table/ui_data_table.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../../../shared/widgets/textformfield/ui_text_form_field.dart';
import '../../data/auth_user_model.dart';
import '../../data/models/user_model.dart';
import '../providers/users_provider.dart';

class UsersPage extends ConsumerStatefulWidget {
  const UsersPage({super.key});

  @override
  ConsumerState<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends ConsumerState<UsersPage> {

  List<User> users = [];
  int totalPages = 1;
  bool isLoading = false;

  List<ColumnConfig<AuthUserModel>> userColumns = [
    
    ColumnConfig<AuthUserModel>(
      width: 120,
      name: 'name',
      label: 'Nombre',
      builder: (u) => Text(u.name),
    ),

    ColumnConfig<AuthUserModel>(
      width: 130,
      name: 'role',
      label: 'Rol',
      builder: (u) => Text(u.role == UserRole.citizen.name? 'Ciudadano': u.role == UserRole.admin.name? 'Admin': 'Entidad'),
    ),

    ColumnConfig<AuthUserModel>(
      width: 150,
      name: 'email',
      label: 'Email',
      builder: (u) => Text(u.email),
    ),

    ColumnConfig<AuthUserModel>(
      name: 'state',
      label: 'Estado',
      builder: (u) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: true ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          true ? 'Activo' : 'Inactivo',
          style: TextStyle(
            color: true ? Colors.green : Colors.red,
          ),
        ),
      ),
    ),

  ];

  List<Map<String, dynamic>> listAccess = [
    {'id': 'publico', 'name': 'Público'},
    {'id': 'privado', 'name': 'Privado'},
  ];

  Map<String, dynamic>? selected;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    ref.read(usersProvider.notifier).build();
  }

  @override
  Widget build(BuildContext context) {
    
    final users = ref.watch(usersProvider);

    return UnFocusKeyboard(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 20,
          automaticallyImplyLeading: false,
          actionsPadding: EdgeInsets.only(right: 10),
          title: UIButton(
            title: 'Volver',
            fontColor: Colors.black54, 
            fontSize: 14.0,
            icon: Icons.arrow_back_ios_new_rounded, 
            iconSize: 15, 
            colorIcon: Colors.black45,
            bold: true,
            borderRadius: 10,
            padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
            onPressed: () => context.pop(),
          ),
          toolbarHeight: 60,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                ListTile(
                  visualDensity: VisualDensity.compact,
                  dense: true,
                  minTileHeight: 0,
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  title: UIText( 
                    title: 'GESTIÓN \nDE USUARIOS', color: Colors.black87, size: 25.0,
                    bold: true,
                  ),
                  subtitle: UIText(title: 'Administración de información, roles y permisos.', size: 12, color: Colors.black87,),
                  trailing: 
                  IconButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10)
                        )
                      ),
                      padding: WidgetStatePropertyAll(EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10)),
                      alignment: Alignment.center,
                      backgroundColor: WidgetStatePropertyAll(AppConfig.primaryColor)
                    ),
                    tooltip: 'Nuevo usuario',
                    icon: Icon(Icons.person_add_alt_1_outlined, color: Colors.white, size: 20),
                    onPressed: () => context.pushNamed(RoutePaths.newUser),
                  ),
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
                          onPressed: () => ref.read(usersProvider.notifier).refresh(), 
                        ),
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 20),

                users.when(
                  loading: () => Center(child: SpinKitFadingCircle(color: Colors.blueGrey,)),
                  error: (e, _) => FormNoData(),
                  data: (items) => buildDataTableUsers(items)
                ),
            
                SizedBox(height: 40)
              ],
            ),
          ),
        ),
      ),
    );
  }

  UIDataTable<AuthUserModel> buildDataTableUsers(List<AuthUserModel> items) {
    return UIDataTable<AuthUserModel>(
      data: items,
      columns: userColumns,
      totalPages: totalPages,
      isLoading: isLoading,
      onPageChange: (page) {
        fetch();
      },
      actions: [
        ActionButton<AuthUserModel>(
          icon: Icons.edit,
          color: Colors.blueGrey,
          tooltip: 'Editar',
          onPressed: (user) {},
        ),
        ActionButton<AuthUserModel>(
          icon: Icons.delete_forever,
          color: Colors.red,
          tooltip: 'Eliminar',
          onPressed: (user) {},
        ),
      ],
    );
  }
}