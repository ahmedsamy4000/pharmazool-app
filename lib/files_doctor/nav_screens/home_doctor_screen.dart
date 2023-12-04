import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pharmazool/app_cubit/states.dart';
import 'package:pharmazool/app/patient/search_screen/search_bar.dart';
import 'package:pharmazool/constants_widgets/main_widgets/constants.dart';

import 'package:pharmazool/constants_widgets/utils/media_query_values.dart';
import 'package:pharmazool/constants_widgets/main_constants.dart';

import 'package:pharmazool/files_doctor/medicine_screen_doctor.dart';

import 'package:pharmazool/files_doctor/nav_screens/search_screen.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../app_cubit/cubit.dart';

class HomeScreenDoctor1 extends StatelessWidget {
  const HomeScreenDoctor1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: state is! GetDoctorGroubListLoadingState,
          fallback: (context) {
            return const Center(child: CircularProgressIndicator());
          },
          builder: (context) {
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Container(
                      height: 140,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/logo_11zon_low.png'),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  SearchBar(() {
                    cubit.getsearchmedicine('');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchScreenDoctor()));
                  }),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 130,
                        ),
                        itemBuilder: (context, index) {
                          return homeGridViewDoctor(homelist[index], context);
                        },
                        itemCount: homelist.length,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

homeGridViewDoctor(HomeIconsModel homeIconModel, BuildContext context) {
  return InkWell(
    onTap: () {
      mycategorymodel = homeIconModel;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MedicineScreenDoctor(
                  int.parse(homeIconModel.genericid.toString()))));
      AppCubit.get(context).getMedicinesByID(id: homeIconModel.genericid!);
    },
    child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: context.height * 0.1,
              width: context.height * 0.1,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                homeIconModel.icon.toString(),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: context.height * 0.0035,
            ),
            AutoSizeText(
              homeIconModel.title.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  // fontSize: context.height * 0.017,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Schyler'),
            ),
            SizedBox(
              height: context.height * 0.02,
            ),
          ],
        ),
      ),
    ),
  );
}
