import 'package:early_warning_system/adapter/helper.dart';
import 'package:early_warning_system/adapter/icon_helper.dart';
import 'package:early_warning_system/api/notification_service.dart';
import 'package:early_warning_system/ui/components/data_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ForegroundView extends StatefulWidget {
  const ForegroundView({
    Key? key,
  }) : super(key: key);

  @override
  State<ForegroundView> createState() => _ForegroundViewState();
}

class _ForegroundViewState extends State<ForegroundView> {
  final ref = FirebaseDatabase.instance.ref();
  final Uri _url = Uri.parse(
      'https://twitter.com/BPPTKG?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor');
  @override
  void initState() {
    Provider.of<NotificationService>(context, listen: false).initialize();
    Stream<DatabaseEvent> stream = ref.child('data').onValue;
    stream.listen((event) {
      // print(event.snapshot.value);
    });
    super.initState();
  }

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String status = '';
    String humidity = '';
    String temperature = '';
    String smoke = '';
    String quake = '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(left: size.width * 0.15),
          width: size.height,
          margin: EdgeInsets.only(
              top: size.height * 0.10, bottom: size.height * 0.04),
          child: Text(
            "Early Warning \nSystem",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        Container(
          height: 450,
          padding: EdgeInsets.only(bottom: 60),
          margin: EdgeInsets.only(bottom: 20),
          width: size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 4,
                color: kPrimaryColor.withOpacity(0.75),
              ),
            ],
          ),
          child: FirebaseDatabaseQueryBuilder(
            query: ref,
            builder: (context, snapshot, _) {
              // print(snapshot.docs);
              if (snapshot.hasData) {
                status = snapshot.docs[0].child('status').value.toString();
                humidity = snapshot.docs[0].child('humidity').value.toString();
                temperature =
                    snapshot.docs[0].child('temperature').value.toString();
                smoke = snapshot.docs[0].child('smoke').value.toString();
                quake = snapshot.docs[0].child('getar').value.toString();
              }
              return Consumer<NotificationService>(
                builder: (context, model, _) {
                  // if (status == 'Berbahaya') {
                  //   //model.instantNotification();
                  // }
                  Color statusColor = Colors.grey;

                  if (status == 'Normal') {
                    statusColor = normal;
                  } else if (status == 'Waspada') {
                    statusColor = waspada;
                  } else if (status == 'Siaga') {
                    statusColor = siaga;
                  } else if (status == 'Awas') {
                    statusColor = awas;
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 75,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Status'),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 40),
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),
                              child: Text(
                                status,
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      DataView(
                        title: 'Humidity',
                        value: humidity,
                      ),
                      DataView(
                        title: 'Temperature',
                        value: temperature,
                      ),
                      DataView(
                        title: 'Quake',
                        value: quake,
                      ),
                      DataView(
                        title: 'Smoke',
                        value: smoke,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          width: size.width * 0.4,
          height: size.height * 0.075,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              onTap: () {
                _launchUrl();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage(iconBpptkg)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'BPPTKG',
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
