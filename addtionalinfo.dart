import 'package:flutter/material.dart';

class Additionalinformation extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const Additionalinformation({
    super.key,
    required this.icon,
    required this.label,
    required this.value,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // 1st one 
      children:  [
        Icon(icon,size: 35,),
        const SizedBox(height: 10,),
         Text(label,style: const TextStyle(fontSize: 18),),
         Text(value,style: const TextStyle(fontSize: 18)),
      ],
    );
    


  }
}