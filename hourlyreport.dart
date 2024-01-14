import 'package:flutter/material.dart';

class Hourlyforecastwidget extends StatelessWidget {
  final String time;
  final icoon;
  final String value;
  const Hourlyforecastwidget({
    super.key,
    required this.time,
    required this.icoon,
    required this.value
});

  @override
  Widget build(BuildContext context) {
    return Card(
                    elevation: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          children:  [
                           const SizedBox(
                              height:10,
                              width: 100,
                            ),
                            Text(time,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                                                     
                            ),
                            maxLines: 1,
                            overflow:TextOverflow.ellipsis
,
                            ),
                            const SizedBox(
                              height:8                        
                            ),
                            Icon(icoon),
                           const  SizedBox(
                              height:8,
                              width: 100,
                            ),
                            Text(value),
                           const  SizedBox(
                              height:10
                              
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
  
  }
}