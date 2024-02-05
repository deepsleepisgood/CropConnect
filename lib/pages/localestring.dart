import 'package:get/get.dart';

class LocalString extends Translations{
  @override
  Map<String,Map<String,String>> get keys => {
    'en_US':{
        'hello':'Welcome',
        'lang':'Language',
    },
    'hi_IN':{
      'hello':'स्वागत',
      'lang':'भाषा',
    },
  };
}