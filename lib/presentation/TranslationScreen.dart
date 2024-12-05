import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googletranslate/buisness_logic_layer/translaotion_cubit.dart';
import 'package:googletranslate/buisness_logic_layer/translation_state.dart';
class Translationscreen extends StatefulWidget {
  final String? translateLanguage;
  const Translationscreen({super.key, this.translateLanguage});

  @override
  State<Translationscreen> createState() => _TranslationscreenState();
}

class _TranslationscreenState extends State<Translationscreen> {
  final TextEditingController _text = TextEditingController();
  String translatedtext = "";
  late TranslationCubit translationCubit;

  String fromLanguage = 'en';
  String toLanguage ='';

  @override
  void initState() {
    super.initState();
    translationCubit = BlocProvider.of<TranslationCubit>(context);
    toLanguage = widget.translateLanguage ?? 'tr';

    _text.addListener(() {
      final inputText = _text.text;
      if (inputText.isNotEmpty) {
        translationCubit.fetchTranslatedText(inputText, fromLanguage, toLanguage);
      } else {
        setState(() {
          translatedtext = "";
        });
      }
    });
  }

  void _swapLanguages() {
    setState(() {
      final temp = fromLanguage;
      fromLanguage = toLanguage;
      toLanguage = temp;

      if (_text.text.isNotEmpty) {
        translationCubit.fetchTranslatedText(
          _text.text,
          fromLanguage,
          toLanguage,
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
          SizedBox(height: 80,),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: Container(
              // width: 340,
              // height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(fromLanguage.toUpperCase(),
              style: const TextStyle(fontSize: 24, color: Colors.grey),),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: _swapLanguages,
                  icon: const Icon(Icons.compare_arrows),
                  color: Colors.blue,
                  iconSize: 30,
                ),
                const SizedBox(width: 20),
                Text(
                  toLanguage.toUpperCase(),
                  style: const TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ],),
            ),
          ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _text,
              decoration: const InputDecoration(
                hintText: "Enter Text",
                hintStyle: TextStyle(color: Colors.grey,
                fontSize: 30,
                fontWeight: FontWeight.bold
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              cursorColor: Colors.black,
            ),
            ),
const SizedBox(height: 160),
Expanded (
  child:Container(
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    child: BlocBuilder<TranslationCubit, TranslaionState>(builder: (context, state){
      if(state is TranslationLoading){
        return const Center(child: CircularProgressIndicator(color: Colors.black,),);
      }
      else if( state is TranslationLoaded){
    translatedtext = state.translation ?? "Failed";
      }
      else if( state is TranslationError){
        translatedtext = "Error: ${state.message}";
      }

      return Align(
        alignment: Alignment.topLeft,
        child: Text(
          translatedtext,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }),

  ),
)
        ],),
      ),
    );
  }
}
