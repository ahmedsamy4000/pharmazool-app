import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharmazool/api_dio/constants.dart';
import 'package:pharmazool/app_cubit/cubit.dart';
import 'package:pharmazool/app_cubit/states.dart';
import 'package:pharmazool/app/patient/nav_screens/home_screen.dart';
import 'package:pharmazool/components/constants.dart';
import 'package:pharmazool/components/utils/assets_images_path.dart';
import 'package:pharmazool/components/utils/media_query_values.dart';
import 'package:pharmazool/mymodels/medicine_model.dart';
import 'package:pharmazool/mymodels/pharmacy_model.dart';
import 'package:pharmazool/components/widgets/loadingwidget.dart';

class HeartCare extends StatefulWidget {
  const HeartCare({Key? key}) : super(key: key);

  @override
  _HeartCareState createState() => _HeartCareState();
}

class _HeartCareState extends State<HeartCare> {
  @override
  Widget build(BuildContext context) {
    var searchcontrolled =
        TextEditingController(text: AppCubit.get(context).searcher);
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: const Text("Heart Care"),
              centerTitle: true,
            ),
            body: Scaffold(
                body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8), // Border width
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(48), // Image radius
                              child: Image.asset(heartCare, fit: BoxFit.cover),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40.0,
                            child: TextField(
                              controller: searchcontrolled,
                              onSubmitted: (value) {
                                cubit.getMedicinesByID(
                                    id: 12, search: searchcontrolled.text);
                              },
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              decoration: InputDecoration(
                                hintText: 'search',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                                filled: true,
                                fillColor: Colors.teal,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                suffixIcon: SvgPicture.asset(
                                  'assets/icons/search.svg',
                                  color: Colors.white,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ConditionalBuilder(
                      condition: state is! GetMedicinesByIdLoadingState,
                      fallback: (context) => loading(),
                      builder: (context) {
                        return SizedBox(
                          width: double.infinity,
                          height: context.height * .64,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return pharmacymedicineitem(
                                  cubit.medicinesbyId[index]);
                            },
                            itemCount: cubit.medicinesbyId.length,
                          ),
                        );
                      }),
                ],
              ),
            )));
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
              width: 60,
              height: 60,
              child: Image.network(
                model.image!.toString().contains('string')
                    ? 'https://resize.indiatvnews.com/en/resize/newbucket/730_-/2021/12/omicron-med-1639726841.jpg'
                    : model.image.toString(),
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Text('loading failed');
                },
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
                  AppCubit.get(context).deletepharmacymedicine(
                      int.parse(model.id.toString()),
                      int.parse(pharmamodel!.id.toString()),
                      context,
                      12);
                } else {
                  AppCubit.get(context).addpharmacymedicine(
                      int.parse(model.id.toString()),
                      int.parse(pharmamodel!.id.toString()),
                      context,
                      12);
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
