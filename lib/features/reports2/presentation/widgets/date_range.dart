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
        Container(
         margin: EdgeInsets.only(top: 20),
         padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
         decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(10),
         border: Border.all(color: Colors.black12)
        ),
         child: Column(
          children: [

           Row(
            children: [
            Icon(Icons.date_range),
            SizedBox(width: 10,),
            UIText(title: "rango de fecha", size: 20,bold: true,)
             ],
            ),

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

            Row(
              children: [

                Container(
                 padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                 decoration: BoxDecoration(
                 color: const Color.fromARGB(255, 171, 207, 255), 
                 border: Border.all(color: Colors.transparent),
                 borderRadius: BorderRadius.circular(30),
                 ),
                 child: UIText(title: "ultimos 7 dias", bold: true,),
               ),

               SizedBox(width: 10,),

               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                 decoration: BoxDecoration(
                 color: const Color.fromARGB(255, 0, 0, 0), 
                 border: Border.all(color: Colors.transparent),
                 borderRadius: BorderRadius.circular(30),
                 ),
                 child: UIText(title: "este mes", bold: true, color: Colors.white,)
               ),
              ],
            )


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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 217, 217, 218), 
            border: Border.all(color: Colors.black87),
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