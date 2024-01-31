import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:refluttersdk/refluttersdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/CertificationPage': (BuildContext ctx) => const CertificationPage(),
        '/FormPage' : (BuildContext ctx) => const FormPage(),
        '/UserDashboard' : (BuildContext ctx) => const UserDashboard(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const MyHomePage(),
    );
  }

}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  StreamSubscription<String>? streamSubscription;
   StreamController<String> controllerData = StreamController<String>();
   StreamController<String> controllerInitSession = StreamController<String>();



  @override
  void initState() {
    super.initState();
    // deeplinkHandler();
    getFcmToken();
    getDeeplinkData();
  }
  deeplinkHandler(){
    /*
    * App screen Navigation's via link and notifications
    */
    _refluttersdkPlugin.listener((data) {
      debugPrint("Deeplink Handler form dashboard!!!") ;
      debugPrint("Deeplink Data dashboard :: $data") ;
      var deeplinkData = jsonDecode(data);
      var customParams = deeplinkData['customParams'];
      screenNavigator(jsonDecode(customParams)['screenName'],jsonDecode(customParams)['data']);
    });
  }

   getDeeplinkData(){
    /*
    * Receive deeplink data using stream
    */
     streamSubscription = _refluttersdkPlugin.listenDeeplinkData().listen((data) async {
       try{
         debugPrint('DeepLink Listener :: $data');
         controllerData.sink.add((data.toString()));
         var deeplinkData = jsonDecode(data);
         var customParams = deeplinkData['customParams'];
         screenNavigator(jsonDecode(customParams)['screenName'],jsonDecode(customParams)['data']);
       }catch(e){
         debugPrint('$e');
       }
     });
   }

  screenNavigator(var screenName,var data){
    switch(screenName){

      case "CareerPage":{
        if(data!=null){
          Navigator.pushNamed(context, '/CareerPage',arguments: data);
        }
        else {
          Navigator.pushNamed(context, '/CareerPage');
        }
        break;
      }
      case "CertificationPage":{
        if(data!=null){
          Navigator.pushNamed(context, '/CertificationPage',arguments: data);
        }
        else {
          Navigator.pushNamed(context, '/CertificationPage');
        }
        break;
      }
      case "FormPage":{
        if(data!=null){
          Navigator.pushNamed(context, '/FormPage',arguments: data);
        }
        else {
          Navigator.pushNamed(context, '/FormPage');
        }
        break;
      }
      case "UserDashboard":{
        if(data!=null){
          Navigator.pushNamed(context, '/UserDashboard',arguments: data);
        }
        else {
          Navigator.pushNamed(context, '/UserDashboard');
        }
        break;
      }

      default:{
        debugPrint("ScreenName is not defined!!!");
      }
    }
  }
getFcmToken(){
  FirebaseMessaging.instance.getToken().then((newToken) {
    debugPrint("FCM token: $newToken ");
    _refluttersdkPlugin.updatePushToken(newToken!);
    Map userData = {
      "userUniqueId": 'user@gmail.com',
      // * unique id could be email id, mobile no, or BrandID defined id like Customer hash, PAN number
      "name": "",
      "age": "",
      "email": "",
      "phone": "",
      "gender": "",
      "profileUrl": "",
      "dob": "",
      "education": "",
      "employed": true,
      "married": false,
      "deviceToken": newToken,
      // * FCM Token
    };
    _refluttersdkPlugin.sdkRegisteration(userData);
  });
}


  @override
  Widget build(BuildContext context) {


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
                getDeeplinkData();
              },
              child: const Text('Get deeplink data'),
            ),
            ElevatedButton(
                onPressed: (){
                  _refluttersdkPlugin.screentracking('Page-1');
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
            StreamBuilder<String>(
              stream: controllerData.stream,
              initialData: null,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  /// handle deeplink data
                  return Container();
                } else {
                  return Container();
                }
              },
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
           Text('Certification Page')
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
            Text('Career Page')
          ],
        ),
      ),
    ) ;
  }
}
class FormPage extends StatelessWidget {
  const FormPage({super.key});

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
            Text('FormPage')
          ],
        ),
      ),
    ) ;
  }
}
class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

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
            Text('UserDashboard Page')
          ],
        ),
      ),
    ) ;
  }
}
