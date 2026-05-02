
import 'package:flutter/material.dart';

class CardClasificationWidget extends StatelessWidget {
  const CardClasificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: Card(
          elevation: 20,
          color: const Color.fromARGB(255, 166, 168, 248),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.looks_one_sharp),
                    SizedBox(width: 10,),
                    Text("clasificacion", 
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: 
                      FontWeight.bold),
                      textAlign: TextAlign.start,
                      ),
                  ],
                ),
      
                SizedBox(height: 20,),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Card(
                        
                        borderOnForeground: true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.traffic),
                              Text("treffic & road")
                            ],
                                                        
                          ),
                        ),
                      ),
                    ),
              
                    
              
              
              
              
                    Expanded(child: 
                     Card(
                        
                        borderOnForeground: true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.warning),
                              Text("public harzard")
                            ],
                                                        
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Card(
                        
                        borderOnForeground: true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.power),
                              Text("utility / infra")
                            ],
                                                        
                          ),
                        ),
                      ),
                    ),
              
                    
              
              
              
              
                    Expanded(child: 
                     Card(
                        
                        borderOnForeground: true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.question_mark_rounded),
                              Text("other")
                            ],
                                                        
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              
                
              ],
            ),
          )
        )
        ),
    );
  }
}