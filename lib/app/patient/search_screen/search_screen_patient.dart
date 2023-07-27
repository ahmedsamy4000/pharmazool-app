import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pharmazool/app_cubit/cubit.dart';
import 'package:pharmazool/app_cubit/states.dart';
import 'package:pharmazool/app/patient/category_screens/MedicineScreen.dart';
import 'package:pharmazool/components/utils/app_theme_colors.dart';
import 'package:pharmazool/components/utils/assets_images_path.dart';
import 'package:pharmazool/components/utils/media_query_values.dart';
import 'package:pharmazool/components/widgets/loadingwidget.dart';

class SearchScreenPatient extends StatefulWidget {
  const SearchScreenPatient({super.key});

  @override
  State<SearchScreenPatient> createState() => _SearchScreenPatientState();
}

class _SearchScreenPatientState extends State<SearchScreenPatient> {
  @override
  Widget build(BuildContext context) {
    var searchcontroller =
        TextEditingController(text: AppCubit.get(context).searcher);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    AppCubit.get(context).searcher = '';
                    Navigator.pop(context);
                  }),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                TextField(
                  onSubmitted: (value) {
                    AppCubit.get(context).getsearchmedicine(value);
                  },
                  controller: searchcontroller,
                  style: TextStyle(
                    fontSize: context.height * 0.015,
                  ),
                  decoration: InputDecoration(
                    hintText: 'بحث',
                    hintStyle: TextStyle(
                      color: const Color(0xFF949098),
                      fontSize: context.height * 0.018,
                    ),
                    filled: true,
                    fillColor: AppColors.kGreyColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: context.height * 0.03,
                      color: const Color(0xFF949098),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        AppCubit.get(context).getPostImage2();
                      },
                      child: Image.asset(
                        scan,
                        color: Colors.black,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ConditionalBuilder(
                    fallback: (context) => Container(
                          color: Colors.white,
                          child: loading(),
                        ),
                    condition: state is! GetMedicinesByIdLoadingState,
                    builder: (context) {
                      return Expanded(
                          child: ListView.separated(
                        separatorBuilder: (context, _) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          return medicineItem(
                              AppCubit.get(context).searchedmedicines[index],
                              context);
                        },
                        itemCount:
                            AppCubit.get(context).searchedmedicines.length,
                      ));
                    })
              ]),
            ),
          );
        });
  }
}
