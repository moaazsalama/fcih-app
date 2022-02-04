import 'package:fcih_app/business_logic/cubit/courses_cubit.dart';
import 'package:fcih_app/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({Key? key, required this.title, required this.keys})
      : super(key: key);
  final String title;

  final int keys;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        return ActionChip(
            onPressed: () {
              BlocProvider.of<CoursesCubit>(context).changeFilter(keys);
            },
            backgroundColor:
                BlocProvider.of<CoursesCubit>(context).filters[keys]!
                    ? Colors.blue
                    : Colors.grey,
            padding: const EdgeInsets.all(2),
            label: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.orientation == Orientation.portrait
                      ? getProportionScreenration(16)
                      : getProportionScreenration(48)),
            ));
      },
    );
  }
}
