import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmazool/api_dio/constants.dart';
import 'package:pharmazool/app_cubit/cubit.dart';
import 'package:pharmazool/app_cubit/states.dart';

import 'package:pharmazool/components/utils/media_query_values.dart';
import 'package:pharmazool/mymodels/pharmacy_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/utils/app_theme_colors.dart';

class MapScreen extends StatefulWidget {
  PharmacyModel model;
  MapScreen(this.model);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Map<String, Marker> markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    markers.clear();
    setState(() {
      final marker = Marker(
        markerId: MarkerId(name!),
        position: LatLng(lat!, long!),
        infoWindow: InfoWindow(title: name, snippet: address, onTap: () {}),
        onTap: () {
          print("Clicked on marker");
        },
      );

      markers[name!] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kGreyColor,
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // title: const Text(''),
      ),
      // floatingActionButton: FloatingBotton(),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                  height: context.height * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.7),
                      borderRadius: const BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(50),
                          bottomEnd: Radius.circular(50)))),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 0.0),
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Column(
                      children: [
                        // Container(
                        //   height: context.height * .01,
                        //   // height: 20,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            width: context.width * 0.9,
                            height: context.height * .798,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                // textDirection: TextDirection.rtl,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Column(
                                    children: [
                                      CardWidget(widget.model),
                                      SizedBox(
                                        height: context.height * 0.05,
                                      ),
                                      Container(
                                        width: context.width * 0.8,
                                        height: context.height * .4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: GoogleMap(
                                          onMapCreated: _onMapCreated,
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(lat!, long!),
                                            zoom: 14.8,
                                          ),
                                          markers: markers.values.toSet(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: context.height * 0.02,
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavWidget(
      //   cubit: cubit,
      // ),
    );
  }
}

class CardWidget extends StatelessWidget {
  PharmacyModel model;
  CardWidget(this.model);
  // bool ExpanasionTouche = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: context.width * 0.8,
        // height: context.height * .25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          color: const Color(0xffB8F2EE),
          // color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: context.width * 0.21,
                      height: context.height * 0.15,
                      child: IconButton(
                        icon: const Icon(
                          Icons.phone_rounded,
                          size: 30,
                        ),
                        onPressed: () async {
                          if (await canLaunch('tel:${model.phone}')) {
                            await launch('tel:${model.phone}');
                          }
                        },
                      )),
                  SizedBox(
                    width: context.width * .025,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AutoSizeText(
                          model.name.toString(),
                          style: const TextStyle(
                              fontSize: 29, fontWeight: FontWeight.bold),
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: AutoSizeText(
                            model.address.toString(),
                            maxLines: 3,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                overflow: TextOverflow.ellipsis),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
