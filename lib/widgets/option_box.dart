import 'package:flutter/material.dart';

import '../utils/color_utils.dart';

class OptionBox extends StatefulWidget {
  const OptionBox({Key? key, this.optionData, this.isCorrect=false})
      : super(key: key);
  final String? optionData;
   final bool? isCorrect;

  @override
  State<OptionBox> createState() => _OptionBoxState();
}

class _OptionBoxState extends State<OptionBox>
    with AutomaticKeepAliveClientMixin {
  @override
// super.build(BuildContext);
  bool get wantKeepAlive => true;
  Color backgroundColor = Colors.white;
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          


          if (widget.isCorrect == true) {
            setState(() {
              backgroundColor = Colors.green;
            });
          } else {
            setState(() {
              backgroundColor = Colors.red;
            });
          }
        },
        child: Container(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(10)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.optionData!,
              style: TextStyle(color: primaryColor, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
