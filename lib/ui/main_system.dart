import 'package:early_warning_system/api/notification_service.dart';
import 'package:early_warning_system/ui/components/background_view.dart';
import 'package:early_warning_system/ui/components/foreground_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainSystem extends StatelessWidget {
  const MainSystem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: Container(
        child: Stack(
          children: [
            BackgroundView(),
            ForegroundView(),
          ],
        ),
        decoration: BoxDecoration(color: Colors.white),
      ),
      providers: [
        ChangeNotifierProvider(
          create: (_) => NotificationService(),
        ),
      ],
    );
  }
}
