import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    // var initializationSettings = const InitializationSettings();

    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  onSelectNotification(String? test)  {print("test1");
    showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('Notification Payload'),
          content: Text('test'),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index){
        return SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () async{
              await Future.delayed(Duration(seconds: (index+1) * 5),() {
                print("test");

                const android = AndroidNotificationDetails('your channel id', 'your channel name',
                    importance: Importance.max, priority: Priority.high);
                const ios = IOSNotificationDetails();
                const detail = NotificationDetails(android: android, iOS: ios);

                flutterLocalNotificationsPlugin.show(
                  index,
                  '단일 Notification',
                  '단일 Notification 내용',
                  detail,
                  payload: 'Hello Flutter',
                );

              });
            },
            child: Text("${(index + 1) * 5} sec"),
          ),
        );
      }
        );
  }
}