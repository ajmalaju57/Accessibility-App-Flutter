import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accessibility_app/ui/components/app_text.dart';
import 'package:accessibility_app/ui/components/app_text_field.dart';
import 'package:accessibility_app/ui/pages/accessibility/cubit/thememode_cubit.dart';
import 'package:accessibility_app/ui/pages/accessibility/cubit/thememode_state.dart';
import 'package:accessibility_app/ui/pages/home/cubit/home_page_cubit.dart';
import 'package:accessibility_app/utils/colors.dart';
import 'package:accessibility_app/utils/constants.dart';
import 'package:accessibility_app/utils/extensions/margin_ext.dart';
import 'package:accessibility_app/utils/shared/page_navigator.dart';

TextEditingController selectedLanguage = TextEditingController();
TextEditingController selectedFont = TextEditingController();

class AccessibilityPage extends StatelessWidget {
  const AccessibilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const AppText("Accessibility Page", size: 20),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppText("Dark Mode", size: 20),
                  Switch(
                    onChanged: (value) {
                      BlocProvider.of<ThemeCubit>(context).toggleTheme();
                    },
                    value:
                        BlocProvider.of<ThemeCubit>(context).state.themeMode ==
                            ThemeModeEnum.dark,
                    inactiveThumbColor: primaryColor,
                    thumbColor: const MaterialStatePropertyAll(colorWhite),
                    trackOutlineColor:
                        const MaterialStatePropertyAll(Colors.transparent),
                  ),
                ],
              ),
              AppTextField(
                  controller: selectedFont,
                  label: "Font Style",
                  hint: "Select Font Style",
                  onTap: () {
                    _showBottom(context, "Select Font Style");
                  }),
              AppTextField(
                  controller: selectedLanguage,
                  label: "Language",
                  hint: "Select Language",
                  onTap: () {
                    _showBottom(context, "Select Language");
                  }),
            ]),
          ),
        );
      },
    );
  }
}

void _showBottom(
  BuildContext ctx,
  String type,
) {
  showModalBottomSheet(
    context: ctx,
    backgroundColor: primaryColor,
    builder: (ctx) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: 400,
          decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Column(
              children: [
                Center(
                  child: AppText(type, size: 16, color: colorWhite),
                ),
                10.hBox,
                Expanded(
                  child: type == "Select Font Style"
                      ? ListView.separated(
                          itemCount: fonts.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            final dataFonts = fonts[index];
                            return GestureDetector(
                              onTap: () {
                                BlocProvider.of<ThemeCubit>(context)
                                    .changeFont(dataFonts['code']);
                                selectedFont.text = dataFonts['name'];
                                Screen.closeDialog(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: AppText(dataFonts['name'],
                                    color: colorWhite),
                              ),
                            );
                          },
                        )
                      : ListView.separated(
                          itemCount: languages.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            final dataLanguages = languages[index];
                            return GestureDetector(
                              onTap: () {
                                language.text = dataLanguages['code'];
                                selectedLanguage.text = dataLanguages['name'];
                                Screen.closeDialog(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: AppText(dataLanguages['name'],
                                    color: colorWhite),
                              ),
                            );
                          },
                        ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
