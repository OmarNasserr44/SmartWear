import 'dart:io';
import 'package:ar_smart_wear/Widgets/CustButton.dart';
import 'package:ar_smart_wear/Widgets/ReportWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:height_slider/height_slider.dart';

class BodyMeasurements extends StatefulWidget {
  static const id = "Body Measurements";
  final File image;

  const BodyMeasurements({this.image});
  @override
  _BodyMeasurementsState createState() => _BodyMeasurementsState(image: image);
}

class _BodyMeasurementsState extends State<BodyMeasurements> {
  final File image;
  int height = 170;
  int neck = 0;
  int chest = 0;
  int shoulder = 0;
  bool gotHeight = false;

  _BodyMeasurementsState({this.image});
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Size Report",
          style: GoogleFonts.gloriaHallelujah(fontSize: screenSize.width / 12),
        ),
      ),
      body: SafeArea(
        child: !gotHeight
            ? Center(
                child: Stack(
                  children: [
                    HeightSlider(
                      height: height,
                      onChange: (val) => setState(() => height = val),
                      unit: 'cm', // optional
                      maxHeight: 210,
                      currentHeightTextColor: Colors.red,
                    ),
                    Positioned(
                        left: screenSize.width / 12,
                        top: screenSize.height / 15,
                        child: CustButton(
                          onTap: () {
                            setState(() {
                              gotHeight = true;
                            });
                          },
                          fillColor: Colors.blue,
                          screenSize: screenSize,
                          text: "Next",
                          fontSize: screenSize.width / 14,
                          textColor: Colors.white,
                          heightDiv: screenSize.height / 60,
                          widthDiv: screenSize.width / 120,
                        )),
                  ],
                ),
              )
            : Container(
                height: screenSize.height,
                width: screenSize.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: screenSize.height / 25,
                    ),
                    ReportWidget(
                        screenSize: screenSize,
                        height: height,
                        neck: neck,
                        chest: chest,
                        shoulder: shoulder,
                        image: image),
                    SizedBox(
                      height: screenSize.height / 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustButton(
                          screenSize: screenSize,
                          onTap: () {
                            setState(() {
                              gotHeight = false;
                            });
                          },
                          text: "Remeasure",
                          heightDiv: screenSize.height / 90,
                          widthDiv: screenSize.width / 160,
                          fontSize: screenSize.width / 18,
                        ),
                        SizedBox(
                          width: screenSize.width / 30,
                        ),
                        CustButton(
                          screenSize: screenSize,
                          onTap: () {
                            setState(() {
                              gotHeight = false;
                            });
                          },
                          text: "Try Outfits",
                          heightDiv: screenSize.height / 90,
                          widthDiv: screenSize.width / 160,
                          fontSize: screenSize.width / 18,
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}