import 'package:civigo/config/app_config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../text/ui_text.dart';
import 'action_button.dart';
import 'column_config.dart';
import 'data_source.dart';
import 'table_controller.dart';

class UIDataTable<T> extends ConsumerWidget {

  final List<T> data;
  final int totalPages;
  final bool isLoading;
  final List<ColumnConfig<T>> columns;
  final List<ActionButton<T>>? actions;
  final Function(int page) onPageChange;

  const UIDataTable({
    super.key,
    required this.data,
    required this.columns,
    required this.totalPages,
    required this.onPageChange,
    this.actions,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentPage = ref.watch(tableControllerProvider);
    final controller = ref.read(tableControllerProvider.notifier);

    final dataSource = GenericDataSource<T>(
      data: data,
      columns: columns,
      actions: actions,
    );

    // combina laas columnas y agrega columna actions si se manda 
    final allColumns = [
      ...columns,
      if (actions != null && actions!.isNotEmpty)
        ColumnConfig<T>(
          name: 'actions',
          label: 'Acciones',
          builder: (_) => const SizedBox(),
          width: 120,
        )
    ];

    return Column(
      children: [

        // PAGINACIÓN
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)
            ),
          ),
          child: Row(
            spacing: 2,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 5,
                  children: [
                    UIText(
                      title: 'Resultados',
                      color: Colors.black87, bold: true, size: 18.0,
                    ),
                    Icon(Icons.filter_list, color: Colors.blueGrey, size: 18,),
                  ],
                ),
              ),

              Row(
                children: [
                  IconButton(
                    style: ButtonStyle(
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: const Icon(Icons.arrow_back_ios_outlined, size: 15),
                    onPressed: currentPage == 1? null : () {
                      controller.prev();
                      onPageChange(ref.read(tableControllerProvider));
                    },
                  ),

                  UIText(title: 'Página $currentPage de $totalPages', size: 11,),

                  IconButton(
                    style: ButtonStyle(
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: const Icon(Icons.arrow_forward_ios, size: 15),
                    onPressed: currentPage == totalPages? null : () {
                      controller.next(totalPages);
                      onPageChange(ref.read(tableControllerProvider));
                    },
                  ),
                ],
              ),

              
            ],
          ),
        ),

        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(2),
            bottomRight: Radius.circular(2)
          ),
          child: SfDataGrid(
            source: dataSource,
            columnWidthMode: ColumnWidthMode.none,
            verticalScrollPhysics: ScrollPhysics(),
            shrinkWrapRows: true,
            isScrollbarAlwaysShown: true,
            rowHeight: 43,
            headerRowHeight: 50,
            columns: allColumns.map((col) {
              return GridColumn(
                columnName: col.name,
                width: col.width ?? double.nan,
                label: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(10),
                  color: AppConfig.primaryColor,
                  child: Text(
                    col.label,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        
      ],
    );
  }
}