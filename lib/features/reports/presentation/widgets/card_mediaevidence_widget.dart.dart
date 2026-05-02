import 'package:flutter/material.dart';

class CardMediaEvidence extends StatelessWidget {
  const CardMediaEvidence({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.looks_two),
                        SizedBox(width: 10,),
                        Text("media \nevidence", 
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: 
                          FontWeight.bold),
                          textAlign: TextAlign.start,
                          ),
                      ],
                    ),
    
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Row(
                          children: [
                            Icon(Icons.house),
                            SizedBox(width: 10,),
                            Text("ia vision\nactive", style: TextStyle(fontSize: 15),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
      
                SizedBox(height: 20,),
            
               Padding(
                 padding: const EdgeInsets.only(bottom: 20),
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(20),
                   child: Image.asset(
                   'assets/image.png',
                   fit: BoxFit.cover,
                   ),
                  ),
               )
                
               
              ],
            ),
          )
        )
        ),
    );
  }
}