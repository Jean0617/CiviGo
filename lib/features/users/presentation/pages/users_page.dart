import 'package:civigo/features/shared/widgets/buttons/ui_button.dart';
import 'package:civigo/features/shared/widgets/textformfield/ui_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/data_table/action_button.dart';
import '../../../shared/widgets/data_table/column_config.dart';
import '../../../shared/widgets/data_table/ui_data_table.dart';
import '../../../shared/widgets/dropdown/ui_dropdown_button.dart';
import '../../../shared/widgets/text/ui_text.dart';
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
      name: 'id',
      label: 'ID',
      builder: (u) => Text('${u.id}'),
    ),

    ColumnConfig<User>(
      width: 120,
      name: 'name',
      label: 'Nombre',
      builder: (u) => Text(u.name),
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
        backgroundColor: Colors.white60,
        body: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                ListTile(
                  minTileHeight: 4,
                  contentPadding: EdgeInsets.symmetric(horizontal: 2),
                  title: const UIText( 
                    title: 'GESTIÓN DE USUARIOS', color: Colors.blueGrey, size: 18.0,
                    bold: true,
                  ),
                  subtitle: const UIText( 
                    title: 'Administra información, accesos y roles en para los usuarios.', color: Colors.black54, size: 13.0,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: UIButton(
                        bold: true,
                        expand: true,
                        borderRadius: 10,
                        title: 'Crear usuario',
                        fontColor: Colors.white,
                        background: Colors.blue,
                        icon: Icon(Icons.person_add_alt, color: Colors.white,),
                      ),
                    ),
                    Expanded(child: SizedBox.shrink())
                  ],
                ),

                SizedBox(height: 20),
            
                Container(
                  margin: EdgeInsets.only(left: 2, right: 2),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5
                      )
                    ]
                  ),
                  child: Column(
                    children: [

                      Row(
                        spacing: 5,
                        children: [
                          const UIText( 
                            title: 'Filtros', color: Colors.blueGrey, bold: true, size: 15.0,
                          ),
                          IconButton(
                            style: ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(5)
                                )
                              ),
                              minimumSize: WidgetStatePropertyAll(Size(20,35)),
                              padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
                              backgroundColor: WidgetStatePropertyAll(Colors.blueGrey.withAlpha(30))
                            ),
                            icon: Icon(Icons.filter_alt_outlined, color: Colors.grey, size: 20,),
                            onPressed: (){},
                          )
                            
                        ],
                      ),

                      SizedBox(height: 10),
            
                      UITextFormField(
                        hintText: 'Buscar por identificación, nombre, etc...',
                        borderRadius: 30,
                        focusBorder: Colors.grey.shade400,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: (){}, 
                        ),
                      ),

                      SizedBox(height: 20),
            
                      buildDataTableUsers(),

                      SizedBox(height: 10),

                    ],
                  ),
                ),
      
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