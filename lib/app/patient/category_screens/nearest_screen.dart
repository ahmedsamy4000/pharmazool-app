import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmazool/app_cubit/cubit.dart';
import 'package:pharmazool/app_cubit/states.dart';
import 'package:pharmazool/app/patient/category_screens/pharmasy_screen.dart';
import 'package:pharmazool/app/patient/nav_screens/BottomNavBarWidget.dart';
import 'package:pharmazool/components/widgets/loadingwidget.dart';
import 'package:pharmazool/files_doctor/nav_screens/floating_botton.dart';
import 'package:pharmazool/components/utils/app_theme_colors.dart';
import 'package:pharmazool/components/utils/media_query_values.dart';

class NearbyPharmacies extends StatelessWidget {
  const NearbyPharmacies({super.key});

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
                                                    is! GetPahrmaciesLoadingState &&
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
                                                          cubit.nearestpharmacies[
                                                              index],
                                                          context),
                                                  itemCount: cubit
                                                      .nearestpharmacies.length,
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                              int index) =>
                                                          SizedBox(
                                                    height:
                                                        context.height * 0.05,
                                                  ),
                                                ),
                                              );
                                            }),
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
