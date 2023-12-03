import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accessibility_app/ui/components/app_text.dart';
import 'package:accessibility_app/ui/pages/home/cubit/home_page_cubit.dart';
import 'package:accessibility_app/utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          final cubit = context.read<HomePageCubit>();
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              centerTitle: true,
              title: const AppText("Home", size: 20),
            ),
            body: Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: AppText(
                      cubit.speechToText.isListening
                          ? "listening..."
                          : cubit.speechEnabled
                              ? "Tap the microphone to start listening..."
                              : "Speech not available",
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        cubit.wordsSpoken,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  if (cubit.speechToText.isNotListening &&
                      cubit.wordsSpoken.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 100,
                      ),
                      child: GestureDetector(
                          onTap: () =>
                              cubit.speak(cubit.wordsSpoken, language.text),
                          child: const Icon(
                            Icons.spatial_audio_off_rounded,
                            color: primaryColor,
                          )),
                    )
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: cubit.speechToText.isListening
                  ? cubit.stopListening
                  : cubit.startListening,
              tooltip: 'Listen',
              backgroundColor: primaryColor,
              child: Icon(
                cubit.speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
