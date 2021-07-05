import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/src/utils/snackbar_helper.dart';
import 'package:places/src/widgets/input_name.dart';
import 'package:places/src/widgets/shared/app_colors.dart';
import 'dart:math' as Math;

void showChangeNameBottomSheet(BuildContext context,Function(String value) callback) {
  final TextEditingController controller = TextEditingController();
  showModalBottomSheet(
      context: context,
      elevation: 12,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Update Name",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding:  EdgeInsets.only(bottom: Math.max(0,MediaQuery.of(context).viewInsets.bottom - MediaQuery.of(context).size.height*.1)),
              child: InputName(controller: controller),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    child: ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide.none),
                          padding: EdgeInsets.all(18.0),
                          primary: primaryColor,
                        ),
                        onPressed: () {
                          // validation logic, validate the name
                          if(controller.text.trim().length<4){
                            showSnackBar(context, "Name must be at least 4 characters long");
                            return;
                          }
                          Navigator.of(context).pop();
                          callback(controller.text.trim());
                        },
                        child: Text("Done"),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 12)
          ],
        );
      });
}
