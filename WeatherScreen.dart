// ignore: file_names
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/apikey.dart';

import 'addtionalinfo.dart';
import 'hourlyreport.dart';
import 'package:http/http.dart' as http;


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  

  Future<Map<String,dynamic>> getCurrentWeather() async{
    try {
       String cityname = 'India';
    final res = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$cityname,&APPID=$apiKey')
    );
      final data = jsonDecode(res.body);
      if(data['cod']!='200'){
        throw 'An unexpected error occured';

      }
    
        //  data['list'][0]['main']['temp'];
         return data;
     
     
    } catch (e) {
      throw e.toString();
      
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Weather App',
        style: TextStyle(fontWeight: FontWeight.bold),
        ),
        shape: const BeveledRectangleBorder(),
        backgroundColor: Colors.black,
        actions:  [IconButton(onPressed: () {
          setState(() {
            
          });
        }, 
        icon: const  Icon(Icons.refresh_outlined),
        
        ),
        ],
        
      ),

      body: FutureBuilder(
        future:getCurrentWeather(),
        builder:(context, snapshot) {
          // snapshot is a class that allows you to handle the states in your app 
          //the 1.) loading state 2.) error state 3.)data state
          // to watit for loading the data 
          if(snapshot.connectionState == ConnectionState.waiting){
            return const  Center(child: CircularProgressIndicator.adaptive());
          }
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          }
          final data = snapshot.data!;
          
          final currentTemp = data['list'][0]['main']['temp'];
          final currentsky = data['list'][0]['weather'][0]['main'];
          final pressure =  data['list'][0]['main']['pressure'];
          final humidity =  data['list'][0]['main']['humidity'];
          final windspeed = data['list'][0]['wind']['speed'];
          final newicon = data['list'][1]['weather'][0]['main'];

          // to get the icons displayed on the main tab
           geticon(){
            if(currentsky == "Snow"){
              return Icons.snowing;
            }
             if(currentsky == "Clear"){
              return Icons.sunny;
            }
             if(currentsky == "Clouds"){
              return Icons.cloud;
            }
             if(currentsky == "Rain"){
              return Icons.water_drop_outlined;
            }
            

          }
          getnewicon(){
            for(int i = 1;i<5;i++){
              if(data['list'][i+1]['weather'][0]['main'] == 'Snow'){
                return Icons.snowing;
              }
               if(data['list'][i+1]['weather'][0]['main']== 'Clear'){
                return Icons.sunny;
              }
               if(data['list'][i+1]['weather'][0]['main']== 'Clouds'){
                return Icons.cloud;
              }
              //  if(data['list'][i+1]['weather'][0]['main']== 'Rain'){
              //   return Icons.water_drop_outlined;
              // }


            }
          }





          return Padding(
            padding:const  EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // main box
                SizedBox(
                  // taking the max amount of the width possible 
                  width: double.infinity,
                  child: Card(
                    elevation:10,
                    
                    // surfaceTintColor: Colors.amberAccent,
                    
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter:ImageFilter.blur(sigmaX: 3,sigmaY:3) ,
                        child:  
                        Column(
                          children: [
                           const  SizedBox(height:15,),
                            Text('$currentTemp k', 
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                      
                            const SizedBox(height:15,
                            ), 
          
                           Icon(
                          
                            // currentsky == 'Clouds' || currentsky == 'Rain'
                            //   ? Icons.cloud
                            //   : Icons.sunny,
                               geticon(),
                            size: 55 ,),
                           const  SizedBox(height: 15),
                            Text(currentsky, 
                            style: 
                            const TextStyle(fontSize: 25
                        ),
                        ),
                        const SizedBox(height: 14,)                       
                          ], 
                        ),
                      ),
                    ),
                  ),
                ),
              
                // used for spacing between the boxes
                const SizedBox(height: 20),
               const Text('Weather Forecast',
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 22,
               ),
               
               ),
                const SizedBox(height: 14),
          
                // additional info  
                //  SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for(int i =0 ; i<30 ; i++)
                //       Hourlyforecastwidget(
                //         time:  data['list'][i+1]['dt'].toString(),

                //         icoon:
                //          data['list'][i+1]['weather'][0]['main'] != 'Clouds'&&data['list'][i+1]['weather'][0]['main'] != 'Rain' 
                //            ? Icons.cloud
                //           : Icons.sunny,
                                                
                                   
                //         value: '20.23',
                //         ),
                      
                      
                       
                //       // Hourlyforecastwidget(),
                //       // Hourlyforecastwidget(),
                //       // Hourlyforecastwidget(),
          
                //     ],
                //   ),
                // ),

                SizedBox(
                  height: 130,
                  
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context,index)
                  { 
                    final hourlyforecast = data['list'][index +1];
                    final hourlysky = data['list'][index+1]['weather'][0]['main'] ;
                    return Hourlyforecastwidget(
                      time: hourlyforecast['dt'].toString(),
                       value: hourlyforecast['main']['temp'].toString(),
                        icoon: 
                          hourlysky != 'Clouds' && hourlysky != 'Rain' 
                             ? Icons.cloud
                            : Icons.sunny,
                        );
                  },
                  ),
                ),


                const SizedBox(height: 20),
                const Text('Additional information',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
                ),
                 const SizedBox(height: 16),            // additional info 
          
                 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:  [
                
                   Additionalinformation(icon: Icons.water_drop,label: 'Humidity',value: humidity.toString(),),
                   Additionalinformation(icon: Icons.air_outlined,label:'wind speed' ,value: windspeed.toString(),),
                   Additionalinformation(icon: Icons.beach_access,label: 'Pressure',value: pressure.toString(),),
          
          
                  ],
                ),
                
                
              ],
            ),
          );
        },
      ),
      );

  
    
  }
}


