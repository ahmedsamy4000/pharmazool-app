import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmazool/api_dio/constants.dart';
import 'package:pharmazool/app_cubit/cubit.dart';
import 'package:pharmazool/app_cubit/states.dart';
import 'package:pharmazool/components/utils/app_theme_colors.dart';
import 'package:pharmazool/components/utils/assets_images_path.dart';
import 'package:pharmazool/components/utils/media_query_values.dart';
import 'package:pharmazool/components/widgets/loadingwidget.dart';
import 'package:pharmazool/mymodels/medicine_model.dart';

class SearchScreenDoctor extends StatefulWidget {
  const SearchScreenDoctor({super.key});

  @override
  State<SearchScreenDoctor> createState() => _SearchScreenDoctorState();
}

class _SearchScreenDoctorState extends State<SearchScreenDoctor> {
  var searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            fallback: (context) => Container(
              color: Colors.white,
              child: loading(),
            ),
            condition: state is! GetMedicinesByIdLoadingState,
            builder: (context) {
              return Padding(
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
                        onTap: () {},
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
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (context, index) {
                      return pharmacymedicineitem(
                          AppCubit.get(context).searchedmedicines[index]);
                    },
                    itemCount: AppCubit.get(context).searchedmedicines.length,
                  ))
                ]),
              );
            },
          ),
        );
      },
    );
  }

  Widget pharmacymedicineitem(MedicineModel model) {
    bool isexist(int id) {
      bool exist = false;
      model.pharmacyMedicines!.forEach((element) {
        if (element['pharmacyId'] == int.parse(pharmamodel!.id.toString())) {
          exist = true;
        }
      });
      return exist;
    }

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(70),
              topRight: Radius.circular(70),
              topLeft: Radius.circular(70),
              bottomLeft: Radius.circular(70),
            ),
            side: BorderSide(width: 5, color: Colors.teal)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: SizedBox(
              child: Image(
                image: NetworkImage(model.image.toString() == 'string'
                    ? 'https://static.vecteezy.com/system/resources/previews/000/297/920/original/vector-set-of-various-medicines.jpg'
                    : model.image.toString()),
                fit: BoxFit.cover,
              ),
            ),
            title: Center(
                child: Text(model.name.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18))),
            trailing: Switch(
              value: isexist(int.parse(pharmamodel!.id.toString())),
              onChanged: (value) {
                if (isexist(int.parse(pharmamodel!.id.toString()))) {
                  AppCubit.get(context).deletesearchpharmacymedicine(
                      int.parse(model.id.toString()),
                      int.parse(pharmamodel!.id.toString()),
                      context,
                      searchcontroller.text);
                } else {
                  AppCubit.get(context).addsearchpharmacymedicine(
                      int.parse(model.id.toString()),
                      int.parse(pharmamodel!.id.toString()),
                      context,
                      searchcontroller.text);
                }
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
