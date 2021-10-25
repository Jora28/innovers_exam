import 'package:flutter/material.dart';
import 'package:innovers_exam/utils/colors.dart';
import 'package:innovers_exam/utils/styles.dart';
import 'package:innovers_exam/widgets/clicable_widgets.dart';
import 'package:innovers_exam/widgets/input.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SwichedButton extends StatefulWidget {
  final TextEditingController controllerRange;
  final TextEditingController controllerDueTo;
  final String buttonText1;
  final String buttonText2;
  final String title;
  final bool textFildVisibility;

  const SwichedButton(
      {Key? key,
      required this.title,
      required this.controllerRange,
      required this.controllerDueTo,
      required this.buttonText1,
      required this.buttonText2,
      required this.textFildVisibility})
      : super(key: key);

  @override
  _SwichedButtonState createState() => _SwichedButtonState();
}

class _SwichedButtonState extends State<SwichedButton> {
  bool isDueTo = true;
  final _formState = GlobalKey<FormState>();
  dynamic _onSave() async {
    if (!_formState.currentState!.validate()) {
      return;
    }
    _formState.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: Borders.border)),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 24),
            child: Text(
              widget.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: Corners.smBorder,
              color: AppColors.greyDark,
            ),
            height: 55,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Clickable(
                        onPressed: () {
                          setState(() {
                            isDueTo = !isDueTo;
                            FocusScope.of(context).unfocus();
                            widget.controllerDueTo.clear();
                            widget.controllerRange.clear();
                            _onSave();
                          });
                        },
                        child: Center(
                            child: Text(
                          widget.buttonText1,
                          style: Theme.of(context).textTheme.button,
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                    Expanded(
                      child: Clickable(
                        onPressed: () {
                          setState(() {
                            FocusScope.of(context).unfocus();
                            widget.controllerDueTo.clear();
                            widget.controllerRange.clear();

                            isDueTo = !isDueTo;
                          });
                        },
                        child: Center(
                            child: Text(
                          widget.buttonText2,
                          style: Theme.of(context).textTheme.button,
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                  ],
                ),
                AnimatedAlign(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  alignment:
                      isDueTo ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    padding: isDueTo
                        ? EdgeInsets.only(left: 2, right: 22)
                        : EdgeInsets.only(right: 2, left: 22),
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: Corners.smBorder),
                      alignment: Alignment.center,
                      child: Text(
                        isDueTo ? widget.buttonText1 : widget.buttonText2,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: widget.textFildVisibility,
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Form(
                key: _formState,
                child: Row(
                  children: [
                    Expanded(
                      child: AbsorbPointer(
                        absorbing: isDueTo,
                        child: CustumInput(
                            textInputType: TextInputType.number,
                            textInputFormatter:
                                MaskTextInputFormatter(mask: "##/##/####"),
                            controller: widget.controllerRange,
                            hintText:
                                isDueTo ? 'Start date/time:' : 'Start date:',
                            onSaved: (String? newValue) {},
                            validator: (String? value) {}),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: CustumInput(
                        textInputType: TextInputType.number,
                        textInputFormatter: isDueTo
                            ? MaskTextInputFormatter(mask: "##/##/#### | ##:##")
                            : MaskTextInputFormatter(mask: "##/##/####"),
                        controller: widget.controllerDueTo,
                        hintText:
                            isDueTo ? "Due to date/time:" : 'End date/time:',
                        onSaved: (String? newValue) {},
                        validator: (String? value) {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
