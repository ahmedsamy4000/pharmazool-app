import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmazool/api_dio/services_paths.dart';
import 'package:pharmazool/app_cubit/cubit.dart';
import 'package:pharmazool/app_cubit/states.dart';
import 'package:pharmazool/constants_widgets/utils/media_query_values.dart';
import 'package:pharmazool/constants_widgets/main_widgets/loadingwidget.dart';
import 'package:pharmazool/app/patient/category_screens/locationinfo.dart';
import 'package:pharmazool/constants_widgets/main_constants.dart';
import 'package:pharmazool/mymodels/pharmacy_model.dart';
import '../../../constants_widgets/utils/app_theme_colors.dart';
import '../nav_screens/BottomNavBarWidget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../files_doctor/nav_screens/floating_botton.dart';
import 'map_screen.dart';

class PharmasyScreen extends StatelessWidget {
  const PharmasyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
                      padding: const EdgeInsetsDirectional.only(top: 20.0),
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
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Container(
                                  width: context.width * 0.9,
                                  height: context.height * .76,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      // textDirection: TextDirection.rtl,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ConditionalBuilder(
                                          condition: state
                                                  is! GetPharmaciesLoadingState &&
                                              state
                                                  is! GetFilteredPharmaciesLoadingState,
                                          fallback: (context) => Container(
                                            color: Colors.white,
                                            child: loading(),
                                          ),
                                          builder: (context) {
                                            return SizedBox(
                                              width: double.infinity,
                                              height: context.height * .7,
                                              child: ListView.separated(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemBuilder: (BuildContext
                                                            context,
                                                        int index) =>
                                                    pharmacyItem(
                                                        cubit.checkarea == false
                                                            ? cubit.pharmacyList[
                                                                index]
                                                            : cubit.filteredpharmacyList[
                                                                index],
                                                        context),
                                                itemCount: cubit.checkarea ==
                                                        false
                                                    ? cubit.pharmacyList.length
                                                    : cubit.filteredpharmacyList
                                                        .length,
                                                separatorBuilder:
                                                    (BuildContext context,
                                                            int index) =>
                                                        SizedBox(
                                                  height: context.height * 0.05,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
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
            floatingActionButton: FloatingBotton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavWidget(
              cubit: cubit,
            ),
          );
        });
  }
}

Widget pharmacyItem(PharmacyModel model, context) {
  String? phoneNumper = model.phone;
  return InkWell(
    onTap: () {
      name = model.name;
      address = model.address;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MapScreen(model)));
      pharmacyhistory.add(
        PharmacyModel(
            name: model.name,
            block: DateTime.now().hour.toString(),
            street: DateTime.now().minute.toString()),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27),
        color: const Color(0xffB8F2EE),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        model.name.toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      AutoSizeText(
                        model.address.toString(),
                        maxLines: 3,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    child: IconButton(
                  icon: const Icon(
                    Icons.phone_rounded,
                    size: 30,
                  ),
                  onPressed: () async {
                    if (await canLaunch('tel:$phoneNumper')) {
                      await launch('tel:$phoneNumper');
                    }
                  },
                )),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
