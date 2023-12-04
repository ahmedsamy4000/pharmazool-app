import 'package:flutter/material.dart';

import 'package:pharmazool/constants_widgets/utils/assets_images_path.dart';
import 'package:pharmazool/constants_widgets/utils/media_query_values.dart';

import '../../../constants_widgets/utils/app_theme_colors.dart';

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  void Function() function;
  SearchBar(this.function, {super.key});

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        // width: context.width * 0.9,
        height: context.height * 0.1,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: context.height * 0.09,
                    child: TextField(
                      readOnly: true,
                      onTap: () => function(),
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
                            // cacheHeight: 20,
                            scan,
                            color: Colors.black,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
