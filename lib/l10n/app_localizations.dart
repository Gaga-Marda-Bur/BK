import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Beriyar Kedebideri'**
  String get appTitle;

  /// No description provided for @question.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @quizFinished.
  ///
  /// In en, this message translates to:
  /// **'Quiz Finished!'**
  String get quizFinished;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score:'**
  String get score;

  /// No description provided for @correctAnswersOf.
  ///
  /// In en, this message translates to:
  /// **'correct answers out of'**
  String get correctAnswersOf;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get restart;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @arkab.
  ///
  /// In en, this message translates to:
  /// **'Arkab'**
  String get arkab;

  /// No description provided for @basigna.
  ///
  /// In en, this message translates to:
  /// **'Basigna'**
  String get basigna;

  /// No description provided for @darbai.
  ///
  /// In en, this message translates to:
  /// **'Darbai'**
  String get darbai;

  /// No description provided for @eh.
  ///
  /// In en, this message translates to:
  /// **'Eh'**
  String get eh;

  /// No description provided for @fitko.
  ///
  /// In en, this message translates to:
  /// **'Fitko'**
  String get fitko;

  /// No description provided for @goway.
  ///
  /// In en, this message translates to:
  /// **'Goway'**
  String get goway;

  /// No description provided for @hirdeabo.
  ///
  /// In en, this message translates to:
  /// **'Hirdeabo'**
  String get hirdeabo;

  /// No description provided for @i.
  ///
  /// In en, this message translates to:
  /// **'I'**
  String get i;

  /// No description provided for @djai.
  ///
  /// In en, this message translates to:
  /// **'Djai'**
  String get djai;

  /// No description provided for @kobo.
  ///
  /// In en, this message translates to:
  /// **'Kobo'**
  String get kobo;

  /// No description provided for @lakko.
  ///
  /// In en, this message translates to:
  /// **'Lakko'**
  String get lakko;

  /// No description provided for @meri.
  ///
  /// In en, this message translates to:
  /// **'Meri'**
  String get meri;

  /// No description provided for @nini.
  ///
  /// In en, this message translates to:
  /// **'Nini'**
  String get nini;

  /// No description provided for @gna.
  ///
  /// In en, this message translates to:
  /// **'Gna'**
  String get gna;

  /// No description provided for @ngay.
  ///
  /// In en, this message translates to:
  /// **'Ngay'**
  String get ngay;

  /// No description provided for @oi.
  ///
  /// In en, this message translates to:
  /// **'Oi'**
  String get oi;

  /// No description provided for @pi.
  ///
  /// In en, this message translates to:
  /// **'Pi'**
  String get pi;

  /// No description provided for @erigo.
  ///
  /// In en, this message translates to:
  /// **'Erigo'**
  String get erigo;

  /// No description provided for @erigoTamura.
  ///
  /// In en, this message translates to:
  /// **'Erigo Tamura'**
  String get erigoTamura;

  /// No description provided for @seri.
  ///
  /// In en, this message translates to:
  /// **'Seri'**
  String get seri;

  /// No description provided for @shep.
  ///
  /// In en, this message translates to:
  /// **'Shep'**
  String get shep;

  /// No description provided for @tatasuwe.
  ///
  /// In en, this message translates to:
  /// **'Tatasuwe'**
  String get tatasuwe;

  /// No description provided for @ui.
  ///
  /// In en, this message translates to:
  /// **'Ui'**
  String get ui;

  /// No description provided for @wasse.
  ///
  /// In en, this message translates to:
  /// **'Wasse'**
  String get wasse;

  /// No description provided for @ay.
  ///
  /// In en, this message translates to:
  /// **'Ay'**
  String get ay;

  /// No description provided for @house.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get house;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sun;

  /// No description provided for @tree.
  ///
  /// In en, this message translates to:
  /// **'Tree'**
  String get tree;

  /// No description provided for @person.
  ///
  /// In en, this message translates to:
  /// **'Person'**
  String get person;

  /// No description provided for @food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// No description provided for @family.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get family;

  /// No description provided for @night.
  ///
  /// In en, this message translates to:
  /// **'Night'**
  String get night;

  /// No description provided for @village.
  ///
  /// In en, this message translates to:
  /// **'Village'**
  String get village;

  /// No description provided for @forest.
  ///
  /// In en, this message translates to:
  /// **'Forest'**
  String get forest;

  /// No description provided for @mountain.
  ///
  /// In en, this message translates to:
  /// **'Mountain'**
  String get mountain;

  /// No description provided for @river.
  ///
  /// In en, this message translates to:
  /// **'River'**
  String get river;

  /// No description provided for @fire.
  ///
  /// In en, this message translates to:
  /// **'Fire'**
  String get fire;

  /// No description provided for @sky.
  ///
  /// In en, this message translates to:
  /// **'Sky'**
  String get sky;

  /// No description provided for @star.
  ///
  /// In en, this message translates to:
  /// **'Star'**
  String get star;

  /// No description provided for @moon.
  ///
  /// In en, this message translates to:
  /// **'Moon'**
  String get moon;

  /// No description provided for @ocean.
  ///
  /// In en, this message translates to:
  /// **'Ocean'**
  String get ocean;

  /// No description provided for @rain.
  ///
  /// In en, this message translates to:
  /// **'Rain'**
  String get rain;

  /// No description provided for @wind.
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get wind;

  /// No description provided for @earth.
  ///
  /// In en, this message translates to:
  /// **'Earth'**
  String get earth;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get goodEvening;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

  /// No description provided for @goodbye.
  ///
  /// In en, this message translates to:
  /// **'Goodbye'**
  String get goodbye;

  /// No description provided for @please.
  ///
  /// In en, this message translates to:
  /// **'Please'**
  String get please;

  /// No description provided for @characterRecognitionQuestion.
  ///
  /// In en, this message translates to:
  /// **'What is this character? {character}'**
  String characterRecognitionQuestion(Object character);

  /// No description provided for @characterRepresentationQuestion.
  ///
  /// In en, this message translates to:
  /// **'Which character represents \"{name}\"?'**
  String characterRepresentationQuestion(Object name);

  /// No description provided for @vocabularyQuestion.
  ///
  /// In en, this message translates to:
  /// **'What does \"{word}\" mean?'**
  String vocabularyQuestion(Object word);

  /// No description provided for @sentenceQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do you say \"{phrase}\" in Beriya?'**
  String sentenceQuestion(Object phrase);

  /// No description provided for @characterExplanation.
  ///
  /// In en, this message translates to:
  /// **'The character {character} represents \"{name}\" in Beria Erfe.'**
  String characterExplanation(Object character, Object name);

  /// No description provided for @reverseCharacterExplanation.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" is represented by the character {character} in Beria Erfe.'**
  String reverseCharacterExplanation(Object character, Object name);

  /// No description provided for @vocabularyExplanation.
  ///
  /// In en, this message translates to:
  /// **'\"{word}\" means \"{meaning}\" in Beria Erfe.'**
  String vocabularyExplanation(Object meaning, Object word);

  /// No description provided for @sentenceExplanation.
  ///
  /// In en, this message translates to:
  /// **'\"{phrase}\" is said \"{translation}\" in Beriya.'**
  String sentenceExplanation(Object phrase, Object translation);

  /// No description provided for @vocabularyTitle.
  ///
  /// In en, this message translates to:
  /// **'Beriya Vocabulary'**
  String get vocabularyTitle;

  /// No description provided for @vocabularyDescription.
  ///
  /// In en, this message translates to:
  /// **'Learn common Beria Erfe words. Tap each word to hear its pronunciation.'**
  String get vocabularyDescription;

  /// No description provided for @favoritesInstruction.
  ///
  /// In en, this message translates to:
  /// **'Tap ★ to add to favorites'**
  String get favoritesInstruction;

  /// No description provided for @addedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'{word} added to favorites ★'**
  String addedToFavorites(Object word);

  /// No description provided for @removedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'{word} removed from favorites ☆'**
  String removedFromFavorites(Object word);

  /// No description provided for @audioFileNotFound.
  ///
  /// In en, this message translates to:
  /// **'Audio file not found'**
  String get audioFileNotFound;

  /// No description provided for @tapToListen.
  ///
  /// In en, this message translates to:
  /// **'Tap to listen'**
  String get tapToListen;

  /// No description provided for @typeTextLabel.
  ///
  /// In en, this message translates to:
  /// **'Type in Beriya Erfe:'**
  String get typeTextLabel;

  /// No description provided for @addToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get addToFavorites;

  /// No description provided for @removeFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get removeFromFavorites;

  /// No description provided for @textOptions.
  ///
  /// In en, this message translates to:
  /// **'Text options:'**
  String get textOptions;

  /// No description provided for @fontSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Font size:'**
  String get fontSizeLabel;

  /// No description provided for @fontWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Font weight:'**
  String get fontWeightLabel;

  /// No description provided for @charactersLabel.
  ///
  /// In en, this message translates to:
  /// **'Beriya Erfe Characters:'**
  String get charactersLabel;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @noTextToCopy.
  ///
  /// In en, this message translates to:
  /// **'No text to copy'**
  String get noTextToCopy;

  /// No description provided for @savedToHistory.
  ///
  /// In en, this message translates to:
  /// **'Text saved to history'**
  String get savedToHistory;

  /// No description provided for @emptyTextWarning.
  ///
  /// In en, this message translates to:
  /// **'Text is empty'**
  String get emptyTextWarning;

  /// No description provided for @resourcesLabel.
  ///
  /// In en, this message translates to:
  /// **'Resources'**
  String get resourcesLabel;

  /// No description provided for @unicodeAnnouncement.
  ///
  /// In en, this message translates to:
  /// **'Unicode 17.0 Announcement'**
  String get unicodeAnnouncement;

  /// No description provided for @kedebideriFont.
  ///
  /// In en, this message translates to:
  /// **'Kedebideri Font'**
  String get kedebideriFont;

  /// No description provided for @keymanKeyboard.
  ///
  /// In en, this message translates to:
  /// **'Keyman Keyboard'**
  String get keymanKeyboard;

  /// No description provided for @characterReference.
  ///
  /// In en, this message translates to:
  /// **'Character Reference'**
  String get characterReference;

  /// No description provided for @openLink.
  ///
  /// In en, this message translates to:
  /// **'Open: {url}'**
  String openLink(Object url);

  /// No description provided for @demo.
  ///
  /// In en, this message translates to:
  /// **'Demo'**
  String get demo;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @vocabulary.
  ///
  /// In en, this message translates to:
  /// **'Vocabulary'**
  String get vocabulary;

  /// No description provided for @quiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get quiz;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @exploreZaghawa.
  ///
  /// In en, this message translates to:
  /// **'Explore the Zaghawa language'**
  String get exploreZaghawa;

  /// No description provided for @beriyaErfe.
  ///
  /// In en, this message translates to:
  /// **'Beriya Erfe'**
  String get beriyaErfe;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @soundEffects.
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get soundEffects;

  /// No description provided for @vibrations.
  ///
  /// In en, this message translates to:
  /// **'Vibrations'**
  String get vibrations;

  /// No description provided for @autoSaveHistory.
  ///
  /// In en, this message translates to:
  /// **'Auto-save History'**
  String get autoSaveHistory;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @defaultFontSize.
  ///
  /// In en, this message translates to:
  /// **'Default Font Size'**
  String get defaultFontSize;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @classic.
  ///
  /// In en, this message translates to:
  /// **'Classic'**
  String get classic;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dataManagement.
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get dataManagement;

  /// No description provided for @clearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear History'**
  String get clearHistory;

  /// No description provided for @clearFavorites.
  ///
  /// In en, this message translates to:
  /// **'Clear Favorites'**
  String get clearFavorites;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportData;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @historyCleared.
  ///
  /// In en, this message translates to:
  /// **'History cleared'**
  String get historyCleared;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @space.
  ///
  /// In en, this message translates to:
  /// **'Space'**
  String get space;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @aboutBeriaErfe.
  ///
  /// In en, this message translates to:
  /// **'About Beria Erfe'**
  String get aboutBeriaErfe;

  /// No description provided for @aboutBeriaErfeDescription.
  ///
  /// In en, this message translates to:
  /// **'Beria Erfe is now part of Unicode 17.0. This app uses Kedebideri fonts to display the script. Use the keyboard below to type Beria Erfe characters.'**
  String get aboutBeriaErfeDescription;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @galleryTitle.
  ///
  /// In en, this message translates to:
  /// **'Image Gallery'**
  String get galleryTitle;

  /// No description provided for @gallerySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discover the beauty of the Beria Erfe script'**
  String get gallerySubtitle;

  /// No description provided for @categoryCharacters.
  ///
  /// In en, this message translates to:
  /// **'Characters'**
  String get categoryCharacters;

  /// No description provided for @categoryWords.
  ///
  /// In en, this message translates to:
  /// **'Common Words'**
  String get categoryWords;

  /// No description provided for @categoryCulture.
  ///
  /// In en, this message translates to:
  /// **'Culture'**
  String get categoryCulture;

  /// No description provided for @noImage.
  ///
  /// In en, this message translates to:
  /// **'No images available'**
  String get noImage;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Images will be added soon'**
  String get comingSoon;

  /// No description provided for @myFavorites.
  ///
  /// In en, this message translates to:
  /// **'My Favorites ★'**
  String get myFavorites;

  /// No description provided for @favoriteUpdated.
  ///
  /// In en, this message translates to:
  /// **'Favorite updated'**
  String get favoriteUpdated;

  /// No description provided for @clearFavoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all favorites'**
  String get clearFavoritesTitle;

  /// No description provided for @clearFavoritesConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all your favorites?'**
  String get clearFavoritesConfirm;

  /// No description provided for @favoritesCleared.
  ///
  /// In en, this message translates to:
  /// **'All favorites have been removed'**
  String get favoritesCleared;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'No favorites'**
  String get noFavorites;

  /// No description provided for @addFavoritesHint.
  ///
  /// In en, this message translates to:
  /// **'Add words or characters to favorites by clicking the star icon'**
  String get addFavoritesHint;

  /// No description provided for @addedOn.
  ///
  /// In en, this message translates to:
  /// **'Added on'**
  String get addedOn;

  /// No description provided for @removeFavorite.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get removeFavorite;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'No history'**
  String get noHistory;

  /// No description provided for @yourTextsWillAppear.
  ///
  /// In en, this message translates to:
  /// **'Your typed texts will appear here'**
  String get yourTextsWillAppear;

  /// No description provided for @clearHistoryConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all history? This action is irreversible.'**
  String get clearHistoryConfirm;

  /// No description provided for @deleteItem.
  ///
  /// In en, this message translates to:
  /// **'Delete item'**
  String get deleteItem;

  /// No description provided for @deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{item}\"?'**
  String deleteConfirm(Object item);

  /// No description provided for @itemDeleted.
  ///
  /// In en, this message translates to:
  /// **'Item deleted'**
  String get itemDeleted;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Text copied to clipboard'**
  String get copied;

  /// No description provided for @copyError.
  ///
  /// In en, this message translates to:
  /// **'Error while copying'**
  String get copyError;

  /// No description provided for @createdOn.
  ///
  /// In en, this message translates to:
  /// **'Created on {date}'**
  String createdOn(Object date);

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @character.
  ///
  /// In en, this message translates to:
  /// **'Character'**
  String get character;

  /// No description provided for @word.
  ///
  /// In en, this message translates to:
  /// **'Word'**
  String get word;

  /// No description provided for @traditionalArt.
  ///
  /// In en, this message translates to:
  /// **'Traditional Art'**
  String get traditionalArt;

  /// No description provided for @traditionalCeremony.
  ///
  /// In en, this message translates to:
  /// **'Traditional Ceremony'**
  String get traditionalCeremony;

  /// No description provided for @traditionalCostumes.
  ///
  /// In en, this message translates to:
  /// **'Traditional Costumes'**
  String get traditionalCostumes;

  /// No description provided for @localCrafts.
  ///
  /// In en, this message translates to:
  /// **'Local Crafts'**
  String get localCrafts;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
