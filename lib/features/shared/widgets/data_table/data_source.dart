import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'action_button.dart';
import 'column_config.dart';
class GenericDataSource<T> extends DataGridSource {
  final List<T> data;
  final List<ColumnConfig<T>> columns;
  final List<ActionButton<T>>? actions;

  late List<DataGridRow> _rows;

  GenericDataSource({
    required this.data,
    required this.columns,
    this.actions,
  }) {
    _rows = data.map((item) {
      final cells = <DataGridCell<Widget>>[];

      // columnas normales
      for (final col in columns) {
        cells.add(
          DataGridCell<Widget>(
            columnName: col.name,
            value: col.builder(item),
          ),
        );
      }

      // columna acciones
      if (actions != null && actions!.isNotEmpty) {
        cells.add(
          DataGridCell<Widget>(
            columnName: 'actions',
            value: _buildActions(item),
          ),
        );
      }

      return DataGridRow(cells: cells);
    }).toList();
  }

  Widget _buildActions(T item) {
    return Row(
      spacing: 3,
      mainAxisSize: MainAxisSize.min,
      children: actions!.map((action) {
        return IconButton(
          style: ButtonStyle(
            visualDensity: VisualDensity.compact,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: WidgetStatePropertyAll(
              action.color?.withAlpha(20) ?? Colors.grey.withAlpha(20) 
            )
          ),
          padding: EdgeInsets.zero,
          icon: Icon(action.icon, color: action.color ?? Colors.grey, size: 19,),
          tooltip: action.tooltip,
          onPressed: () => action.onPressed(item),
        );
      }).toList(),
    );
  }

  @override
  List<DataGridRow> get rows => _rows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: cell.value as Widget,
        );
      }).toList(),
    );
  }
}