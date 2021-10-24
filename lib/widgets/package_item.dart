import 'dart:io';

import 'package:flutter/material.dart';
import 'package:innovers_exam/utils/styles.dart';
import 'package:innovers_exam/widgets/clicable_widgets.dart';

class PackageItem extends StatelessWidget {
  final File file;
  final String itemName;
  final String count;
  final String weight;
  final String description;
  final Function() onPressed;

  const PackageItem(
      {Key? key,
      required this.file,
      required this.itemName,
      required this.count,
      required this.weight,
      required this.onPressed,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: Corners.smBorder,
              child: Image.file(
                file,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(itemName),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Count",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                              Text(
                                                count,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(
                                        color: Colors.blue,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Total Weght",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                              Text(
                                                weight.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //Spacer(),
                            Flexible(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.mode_edit),
                                    Clickable(
                                        onPressed:onPressed,
                                        child: Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(description),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
