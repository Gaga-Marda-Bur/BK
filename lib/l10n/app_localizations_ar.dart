// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'بريار كيدبيديري';

  @override
  String get question => 'سؤال';

  @override
  String get previous => 'السابق';

  @override
  String get next => 'التالي';

  @override
  String get quizFinished => 'انتهى الاختبار!';

  @override
  String get score => 'الدرجة :';

  @override
  String get correctAnswersOf => 'إجابات صحيحة من';

  @override
  String get restart => 'إعادة المحاولة';

  @override
  String get back => 'عودة';

  @override
  String get arkab => 'أركاب';

  @override
  String get basigna => 'باسيجنا';

  @override
  String get darbai => 'دارباي';

  @override
  String get eh => 'إيه';

  @override
  String get fitko => 'فيتكو';

  @override
  String get goway => 'جواي';

  @override
  String get hirdeabo => 'هيرديابو';

  @override
  String get i => 'آي';

  @override
  String get djai => 'جاي';

  @override
  String get kobo => 'كوبو';

  @override
  String get lakko => 'لاككو';

  @override
  String get meri => 'ميري';

  @override
  String get nini => 'نيني';

  @override
  String get gna => 'جنا';

  @override
  String get ngay => 'نجاي';

  @override
  String get oi => 'أوي';

  @override
  String get pi => 'بي';

  @override
  String get erigo => 'إريغو';

  @override
  String get erigoTamura => 'إريغو تامورا';

  @override
  String get seri => 'سيري';

  @override
  String get shep => 'شيب';

  @override
  String get tatasuwe => 'تاتاسووي';

  @override
  String get ui => 'أوي';

  @override
  String get wasse => 'واسي';

  @override
  String get ay => 'أي';

  @override
  String get house => 'منزل';

  @override
  String get water => 'ماء';

  @override
  String get sun => 'شمس';

  @override
  String get tree => 'شجرة';

  @override
  String get person => 'شخص';

  @override
  String get food => 'طعام';

  @override
  String get family => 'عائلة';

  @override
  String get night => 'ليل';

  @override
  String get village => 'قرية';

  @override
  String get forest => 'غابة';

  @override
  String get mountain => 'جبل';

  @override
  String get river => 'نهر';

  @override
  String get fire => 'نار';

  @override
  String get sky => 'سماء';

  @override
  String get star => 'نجمة';

  @override
  String get moon => 'قمر';

  @override
  String get ocean => 'محيط';

  @override
  String get rain => 'مطر';

  @override
  String get wind => 'ريح';

  @override
  String get earth => 'أرض';

  @override
  String get goodEvening => 'مساء الخير';

  @override
  String get goodMorning => 'صباح الخير';

  @override
  String get goodbye => 'وداعًا';

  @override
  String get please => 'من فضلك';

  @override
  String characterRecognitionQuestion(Object character) {
    return 'ما هذا الحرف؟ $character';
  }

  @override
  String characterRepresentationQuestion(Object name) {
    return 'أي حرف يمثل \"$name\"؟';
  }

  @override
  String vocabularyQuestion(Object word) {
    return 'ماذا يعني \"$word\"؟';
  }

  @override
  String sentenceQuestion(Object phrase) {
    return 'كيف تقول \"$phrase\" في لغة بيريا؟';
  }

  @override
  String characterExplanation(Object character, Object name) {
    return 'الحرف $character يمثل \"$name\" في لغة بيريا إيرفي.';
  }

  @override
  String reverseCharacterExplanation(Object character, Object name) {
    return '\"$name\" يمثله الحرف $character في لغة بيريا إيرفي.';
  }

  @override
  String vocabularyExplanation(Object meaning, Object word) {
    return '\"$word\" يعني \"$meaning\" في لغة بيريا إيرفي.';
  }

  @override
  String sentenceExplanation(Object phrase, Object translation) {
    return '\"$phrase\" يقال \"$translation\" في لغة بيريا.';
  }

  @override
  String get vocabularyTitle => 'مفردات بيريا ';

  @override
  String get vocabularyDescription => 'تعلم الكلمات الشائعة بلغة بيريا إرفي. اضغط على كل كلمة لسماع نطقها.';

  @override
  String get favoritesInstruction => 'اضغط ★ لإضافتها إلى المفضلة';

  @override
  String addedToFavorites(Object word) {
    return 'تمت إضافة $word إلى المفضلة ★';
  }

  @override
  String removedFromFavorites(Object word) {
    return 'تمت إزالة $word من المفضلة ☆';
  }

  @override
  String get audioFileNotFound => 'ملف الصوت غير موجود';

  @override
  String get tapToListen => 'اضغط للاستماع';

  @override
  String get typeTextLabel => 'اكتب بلغة بيريا إرفي:';

  @override
  String get addToFavorites => 'إضافة إلى المفضلة';

  @override
  String get removeFromFavorites => 'إزالة من المفضلة';

  @override
  String get textOptions => 'خيارات النص:';

  @override
  String get fontSizeLabel => 'حجم الخط:';

  @override
  String get fontWeightLabel => 'سمك الخط:';

  @override
  String get charactersLabel => 'حروف بيريا إرفي:';

  @override
  String get copiedToClipboard => 'تم النسخ إلى الحافظة';

  @override
  String get noTextToCopy => 'لا يوجد نص للنسخ';

  @override
  String get savedToHistory => 'تم حفظ النص في السجل';

  @override
  String get emptyTextWarning => 'النص فارغ';

  @override
  String get resourcesLabel => 'الموارد';

  @override
  String get unicodeAnnouncement => 'إعلان اليونيكود 17.0';

  @override
  String get kedebideriFont => 'خط كيدي بيديري';

  @override
  String get keymanKeyboard => 'لوحة مفاتيح كيمان';

  @override
  String get characterReference => 'مرجع الحروف';

  @override
  String openLink(Object url) {
    return 'فتح: $url';
  }

  @override
  String get demo => 'عرض توضيحي';

  @override
  String get information => 'معلومات';

  @override
  String get vocabulary => 'المفردات';

  @override
  String get quiz => 'اختبار';

  @override
  String get gallery => 'معرض';

  @override
  String get history => 'السجل';

  @override
  String get favorites => 'المفضلة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get exploreZaghawa => 'استكشف لغة الزغاوة';

  @override
  String get beriyaErfe => 'بريار كيدبيديري';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get soundEffects => 'التأثيرات الصوتية';

  @override
  String get vibrations => 'الاهتزاز';

  @override
  String get autoSaveHistory => 'حفظ السجل تلقائيًا';

  @override
  String get appearance => 'المظهر';

  @override
  String get defaultFontSize => 'حجم الخط الافتراضي';

  @override
  String get theme => 'الثيم';

  @override
  String get classic => 'كلاسيكي';

  @override
  String get dark => 'داكن';

  @override
  String get light => 'فاتح';

  @override
  String get dataManagement => 'إدارة البيانات';

  @override
  String get clearHistory => 'مسح السجل';

  @override
  String get clearFavorites => 'مسح المفضلة';

  @override
  String get exportData => 'تصدير البيانات';

  @override
  String get language => 'اللغة';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get historyCleared => 'تم مسح السجل';

  @override
  String get delete => 'حذف';

  @override
  String get space => 'مسافة';

  @override
  String get clear => 'كل شيء';

  @override
  String get aboutBeriaErfe => 'حول بيريا إرفي';

  @override
  String get aboutBeriaErfeDescription => 'بيريا إرفي أصبح الآن جزءًا من اليونيكود 17.0. يستخدم هذا التطبيق خطوط Kedebideri لعرض النص. استخدم لوحة المفاتيح أدناه لكتابة أحرف بيريا إرفي.';

  @override
  String get ok => 'حسناً';

  @override
  String get galleryTitle => 'معرض الصور';

  @override
  String get gallerySubtitle => 'اكتشف جمال كتابة البيريا إرفي';

  @override
  String get categoryCharacters => 'الحروف';

  @override
  String get categoryWords => 'الكلمات الشائعة';

  @override
  String get categoryCulture => 'الثقافة';

  @override
  String get noImage => 'لا توجد صور متاحة';

  @override
  String get comingSoon => 'سيتم إضافة الصور قريباً';

  @override
  String get myFavorites => 'مفضلتي ★';

  @override
  String get favoriteUpdated => 'تم تحديث المفضلة';

  @override
  String get clearFavoritesTitle => 'مسح جميع المفضلات';

  @override
  String get clearFavoritesConfirm => 'هل أنت متأكد أنك تريد مسح جميع المفضلات؟';

  @override
  String get favoritesCleared => 'تمت إزالة جميع المفضلات';

  @override
  String get noFavorites => 'لا توجد مفضلات';

  @override
  String get addFavoritesHint => 'أضف كلمات أو حروف إلى المفضلة عن طريق النقر على أيقونة النجمة';

  @override
  String get addedOn => 'أضيف في';

  @override
  String get removeFavorite => 'إزالة من المفضلة';

  @override
  String get noHistory => 'لا يوجد سجل';

  @override
  String get yourTextsWillAppear => 'النصوص التي تكتبها ستظهر هنا';

  @override
  String get clearHistoryConfirm => 'هل أنت متأكد أنك تريد مسح السجل بالكامل؟ هذا الإجراء لا يمكن التراجع عنه.';

  @override
  String get deleteItem => 'حذف العنصر';

  @override
  String deleteConfirm(Object item) {
    return 'هل أنت متأكد أنك تريد حذف \"$item\"؟';
  }

  @override
  String get itemDeleted => 'تم حذف العنصر';

  @override
  String get copied => 'تم نسخ النص إلى الحافظة';

  @override
  String get copyError => 'حدث خطأ أثناء النسخ';

  @override
  String createdOn(Object date) {
    return 'تم الإنشاء في $date';
  }

  @override
  String get more => 'المزيد';

  @override
  String get save => 'حفظ';

  @override
  String get copy => 'نسخ';

  @override
  String get character => 'الحرف';

  @override
  String get word => 'كلمة';

  @override
  String get traditionalArt => 'الفن التقليدي';

  @override
  String get traditionalCeremony => 'المراسم التقليدية';

  @override
  String get traditionalCostumes => 'الأزياء التقليدية';

  @override
  String get localCrafts => 'الحرف اليدوية المحلية';

  @override
  String get cancel => 'إلغاء';

  @override
  String get clearAll => 'مسح الكل';
}
