import 'package:flutter/material.dart';

class CardDescription extends StatelessWidget {
  const CardDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
       padding: EdgeInsets.all(8),
        child: Expanded(
          child: Card(
            elevation: 20,
            color: const Color.fromARGB(255, 166, 168, 248),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.looks_two),
                          SizedBox(width: 10,),
                          Text("descripcion", 
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: 
                            FontWeight.bold),
                            textAlign: TextAlign.start,
                            ),
                        ],
                      ),            
                    ],
                  ),
        
                  SizedBox(height: 20,),
              
                 TextField(
                  decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: const Color(0xFFF7F7F7),
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                  color: Color(0xFFD9D9D9),
                  width: 1,
                          ),
                        ),
                  focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                  color: Color(0xFFBDBDBD),
                  width: 1,
                  ),
                  ),
                  )
                 )
                 
                ],
              ),
            )
          )
          ),
      
      ),
    );
  }
}