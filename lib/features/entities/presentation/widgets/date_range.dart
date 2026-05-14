import 'package:civigo/config/app_config/app_config.dart';
import 'package:civigo/features/reports2/presentation/providers/date_provider.dart';
import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateRange extends ConsumerWidget{
  const DateRange({super.key});
  
    Future<void> _selectDate(BuildContext context, WidgetRef ref, bool isDesde) async {
    final dateRange = ref.read(reportDateProvider);
    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isDesde ? dateRange.desde : dateRange.hasta,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
  
      if (isDesde) {
        ref.read(reportDateProvider.notifier).state = dateRange.copyWith(desde: picked);
      } else {
        ref.read(reportDateProvider.notifier).state = dateRange.copyWith(hasta: picked);
      }
    }
  }
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final dateRange = ref.watch(reportDateProvider);

  String format(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

    return 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
           children: [
          
            Row(
             children: [
             Icon(Icons.date_range, size: 18,),
             SizedBox(width: 10,),
             UIText(title: "rango de fecha", size: 18,bold: true,)
              ],
             ),

             SizedBox(height: 10,),

             Row(
              mainAxisAlignment: MainAxisAlignment.start,
               children: [
          
                 Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                  decoration: BoxDecoration(
                  color: AppConfig.primaryColor.withAlpha(20),
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(30),
                  ),
                  child: UIText(title: "esta semana", bold: true,),
                ),

                SizedBox(width: 8,),
          
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                  decoration: BoxDecoration(
                  color: AppConfig.primaryColor.withAlpha(20), 
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(30),
                  ),
                  child: UIText(title: "este mes", bold: true,)
                ),

                SizedBox(width: 8,),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                  decoration: BoxDecoration(
                  color: AppConfig.primaryColor.withAlpha(20), 
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(30),
                  ),
                  child: UIText(title: "personalizar", bold: true, )
                ),
               ],
             ),

             SizedBox(height: 10,),
          
             Row(
              children: [
               Expanded(
               child: _buildDatePicker(
                "Desde",
                 format(dateRange.desde),
                 () => _selectDate(context, ref, true),
                ),
               ),
          
               const SizedBox(width: 15),
          
               Expanded(
               child: _buildDatePicker(
                "Hasta",
                format(dateRange.hasta),
                () => _selectDate(context, ref, false),
                 ),
               )
                ],
             ),
          
             SizedBox(height: 10,),
          
          
           ],
          ),
        );
  }
}
  



Widget _buildDatePicker(String label, String dateText, VoidCallback onTap) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      SizedBox(height: 8),
      InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color:  Colors.white, 
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dateText, style: const TextStyle(fontSize: 16)),
              const Icon(Icons.calendar_month_outlined, size: 20),
            ],
          ),
        ),
      ),
    ],
  );
}