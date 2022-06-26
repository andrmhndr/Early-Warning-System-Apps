import 'package:early_warning_system/adapter/helper.dart';
import 'package:early_warning_system/adapter/icon_helper.dart';
import 'package:flutter/material.dart';

class DataView extends StatelessWidget {
  const DataView({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title, value;

  imageValidator(String name) {
    if (name == 'Quake') {
      return AssetImage(iconEarthquake);
    }
    if (name == 'Humidity') {
      return AssetImage(iconHumidity);
    }
    if (name == 'Smoke') {
      return AssetImage(iconSmoke);
    }
    if (name == 'Temperature') {
      return AssetImage(iconEarthquake);
    }
  }

  satuan(String name) {
    if (name == 'Quake') {
      return '';
    }
    if (name == 'Humidity') {
      return '%';
    }
    if (name == 'Smoke') {
      return 'ppm';
    }
    if (name == 'Temperature') {
      return 'C';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Image(image: AssetImage(image)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                height: 40,
                child: Image(
                  image: imageValidator(title),
                  color: kPrimaryColor,
                ),
              ),
              Center(
                child: Text('$title'),
              ),
            ],
          ),
          Text('$value ${satuan(title)}'),
        ],
      ),
    );
  }
}
