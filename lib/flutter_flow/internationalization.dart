import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() =>
      ['fr', 'en', 'zh_Hans', 'es', 'hi', 'ar', 'pt', 'bn', 'ru', 'ja', 'pa'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? frText = '',
    String? enText = '',
    String? zh_HansText = '',
    String? esText = '',
    String? hiText = '',
    String? arText = '',
    String? ptText = '',
    String? bnText = '',
    String? ruText = '',
    String? jaText = '',
    String? paText = '',
  }) =>
      [
        frText,
        enText,
        zh_HansText,
        esText,
        hiText,
        arText,
        ptText,
        bnText,
        ruText,
        jaText,
        paText
      ][languageIndex] ??
      '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // GPTFlow
  {
    '2but2wgd': {
      'fr': 'Copy response',
      'ar': 'نسخ الرد',
      'bn': 'কপি প্রতিক্রিয়া',
      'en': 'Copy response',
      'es': 'Copiar respuesta',
      'hi': 'प्रतिक्रिया कॉपी करें',
      'ja': '応答をコピーする',
      'pa': 'ਜਵਾਬ ਕਾਪੀ ਕਰੋ',
      'pt': 'Copiar resposta',
      'ru': 'Копировать ответ',
      'zh_Hans': '复制回复',
    },
    'f2m003hr': {
      'fr': 'Posez votre  question...',
      'ar': 'اطبع شيئا...',
      'bn': 'কিছু লেখো...',
      'en': 'Type something...',
      'es': 'Escribe algo...',
      'hi': 'कुछ लिखें...',
      'ja': '何かを入力...',
      'pa': 'ਕੁਝ ਟਾਈਪ ਕਰੋ...',
      'pt': 'Digite algo...',
      'ru': 'Введите что-либо...',
      'zh_Hans': '输入一些东西...',
    },
    'i8qbnj59': {
      'fr': 'Home',
      'ar': 'بيت',
      'bn': 'বাড়ি',
      'en': 'Home',
      'es': 'Hogar',
      'hi': 'घर',
      'ja': '家',
      'pa': 'ਘਰ',
      'pt': 'Lar',
      'ru': 'Дом',
      'zh_Hans': '家',
    },
  },
  // Welcome
  {
    'ccc6nitk': {
      'fr': 'Welcome',
      'ar': 'مرحباً',
      'bn': 'স্বাগত',
      'en': 'Welcome',
      'es': 'Bienvenido',
      'hi': 'स्वागत',
      'ja': 'いらっしゃいませ',
      'pa': 'ਸੁਆਗਤ ਹੈ',
      'pt': 'Bem-vindo',
      'ru': 'Добро пожаловать',
      'zh_Hans': '欢迎',
    },
    'lv845ovi': {
      'fr':
          'Merci de nous rejoindre ! Accédez ou créez votre compte ci-dessous, et commencez votre voyage en Couture!',
      'ar':
          'شكرا لانضمامك الينا! قم بتسجيل الدخول أو إنشاء حسابك أدناه، وابدأ رحلة الأزياء الراقية الخاصة بك!',
      'bn':
          'আমাদের সাথে যোগ দেওয়ার জন্য ধন্যবাদ! লগ ইন করুন বা নীচে আপনার অ্যাকাউন্ট তৈরি করুন, এবং আপনার Couture যাত্রা শুরু করুন!',
      'en':
          'Thanks for joining us! Log in or create your account below, and start your Couture journey!',
      'es':
          '¡Gracias por unirte a nosotros! ¡Inicie sesión o cree su cuenta a continuación y comience su viaje de alta costura!',
      'hi':
          'हमसे जुड़ने के लिए धन्यवाद! लॉग इन करें या नीचे अपना खाता बनाएं, और अपनी कॉउचर यात्रा शुरू करें!',
      'ja': 'ご参加いただきありがとうございます!ログインするか、以下でアカウントを作成して、クチュールの旅を始めましょう!',
      'pa':
          'ਸਾਡੇ ਨਾਲ ਜੁੜਨ ਲਈ ਧੰਨਵਾਦ! ਲੌਗ ਇਨ ਕਰੋ ਜਾਂ ਹੇਠਾਂ ਆਪਣਾ ਖਾਤਾ ਬਣਾਓ, ਅਤੇ ਆਪਣੀ ਕਾਊਚਰ ਯਾਤਰਾ ਸ਼ੁਰੂ ਕਰੋ!',
      'pt':
          'Obrigado por se juntar a nós! Faça login ou crie sua conta abaixo e comece sua jornada Couture!',
      'ru':
          'Спасибо, что присоединились к нам! Войдите в систему или создайте свою учетную запись ниже и начните свое путешествие от кутюр!',
      'zh_Hans': '感谢您加入我们！在下面登录或创建您的帐户，开始您的时装之旅！',
    },
    'fdtzzvy6': {
      'fr': 'Seamstress',
      'ar': 'وصفات رهيبة',
      'bn': 'অসাধারণ রেসিপি',
      'en': 'Awesome Recipes',
      'es': 'Recetas impresionantes',
      'hi': 'बहुत बढ़िया रेसिपी',
      'ja': '素晴らしいレシピ',
      'pa': 'ਸ਼ਾਨਦਾਰ ਪਕਵਾਨਾ',
      'pt': 'Receitas incríveis',
      'ru': 'Потрясающие рецепты',
      'zh_Hans': '很棒的食谱',
    },
    'kur0ygv8': {
      'fr':
          'L\'application Seamstress vise à révolutionner le monde de la couture en offrant un outil intuitif et puissant.',
      'ar': 'لدي بعض خيارات الطعام الرائعة هنا!! لذيذ!!',
      'bn': 'আমি এখানে কিছু মহান খাদ্য বিকল্প আছে!! স্বু - স্বাদু!!',
      'en': 'I have some great food options here!! Yum yum!!',
      'es': '¡¡Tengo excelentes opciones de comida aquí!! ¡¡Yum Yum!!',
      'hi': 'मेरे पास यहां भोजन के कुछ बेहतरीन विकल्प हैं!! स्वादिष्ट!!',
      'ja': 'ここには素晴らしい食べ物の選択肢があります!!ヤムヤム!!',
      'pa': 'ਮੇਰੇ ਕੋਲ ਇੱਥੇ ਭੋਜਨ ਦੇ ਕੁਝ ਵਧੀਆ ਵਿਕਲਪ ਹਨ !! ਯਮ ਯਮ !!',
      'pt': 'Tenho ótimas opções de comida aqui!! Hum, hum!',
      'ru': 'У меня здесь есть отличные варианты еды! Ням ням!!',
      'zh_Hans': '我这里有一些很棒的食物选择！好吃！！',
    },
    'lvk80cgo': {
      'fr': 'Chat intégré',
      'ar': 'اكتشاف وصفة شخصية',
      'bn': 'ব্যক্তিগতকৃত রেসিপি আবিষ্কার',
      'en': 'Personalized recipe discovery',
      'es': 'Descubrimiento de recetas personalizado',
      'hi': 'वैयक्तिकृत नुस्खा खोज',
      'ja': 'パーソナライズされたレシピの発見',
      'pa': 'ਵਿਅਕਤੀਗਤ ਵਿਅੰਜਨ ਖੋਜ',
      'pt': 'Descoberta de receitas personalizadas',
      'ru': 'Персонализированное открытие рецептов',
      'zh_Hans': '个性化食谱发现',
    },
    'sx6rh1zp': {
      'fr':
          'Grâce à son chat intégré, propulsé par IA, elle permet aux utilisateurs d\'obtenir des conseils et des idées créatives en temps réel.',
      'ar': 'لدي بعض خيارات الطعام الرائعة هنا!! لذيذ!!',
      'bn': 'আমি এখানে কিছু মহান খাদ্য বিকল্প আছে!! স্বু - স্বাদু!!',
      'en': 'I have some great food options here!! Yum yum!!',
      'es': '¡¡Tengo excelentes opciones de comida aquí!! ¡¡Yum Yum!!',
      'hi': 'मेरे पास यहाँ भोजन के कुछ बेहतरीन विकल्प हैं!! स्वादिष्ट!!',
      'ja': 'ここには素晴らしい食べ物の選択肢があります!!ヤムヤム!!',
      'pa': 'ਮੇਰੇ ਕੋਲ ਇੱਥੇ ਭੋਜਨ ਦੇ ਕੁਝ ਵਧੀਆ ਵਿਕਲਪ ਹਨ !! ਯਮ ਯਮ !!',
      'pt': 'Tenho ótimas opções de comida aqui!! Hum, hum!',
      'ru': 'У меня здесь есть отличные варианты еды! Ням ням!!',
      'zh_Hans': '我这里有一些很棒的食物选择！好吃！！',
    },
    'tajjd3yq': {
      'fr': 'Commencer',
      'ar': 'يبدأ',
      'bn': 'শুরুতেই',
      'en': 'To start',
      'es': 'Comenzar',
      'hi': 'आरंभ करना',
      'ja': '始めること',
      'pa': 'ਸੁਰੂ ਕਰਨਾ',
      'pt': 'Para iniciar',
      'ru': 'Начать',
      'zh_Hans': '开始',
    },
    'rekh0x60': {
      'fr': 'Home',
      'ar': 'بيت',
      'bn': 'বাড়ি',
      'en': 'Home',
      'es': 'Hogar',
      'hi': 'घर',
      'ja': '家',
      'pa': 'ਘਰ',
      'pt': 'Lar',
      'ru': 'Дом',
      'zh_Hans': '家',
    },
  },
  // phone
  {
    '805qgpkf': {
      'fr': 'INSCRIPTION / se connecter',
      'ar': 'التسجيل / تسجيل الدخول',
      'bn': 'নিবন্ধন / লগ ইন করুন',
      'en': 'REGISTRATION / log in',
      'es': 'REGISTRO / iniciar sesión',
      'hi': 'पंजीकरण / लॉग इन करें',
      'ja': '登録/ログイン',
      'pa': 'ਰਜਿਸਟ੍ਰੇਸ਼ਨ / ਲੌਗ ਇਨ ਕਰੋ',
      'pt': 'INSCRIÇÃO / login',
      'ru': 'РЕГИСТРАЦИЯ / вход',
      'zh_Hans': '注册/登录',
    },
    'bim265ne': {
      'fr': 'Votre numéro de téléphone...',
      'ar': 'رقم هاتفك...',
      'bn': 'আপনার ফোন নম্বর...',
      'en': 'Your phone number...',
      'es': 'Su número de teléfono...',
      'hi': 'आपका फोन नंबर...',
      'ja': 'あなたの電話番号...',
      'pa': 'ਤੁਹਾਡਾ ਫ਼ੋਨ ਨੰਬਰ...',
      'pt': 'Seu número de telefone...',
      'ru': 'Ваш номер телефона...',
      'zh_Hans': '你的电话号码...',
    },
    'dn5ycmt8': {
      'fr': '+1 (204) 204-2056',
      'ar': '+1 (204) 204-2056',
      'bn': '+1 (204) 204-2056',
      'en': '+1 (204) 204-2056',
      'es': '+1 (204) 204-2056',
      'hi': '+1 (204)204-2056',
      'ja': '+1 (204) 204-2056',
      'pa': '+1 (204) 204-2056',
      'pt': '+1 (204) 204-2056',
      'ru': '+1 (204) 204-2056',
      'zh_Hans': '+1 (204) 204-2056',
    },
    'demyz9wz': {
      'fr': 'S\'inscrire  /se connecter',
      'ar': 'تسجيل الدخول',
      'bn': 'নিবন্ধন লগইন',
      'en': 'Register/Login',
      'es': 'Registro de inicio de sesión',
      'hi': 'लॉग इन रजिस्टर करें',
      'ja': '登録/ログイン',
      'pa': 'ਰਜਿਸਟਰ/ਲੌਗਇਨ ਕਰੋ',
      'pt': 'Cadastre-se/Entrar',
      'ru': 'Регистрация Войти',
      'zh_Hans': '注册/登录',
    },
    'wxwnxe92': {
      'fr': 'Home',
      'ar': 'بيت',
      'bn': 'বাড়ি',
      'en': 'Home',
      'es': 'Hogar',
      'hi': 'घर',
      'ja': '家',
      'pa': 'ਘਰ',
      'pt': 'Lar',
      'ru': 'Дом',
      'zh_Hans': '家',
    },
  },
  // verificationphone
  {
    'jr9n28kl': {
      'fr': 'Entrer le code',
      'ar': 'ادخل الرمز',
      'bn': 'কোড লিখুন',
      'en': 'Enter code',
      'es': 'Introduzca el código',
      'hi': 'कोड दर्ज करें',
      'ja': 'コードを入力する',
      'pa': 'ਕੋਡ ਦਰਜ ਕਰੋ',
      'pt': 'Coloque o código',
      'ru': 'Введите код',
      'zh_Hans': '输入代码',
    },
    'xzeucu2l': {
      'fr': 'Valider',
      'ar': 'للتحقق من صحة',
      'bn': 'যাচাই করা',
      'en': 'To validate',
      'es': 'Validar',
      'hi': 'सत्यापित करना',
      'ja': '検証します',
      'pa': 'ਪ੍ਰਮਾਣਿਤ ਕਰਨ ਲਈ',
      'pt': 'Para validar',
      'ru': 'Чтобы проверить',
      'zh_Hans': '验证',
    },
    'i928ai2j': {
      'fr': 'Home',
      'ar': 'بيت',
      'bn': 'বাড়ি',
      'en': 'Home',
      'es': 'Hogar',
      'hi': 'घर',
      'ja': '家',
      'pa': 'ਘਰ',
      'pt': 'Lar',
      'ru': 'Дом',
      'zh_Hans': '家',
    },
  },
  // loginPage
  {
    'x8eqfp77': {
      'fr': 'S\'identifier',
      'ar': 'تسجيل الدخول',
      'bn': 'প্রবেশ করুন',
      'en': 'Log in',
      'es': 'Acceso',
      'hi': 'लॉग इन करें',
      'ja': 'ログイン',
      'pa': 'ਲਾਗਿਨ',
      'pt': 'Conecte-se',
      'ru': 'Авторизоваться',
      'zh_Hans': '登录',
    },
    '65sehks2': {
      'fr': 'Email Address',
      'ar': 'عنوان البريد الإلكتروني',
      'bn': 'ইমেইল ঠিকানা',
      'en': 'Email Address',
      'es': 'Dirección de correo electrónico',
      'hi': 'मेल पता',
      'ja': '電子メールアドレス',
      'pa': 'ਈਮੇਲ ਪਤਾ',
      'pt': 'Endereço de email',
      'ru': 'Адрес электронной почты',
      'zh_Hans': '电子邮件地址',
    },
    '5h8fa52f': {
      'fr': 'Entrez votre email...',
      'ar': 'أدخل بريدك الإلكتروني...',
      'bn': 'তুমার ইমেইল প্রবেশ করাও...',
      'en': 'Enter your e-mail...',
      'es': 'Introduce tu correo electrónico...',
      'hi': 'अपना ईमेल दर्ज करें...',
      'ja': 'メールアドレスを入力...',
      'pa': 'ਆਪਣਾ ਈ - ਮੇਲ ਭਰੋ...',
      'pt': 'Digite seu e-mail...',
      'ru': 'Введите адрес электронной почты...',
      'zh_Hans': '输入你的电子邮箱...',
    },
    'dof320xm': {
      'fr': 'Password',
      'ar': 'كلمة المرور',
      'bn': 'পাসওয়ার্ড',
      'en': 'Password',
      'es': 'Contraseña',
      'hi': 'पासवर्ड',
      'ja': 'パスワード',
      'pa': 'ਪਾਸਵਰਡ',
      'pt': 'Senha',
      'ru': 'Пароль',
      'zh_Hans': '密码',
    },
    'fkkmt55t': {
      'fr': 'Entrez votre mot de passe...',
      'ar': 'ادخل رقمك السري...',
      'bn': 'আপনার পাসওয়ার্ড লিখুন...',
      'en': 'Enter your password...',
      'es': 'Ingresa tu contraseña...',
      'hi': 'अपना कूटशब्द भरें...',
      'ja': 'パスワードを入力してください...',
      'pa': 'ਆਪਣਾ ਪਾਸਵਰਡ ਦਰਜ ਕਰੋ...',
      'pt': 'Coloque sua senha...',
      'ru': 'Введите ваш пароль...',
      'zh_Hans': '输入您的密码...',
    },
    'y601k8o7': {
      'fr': 'Se connecter',
      'ar': 'يتصل',
      'bn': 'লগ - ইন করতে',
      'en': 'To log in',
      'es': 'Conectarse',
      'hi': 'लॉग इन करने के लिए',
      'ja': 'ログインします',
      'pa': 'ਲੌਗ ਇਨ ਕਰਨ ਲਈ',
      'pt': 'Entrar',
      'ru': 'Чтобы залогиниться',
      'zh_Hans': '登录',
    },
    'g64mm9eh': {
      'fr': 'Ou par téléphone',
      'ar': 'أو عن طريق الهاتف',
      'bn': 'অথবা ফোনে',
      'en': 'Or by phone',
      'es': 'O por telefono',
      'hi': 'या फोन से',
      'ja': 'またはお電話で',
      'pa': 'ਜਾਂ ਫ਼ੋਨ ਰਾਹੀਂ',
      'pt': 'Ou por telefone',
      'ru': 'Или по телефону',
      'zh_Hans': '或通过电话',
    },
    'womkt66w': {
      'fr': 'Qaiser Pay Now',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    '2wj8ipzj': {
      'fr': 'S\'INSCRIRE',
      'ar': 'يسجل',
      'bn': 'নিবন্ধন',
      'en': 'REGISTER',
      'es': 'INSCRIBIRSE',
      'hi': 'पंजीकरण करवाना',
      'ja': '登録する',
      'pa': 'ਰਜਿਸਟਰ',
      'pt': 'REGISTRO',
      'ru': 'РЕГИСТР',
      'zh_Hans': '登记',
    },
    '5tvd8mp2': {
      'fr': 'Email Address',
      'ar': 'عنوان البريد الإلكتروني',
      'bn': 'ইমেইল ঠিকানা',
      'en': 'Email Address',
      'es': 'Dirección de correo electrónico',
      'hi': 'मेल पता',
      'ja': '電子メールアドレス',
      'pa': 'ਈਮੇਲ ਪਤਾ',
      'pt': 'Endereço de email',
      'ru': 'Адрес электронной почты',
      'zh_Hans': '电子邮件地址',
    },
    'wchytvil': {
      'fr': 'Entrez votre email...',
      'ar': 'أدخل بريدك الإلكتروني...',
      'bn': 'তুমার ইমেইল প্রবেশ করাও...',
      'en': 'Enter your e-mail...',
      'es': 'Introduce tu correo electrónico...',
      'hi': 'अपना ईमेल दर्ज करें...',
      'ja': 'メールアドレスを入力...',
      'pa': 'ਆਪਣਾ ਈ - ਮੇਲ ਭਰੋ...',
      'pt': 'Digite seu e-mail...',
      'ru': 'Введите адрес электронной почты...',
      'zh_Hans': '输入你的电子邮箱...',
    },
    'q6nb6dfc': {
      'fr': 'mot de passe',
      'ar': 'كلمة السر',
      'bn': 'পাসওয়ার্ড',
      'en': 'password',
      'es': 'contraseña',
      'hi': 'पासवर्ड',
      'ja': 'パスワード',
      'pa': 'ਪਾਸਵਰਡ',
      'pt': 'senha',
      'ru': 'пароль',
      'zh_Hans': '密码',
    },
    '01r6tk1j': {
      'fr': 'Entrez votre mot de passe...',
      'ar': 'ادخل رقمك السري...',
      'bn': 'আপনার পাসওয়ার্ড লিখুন...',
      'en': 'Enter your password...',
      'es': 'Ingresa tu contraseña...',
      'hi': 'अपना कूटशब्द भरें...',
      'ja': 'パスワードを入力してください...',
      'pa': 'ਆਪਣਾ ਪਾਸਵਰਡ ਦਰਜ ਕਰੋ...',
      'pt': 'Coloque sua senha...',
      'ru': 'Введите ваш пароль...',
      'zh_Hans': '输入您的密码...',
    },
    'n5qe06z0': {
      'fr': 'Créer compte',
      'ar': 'إنشاء حساب',
      'bn': 'হিসাব তৈরি কর',
      'en': 'Create account',
      'es': 'Crear una cuenta',
      'hi': 'खाता बनाएं',
      'ja': 'アカウントを作成する',
      'pa': 'ਖਾਤਾ ਬਣਾਉ',
      'pt': 'Criar uma conta',
      'ru': 'Зарегистрироваться',
      'zh_Hans': '创建账户',
    },
    'p5bx6cfn': {
      'fr': 'S\'inscrire à l\'aide d\'un numéro de téléphone',
      'ar': 'سجل باستخدام رقم الهاتف',
      'bn': 'একটি ফোন নম্বর ব্যবহার করে নিবন্ধন করুন',
      'en': 'Register using a phone number',
      'es': 'Regístrese usando un número de teléfono',
      'hi': 'फ़ोन नंबर का उपयोग करके पंजीकरण करें',
      'ja': '電話番号を使用して登録する',
      'pa': 'ਇੱਕ ਫ਼ੋਨ ਨੰਬਰ ਵਰਤ ਕੇ ਰਜਿਸਟਰ ਕਰੋ',
      'pt': 'Registre-se usando um número de telefone',
      'ru': 'Зарегистрируйтесь по номеру телефона',
      'zh_Hans': '使用电话号码注册',
    },
    'hgapo4e6': {
      'fr': 'Home',
      'ar': 'بيت',
      'bn': 'বাড়ি',
      'en': 'Home',
      'es': 'Hogar',
      'hi': 'घर',
      'ja': '家',
      'pa': 'ਘਰ',
      'pt': 'Lar',
      'ru': 'Дом',
      'zh_Hans': '家',
    },
  },
  // profil
  {
    'kbzfjqr0': {
      'fr': 'App Settings',
      'ar': 'إعدادات التطبيقات',
      'bn': 'অ্যাপ সেটিংস',
      'en': 'App Settings',
      'es': 'Ajustes de Aplicacion',
      'hi': 'एप्लिकेशन सेटिंग',
      'ja': 'アプリの設定',
      'pa': 'ਐਪ ਸੈਟਿੰਗਾਂ',
      'pt': 'Configurações do aplicativo',
      'ru': 'Настройки приложения',
      'zh_Hans': '应用程序设置',
    },
    'enm186e9': {
      'fr': 'Rejoindre notre communuaté',
      'ar': 'انضم إلى مجتمعنا',
      'bn': 'আমাদের সম্প্রদায়ে যোগ দিন',
      'en': 'Join our community',
      'es': 'Únete a nuestra comunidad',
      'hi': 'हमारी संस्था से जुड़े',
      'ja': '私たちのコミュニティに参加する',
      'pa': 'ਸਾਡੇ ਭਾਈਚਾਰੇ ਵਿੱਚ ਸ਼ਾਮਲ ਹੋਵੋ',
      'pt': 'Junte-se a nossa comunidade',
      'ru': 'Присоединяйтесь к нашему сообществу',
      'zh_Hans': '加入我们的社区',
    },
    '6n0ykaft': {
      'fr': 'Support',
      'ar': 'يدعم',
      'bn': 'সমর্থন',
      'en': 'Support',
      'es': 'Apoyo',
      'hi': 'सहायता',
      'ja': 'サポート',
      'pa': 'ਸਪੋਰਟ',
      'pt': 'Apoiar',
      'ru': 'Поддерживать',
      'zh_Hans': '支持',
    },
    'lkgsmu06': {
      'fr': 'Terms of Service',
      'ar': 'شروط الخدمة',
      'bn': 'সেবা পাবার শর্ত',
      'en': 'Terms of Service',
      'es': 'Términos de servicio',
      'hi': 'सेवा की शर्तें',
      'ja': '利用規約',
      'pa': 'ਸੇਵਾ ਦੀਆਂ ਸ਼ਰਤਾਂ',
      'pt': 'Termos de serviço',
      'ru': 'Условия использования',
      'zh_Hans': '服务条款',
    },
    'iy8sbmln': {
      'fr': 'Log Out',
      'ar': 'تسجيل خروج',
      'bn': 'প্রস্থান',
      'en': 'Log Out',
      'es': 'Cerrar sesión',
      'hi': 'लॉग आउट',
      'ja': 'ログアウト',
      'pa': 'ਲਾੱਗ ਆਊਟ, ਬਾਹਰ ਆਉਣਾ',
      'pt': 'Sair',
      'ru': 'Выйти',
      'zh_Hans': '登出',
    },
    'neyknu4f': {
      'fr': 'Profile',
      'ar': 'حساب تعريفي',
      'bn': 'প্রোফাইল',
      'en': 'Profile',
      'es': 'Perfil',
      'hi': 'प्रोफ़ाइल',
      'ja': 'プロフィール',
      'pa': 'ਪ੍ਰੋਫਾਈਲ',
      'pt': 'Perfil',
      'ru': 'Профиль',
      'zh_Hans': '轮廓',
    },
  },
  // Support
  {
    'vekd7dxp': {
      'fr': 'Support',
      'ar': 'يدعم',
      'bn': 'সমর্থন',
      'en': 'Support',
      'es': 'Apoyo',
      'hi': 'सहायता',
      'ja': 'サポート',
      'pa': 'ਸਪੋਰਟ',
      'pt': 'Apoiar',
      'ru': 'Поддерживать',
      'zh_Hans': '支持',
    },
    'cskwsjkq': {
      'fr':
          'Vous avez une question ou besoin d\'aide ? Nous sommes là pour vous aider !',
      'ar': 'هل لديك سؤال أو تحتاج إلى مساعدة؟ نحن هنا لمساعدتك !',
      'bn':
          'আপনার একটি প্রশ্ন আছে বা সাহায্য প্রয়োজন? আপনাকে সাহায্য করার জন্য আমরা এইখানে !',
      'en': 'Do you have a question or need help? We are here to help you !',
      'es':
          '¿Tiene alguna pregunta o necesita ayuda? Estamos aquí para ayudarte !',
      'hi':
          'क्या आपका कोई प्रश्न है या सहायता की आवश्यकता है? हम यहां आपकी सहायता के लिए उपलब्ध हैं !',
      'ja': 'ご質問がありますか、またはサポートが必要ですか?私たちはあなたを助けるためにここにいます!',
      'pa':
          'ਕੀ ਤੁਹਾਡੇ ਕੋਲ ਕੋਈ ਸਵਾਲ ਹੈ ਜਾਂ ਮਦਦ ਦੀ ਲੋੜ ਹੈ? ਅਸੀਂ ਤੁਹਾਡੀ ਮਦਦ ਕਰਨ ਲਈ ਇੱਥੇ ਹਾਂ!',
      'pt':
          'Você tem alguma dúvida ou precisa de ajuda? Estamos aqui para ajudá-lo !',
      'ru':
          'У вас есть вопрос или вам нужна помощь? Мы здесь чтобы помочь вам !',
      'zh_Hans': '您有疑问或需要帮助吗？我们是来帮你的 ！',
    },
    'mb8q1ksg': {
      'fr': 'Contact Information',
      'ar': 'معلومات الاتصال',
      'bn': 'যোগাযোগের তথ্য',
      'en': 'Contact information',
      'es': 'Información del contacto',
      'hi': 'संपर्क जानकारी',
      'ja': '連絡先',
      'pa': 'ਸੰਪਰਕ ਜਾਣਕਾਰੀ',
      'pt': 'Informações de contato',
      'ru': 'Контактная информация',
      'zh_Hans': '联系信息',
    },
    'm4jcoc9y': {
      'fr': 'Email: info@sacchic.ca',
      'ar': 'البريد الإلكتروني: info@sacchic.ca',
      'bn': 'ইমেইল: info@sacchic.ca',
      'en': 'Email: info@sacchic.ca',
      'es': 'Correo electrónico: info@sacchic.ca',
      'hi': 'ईमेल: info@sacchic.ca',
      'ja': 'メール: info@sacchic.ca',
      'pa': 'ਈਮੇਲ: info@sacchic.ca',
      'pt': 'E-mail: info@sacchic.ca',
      'ru': 'Электронная почта: info@sacchic.ca',
      'zh_Hans': '电子邮件：info@sacchic.ca',
    },
    'lczeropl': {
      'fr': 'Phone: +1( 438 )-738-9182',
      'ar': 'الهاتف: +1(438)-738-9182',
      'bn': 'ফোন: +1(438)-738-9182',
      'en': 'Phone: +1(438)-738-9182',
      'es': 'Teléfono: +1(438)-738-9182',
      'hi': 'फ़ोन: +1(438)-738-9182',
      'ja': '電話: +1(438)-738-9182',
      'pa': 'ਫ਼ੋਨ: +1(438)-738-9182',
      'pt': 'Telefone: +1(438)-738-9182',
      'ru': 'Телефон: +1(438)-738-9182',
      'zh_Hans': '电话：+1(438)-738-9182',
    },
    '8b5i7kcw': {
      'fr': 'Vous  aimeriez savoir comment utiliser Seamstress ALice ?',
      'ar': 'هل ترغب في معرفة كيفية استخدام Seamstress ALice؟',
      'bn': 'আপনি কি সেমস্ট্রেস অ্যালিস কীভাবে ব্যবহার করবেন তা জানতে চান?',
      'en': 'Would you like to know how to use Seamstress ALice?',
      'es': '¿Quieres saber cómo utilizar Seamstress ALice?',
      'hi': 'क्या आप जानना चाहेंगे कि सीमस्ट्रेस ऐलिस का उपयोग कैसे करें?',
      'ja': 'お針子アリスの使い方を知りたいですか？',
      'pa': 'ਕੀ ਤੁਸੀਂ ਜਾਣਨਾ ਚਾਹੋਗੇ ਕਿ ਸੀਮਸਟ੍ਰੈਸ ਐਲਿਸ ਦੀ ਵਰਤੋਂ ਕਿਵੇਂ ਕਰੀਏ?',
      'pt': 'Gostaria de saber como usar a Costureira ALice?',
      'ru': 'Хотите знать, как использовать Seamstress ALice?',
      'zh_Hans': '您想知道如何使用Seamstress ALice吗？',
    },
    '7pxolw7y': {
      'fr': 'Voir le Guide',
      'ar': 'انظر الدليل',
      'bn': 'গাইড দেখুন',
      'en': 'See the Guide',
      'es': 'Ver la guía',
      'hi': 'गाइड देखें',
      'ja': 'ガイドを参照',
      'pa': 'ਗਾਈਡ ਦੇਖੋ',
      'pt': 'Veja o Guia',
      'ru': 'Посмотреть руководство',
      'zh_Hans': '查看指南',
    },
    'veu6z03e': {
      'fr': 'Support',
      'ar': 'يدعم',
      'bn': 'সমর্থন',
      'en': 'Support',
      'es': 'Apoyo',
      'hi': 'सहायता',
      'ja': 'サポート',
      'pa': 'ਸਪੋਰਟ',
      'pt': 'Apoiar',
      'ru': 'Поддерживать',
      'zh_Hans': '支持',
    },
    'kv6s6x81': {
      'fr': 'Support',
      'ar': 'يدعم',
      'bn': 'সমর্থন',
      'en': 'Support',
      'es': 'Apoyo',
      'hi': 'सहायता',
      'ja': 'サポート',
      'pa': 'ਸਪੋਰਟ',
      'pt': 'Apoiar',
      'ru': 'Поддерживать',
      'zh_Hans': '支持',
    },
  },
  // terme_service
  {
    'ftzcai9n': {
      'fr': 'Retour page d\'accueil',
      'ar': 'العوده للصفحة الرئيسية',
      'bn': 'হোমপেজে ফিরে যান',
      'en': 'Return to home page',
      'es': 'Regresar a la página principal',
      'hi': 'होमपेज पर वापस आएं',
      'ja': 'ホームページに戻る',
      'pa': 'ਹੋਮ ਪੇਜ \'ਤੇ ਵਾਪਸ ਜਾਓ',
      'pt': 'Retornar a página inicial',
      'ru': 'Вернуться на главную страницу',
      'zh_Hans': '返回首页',
    },
    'fg8r80s5': {
      'fr': 'Conditions d\'utilisation',
      'ar': 'شروط الاستعمال',
      'bn': 'ব্যবহারের শর্তাবলী',
      'en': 'Terms of use',
      'es': 'condiciones de uso',
      'hi': 'उपयोग की शर्तें',
      'ja': '利用規約',
      'pa': 'ਵਰਤੋ ਦੀਆਂ ਸ਼ਰਤਾਂ',
      'pt': 'Termos de uso',
      'ru': 'Условия эксплуатации',
      'zh_Hans': '使用条款',
    },
    '7pj04rqd': {
      'fr':
          'Veuillez lire attentivement ces conditions avant d\'utiliser notre application Seamstress',
      'ar':
          'يرجى قراءة هذه الشروط بعناية قبل استخدام تطبيق Seamstress الخاص بنا',
      'bn':
          'আমাদের সীমস্ট্রেস অ্যাপ ব্যবহার করার আগে দয়া করে এই শর্তগুলি সাবধানে পড়ুন',
      'en': 'Please read these terms carefully before using our Seamstress app',
      'es':
          'Lea atentamente estos términos antes de utilizar nuestra aplicación Seamstress',
      'hi':
          'कृपया हमारे सीमस्ट्रेस ऐप का उपयोग करने से पहले इन शर्तों को ध्यान से पढ़ें',
      'ja': 'Seamtress アプリを使用する前に、これらの規約をよくお読みください。',
      'pa':
          'ਕਿਰਪਾ ਕਰਕੇ ਸਾਡੀ ਸੀਮਸਟ੍ਰੈਸ ਐਪ ਦੀ ਵਰਤੋਂ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਇਹਨਾਂ ਨਿਯਮਾਂ ਨੂੰ ਧਿਆਨ ਨਾਲ ਪੜ੍ਹੋ',
      'pt':
          'Por favor, leia estes termos com atenção antes de usar nosso aplicativo Costureira',
      'ru':
          'Пожалуйста, внимательно прочтите эти условия перед использованием нашего приложения «Швея».',
      'zh_Hans': '在使用我们的 Seamstress 应用程序之前，请仔细阅读这些条款',
    },
    'skqsrtkr': {
      'fr':
          'En accédant ou en utilisant l\'application Seamstress, vous acceptez d\'être lié par ces termes et conditions. Si vous n\'êtes pas d\'accord avec une partie de ces termes et conditions, vous ne pouvez pas utiliser l\'application Seamstress.',
      'ar':
          'من خلال الوصول إلى تطبيق Seamstress أو استخدامه، فإنك توافق على الالتزام بهذه الشروط والأحكام. إذا كنت لا توافق على أي جزء من هذه الشروط والأحكام، فلا يجوز لك استخدام تطبيق Seamstress.',
      'bn':
          'সিমস্ট্রেস অ্যাপ অ্যাক্সেস বা ব্যবহার করে, আপনি এই শর্তাবলী দ্বারা আবদ্ধ হতে সম্মত হন। আপনি যদি এই শর্তাবলীর কোনো অংশের সাথে একমত না হন তবে আপনি সীমস্ট্রেস অ্যাপ ব্যবহার করতে পারবেন না।',
      'en':
          'By accessing or using the Seamstress App, you agree to be bound by these terms and conditions. If you disagree with any part of these terms and conditions, you may not use the Seamstress App.',
      'es':
          'Al acceder o utilizar la aplicación Seamstress, usted acepta estar sujeto a estos términos y condiciones. Si no está de acuerdo con alguna parte de estos términos y condiciones, no podrá utilizar la aplicación Seamstress.',
      'hi':
          'सीमस्ट्रेस ऐप तक पहुंच या उपयोग करके, आप इन नियमों और शर्तों से बंधे होने के लिए सहमत हैं। यदि आप इन नियमों और शर्तों के किसी भी भाग से असहमत हैं, तो आप सीमस्ट्रेस ऐप का उपयोग नहीं कर सकते हैं।',
      'ja':
          'Seamstress アプリにアクセスまたは使用すると、これらの利用規約に拘束されることに同意したものとみなされます。これらの利用規約のいずれかの部分に同意しない場合は、Seamtress アプリを使用することはできません。',
      'pa':
          'ਸੀਮਸਟ੍ਰੈਸ ਐਪ ਨੂੰ ਐਕਸੈਸ ਕਰਨ ਜਾਂ ਵਰਤ ਕੇ, ਤੁਸੀਂ ਇਹਨਾਂ ਨਿਯਮਾਂ ਅਤੇ ਸ਼ਰਤਾਂ ਦੁਆਰਾ ਬੰਨ੍ਹੇ ਜਾਣ ਲਈ ਸਹਿਮਤ ਹੁੰਦੇ ਹੋ। ਜੇਕਰ ਤੁਸੀਂ ਇਹਨਾਂ ਨਿਯਮਾਂ ਅਤੇ ਸ਼ਰਤਾਂ ਦੇ ਕਿਸੇ ਵੀ ਹਿੱਸੇ ਨਾਲ ਅਸਹਿਮਤ ਹੋ, ਤਾਂ ਤੁਸੀਂ ਸੀਮਸਟ੍ਰੈਸ ਐਪ ਦੀ ਵਰਤੋਂ ਨਹੀਂ ਕਰ ਸਕਦੇ ਹੋ।',
      'pt':
          'Ao acessar ou usar o App Costureira, você concorda em ficar vinculado a estes termos e condições. Se você discordar de qualquer parte destes termos e condições, você não poderá usar o Aplicativo Costureira.',
      'ru':
          'Получая доступ к приложению Seamstress или используя его, вы соглашаетесь соблюдать эти положения и условия. Если вы не согласны с какой-либо частью этих условий, вы не имеете права использовать приложение Seamstress.',
      'zh_Hans':
          '通过访问或使用 Seamstress 应用程序，您同意受这些条款和条件的约束。如果您不同意这些条款和条件的任何部分，则不得使用 Seamstress 应用程序。',
    },
    '8e9x9mzw': {
      'fr': '1. Utilisation de l\'application Seamstress',
      'ar': '1. استخدام تطبيق الخياطة',
      'bn': '1. সিমস্ট্রেস অ্যাপ ব্যবহার করা',
      'en': '1. Using the Seamstress App',
      'es': '1. Usando la aplicación Costurera',
      'hi': '1. सीमस्ट्रेस ऐप का उपयोग करना',
      'ja': '1. 裁縫アプリの使用',
      'pa': '1. ਸੀਮਸਟ੍ਰੈਸ ਐਪ ਦੀ ਵਰਤੋਂ ਕਰਨਾ',
      'pt': '1. Usando o aplicativo Costureira',
      'ru': '1. Использование приложения «Швея»',
      'zh_Hans': '1. 使用裁缝应用程序',
    },
    '1xg9ul3z': {
      'fr':
          'L\'application Seamstress est conçue pour fournir un service de chatbot permettant aux utilisateurs d\'interagir avec un assistant virtuel doté d\'une intelligence artificielle. Vous pouvez utiliser l\'application Seamstress à des fins personnelles et non commerciales uniquement.',
      'ar':
          'تم تصميم تطبيق Seamstress لتوفير خدمة chatbot تتيح للمستخدمين التفاعل مع مساعد افتراضي مدعوم بالذكاء الاصطناعي. يجوز لك استخدام تطبيق Seamstress للأغراض الشخصية وغير التجارية فقط.',
      'bn':
          'সীমস্ট্রেস অ্যাপটি একটি চ্যাটবট পরিষেবা প্রদান করার জন্য ডিজাইন করা হয়েছে যা ব্যবহারকারীদের কৃত্রিম বুদ্ধিমত্তা দ্বারা চালিত ভার্চুয়াল সহকারীর সাথে যোগাযোগ করতে দেয়। আপনি সিমস্ট্রেস অ্যাপটি শুধুমাত্র ব্যক্তিগত, অ-বাণিজ্যিক উদ্দেশ্যে ব্যবহার করতে পারেন।',
      'en':
          'The Seamstress app is designed to provide a chatbot service that allows users to interact with a virtual assistant powered by artificial intelligence. You may use the Seamstress app for personal, non-commercial purposes only.',
      'es':
          'La aplicación Seamstress está diseñada para proporcionar un servicio de chatbot que permite a los usuarios interactuar con un asistente virtual impulsado por inteligencia artificial. Puede utilizar la aplicación Seamstress únicamente con fines personales y no comerciales.',
      'hi':
          'सीमस्ट्रेस ऐप को एक चैटबॉट सेवा प्रदान करने के लिए डिज़ाइन किया गया है जो उपयोगकर्ताओं को कृत्रिम बुद्धिमत्ता द्वारा संचालित आभासी सहायक के साथ बातचीत करने की अनुमति देता है। आप सीमस्ट्रेस ऐप का उपयोग केवल व्यक्तिगत, गैर-व्यावसायिक उद्देश्यों के लिए कर सकते हैं।',
      'ja':
          'Seamstress アプリは、ユーザーが人工知能を活用した仮想アシスタントと対話できるチャットボット サービスを提供するように設計されています。 Seamstress アプリは個人的な非営利目的にのみ使用できます。',
      'pa':
          'ਸੀਮਸਟ੍ਰੈਸ ਐਪ ਨੂੰ ਇੱਕ ਚੈਟਬੋਟ ਸੇਵਾ ਪ੍ਰਦਾਨ ਕਰਨ ਲਈ ਤਿਆਰ ਕੀਤਾ ਗਿਆ ਹੈ ਜੋ ਉਪਭੋਗਤਾਵਾਂ ਨੂੰ ਆਰਟੀਫੀਸ਼ੀਅਲ ਇੰਟੈਲੀਜੈਂਸ ਦੁਆਰਾ ਸੰਚਾਲਿਤ ਇੱਕ ਵਰਚੁਅਲ ਸਹਾਇਕ ਨਾਲ ਇੰਟਰੈਕਟ ਕਰਨ ਦੀ ਆਗਿਆ ਦਿੰਦਾ ਹੈ। ਤੁਸੀਂ ਸੀਮਸਟ੍ਰੈਸ ਐਪ ਦੀ ਵਰਤੋਂ ਸਿਰਫ਼ ਨਿੱਜੀ, ਗੈਰ-ਵਪਾਰਕ ਉਦੇਸ਼ਾਂ ਲਈ ਕਰ ਸਕਦੇ ਹੋ।',
      'pt':
          'O aplicativo Costureira foi projetado para fornecer um serviço de chatbot que permite aos usuários interagir com um assistente virtual alimentado por inteligência artificial. Você pode usar o aplicativo Costureira apenas para fins pessoais e não comerciais.',
      'ru':
          'Приложение Seamstress предназначено для предоставления услуги чат-бота, который позволяет пользователям взаимодействовать с виртуальным помощником на базе искусственного интеллекта. Вы можете использовать приложение Seamstress только в личных, некоммерческих целях.',
      'zh_Hans':
          'Seamstress 应用程序旨在提供聊天机器人服务，允许用户与人工智能驱动的虚拟助手进行交互。您只能将 Seamstress 应用程序用于个人非商业目的。',
    },
    '3p4mxbyi': {
      'fr': '2. Comportement de l\'utilisateur',
      'ar': '2. سلوك المستخدم',
      'bn': '2. ব্যবহারকারীর আচরণ',
      'en': '2. User behavior',
      'es': '2. Comportamiento del usuario',
      'hi': '2. उपयोगकर्ता व्यवहार',
      'ja': '2. ユーザーの行動',
      'pa': '2. ਉਪਭੋਗਤਾ ਵਿਹਾਰ',
      'pt': '2. Comportamento do usuário',
      'ru': '2. Поведение пользователя',
      'zh_Hans': '2. 用户行为',
    },
    'fp3c31dc': {
      'fr':
          'Vous acceptez d\'utiliser l\'application Seamstress en conformité avec toutes les lois et réglementations applicables. Vous êtes seul responsable du contenu de vos interactions avec l\'assistant virtuel et tout autre utilisateur de l\'application Seamstress.',
      'ar':
          'أنت توافق على استخدام تطبيق Seamstress بما يتوافق مع جميع القوانين واللوائح المعمول بها. أنت وحدك المسؤول عن محتوى تفاعلاتك مع المساعد الافتراضي وأي مستخدم آخر لتطبيق Seamstress.',
      'bn':
          'আপনি সমস্ত প্রযোজ্য আইন ও প্রবিধান মেনে সিমস্ট্রেস অ্যাপ ব্যবহার করতে সম্মত হন। ভার্চুয়াল সহকারী এবং সিমস্ট্রেস অ্যাপ্লিকেশনের অন্য কোনো ব্যবহারকারীর সাথে আপনার মিথস্ক্রিয়াগুলির বিষয়বস্তুর জন্য আপনি সম্পূর্ণরূপে দায়ী।',
      'en':
          'You agree to use the Seamstress App in compliance with all applicable laws and regulations. You are solely responsible for the content of your interactions with the virtual assistant and any other user of the Seamstress application.',
      'es':
          'Acepta utilizar la aplicación Seamstress de conformidad con todas las leyes y regulaciones aplicables. Usted es el único responsable del contenido de sus interacciones con el asistente virtual y cualquier otro usuario de la aplicación Seamstress.',
      'hi':
          'आप सभी लागू कानूनों और विनियमों के अनुपालन में सीमस्ट्रेस ऐप का उपयोग करने के लिए सहमत हैं। आप वर्चुअल असिस्टेंट और सीमस्ट्रेस एप्लिकेशन के किसी अन्य उपयोगकर्ता के साथ अपनी बातचीत की सामग्री के लिए पूरी तरह जिम्मेदार हैं।',
      'ja':
          'あなたは、適用されるすべての法律および規制に従ってお針子アプリを使用することに同意します。あなたは、仮想アシスタントおよび Seamstress アプリケーションの他のユーザーとのやり取りの内容に対して単独で責任を負います。',
      'pa':
          'ਤੁਸੀਂ ਸਾਰੇ ਲਾਗੂ ਕਾਨੂੰਨਾਂ ਅਤੇ ਨਿਯਮਾਂ ਦੀ ਪਾਲਣਾ ਵਿੱਚ ਸੀਮਸਟ੍ਰੈਸ ਐਪ ਦੀ ਵਰਤੋਂ ਕਰਨ ਲਈ ਸਹਿਮਤ ਹੁੰਦੇ ਹੋ। ਤੁਸੀਂ ਵਰਚੁਅਲ ਅਸਿਸਟੈਂਟ ਅਤੇ ਸੀਮਸਟ੍ਰੈਸ ਐਪਲੀਕੇਸ਼ਨ ਦੇ ਕਿਸੇ ਵੀ ਹੋਰ ਉਪਭੋਗਤਾ ਨਾਲ ਤੁਹਾਡੀ ਗੱਲਬਾਤ ਦੀ ਸਮਗਰੀ ਲਈ ਪੂਰੀ ਤਰ੍ਹਾਂ ਜ਼ਿੰਮੇਵਾਰ ਹੋ।',
      'pt':
          'Você concorda em usar o Aplicativo Costureira em conformidade com todas as leis e regulamentos aplicáveis. Você é o único responsável pelo conteúdo de suas interações com a assistente virtual e qualquer outro usuário do aplicativo Costureira.',
      'ru':
          'Вы соглашаетесь использовать приложение Seamstress в соответствии со всеми применимыми законами и правилами. Вы несете единоличную ответственность за содержание вашего взаимодействия с виртуальным помощником и любым другим пользователем приложения Seamstress.',
      'zh_Hans':
          '您同意按照所有适用的法律和法规使用 Seamstress 应用程序。您对与虚拟助手和 Seamstress 应用程序的任何其他用户交互的内容承担全部责任。',
    },
    'z542a64v': {
      'fr': '3. Propriété intellectuelle',
      'ar': '3. الملكية الفكرية',
      'bn': '3. মেধা সম্পত্তি',
      'en': '3. Intellectual property',
      'es': '3. Propiedad intelectual',
      'hi': '3. बौद्धिक संपदा',
      'ja': '3. 知的財産',
      'pa': '3. ਬੌਧਿਕ ਸੰਪਤੀ',
      'pt': '3. Propriedade intelectual',
      'ru': '3. Интеллектуальная собственность',
      'zh_Hans': '3. 知识产权',
    },
    'vm9m345w': {
      'fr':
          'L\'application Seamstress et tout son contenu, y compris, mais sans s\'y limiter, le texte, les graphiques, les logos et les images, sont la propriété du propriétaire de l\'application et sont protégés par les lois sur la propriété intellectuelle. Vous ne pouvez pas reproduire, modifier, distribuer ou afficher toute partie de l\'application Seamstress sans l\'autorisation écrite préalable du propriétaire de l\'application.',
      'ar':
          'إن تطبيق Seamstress وجميع محتوياته، بما في ذلك على سبيل المثال لا الحصر، النصوص والرسومات والشعارات والصور، هي ملك لمالك التطبيق ومحمية بموجب قوانين الملكية الفكرية. لا يجوز لك إعادة إنتاج أو تعديل أو توزيع أو عرض أي جزء من تطبيق Seamstress دون الحصول على إذن كتابي مسبق من صاحب التطبيق.',
      'bn':
          'সিমস্ট্রেস অ্যাপ্লিকেশন এবং এর সমস্ত বিষয়বস্তু, পাঠ্য, গ্রাফিক্স, লোগো এবং চিত্র সহ কিন্তু সীমাবদ্ধ নয়, অ্যাপ্লিকেশন মালিকের সম্পত্তি এবং মেধা সম্পত্তি আইন দ্বারা সুরক্ষিত। আপনি আবেদনের মালিকের পূর্ব লিখিত অনুমতি ব্যতীত সিমস্ট্রেস অ্যাপ্লিকেশনটির কোনও অংশ পুনরুত্পাদন, পরিবর্তন, বিতরণ বা প্রদর্শন করতে পারবেন না।',
      'en':
          'The Seamstress application and all its content, including but not limited to text, graphics, logos and images, are the property of the application owner and are protected by intellectual property laws . You may not reproduce, modify, distribute or display any part of the Seamstress application without the prior written permission of the application owner.',
      'es':
          'La aplicación Seamstress y todo su contenido, incluidos, entre otros, texto, gráficos, logotipos e imágenes, son propiedad del propietario de la aplicación y están protegidos por las leyes de propiedad intelectual. No puede reproducir, modificar, distribuir ni mostrar ninguna parte de la aplicación Seamstress sin el permiso previo por escrito del propietario de la aplicación.',
      'hi':
          'सीमस्ट्रेस एप्लिकेशन और इसकी सभी सामग्री, जिसमें टेक्स्ट, ग्राफिक्स, लोगो और छवियां शामिल हैं, लेकिन इन्हीं तक सीमित नहीं हैं, एप्लिकेशन मालिक की संपत्ति हैं और बौद्धिक संपदा कानूनों द्वारा संरक्षित हैं। आप एप्लिकेशन स्वामी की पूर्व लिखित अनुमति के बिना सीमस्ट्रेस एप्लिकेशन के किसी भी हिस्से को पुन: पेश, संशोधित, वितरित या प्रदर्शित नहीं कर सकते हैं।',
      'ja':
          'Seamstress アプリケーションとそのすべてのコンテンツ (テキスト、グラフィック、ロゴ、画像を含むがこれらに限定されない) はアプリケーション所有者の財産であり、知的財産法によって保護されています。アプリケーション所有者の事前の書面による許可がない限り、Seamtress アプリケーションのいかなる部分も複製、変更、配布、または表示することはできません。',
      'pa':
          'ਸੀਮਸਟ੍ਰੈਸ ਐਪਲੀਕੇਸ਼ਨ ਅਤੇ ਇਸਦੀ ਸਾਰੀ ਸਮੱਗਰੀ, ਜਿਸ ਵਿੱਚ ਟੈਕਸਟ, ਗ੍ਰਾਫਿਕਸ, ਲੋਗੋ ਅਤੇ ਚਿੱਤਰ ਸ਼ਾਮਲ ਹਨ ਪਰ ਇਹਨਾਂ ਤੱਕ ਸੀਮਿਤ ਨਹੀਂ ਹਨ, ਐਪਲੀਕੇਸ਼ਨ ਦੇ ਮਾਲਕ ਦੀ ਸੰਪਤੀ ਹਨ ਅਤੇ ਬੌਧਿਕ ਸੰਪਤੀ ਕਾਨੂੰਨਾਂ ਦੁਆਰਾ ਸੁਰੱਖਿਅਤ ਹਨ। ਤੁਸੀਂ ਬਿਨੈ-ਪੱਤਰ ਦੇ ਮਾਲਕ ਦੀ ਪੂਰਵ ਲਿਖਤੀ ਇਜਾਜ਼ਤ ਤੋਂ ਬਿਨਾਂ ਸੀਮਸਟ੍ਰੈਸ ਐਪਲੀਕੇਸ਼ਨ ਦੇ ਕਿਸੇ ਵੀ ਹਿੱਸੇ ਨੂੰ ਦੁਬਾਰਾ ਤਿਆਰ, ਸੋਧ, ਵੰਡ ਜਾਂ ਪ੍ਰਦਰਸ਼ਿਤ ਨਹੀਂ ਕਰ ਸਕਦੇ ਹੋ।',
      'pt':
          'O aplicativo Costureira e todo o seu conteúdo, incluindo, entre outros, textos, gráficos, logotipos e imagens, são de propriedade do proprietário do aplicativo e estão protegidos pelas leis de propriedade intelectual. Você não pode reproduzir, modificar, distribuir ou exibir qualquer parte do aplicativo Seamstress sem a permissão prévia por escrito do proprietário do aplicativo.',
      'ru':
          'Приложение Seamstress и все его содержимое, включая, помимо прочего, текст, графику, логотипы и изображения, являются собственностью владельца приложения и защищены законами об интеллектуальной собственности. Вы не имеете права воспроизводить, изменять, распространять или отображать какую-либо часть приложения Seamstress без предварительного письменного разрешения владельца приложения.',
      'zh_Hans':
          'Seamstress 应用程序及其所有内容，包括但不限于文本、图形、徽标和图像，均为应用程序所有者的财产，并受知识产权法的保护。未经应用程序所有者事先书面许可，您不得复制、修改、分发或展示 Seamstress 应用程序的任何部分。',
    },
    'zrmznr9k': {
      'fr': '4. Limitation of Liability',
      'ar': '4. حدود المسؤولية',
      'bn': '4. দায়বদ্ধতার সীমাবদ্ধতা',
      'en': '4. Limitation of Liability',
      'es': '4. Limitación de responsabilidad',
      'hi': '4. दायित्व की सीमा',
      'ja': '4. 責任の制限',
      'pa': '4. ਦੇਣਦਾਰੀ ਦੀ ਸੀਮਾ',
      'pt': '4. Limitação de Responsabilidade',
      'ru': '4. Ограничение ответственности',
      'zh_Hans': '4. 责任限制',
    },
    'jql08yx6': {
      'fr':
          'The ChatGPT application is provided on an \'as is\' basis, without any warranties or representations, express or implied. The application owner shall not be liable for any damages arising out of or in connection with the use of the ChatGPT application.',
      'ar':
          'يتم توفير تطبيق ChatGPT على أساس \"كما هو\"، دون أي ضمانات أو إقرارات، صريحة أو ضمنية. لن يكون مالك التطبيق مسؤولاً عن أي أضرار تنشأ عن أو فيما يتعلق باستخدام تطبيق ChatGPT.',
      'bn':
          'ChatGPT অ্যাপ্লিকেশনটি \'যেমন আছে\' ভিত্তিতে প্রদান করা হয়, কোনো ওয়ারেন্টি বা উপস্থাপনা ছাড়াই, প্রকাশ বা উহ্য। চ্যাটজিপিটি অ্যাপ্লিকেশন ব্যবহারের ফলে বা তার সাথে সম্পর্কিত কোনো ক্ষতির জন্য অ্যাপ্লিকেশনের মালিক দায়ী থাকবে না।',
      'en':
          'The ChatGPT application is provided on an \'as is\' basis, without any warranties or representations, express or implied. The application owner shall not be liable for any damages arising out of or in connection with the use of the ChatGPT application.',
      'es':
          'La aplicación ChatGPT se proporciona \"tal cual\", sin garantías ni representaciones, expresas o implícitas. El propietario de la aplicación no será responsable de ningún daño que surja de o esté relacionado con el uso de la aplicación ChatGPT.',
      'hi':
          'चैटजीपीटी एप्लिकेशन \'जैसा है\' के आधार पर प्रदान किया जाता है, बिना किसी वारंटी या अभ्यावेदन, व्यक्त या निहित के। चैटजीपीटी एप्लिकेशन के उपयोग से या उसके संबंध में होने वाली किसी भी क्षति के लिए एप्लिकेशन स्वामी उत्तरदायी नहीं होगा।',
      'ja':
          'ChatGPT アプリケーションは、明示的か黙示的かを問わず、いかなる保証も表明も行わず、「現状のまま」で提供されます。アプリケーションの所有者は、ChatGPT アプリケーションの使用に起因または関連して生じる損害に対して責任を負わないものとします。',
      'pa':
          'ਚੈਟਜੀਪੀਟੀ ਐਪਲੀਕੇਸ਼ਨ \'ਜਿਵੇਂ ਹੈ\' ਦੇ ਆਧਾਰ \'ਤੇ ਪ੍ਰਦਾਨ ਕੀਤੀ ਜਾਂਦੀ ਹੈ, ਬਿਨਾਂ ਕਿਸੇ ਵਾਰੰਟੀ ਜਾਂ ਪ੍ਰਤੀਨਿਧਤਾ, ਸਪੱਸ਼ਟ ਜਾਂ ਅਪ੍ਰਤੱਖ। ਐਪਲੀਕੇਸ਼ਨ ਦਾ ਮਾਲਕ ਚੈਟਜੀਪੀਟੀ ਐਪਲੀਕੇਸ਼ਨ ਦੀ ਵਰਤੋਂ ਤੋਂ ਜਾਂ ਇਸ ਦੇ ਸਬੰਧ ਵਿੱਚ ਹੋਣ ਵਾਲੇ ਕਿਸੇ ਵੀ ਨੁਕਸਾਨ ਲਈ ਜਵਾਬਦੇਹ ਨਹੀਂ ਹੋਵੇਗਾ।',
      'pt':
          'O aplicativo ChatGPT é fornecido \'no estado em que se encontra\', sem quaisquer garantias ou representações, expressas ou implícitas. O proprietário do aplicativo não será responsável por quaisquer danos decorrentes ou relacionados ao uso do aplicativo ChatGPT.',
      'ru':
          'Приложение ChatGPT предоставляется «как есть», без каких-либо гарантий или заявлений, явных или подразумеваемых. Владелец приложения не несет ответственности за любой ущерб, возникший в результате или в связи с использованием приложения ChatGPT.',
      'zh_Hans':
          'ChatGPT 应用程序按“原样”提供，不提供任何明示或暗示的保证或陈述。应用程序所有者不对因使用 ChatGPT 应用程序而引起或与之相关的任何损害承担责任。',
    },
    'e4ae98za': {
      'fr': '5. Governing Law',
      'ar': '5. القانون الحاكم',
      'bn': '5. পরিচালনা আইন',
      'en': '5. Governing Law',
      'es': '5. Ley aplicable',
      'hi': '5. शासी कानून',
      'ja': '5. 準拠法',
      'pa': '5. ਗਵਰਨਿੰਗ ਕਾਨੂੰਨ',
      'pt': '5. Lei Aplicável',
      'ru': '5. Применимое право',
      'zh_Hans': '5. 适用法律',
    },
    'cks50d36': {
      'fr':
          'These terms and conditions shall be governed by and construed in accordance with the laws of [your country]. Any disputes arising out of or in connection with these terms and conditions shall be subject to the exclusive jurisdiction of the courts of [your country].',
      'ar':
          'تخضع هذه الشروط والأحكام ويتم وضعها وفقًا لقوانين [بلدك]. أي نزاعات تنشأ عن أو فيما يتعلق بهذه الشروط والأحكام تخضع للاختصاص القضائي الحصري لمحاكم [بلدك].',
      'bn':
          'এই শর্তাবলী দ্বারা পরিচালিত হবে এবং [আপনার দেশের] আইন অনুসারে নির্মিত হবে। এই শর্তাবলী থেকে বা এর সাথে সম্পর্কিত যেকোন বিরোধ [আপনার দেশের] আদালতের একচেটিয়া এখতিয়ারের অধীন হবে।',
      'en':
          'These terms and conditions shall be governed by and constructed in accordance with the laws of [your country]. Any disputes arising out of or in connection with these terms and conditions shall be subject to the exclusive jurisdiction of the courts of [your country].',
      'es':
          'Estos términos y condiciones se regirán y construirán de acuerdo con las leyes de [su país]. Cualquier disputa que surja de estos términos y condiciones o esté relacionada con ellos estará sujeta a la jurisdicción exclusiva de los tribunales de [su país].',
      'hi':
          'ये नियम और शर्तें [आपके देश] के कानूनों द्वारा शासित और निर्मित की जाएंगी। इन नियमों और शर्तों से उत्पन्न या उनके संबंध में कोई भी विवाद [आपके देश] की अदालतों के विशेष क्षेत्राधिकार के अधीन होगा।',
      'ja':
          'これらの利用規約は、[あなたの国] の法律に準拠し、それに従って構築されるものとします。これらの利用規約に起因または関連して生じるあらゆる紛争は、[あなたの国] の裁判所の専属管轄権に従うものとします。',
      'pa':
          'ਇਹ ਨਿਯਮ ਅਤੇ ਸ਼ਰਤਾਂ [ਤੁਹਾਡੇ ਦੇਸ਼] ਦੇ ਕਾਨੂੰਨਾਂ ਦੁਆਰਾ ਨਿਯੰਤਰਿਤ ਅਤੇ ਬਣਾਈਆਂ ਜਾਣਗੀਆਂ। ਇਹਨਾਂ ਨਿਯਮਾਂ ਅਤੇ ਸ਼ਰਤਾਂ ਤੋਂ ਪੈਦਾ ਹੋਣ ਵਾਲੇ ਜਾਂ ਇਹਨਾਂ ਦੇ ਸਬੰਧ ਵਿੱਚ ਕੋਈ ਵੀ ਵਿਵਾਦ [ਤੁਹਾਡੇ ਦੇਸ਼] ਦੀਆਂ ਅਦਾਲਤਾਂ ਦੇ ਵਿਸ਼ੇਸ਼ ਅਧਿਕਾਰ ਖੇਤਰ ਦੇ ਅਧੀਨ ਹੋਵੇਗਾ।',
      'pt':
          'Estes termos e condições serão regidos e elaborados de acordo com as leis de [seu país]. Quaisquer disputas decorrentes ou relacionadas a estes termos e condições estarão sujeitas à jurisdição exclusiva dos tribunais de [seu país].',
      'ru':
          'Настоящие положения и условия регулируются и составляются в соответствии с законами [вашей страны]. Любые споры, возникающие из или в связи с настоящими положениями и условиями, подлежат исключительной юрисдикции судов [вашей страны].',
      'zh_Hans':
          '这些条款和条件应受[您所在国家/地区]的法律管辖并根据其制定。因这些条款和条件引起的或与之相关的任何争议均应受[您所在国家/地区]法院的专属管辖。',
    },
    'rdjd91q1': {
      'fr':
          'By using the ChatGPT application, you acknowledge that you have read, understood, and agree to be bound by these terms and conditions.',
      'ar':
          'باستخدام تطبيق ChatGPT، فإنك تقر بأنك قد قرأت هذه الشروط والأحكام وفهمتها ووافقت على الالتزام بها.',
      'bn':
          'ChatGPT অ্যাপ্লিকেশনটি ব্যবহার করে, আপনি স্বীকার করেন যে আপনি এই শর্তাবলী পড়েছেন, বুঝেছেন এবং সম্মত হয়েছেন।',
      'en':
          'By using the ChatGPT application, you acknowledge that you have read, understood, and agree to be bound by these terms and conditions.',
      'es':
          'Al utilizar la aplicación ChatGPT, usted reconoce que ha leído, comprendido y aceptado regirse por estos términos y condiciones.',
      'hi':
          'चैटजीपीटी एप्लिकेशन का उपयोग करके, आप स्वीकार करते हैं कि आपने इन नियमों और शर्तों को पढ़, समझ लिया है और उनसे बंधे होने के लिए सहमत हैं।',
      'ja': 'ChatGPT アプリケーションを使用すると、これらの利用規約を読み、理解し、それに拘束されることに同意したことになります。',
      'pa':
          'ਚੈਟਜੀਪੀਟੀ ਐਪਲੀਕੇਸ਼ਨ ਦੀ ਵਰਤੋਂ ਕਰਕੇ, ਤੁਸੀਂ ਸਵੀਕਾਰ ਕਰਦੇ ਹੋ ਕਿ ਤੁਸੀਂ ਇਹਨਾਂ ਨਿਯਮਾਂ ਅਤੇ ਸ਼ਰਤਾਂ ਨੂੰ ਪੜ੍ਹਿਆ, ਸਮਝ ਲਿਆ ਹੈ ਅਤੇ ਉਹਨਾਂ ਨਾਲ ਬੰਨ੍ਹਣ ਲਈ ਸਹਿਮਤ ਹੋ।',
      'pt':
          'Ao usar o aplicativo ChatGPT, você reconhece que leu, compreendeu e concorda em ficar vinculado a estes termos e condições.',
      'ru':
          'Используя приложение ChatGPT, вы подтверждаете, что прочитали, поняли и согласны соблюдать эти положения и условия.',
      'zh_Hans': '通过使用 ChatGPT 应用程序，您承认您已阅读、理解并同意受这些条款和条件的约束。',
    },
  },
  // page_accueil
  {
    'f7igs0tx': {
      'fr': 'Bienvenue sur Seamstress',
      'ar': 'مرحبا بكم في خياطة',
      'bn': 'সীমস্ট্রেস স্বাগতম',
      'en': 'Welcome to Seamstress',
      'es': 'Bienvenido a Costurera',
      'hi': 'सीमस्ट्रेस में आपका स्वागत है',
      'ja': 'お針子へようこそ',
      'pa': 'ਸੀਮਸਟ੍ਰੈਸ ਵਿੱਚ ਤੁਹਾਡਾ ਸੁਆਗਤ ਹੈ',
      'pt': 'Bem-vindo à Costureira',
      'ru': 'Добро пожаловать в Швею',
      'zh_Hans': '欢迎来到裁缝师',
    },
    'qwu6z6br': {
      'fr':
          'L\'application qui vous aide à réaliser vos créations couture avec facilité.',
      'ar': 'التطبيق الذي يساعدك على صنع إبداعاتك من الأزياء الراقية بسهولة.',
      'bn': 'অ্যাপ্লিকেশন যা আপনাকে সহজেই আপনার পোশাক তৈরি করতে সহায়তা করে।',
      'en':
          'The application that helps you make your couture creations with ease.',
      'es':
          'La aplicación que te ayuda a realizar tus creaciones de alta costura con facilidad.',
      'hi':
          'वह एप्लिकेशन जो आपके वस्त्र निर्माण को आसानी से बनाने में आपकी सहायता करता है।',
      'ja': 'クチュール作品を簡単に作るためのアプリケーションです。',
      'pa':
          'ਐਪਲੀਕੇਸ਼ਨ ਜੋ ਤੁਹਾਡੀ ਕਾਊਚਰ ਰਚਨਾਵਾਂ ਨੂੰ ਆਸਾਨੀ ਨਾਲ ਬਣਾਉਣ ਵਿੱਚ ਤੁਹਾਡੀ ਮਦਦ ਕਰਦੀ ਹੈ।',
      'pt':
          'O aplicativo que ajuda você a fazer suas criações de alta costura com facilidade.',
      'ru':
          'Приложение, которое поможет вам с легкостью создавать свои творения от кутюр.',
      'zh_Hans': '该应用程序可帮助您轻松进行时装创作。',
    },
    'nsurpwgx': {
      'fr': 'Poser vos questions',
      'ar': 'اسال اسالتك',
      'bn': 'আপনার প্রশ্ন জিজ্ঞাসা করুন',
      'en': 'Ask your questions',
      'es': 'Haga sus preguntas',
      'hi': 'अपने प्रश्न पूछें',
      'ja': '質問してください',
      'pa': 'ਆਪਣੇ ਸਵਾਲ ਪੁੱਛੋ',
      'pt': 'Faça suas perguntas',
      'ru': 'Задавайте свои вопросы',
      'zh_Hans': '提出你的问题',
    },
    'e9cmh784': {
      'fr': 'Vos Notes ',
      'ar': 'ملاحظاتك',
      'bn': 'আপনার নোট',
      'en': 'Your Notes',
      'es': 'Tus notas',
      'hi': 'तुम्हारे पर्चे',
      'ja': 'あなたのメモ',
      'pa': 'ਤੁਹਾਡੇ ਨੋਟਸ',
      'pt': 'Suas notas',
      'ru': 'Ваши заметки',
      'zh_Hans': '你的笔记',
    },
    'k8ntso5v': {
      'fr': 'Guide d\'utilisation de Seamstress',
      'ar': 'دليل مستخدم الخياطة',
      'bn': 'সেমস্ট্রেস ব্যবহারকারীর নির্দেশিকা',
      'en': 'Seamstress User Guide',
      'es': 'Guía del usuario de costurera',
      'hi': 'सीमस्ट्रेस उपयोगकर्ता गाइड',
      'ja': '裁縫師ユーザーガイド',
      'pa': 'ਸੀਮਸਟ੍ਰੈਸ ਉਪਭੋਗਤਾ ਗਾਈਡ',
      'pt': 'Guia do usuário da costureira',
      'ru': 'Руководство пользователя для швеи',
      'zh_Hans': '裁缝用户指南',
    },
    '0eruqfxo': {
      'fr': 'Accueil',
      'ar': 'ترحيب',
      'bn': 'স্বাগত',
      'en': 'Welcome',
      'es': 'bienvenida',
      'hi': 'स्वागत',
      'ja': 'いらっしゃいませ',
      'pa': 'ਸੁਆਗਤ ਹੈ',
      'pt': 'Bem-vindo',
      'ru': 'Добро пожаловать',
      'zh_Hans': '欢迎',
    },
    'eo8vwvyx': {
      'fr': 'se déconnecter',
      'ar': 'تسجيل الخروج',
      'bn': 'সাইন আউট',
      'en': 'Sign out',
      'es': 'desconectarse',
      'hi': 'साइन आउट',
      'ja': 'サインアウト',
      'pa': 'ਸਾਇਨ ਆਉਟ',
      'pt': 'sair',
      'ru': 'выход',
      'zh_Hans': '登出',
    },
    'ruux2w8w': {
      'fr': 'Accueil',
      'ar': 'ترحيب',
      'bn': 'স্বাগত',
      'en': 'Welcome',
      'es': 'bienvenida',
      'hi': 'स्वागत',
      'ja': 'いらっしゃいませ',
      'pa': 'ਸੁਆਗਤ ਹੈ',
      'pt': 'Bem-vindo',
      'ru': 'Добро пожаловать',
      'zh_Hans': '欢迎',
    },
  },
  // guidedUtilisationdeSeamstress
  {
    'ryf59ey8': {
      'fr': 'Utilisation de Seamstress - Étapes par étapes',
      'ar': 'استخدام الخياطة – خطوة بخطوة',
      'bn': 'সিমস্ট্রেস ব্যবহার করা - ধাপে ধাপে',
      'en': 'Using Seamstress – Step by Step',
      'es': 'Usando Seamstress – Paso a Paso',
      'hi': 'सीमस्ट्रेस का उपयोग करना - चरण दर चरण',
      'ja': 'Seamtress の使用 – ステップバイステップ',
      'pa': 'ਸੀਮਸਟ੍ਰੈਸ ਦੀ ਵਰਤੋਂ ਕਰਨਾ - ਕਦਮ ਦਰ ਕਦਮ',
      'pt': 'Usando Costureira – Passo a Passo',
      'ru': 'Использование швеи – шаг за шагом',
      'zh_Hans': '使用裁缝师 – 一步一步',
    },
    'pgj3vm0w': {
      'fr':
          'Votre partenaire intelligent en couture. Notre application est conçue pour simplifier votre expérience de couture en fournissant des réponses rapides à vos questions et des conseils utiles pour vos projets de couture, y compris les dimensions précises. Voici comment tirer le meilleur parti de notre application.',
      'ar':
          'شريكك الذكي في الخياطة. تم تصميم تطبيقنا لتبسيط تجربة الخياطة الخاصة بك من خلال تقديم إجابات سريعة لأسئلتك ونصائح مفيدة لمشاريع الخياطة الخاصة بك، بما في ذلك الأبعاد الدقيقة. إليك كيفية تحقيق أقصى استفادة من تطبيقنا.',
      'bn':
          'আপনার স্মার্ট সেলাই অংশীদার. আমাদের অ্যাপটি আপনার প্রশ্নের দ্রুত উত্তর এবং সুনির্দিষ্ট মাত্রা সহ আপনার সেলাই প্রকল্পগুলির জন্য সহায়ক টিপস প্রদান করে আপনার সেলাইয়ের অভিজ্ঞতাকে সহজ করার জন্য ডিজাইন করা হয়েছে। আমাদের অ্যাপ থেকে কীভাবে সবচেয়ে বেশি সুবিধা পাবেন তা এখানে।',
      'en':
          'Your smart sewing partner. Our app is designed to simplify your sewing experience by providing quick answers to your questions and helpful tips for your sewing projects, including precise dimensions. Here\'s how to get the most out of our app.',
      'es':
          'Tu compañero de costura inteligente. Nuestra aplicación está diseñada para simplificar su experiencia de costura al brindarle respuestas rápidas a sus preguntas y consejos útiles para sus proyectos de costura, incluidas dimensiones precisas. Aquí le mostramos cómo aprovechar al máximo nuestra aplicación.',
      'hi':
          'आपका स्मार्ट सिलाई पार्टनर. हमारा ऐप आपके प्रश्नों के त्वरित उत्तर और सटीक आयामों सहित आपकी सिलाई परियोजनाओं के लिए उपयोगी टिप्स प्रदान करके आपके सिलाई अनुभव को सरल बनाने के लिए डिज़ाइन किया गया है। यहां बताया गया है कि हमारे ऐप से अधिकतम लाभ कैसे उठाया जाए।',
      'ja':
          'あなたの賢い縫製パートナー。私たちのアプリは、質問に対する迅速な回答や、正確な寸法などの縫製プロジェクトに役立つヒントを提供することで、縫製体験を簡素化するように設計されています。アプリを最大限に活用する方法は次のとおりです。',
      'pa':
          'ਤੁਹਾਡਾ ਸਮਾਰਟ ਸਿਲਾਈ ਸਾਥੀ। ਸਾਡੀ ਐਪ ਤੁਹਾਡੇ ਸਵਾਲਾਂ ਦੇ ਤੁਰੰਤ ਜਵਾਬ ਅਤੇ ਸਹੀ ਮਾਪਾਂ ਸਮੇਤ ਤੁਹਾਡੇ ਸਿਲਾਈ ਪ੍ਰੋਜੈਕਟਾਂ ਲਈ ਮਦਦਗਾਰ ਸੁਝਾਅ ਪ੍ਰਦਾਨ ਕਰਕੇ ਤੁਹਾਡੇ ਸਿਲਾਈ ਅਨੁਭਵ ਨੂੰ ਸਰਲ ਬਣਾਉਣ ਲਈ ਤਿਆਰ ਕੀਤੀ ਗਈ ਹੈ। ਸਾਡੀ ਐਪ ਦਾ ਵੱਧ ਤੋਂ ਵੱਧ ਲਾਭ ਲੈਣ ਦਾ ਤਰੀਕਾ ਇੱਥੇ ਹੈ।',
      'pt':
          'Seu parceiro de costura inteligente. Nosso aplicativo foi projetado para simplificar sua experiência de costura, fornecendo respostas rápidas às suas perguntas e dicas úteis para seus projetos de costura, incluindo dimensões precisas. Veja como aproveitar ao máximo nosso aplicativo.',
      'ru':
          'Ваш умный партнер по шитью. Наше приложение создано для того, чтобы упростить вам процесс шитья, предоставляя быстрые ответы на ваши вопросы и полезные советы для ваших швейных проектов, включая точные размеры. Вот как можно максимально эффективно использовать наше приложение.',
      'zh_Hans':
          '您的智能缝纫伙伴。我们的应用程序旨在通过提供问题的快速解答和缝纫项目的有用提示（包括精确的尺寸）来简化您的缝纫体验。以下是如何充分利用我们的应用程序。',
    },
    'ju70nl3z': {
      'fr': 'Étape 1: Connexion',
      'ar': 'الخطوة 1: تسجيل الدخول',
      'bn': 'ধাপ 1: লগইন করুন',
      'en': 'Step 1: Login',
      'es': 'Paso 1: Iniciar sesión',
      'hi': 'चरण 1: लॉगिन करें',
      'ja': 'ステップ 1: ログイン',
      'pa': 'ਕਦਮ 1: ਲੌਗਇਨ ਕਰੋ',
      'pt': 'Passo 1: Login',
      'ru': 'Шаг 1: Войдите',
      'zh_Hans': '第 1 步：登录',
    },
    'imr0wiic': {
      'fr':
          'Connectez-vous à votre compte ChatGPT en utilisant vos identifiants de connexion.',
      'ar':
          'قم بتسجيل الدخول إلى حساب ChatGPT الخاص بك باستخدام بيانات اعتماد تسجيل الدخول الخاصة بك.',
      'bn':
          'আপনার লগইন শংসাপত্র ব্যবহার করে আপনার ChatGPT অ্যাকাউন্টে লগ ইন করুন৷',
      'en': 'Log in to your ChatGPT account using your login credentials.',
      'es':
          'Inicie sesión en su cuenta ChatGPT con sus credenciales de inicio de sesión.',
      'hi':
          'अपने लॉगिन क्रेडेंशियल का उपयोग करके अपने ChatGPT खाते में लॉग इन करें।',
      'ja': 'ログイン資格情報を使用して ChatGPT アカウントにログインします。',
      'pa':
          'ਆਪਣੇ ਲੌਗਇਨ ਪ੍ਰਮਾਣ ਪੱਤਰਾਂ ਦੀ ਵਰਤੋਂ ਕਰਕੇ ਆਪਣੇ ਚੈਟਜੀਪੀਟੀ ਖਾਤੇ ਵਿੱਚ ਲੌਗ ਇਨ ਕਰੋ।',
      'pt': 'Faça login em sua conta ChatGPT usando suas credenciais de login.',
      'ru':
          'Войдите в свою учетную запись ChatGPT, используя свои учетные данные.',
      'zh_Hans': '使用您的登录凭据登录您的 ChatGPT 帐户。',
    },
    'w6gx9sn8': {
      'fr': 'Étape 2: Création d\'une conversation',
      'ar': 'الخطوة 2: إنشاء محادثة',
      'bn': 'ধাপ 2: একটি কথোপকথন তৈরি করা',
      'en': 'Step 2: Creating a Conversation',
      'es': 'Paso 2: crear una conversación',
      'hi': 'चरण 2: वार्तालाप बनाना',
      'ja': 'ステップ 2: 会話を作成する',
      'pa': 'ਕਦਮ 2: ਇੱਕ ਗੱਲਬਾਤ ਬਣਾਉਣਾ',
      'pt': 'Etapa 2: criando uma conversa',
      'ru': 'Шаг 2: Создание разговора',
      'zh_Hans': '第 2 步：创建对话',
    },
    'b5s6k6ds': {
      'fr':
          'Cliquez su poser une question dans le menu principal de l\'application.\nVous serez redirigée vers l\'interface de Seamstress IA où vous pourrez poser des questions et demander de l\'aide.',
      'ar':
          'اضغط على \"طرح سؤال\" في القائمة الرئيسية للتطبيق.\nستتم إعادة توجيهك إلى واجهة Seamstress AI حيث يمكنك طرح الأسئلة وطلب المساعدة.',
      'bn':
          'অ্যাপ্লিকেশনের প্রধান মেনুতে একটি প্রশ্ন জিজ্ঞাসা করুন এ ক্লিক করুন।\nআপনাকে সিমস্ট্রেস এআই ইন্টারফেসে পুনঃনির্দেশিত করা হবে যেখানে আপনি প্রশ্ন জিজ্ঞাসা করতে এবং সাহায্যের অনুরোধ করতে পারেন।',
      'en':
          'Click on ask a question in the main menu of the application.\nYou will be redirected to the Seamstress AI interface where you can ask questions and request help.',
      'es':
          'Haga clic en hacer una pregunta en el menú principal de la aplicación.\nSerás redirigido a la interfaz de Seamstress AI, donde podrás hacer preguntas y solicitar ayuda.',
      'hi':
          'एप्लिकेशन के मुख्य मेनू में प्रश्न पूछें पर क्लिक करें।\nआपको सीमस्ट्रेस एआई इंटरफ़ेस पर पुनः निर्देशित किया जाएगा जहां आप प्रश्न पूछ सकते हैं और सहायता का अनुरोध कर सकते हैं।',
      'ja':
          'アプリケーションのメインメニューで「質問する」をクリックします。\nSeamtress AI インターフェイスにリダイレクトされ、そこで質問したりヘルプをリクエストしたりできます。',
      'pa':
          'ਐਪਲੀਕੇਸ਼ਨ ਦੇ ਮੁੱਖ ਮੀਨੂ ਵਿੱਚ ਸਵਾਲ ਪੁੱਛੋ \'ਤੇ ਕਲਿੱਕ ਕਰੋ।\nਤੁਹਾਨੂੰ ਸੀਮਸਟ੍ਰੈਸ AI ਇੰਟਰਫੇਸ \'ਤੇ ਰੀਡਾਇਰੈਕਟ ਕੀਤਾ ਜਾਵੇਗਾ ਜਿੱਥੇ ਤੁਸੀਂ ਸਵਾਲ ਪੁੱਛ ਸਕਦੇ ਹੋ ਅਤੇ ਮਦਦ ਲਈ ਬੇਨਤੀ ਕਰ ਸਕਦੇ ਹੋ।',
      'pt':
          'Clique em fazer uma pergunta no menu principal do aplicativo.\nVocê será redirecionado para a interface do Seamstress AI, onde poderá fazer perguntas e solicitar ajuda.',
      'ru':
          'Нажмите «Задать вопрос» в главном меню приложения.\nВы будете перенаправлены в AI-интерфейс Seamstress, где сможете задавать вопросы и обращаться за помощью.',
      'zh_Hans': '单击应用程序主菜单中的“提问”。\n您将被重定向到 Seamstress AI 界面，您可以在其中提出问题并请求帮助。',
    },
    'uoe26e3z': {
      'fr': 'Étape 3: Interagir avec Seamstress',
      'ar': 'الخطوة 3: التفاعل مع الخياطة',
      'bn': 'ধাপ 3: সিমস্ট্রেসের সাথে যোগাযোগ করুন',
      'en': 'Step 3: Interact with Seamstress',
      'es': 'Paso 3: interactuar con la costurera',
      'hi': 'चरण 3: सीमस्ट्रेस के साथ बातचीत करें',
      'ja': 'ステップ 3: お針子と対話する',
      'pa': 'ਕਦਮ 3: ਸੀਮਸਟ੍ਰੈਸ ਨਾਲ ਗੱਲਬਾਤ ਕਰੋ',
      'pt': 'Passo 3: Interaja com a Costureira',
      'ru': 'Шаг 3: Взаимодействуйте со швеей',
      'zh_Hans': '第三步：与裁缝互动',
    },
    'kpudn5y3': {
      'fr':
          'Posez des questions ou engagez-vous dans une conversation avec Seamstress en utilisant des phrases claires et concises.',
      'ar':
          'اطرح أسئلة أو شارك في محادثة مع Seamstress باستخدام جمل واضحة وموجزة.',
      'bn':
          'প্রশ্ন জিজ্ঞাসা করুন বা স্পষ্ট, সংক্ষিপ্ত বাক্য ব্যবহার করে সিমস্ট্রেসের সাথে কথোপকথনে নিযুক্ত হন।',
      'en':
          'Ask questions or engage in conversation with Seamstress using clear, concise sentences.',
      'es':
          'Haga preguntas o entable una conversación con Seamstress utilizando oraciones claras y concisas.',
      'hi':
          'स्पष्ट, संक्षिप्त वाक्यों का उपयोग करके प्रश्न पूछें या सीमस्ट्रेस के साथ बातचीत में शामिल हों।',
      'ja': '明確で簡潔な文を使用して、裁縫師に質問したり会話をしたりしてください。',
      'pa':
          'ਸਵਾਲ ਪੁੱਛੋ ਜਾਂ ਸਪਸ਼ਟ, ਸੰਖੇਪ ਵਾਕਾਂ ਦੀ ਵਰਤੋਂ ਕਰਕੇ ਸੀਮਸਟ੍ਰੈਸ ਨਾਲ ਗੱਲਬਾਤ ਵਿੱਚ ਸ਼ਾਮਲ ਹੋਵੋ।',
      'pt':
          'Faça perguntas ou converse com a Costureira usando frases claras e concisas.',
      'ru':
          'Задавайте вопросы или общайтесь с Швеей, используя четкие и краткие предложения.',
      'zh_Hans': '使用清晰、简洁的句子提问或与女裁缝进行对话。',
    },
    'cxzm3z8y': {
      'fr': 'Étape 4: Analyser les réponses',
      'ar': 'الخطوة 4: تحليل الردود',
      'bn': 'ধাপ 4: প্রতিক্রিয়া বিশ্লেষণ করুন',
      'en': 'Step 4: Analyze the Responses',
      'es': 'Paso 4: Analizar las respuestas',
      'hi': 'चरण 4: प्रतिक्रियाओं का विश्लेषण करें',
      'ja': 'ステップ 4: 応答を分析する',
      'pa': 'ਕਦਮ 4: ਜਵਾਬਾਂ ਦਾ ਵਿਸ਼ਲੇਸ਼ਣ ਕਰੋ',
      'pt': 'Etapa 4: analise as respostas',
      'ru': 'Шаг 4. Проанализируйте ответы',
      'zh_Hans': '第 4 步：分析响应',
    },
    'q6skrylq': {
      'fr':
          'Analysez attentivement les réponses de Seamstress et ajustez vos questions ou vos instructions si nécessaire.',
      'ar':
          'قم بتحليل إجابات الخياطة بعناية وقم بتعديل أسئلتك أو تعليماتك إذا لزم الأمر.',
      'bn':
          'সিমস্ট্রেসের প্রতিক্রিয়াগুলি সাবধানে বিশ্লেষণ করুন এবং প্রয়োজনে আপনার প্রশ্ন বা নির্দেশাবলী সামঞ্জস্য করুন।',
      'en':
          'Analyze Seamstress\'s responses carefully and adjust your questions or instructions if necessary.',
      'es':
          'Analice cuidadosamente las respuestas de Seamstress y ajuste sus preguntas o instrucciones si es necesario.',
      'hi':
          'सीमस्ट्रेस की प्रतिक्रियाओं का सावधानीपूर्वक विश्लेषण करें और यदि आवश्यक हो तो अपने प्रश्नों या निर्देशों को समायोजित करें।',
      'ja': 'お針子さんの回答を注意深く分析し、必要に応じて質問や指示を調整します。',
      'pa':
          'ਸੀਮਸਟ੍ਰੈਸ ਦੇ ਜਵਾਬਾਂ ਦਾ ਧਿਆਨ ਨਾਲ ਵਿਸ਼ਲੇਸ਼ਣ ਕਰੋ ਅਤੇ ਜੇ ਲੋੜ ਹੋਵੇ ਤਾਂ ਆਪਣੇ ਸਵਾਲਾਂ ਜਾਂ ਨਿਰਦੇਸ਼ਾਂ ਨੂੰ ਵਿਵਸਥਿਤ ਕਰੋ।',
      'pt':
          'Analise cuidadosamente as respostas da Costureira e ajuste suas perguntas ou instruções se necessário.',
      'ru':
          'Внимательно проанализируйте ответы Швеи и при необходимости скорректируйте свои вопросы или инструкции.',
      'zh_Hans': '仔细分析女裁缝的回答，并在必要时调整您的问题或指示。',
    },
    'aipkewjv': {
      'fr': 'Suivant',
      'ar': 'التالي',
      'bn': 'অনুসরণ করছে',
      'en': 'Following',
      'es': 'Próximo',
      'hi': 'अगले',
      'ja': '続く',
      'pa': 'ਅਨੁਸਰਣ ਕਰ ਰਹੇ ਹਨ',
      'pt': 'Seguindo',
      'ru': 'Следующий',
      'zh_Hans': '下列的',
    },
    'gkxnie3t': {
      'fr': 'Guide d\'utilisation de ChatGPT',
      'ar': 'دليل مستخدم ChatGPT',
      'bn': 'ChatGPT ব্যবহারকারীর নির্দেশিকা',
      'en': 'ChatGPT User Guide',
      'es': 'Guía del usuario de ChatGPT',
      'hi': 'चैटजीपीटी उपयोगकर्ता गाइड',
      'ja': 'ChatGPT ユーザーガイド',
      'pa': 'ਚੈਟਜੀਪੀਟੀ ਯੂਜ਼ਰ ਗਾਈਡ',
      'pt': 'Guia do usuário ChatGPT',
      'ru': 'Руководство пользователя ChatGPT',
      'zh_Hans': 'ChatGPT 用户指南',
    },
  },
  // guide2
  {
    '9i7ppon9': {
      'fr':
          'Seamstress IA est là pour simplifier votre expérience de couture, que ce soit en répondant à vos questions générales ou en fournissant des détails précis, y compris les dimensions pour vos projets. N\'hésitez pas à poser toutes autres questions liées à la couture. Profitez de l\'assistance de Seamstress IA pour rendre votre expérience de couture encore plus agréable.\n\nNous espérons que cet outil renforcera vos compétences de couturière et que vous obtiendrez des réponses précises à toutes vos questions. Si vous avez des questions supplémentaires, n\'hésitez pas à nous contacter via le support.\n\n',
      'ar':
          'Seamstress AI موجود هنا لتبسيط تجربة الخياطة الخاصة بك، سواء عن طريق الإجابة على أسئلتك العامة أو تقديم تفاصيل محددة، بما في ذلك أبعاد مشاريعك. لا تتردد في طرح أي أسئلة أخرى تتعلق بالخياطة. استفد من دعم Seamstress AI لتجعل تجربة الخياطة الخاصة بك أكثر متعة.\n\nنأمل أن تعمل هذه الأداة على تعزيز مهاراتك كخياطة وأن تحصل على إجابات دقيقة لجميع أسئلتك. إذا كانت لديك أي أسئلة إضافية، فلا تتردد في الاتصال بنا عبر الدعم.',
      'bn':
          'সিমস্ট্রেস AI এখানে আপনার সেলাইয়ের অভিজ্ঞতাকে সহজ করতে, আপনার সাধারণ প্রশ্নের উত্তর দিয়ে বা আপনার প্রকল্পের মাত্রা সহ নির্দিষ্ট বিবরণ প্রদান করে। অনুগ্রহ করে নির্দ্বিধায় সেলাই-সম্পর্কিত অন্য কোনো প্রশ্ন জিজ্ঞাসা করুন। আপনার সেলাইয়ের অভিজ্ঞতাকে আরও আনন্দদায়ক করতে সিমস্ট্রেস এআই সমর্থনের সুবিধা নিন।\n\nআমরা আশা করি যে এই টুলটি একজন সিমস্ট্রেস হিসাবে আপনার দক্ষতাকে শক্তিশালী করবে এবং আপনি আপনার সমস্ত প্রশ্নের সুনির্দিষ্ট উত্তর পাবেন। আপনার যদি কোন অতিরিক্ত প্রশ্ন থাকে, অনুগ্রহ করে সমর্থনের মাধ্যমে আমাদের সাথে নির্দ্বিধায় যোগাযোগ করুন।',
      'en':
          'Seamstress AI is here to simplify your sewing experience, whether by answering your general questions or providing specific details, including dimensions for your projects. Please feel free to ask any other sewing-related questions. Take advantage of Seamstress AI support to make your sewing experience even more enjoyable.\n\nWe hope that this tool will strengthen your skills as a seamstress and that you will get precise answers to all your questions. If you have any additional questions, please feel free to contact us via Support.',
      'es':
          'Seamstress AI está aquí para simplificar su experiencia de costura, ya sea respondiendo sus preguntas generales o brindando detalles específicos, incluidas las dimensiones de sus proyectos. No dude en hacer cualquier otra pregunta relacionada con la costura. Aproveche el soporte de Seamstress AI para que su experiencia de costura sea aún más placentera.\n\nEsperamos que esta herramienta fortalezca tus habilidades como costurera y que obtengas respuestas precisas a todas tus preguntas. Si tiene alguna pregunta adicional, no dude en contactarnos a través de Soporte.',
      'hi':
          'सीमस्ट्रेस एआई आपके सिलाई अनुभव को सरल बनाने के लिए यहां है, चाहे आपके सामान्य प्रश्नों का उत्तर देकर या आपकी परियोजनाओं के आयामों सहित विशिष्ट विवरण प्रदान करके। कृपया बेझिझक सिलाई से संबंधित कोई भी अन्य प्रश्न पूछें। अपने सिलाई अनुभव को और भी अधिक मनोरंजक बनाने के लिए सीमस्ट्रेस एआई समर्थन का लाभ उठाएं।\n\nहमें उम्मीद है कि यह टूल एक दर्जी के रूप में आपके कौशल को मजबूत करेगा और आपको अपने सभी सवालों के सटीक उत्तर मिलेंगे। यदि आपके कोई अतिरिक्त प्रश्न हैं, तो कृपया बेझिझक सहायता के माध्यम से हमसे संपर्क करें।',
      'ja':
          'Seamtress AI は、一般的な質問に答えたり、プロジェクトの寸法などの具体的な詳細を提供したりして、縫製体験を簡素化します。その他縫製に関するご質問もお気軽にどうぞ。 Seamtress AI サポートを活用して、裁縫体験をさらに楽しくしましょう。\n\nこのツールがあなたの裁縫師としてのスキルを強化し、すべての質問に正確に答えられることを願っています。他にご不明な点がございましたら、お気軽にサポートまでお問い合わせください。',
      'pa':
          'ਸੀਮਸਟ੍ਰੈਸ AI ਤੁਹਾਡੇ ਸਿਲਾਈ ਅਨੁਭਵ ਨੂੰ ਸਰਲ ਬਣਾਉਣ ਲਈ ਇੱਥੇ ਹੈ, ਭਾਵੇਂ ਤੁਹਾਡੇ ਆਮ ਸਵਾਲਾਂ ਦੇ ਜਵਾਬ ਦੇ ਕੇ ਜਾਂ ਤੁਹਾਡੇ ਪ੍ਰੋਜੈਕਟਾਂ ਲਈ ਮਾਪਾਂ ਸਮੇਤ ਖਾਸ ਵੇਰਵੇ ਪ੍ਰਦਾਨ ਕਰਕੇ। ਕਿਰਪਾ ਕਰਕੇ ਸਿਲਾਈ ਨਾਲ ਸਬੰਧਤ ਕੋਈ ਹੋਰ ਸਵਾਲ ਪੁੱਛਣ ਲਈ ਬੇਝਿਜਕ ਮਹਿਸੂਸ ਕਰੋ। ਆਪਣੇ ਸਿਲਾਈ ਅਨੁਭਵ ਨੂੰ ਹੋਰ ਵੀ ਮਜ਼ੇਦਾਰ ਬਣਾਉਣ ਲਈ ਸੀਮਸਟ੍ਰੈਸ AI ਸਹਾਇਤਾ ਦਾ ਲਾਭ ਉਠਾਓ।\n\nਅਸੀਂ ਉਮੀਦ ਕਰਦੇ ਹਾਂ ਕਿ ਇਹ ਟੂਲ ਇੱਕ ਸੀਮਸਟ੍ਰੈਸ ਵਜੋਂ ਤੁਹਾਡੇ ਹੁਨਰ ਨੂੰ ਮਜ਼ਬੂਤ ​​ਕਰੇਗਾ ਅਤੇ ਤੁਹਾਨੂੰ ਤੁਹਾਡੇ ਸਾਰੇ ਸਵਾਲਾਂ ਦੇ ਸਹੀ ਜਵਾਬ ਮਿਲਣਗੇ। ਜੇਕਰ ਤੁਹਾਡੇ ਕੋਈ ਵਾਧੂ ਸਵਾਲ ਹਨ, ਤਾਂ ਕਿਰਪਾ ਕਰਕੇ ਸਹਾਇਤਾ ਦੁਆਰਾ ਸਾਡੇ ਨਾਲ ਸੰਪਰਕ ਕਰਨ ਲਈ ਬੇਝਿਜਕ ਮਹਿਸੂਸ ਕਰੋ।',
      'pt':
          'A Costureira AI está aqui para simplificar sua experiência de costura, seja respondendo suas dúvidas gerais ou fornecendo detalhes específicos, incluindo dimensões para seus projetos. Fique à vontade para fazer qualquer outra pergunta relacionada à costura. Aproveite o suporte do Seamstress AI para tornar sua experiência de costura ainda mais agradável.\n\nEsperamos que esta ferramenta fortaleça suas habilidades como costureira e que você obtenha respostas precisas para todas as suas dúvidas. Se você tiver alguma dúvida adicional, não hesite em nos contatar através do Suporte.',
      'ru':
          'Искусственный интеллект швеи здесь, чтобы упростить вам процесс шитья, отвечая на ваши общие вопросы или предоставляя конкретные детали, включая размеры для ваших проектов. Пожалуйста, не стесняйтесь задавать любые другие вопросы, связанные с шитьем. Воспользуйтесь поддержкой искусственного интеллекта Seamstress, чтобы сделать процесс шитья еще более приятным.\n\nМы надеемся, что этот инструмент укрепит ваши навыки швеи и вы получите точные ответы на все ваши вопросы. Если у вас есть дополнительные вопросы, пожалуйста, свяжитесь с нами через службу поддержки.',
      'zh_Hans':
          'Seamstress AI 旨在简化您的缝纫体验，无论是回答您的一般问题还是提供具体细节（包括项目的尺寸）。请随时询问任何其他与缝纫相关的问题。利用 Seamstress AI 支持让您的缝纫体验更加愉快。\n\n我们希望这个工具能够增强您作为裁缝的技能，并希望您能够得到所有问题的准确答案。如果您还有任何其他问题，请随时通过支持与我们联系。',
    },
    'r0nd6fzw': {
      'fr': 'Commencer',
      'ar': 'يبدأ',
      'bn': 'শুরুতেই',
      'en': 'To start',
      'es': 'Comenzar',
      'hi': 'आरंभ करना',
      'ja': '始めること',
      'pa': 'ਸੁਰੂ ਕਰਨਾ',
      'pt': 'Para iniciar',
      'ru': 'Начать',
      'zh_Hans': '开始',
    },
    'if5n2nuz': {
      'fr': 'Seamstress IA \n\n',
      'ar': 'خياطة منظمة العفو الدولية',
      'bn': 'সিমস্ট্রেস এআই',
      'en': 'Seamstress AI',
      'es': 'IA de costurera',
      'hi': 'सीमस्ट्रेस ए.आई',
      'ja': 'お針子AI',
      'pa': 'ਸੀਮਸਟ੍ਰੈਸ ਏ.ਆਈ',
      'pt': 'Costureira IA',
      'ru': 'Швея ИИ',
      'zh_Hans': '裁缝人工智能',
    },
  },
  // Notes
  {
    'aemm7bo7': {
      'fr': 'Notes',
      'ar': 'ملحوظات',
      'bn': 'মন্তব্য',
      'en': 'Notes',
      'es': 'Notas',
      'hi': 'टिप्पणियाँ',
      'ja': 'ノート',
      'pa': 'ਨੋਟਸ',
      'pt': 'Notas',
      'ru': 'Примечания',
      'zh_Hans': '笔记',
    },
    '0lxiqjeb': {
      'fr': 'Vos notes',
      'ar': 'الدرجات الخاصة بك',
      'bn': 'আপনার গ্রেড',
      'en': 'Your grades',
      'es': 'Tus calificaciones',
      'hi': 'आपके ग्रेड',
      'ja': 'あなたの成績',
      'pa': 'ਤੁਹਾਡੇ ਗ੍ਰੇਡ',
      'pt': 'Suas notas',
      'ru': 'Ваши оценки',
      'zh_Hans': '你的成绩',
    },
  },
  // NewTachesPage
  {
    'sxo7jl1p': {
      'fr': 'Entrez votre note ici...',
      'ar': 'أدخل تقييمك هنا...',
      'bn': 'এখানে আপনার রেটিং লিখুন...',
      'en': 'Enter your rating here...',
      'es': 'Ingresa tu calificación aquí...',
      'hi': 'अपनी रेटिंग यहां दर्ज करें...',
      'ja': 'ここに評価を入力してください...',
      'pa': 'ਇੱਥੇ ਆਪਣੀ ਰੇਟਿੰਗ ਦਰਜ ਕਰੋ...',
      'pt': 'Digite sua classificação aqui...',
      'ru': 'Введите свой рейтинг здесь...',
      'zh_Hans': '在此输入您的评分...',
    },
    '34nhbszx': {
      'fr': 'Enregistrer',
      'ar': 'يحفظ',
      'bn': 'সংরক্ষণ',
      'en': 'Save',
      'es': 'Ahorrar',
      'hi': 'बचाना',
      'ja': '保存',
      'pa': 'ਸੇਵ ਕਰੋ',
      'pt': 'Salvar',
      'ru': 'Сохранять',
      'zh_Hans': '节省',
    },
    'eaiip3u0': {
      'fr': 'Nouvelle note',
      'ar': 'ملاحظة جديدة',
      'bn': 'নতুন নোট',
      'en': 'New note',
      'es': 'Nueva nota',
      'hi': 'नया नोट',
      'ja': '新しいメモ',
      'pa': 'ਨਵਾਂ ਨੋਟ',
      'pt': 'Nova nota',
      'ru': 'Новая заметка',
      'zh_Hans': '新笔记',
    },
    'l86ztu9a': {
      'fr': 'Home',
      'ar': 'بيت',
      'bn': 'বাড়ি',
      'en': 'Home',
      'es': 'Hogar',
      'hi': 'घर',
      'ja': '家',
      'pa': 'ਘਰ',
      'pt': 'Lar',
      'ru': 'Дом',
      'zh_Hans': '家',
    },
  },
  // CompleteProfile
  {
    'lphrsx61': {
      'fr': 'Complete ton profil',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'uvmeqvkt': {
      'fr': 'mets  ton  image',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    '7byx9iuo': {
      'fr': 'Entrez votre  nom',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'qkzkp9ro': {
      'fr': 'Continuer',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'zl05l8u2': {
      'fr': 'Home',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
  },
  // feed
  {
    'rojke5wy': {
      'fr': 'Sonapp',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'crqr384p': {
      'fr': '256',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'nwdpwm8m': {
      'fr': '36',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    '1fqaa3ve': {
      'fr': 'Home',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
  },
  // createPost
  {
    'osuf6isq': {
      'fr': 'Cancel',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'gfbq7mzo': {
      'fr': 'Post',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'mi66e5lk': {
      'fr': 'Tell your opinion ...',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'j2b2d332': {
      'fr': 'Home',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
  },
  // BlankListComponent
  {
    'j3uug69p': {
      'fr': 'seamstress',
      'ar': 'خياطة',
      'bn': 'মেয়ে - দর্জি',
      'en': 'seamstress',
      'es': 'costurera',
      'hi': 'सीनेवाली स्री',
      'ja': '裁縫師',
      'pa': 'ਸੀਮਸਟਰੈਸ',
      'pt': 'costureira',
      'ru': 'швея',
      'zh_Hans': '裁缝',
    },
  },
  // Miscellaneous
  {
    '04ymqex3': {
      'fr':
          'Pour prendre une photo ou une vidéo, cette application nécessite une autorisation d\'accès à l\'appareil photo.',
      'ar':
          'لالتقاط صورة أو مقطع فيديو، يتطلب هذا التطبيق إذنًا للوصول إلى الكاميرا.',
      'bn':
          'একটি ছবি বা ভিডিও তুলতে, এই অ্যাপটির ক্যামেরা অ্যাক্সেসের অনুমতি প্রয়োজন৷',
      'en':
          'To take a photo or video, this app requires camera access permission.',
      'es':
          'Para tomar una foto o un video, esta aplicación requiere permiso de acceso a la cámara.',
      'hi':
          'फोटो या वीडियो लेने के लिए इस ऐप को कैमरा एक्सेस अनुमति की आवश्यकता होती है।',
      'ja': 'このアプリで写真やビデオを撮影するには、カメラへのアクセス許可が必要です。',
      'pa':
          'ਇੱਕ ਫੋਟੋ ਜਾਂ ਵੀਡੀਓ ਲੈਣ ਲਈ, ਇਸ ਐਪ ਨੂੰ ਕੈਮਰੇ ਤੱਕ ਪਹੁੰਚ ਦੀ ਇਜਾਜ਼ਤ ਦੀ ਲੋੜ ਹੁੰਦੀ ਹੈ।',
      'pt':
          'Para tirar uma foto ou gravar um vídeo, este aplicativo requer permissão de acesso à câmera.',
      'ru':
          'Чтобы сделать фото или видео, этому приложению требуется разрешение на доступ к камере.',
      'zh_Hans': '要拍摄照片或视频，此应用程序需要相机访问权限。',
    },
    'oi7s9609': {
      'fr':
          'Pour pouvoir télécharger des données, cette application nécessite l\'autorisation d\'accéder à la photothèque.',
      'ar':
          'لتتمكن من تنزيل البيانات، يتطلب هذا التطبيق إذنًا للوصول إلى مكتبة الصور.',
      'bn':
          'ডেটা ডাউনলোড করতে সক্ষম হতে, এই অ্যাপ্লিকেশনটির ফটো লাইব্রেরি অ্যাক্সেস করার অনুমতি প্রয়োজন৷',
      'en':
          'To be able to download data, this application requires permission to access the photo library.',
      'es':
          'Para poder descargar datos, esta aplicación requiere permiso para acceder a la biblioteca de fotos.',
      'hi':
          'डेटा डाउनलोड करने में सक्षम होने के लिए, इस एप्लिकेशन को फोटो लाइब्रेरी तक पहुंचने की अनुमति की आवश्यकता होती है।',
      'ja': 'このアプリケーションがデータをダウンロードするには、フォトライブラリへのアクセス許可が必要です。',
      'pa':
          'ਡਾਟਾ ਡਾਊਨਲੋਡ ਕਰਨ ਦੇ ਯੋਗ ਹੋਣ ਲਈ, ਇਸ ਐਪਲੀਕੇਸ਼ਨ ਨੂੰ ਫੋਟੋ ਲਾਇਬ੍ਰੇਰੀ ਤੱਕ ਪਹੁੰਚ ਕਰਨ ਦੀ ਇਜਾਜ਼ਤ ਦੀ ਲੋੜ ਹੈ।',
      'pt':
          'Para poder baixar dados, este aplicativo requer permissão para acessar a biblioteca de fotos.',
      'ru':
          'Чтобы иметь возможность загружать данные, этому приложению требуется разрешение на доступ к библиотеке фотографий.',
      'zh_Hans': '为了能够下载数据，该应用程序需要访问照片库的权限。',
    },
    '0jsnk8f8': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'qjhb3pc9': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'd68sqgqr': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    '7wp6q61b': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'd7pl7sjv': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    '1rpxlnh5': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'kum7z80r': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'oybct1i4': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    '85t3j0qv': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'dur4yqu6': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'rxlql565': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'p05x450k': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    '1b6y2dxe': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'f40rc5ji': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'k278efdy': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'fg76o39g': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'ezlfede9': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'zsun6okv': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'h488ih1d': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    '5ssin1dv': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'zh8pm5fl': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    'ekrb0fro': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
    '2zp8wlgl': {
      'fr': '',
      'ar': '',
      'bn': '',
      'en': '',
      'es': '',
      'hi': '',
      'ja': '',
      'pa': '',
      'pt': '',
      'ru': '',
      'zh_Hans': '',
    },
  },
].reduce((a, b) => a..addAll(b));
