import 'package:fcih_app/constants/size_config.dart';
import 'package:fcih_app/data/models/course.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseItem extends StatelessWidget {
  final Course course;
  const CourseItem({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        dense: true,
        leading: Text(course.code!.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).textTheme.subtitle1!.color!,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.orientation == Orientation.portrait
                    ? getProportionScreenration(12)
                    : getProportionScreenration(60))),
        title: Text(
          course.name!,
          style: TextStyle(
              fontSize: SizeConfig.orientation == Orientation.portrait
                  ? getProportionScreenration(17)
                  : getProportionScreenration(50),
              //  fontWeight: FontWeight.bold,
              color: Colors.black54),
        ),
        trailing: IconButton(
            onPressed: () {
              launch(course.link!);
            },
            icon: const Icon(Icons.open_in_new)),
      ),
    );
  }
}
