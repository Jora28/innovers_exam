import 'package:flutter/material.dart';
import 'package:innovers_exam/main.dart';
import 'package:innovers_exam/utils/colors.dart';
import 'package:innovers_exam/utils/data.dart';
import 'package:innovers_exam/utils/styles.dart';
import 'package:innovers_exam/widgets/clicable_widgets.dart';

class ContactList extends StatelessWidget {
  final double width;
  final Function(Contacts model) onTap;

  const ContactList({required this.width, required this.onTap});

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
            itemCount: ExamData.listContacts.length,
            itemBuilder: (context, index) {
              return Container(
                decoration:
                    BoxDecoration(border: Border(bottom: Borders.border)),
                child: Clickable(
                  onPressed: () {
                    onTap(ExamData.listContacts[index]);
                  },
                  borderRadius: null,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          AssetImage(ExamData.listContacts[index].avatar),
                    ),
                    title: Text(
                      ExamData.listContacts[index].phone,
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(ExamData.listContacts[index].name,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline2),
                    trailing: Icon(Icons.north_west),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
