import 'package:flutter/material.dart';
import 'package:innovers_exam/utils/colors.dart';
import 'package:innovers_exam/utils/styles.dart';
import 'package:innovers_exam/widgets/clicable_widgets.dart';

class LocationList extends StatelessWidget {
  final double width;
  final List<String> listLocations;
  final Function(String name) onTap;

  const LocationList(
      {required this.width, required this.onTap, required this.listLocations});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: Corners.smBorder,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: Corners.smBorder,
        ),
        height: 222,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: listLocations.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: Borders.border)),
                child: Clickable(
                  onPressed: () {
                    onTap(listLocations[index]);
                  },
                  borderRadius: null,
                  child: ListTile(
                    title: Text(
                      listLocations[index],
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.north_west),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
