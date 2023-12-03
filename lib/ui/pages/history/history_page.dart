import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accessibility_app/ui/components/app_text.dart';
import 'package:accessibility_app/ui/pages/home/cubit/home_page_cubit.dart';
import 'package:accessibility_app/utils/colors.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const AppText("History Page", size: 20),
      ),
      body: BlocProvider(
        create: (context) => HomePageCubit(),
        child: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            final cubit = context.read<HomePageCubit>();
            return Padding(
                padding: const EdgeInsets.all(16.0),
                child: state is HistoryDataLoaded
                    ? state.box.isEmpty
                        ? const Center(child: AppText("No History"))
                        : ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.box.length,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemBuilder: (context, index) {
                              final data = state.box[index];
                              return ListTile(
                                tileColor: primaryColor,
                                leading: AppText(
                                  index + 1,
                                  color: colorWhite,
                                ),
                                title: AppText(
                                  data.wordsSpoken,
                                  size: 15,
                                  color: colorWhite,
                                ),
                                trailing: GestureDetector(
                                    onTap: () => cubit.speak(
                                        data.wordsSpoken, data.languageCode),
                                    child: const Icon(
                                      Icons.spatial_audio_off_rounded,
                                      color: colorWhite,
                                    )),
                              );
                            })
                    : const Center(
                        child: CupertinoActivityIndicator(),
                      ));
          },
        ),
      ),
    );
  }
}
