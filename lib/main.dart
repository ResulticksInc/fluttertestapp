import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:refluttersdk/refluttersdk.dart';

void main() {

  runApp(const MyApp());
}
final _refluttersdkPlugin =Refluttersdk();
late var buildContext;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Plugin Test App',
      routes: {
        '/CareerPage': (BuildContext ctx) => const CareerPage(),
        "/CertificationPage": (BuildContext ctx) => const CertificationPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }

}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  deeplinkHandler(){
    /*
    * App screen Navigations via link and notifications
    */
    _refluttersdkPlugin.listener((data) {
      print("Deeplink Handler form dashboard!!!") ;
      print("Deeplink Data dashboard :: $data") ;
      var deeplinkData = jsonDecode(data);
      var customParams = deeplinkData['customParams'];
      screenNavigator(jsonDecode(customParams)['screenName'],jsonDecode(customParams)['data']);
      _refluttersdkPlugin.deepLinkDataReset();
    });
  }
  screenNavigator(var screenName,var data){
    switch(screenName){

      case "CareerPage":{
        if(data!=null){
          Navigator.pushNamed(buildContext, '/CareerPage',arguments: data);
        }
        else {
          Navigator.pushNamed(buildContext, '/CareerPage');
        }
        break;
      }
      case "CertificationPage":{
        if(data!=null){
          Navigator.pushNamed(buildContext, '/CertificationPage',arguments: data);
        }
        else {
          Navigator.pushNamed(buildContext, '/CertificationPage');
        }
        break;
      }

      default:{
        print("ScreenName is not defined!!!");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    deeplinkHandler();
    debugPrint('Build method called!!');
    buildContext = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin Test App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:  Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/CertificationPage');
                },
                child: const Text('Page-1'),
            ),

            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/CareerPage');
                },
                child: const Text('Page-2'),
            ),
          ],
        ),
      ),
    );
  }
}

class CertificationPage extends StatelessWidget {
  const CertificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:  const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Text('Page-1')
          ],
        ),
      ),
    ) ;
  }
}

class CareerPage extends StatelessWidget {
  const CareerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:  const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Page-2')
          ],
        ),
      ),
    ) ;
  }
}
