import 'package:civigo/config/route_config/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_config/app_config.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/buttons/ui_button.dart';
import '../../../shared/widgets/container/form_no_data.dart';
import '../../../shared/widgets/data_table/action_button.dart';
import '../../../shared/widgets/data_table/column_config.dart';
import '../../../shared/widgets/data_table/ui_data_table.dart';
import '../../../shared/widgets/popup/ui_popup.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../../../shared/widgets/textformfield/ui_text_form_field.dart';
import '../../data/models/user_model.dart';

class UsersPage extends ConsumerStatefulWidget {
  const UsersPage({super.key});

  @override
  ConsumerState<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends ConsumerState<UsersPage> {

  List<User> users = [];
  int totalPages = 5;
  bool isLoading = false;

  List<ColumnConfig<User>> userColumns = [
    
    ColumnConfig<User>(
      width: 120,
      name: 'name',
      label: 'Nombre',
      builder: (u) => Text(u.name),
    ),

    ColumnConfig<User>(
      width: 130,
      name: 'id',
      label: 'Identificación',
      builder: (u) => Text('CC-${u.id*356}'),
    ),

    ColumnConfig<User>(
      width: 150,
      name: 'email',
      label: 'Email',
      builder: (u) => Text(u.email),
    ),

    ColumnConfig<User>(
      name: 'state',
      label: 'Estado',
      builder: (u) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: u.active ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          u.active ? 'Activo' : 'Inactivo',
          style: TextStyle(
            color: u.active ? Colors.green : Colors.red,
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
    fetch(1);
  }

  Future<void> fetch(int page) async {
    setState(() => isLoading = true);

    await Future.delayed(const Duration(milliseconds: 500));

    final newUsers = List.generate(10, (i) {
      final index = ((page - 1) * 10) + i + 1;
      return User(
        id: index,
        name: 'User $index',
        email: 'user$index@mail.com',
        age: 20,
        phone: '300000000',
        active: true,
      );
    });

    setState(() {
      users = newUsers;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 15, color: Colors.black45,),
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
            
                users.isNotEmpty?
                  FormNoData()
                :
                  buildDataTableUsers(),
      
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  UIDataTable<User> buildDataTableUsers() {
    return UIDataTable<User>(
      data: users,
      columns: userColumns,
      totalPages: totalPages,
      isLoading: isLoading,
      onPageChange: (page) {
        fetch(page);
      },
      actions: [
        ActionButton<User>(
          icon: Icons.edit,
          color: Colors.blueGrey,
          tooltip: 'Editar',
          onPressed: (user) {},
        ),
        ActionButton<User>(
          icon: Icons.delete_forever,
          color: Colors.red,
          tooltip: 'Eliminar',
          onPressed: (user) {},
        ),
      ],
    );
  }
}