import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pharmazool/api_dio/constants.dart';
import 'package:pharmazool/app_cubit/cubit.dart';
import 'package:pharmazool/app_cubit/states.dart';

import 'package:pharmazool/components/utils/media_query_values.dart';
import 'package:pharmazool/components/widgets/loadingwidget.dart';

import 'package:pharmazool/app/patient/category_screens/locationinfo.dart';
import 'package:pharmazool/mymodels/medicine_model.dart';
import 'package:pharmazool/mymodels/pharmacy_model.dart';

import '../../../components/utils/app_theme_colors.dart';
import '../../../components/utils/assets_images_path.dart';
import '../nav_screens/BottomNavBarWidget.dart';
import '../../../files_doctor/nav_screens/floating_botton.dart';

class MedicineScreen extends StatelessWidget {
  int? id;

  MedicineScreen(this.id);

  @override
  Widget build(BuildContext context) {
    var searchcontrolled =
        TextEditingController(text: AppCubit.get(context).searcher);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);

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
                  AppCubit.get(context).searcher = '';
                  Navigator.pop(context);
                },
              ),
              // title: const Text(''),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                cubit.getPostImage();
              },
              child: Image.asset(
                // cacheHeight: 20,
                scan,
                color: Colors.black,
                fit: BoxFit.scaleDown,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: SingleChildScrollView(
              child: Column(
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
                                Container(
                                  height: context.height * .025,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 20, right: 20),
                                  child: Container(
                                    width: context.width * 0.95,
                                    height: context.height * .7,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // textDirection: TextDirection.rtl,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              margin: const EdgeInsets.only(
                                                  top: 40, bottom: 20),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(27),
                                                color: const Color(0xffB8F2EE),
                                              ),
                                              child: TextField(
                                                controller: searchcontrolled,
                                                style: TextStyle(
                                                  fontSize:
                                                      context.height * 0.015,
                                                ),
                                                onSubmitted: (value) {
                                                  cubit.getMedicinesByID(
                                                      id: id!,
                                                      search: searchcontrolled
                                                          .text);
                                                  cubit.searcher = '';
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'بحث',
                                                  hintStyle: const TextStyle(
                                                    color: Color(0xFF949098),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            27.0),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 20,
                                                    vertical: 8,
                                                  ),
                                                  prefixIcon: Icon(
                                                    Icons.search,
                                                    size: context.height * 0.03,
                                                    color: Color(0xFF949098),
                                                  ),
                                                  suffixIcon: InkWell(
                                                    onTap: () {
                                                      cubit.getPostImage2();
                                                    },
                                                    child: Image.asset(
                                                      // cacheHeight: 20,
                                                      scan,
                                                      color: Colors.black,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ConditionalBuilder(
                                              condition: state
                                                  is! GetMedicinesByIdLoadingState,
                                              fallback: (context) => Container(
                                                color: Colors.white,
                                                child: loading(),
                                              ),
                                              builder: (context) {
                                                return SizedBox(
                                                  width: double.infinity,
                                                  height: context.height * .50,
                                                  child: ListView.separated(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    itemBuilder: (context,
                                                            index) =>
                                                        medicineItem(
                                                            cubit.medicinesbyId[
                                                                index],
                                                            context),
                                                    itemCount: cubit
                                                        .medicinesbyId.length,
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            SizedBox(
                                                      height:
                                                          context.height * 0.03,
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
                                ),
                              ],
                            ),
                            Positioned(
                                top: 0,
                                bottom: context.height * .64,
                                child: Image.asset(
                                    mycategorymodel!.icon.toString())),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavWidget(
              cubit: cubit,
            ),
          );
        });
  }
}

Widget medicineItem(MedicineModel medicineModel, context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(27),
      color: const Color(0xffB8F2EE),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(13.0)),
                clipBehavior: Clip.antiAlias,
                width: 70,
                height: 70,
                child: medicineModel.image!.toString().contains('string')
                    ? const Image(
                        image: AssetImage('assets/images/noimage.png'),
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        medicineModel.image.toString(),
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Center(
                            child: Icon(Icons.image_not_supported_sharp),
                          );
                        },
                      ),

                //Image.network(
                //medicineModel.image!.toString().contains('string')
                //  ? 'https://resize.indiatvnews.com/en/resize/newbucket/730_-/2021/12/omicron-med-1639726841.jpg'
                //: medicineModel.image.toString(),
                //fit: BoxFit.cover,
                //errorBuilder: (BuildContext context, Object exception,
                //  StackTrace? stackTrace) {
                //return const Text('loading failed');
                // },
                //),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    medicineModel.name.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          LocationInfo(medicineModel.id.toString())));
                },
                child: const AutoSizeText(
                  'بحث',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ],
      ),
    ),
  );
}
