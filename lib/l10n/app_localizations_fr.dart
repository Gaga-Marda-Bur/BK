// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Beriyar Kedebideri';

  @override
  String get question => 'Question';

  @override
  String get previous => 'Précédent';

  @override
  String get next => 'Suivant';

  @override
  String get quizFinished => 'Quiz terminé !';

  @override
  String get score => 'Score :';

  @override
  String get correctAnswersOf => 'réponses correctes sur';

  @override
  String get restart => 'Recommencer';

  @override
  String get back => 'Retour';

  @override
  String get arkab => 'Arkab';

  @override
  String get basigna => 'Basigna';

  @override
  String get darbai => 'Darbai';

  @override
  String get eh => 'Eh';

  @override
  String get fitko => 'Fitko';

  @override
  String get goway => 'Goway';

  @override
  String get hirdeabo => 'Hirdeabo';

  @override
  String get i => 'I';

  @override
  String get djai => 'Djai';

  @override
  String get kobo => 'Kobo';

  @override
  String get lakko => 'Lakko';

  @override
  String get meri => 'Meri';

  @override
  String get nini => 'Nini';

  @override
  String get gna => 'Gna';

  @override
  String get ngay => 'Ngay';

  @override
  String get oi => 'Oi';

  @override
  String get pi => 'Pi';

  @override
  String get erigo => 'Erigo';

  @override
  String get erigoTamura => 'Erigo Tamura';

  @override
  String get seri => 'Seri';

  @override
  String get shep => 'Shep';

  @override
  String get tatasuwe => 'Tatasuwe';

  @override
  String get ui => 'Ui';

  @override
  String get wasse => 'Wasse';

  @override
  String get ay => 'Ay';

  @override
  String get house => 'Maison';

  @override
  String get water => 'Eau';

  @override
  String get sun => 'Soleil';

  @override
  String get tree => 'Arbre';

  @override
  String get person => 'Personne';

  @override
  String get food => 'Nourriture';

  @override
  String get family => 'Famille';

  @override
  String get night => 'Nuit';

  @override
  String get village => 'Village';

  @override
  String get forest => 'Forêt';

  @override
  String get mountain => 'Montagne';

  @override
  String get river => 'Rivière';

  @override
  String get fire => 'Feu';

  @override
  String get sky => 'Ciel';

  @override
  String get star => 'Étoile';

  @override
  String get moon => 'Lune';

  @override
  String get ocean => 'Océan';

  @override
  String get rain => 'Pluie';

  @override
  String get wind => 'Vent';

  @override
  String get earth => 'Terre';

  @override
  String get goodEvening => 'Bonsoir';

  @override
  String get goodMorning => 'Bonjour';

  @override
  String get goodbye => 'Au revoir';

  @override
  String get please => 'S\'il vous plaît';

  @override
  String characterRecognitionQuestion(Object character) {
    return 'Quel est ce caractère ? $character';
  }

  @override
  String characterRepresentationQuestion(Object name) {
    return 'Quel caractère représente \"$name\" ?';
  }

  @override
  String vocabularyQuestion(Object word) {
    return 'Que signifie \"$word\" ?';
  }

  @override
  String sentenceQuestion(Object phrase) {
    return 'Comment dit-on \"$phrase\" en langue Beriya ?';
  }

  @override
  String characterExplanation(Object character, Object name) {
    return 'Le caractère $character représente \"$name\" en langue Beriya Irvi.';
  }

  @override
  String reverseCharacterExplanation(Object character, Object name) {
    return '\"$name\" est représenté par le caractère $character en langue Beriya Irvi.';
  }

  @override
  String vocabularyExplanation(Object meaning, Object word) {
    return '\"$word\" signifie \"$meaning\" en langue Beriya Irvi.';
  }

  @override
  String sentenceExplanation(Object phrase, Object translation) {
    return '\"$phrase\" se dit \"$translation\" en langue Beriya.';
  }

  @override
  String get vocabularyTitle => 'Vocabulaire Beriya';

  @override
  String get vocabularyDescription => 'Apprenez des mots courants en Beria Erfe. Touchez chaque mot pour entendre sa prononciation.';

  @override
  String get favoritesInstruction => 'Appuyez sur ★ pour ajouter aux favoris';

  @override
  String addedToFavorites(Object word) {
    return '$word ajouté aux favoris ★';
  }

  @override
  String removedFromFavorites(Object word) {
    return '$word retiré des favoris ☆';
  }

  @override
  String get audioFileNotFound => 'Fichier audio non trouvé';

  @override
  String get tapToListen => 'Appuyez pour écouter';

  @override
  String get typeTextLabel => 'Tapez en Beriya Erfe :';

  @override
  String get addToFavorites => 'Ajouter aux favoris';

  @override
  String get removeFromFavorites => 'Retirer des favoris';

  @override
  String get textOptions => 'Options de texte :';

  @override
  String get fontSizeLabel => 'Taille de police :';

  @override
  String get fontWeightLabel => 'Poids de police :';

  @override
  String get charactersLabel => 'Caractères Beriya Erfe :';

  @override
  String get copiedToClipboard => 'Copié dans le presse-papier';

  @override
  String get noTextToCopy => 'Aucun texte à copier';

  @override
  String get savedToHistory => 'Texte ajouté à l\'historique';

  @override
  String get emptyTextWarning => 'Le texte est vide';

  @override
  String get resourcesLabel => 'Ressources';

  @override
  String get unicodeAnnouncement => 'Annonce Unicode 17.0';

  @override
  String get kedebideriFont => 'Police Kedebideri';

  @override
  String get keymanKeyboard => 'Clavier Keyman';

  @override
  String get characterReference => 'Référence des caractères';

  @override
  String openLink(Object url) {
    return 'Ouvrir: $url';
  }

  @override
  String get demo => 'Démo';

  @override
  String get information => 'Information';

  @override
  String get vocabulary => 'Vocabulaire';

  @override
  String get quiz => 'Quiz';

  @override
  String get gallery => 'Galerie';

  @override
  String get history => 'Historique';

  @override
  String get favorites => 'Favoris';

  @override
  String get settings => 'Paramètres';

  @override
  String get exploreZaghawa => 'Explorez la langue Zaghawa';

  @override
  String get beriyaErfe => 'Beriya Erfe';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get soundEffects => 'Effets sonores';

  @override
  String get vibrations => 'Vibrations';

  @override
  String get autoSaveHistory => 'Sauvegarder automatiquement l\'historique';

  @override
  String get appearance => 'Apparence';

  @override
  String get defaultFontSize => 'Taille de police par défaut';

  @override
  String get theme => 'Thème';

  @override
  String get classic => 'Classique';

  @override
  String get dark => 'Sombre';

  @override
  String get light => 'Clair';

  @override
  String get dataManagement => 'Gestion des données';

  @override
  String get clearHistory => 'Effacer l\'historique';

  @override
  String get clearFavorites => 'Effacer les favoris';

  @override
  String get exportData => 'Exporter les données';

  @override
  String get language => 'Langue';

  @override
  String get selectLanguage => 'Choisir la langue';

  @override
  String get historyCleared => 'Historique effacé';

  @override
  String get delete => 'Supprimer';

  @override
  String get space => 'Espace';

  @override
  String get clear => 'Tout';

  @override
  String get aboutBeriaErfe => 'À propos de Beria Erfe';

  @override
  String get aboutBeriaErfeDescription => 'Beria Erfe fait maintenant partie d\'Unicode 17.0. Cette application utilise les polices Kedebideri pour afficher le script. Utilisez le clavier ci-dessous pour taper des caractères Beria Erfe.';

  @override
  String get ok => 'OK';

  @override
  String get galleryTitle => 'Galerie d\'Images';

  @override
  String get gallerySubtitle => 'Découvrez la beauté du script Beria Erfe';

  @override
  String get categoryCharacters => 'Caractères';

  @override
  String get categoryWords => 'Mots courants';

  @override
  String get categoryCulture => 'Culture';

  @override
  String get noImage => 'Aucune image disponible';

  @override
  String get comingSoon => 'Les images seront ajoutées prochainement';

  @override
  String get myFavorites => 'Mes Favoris ★';

  @override
  String get favoriteUpdated => 'Favori mis à jour';

  @override
  String get clearFavoritesTitle => 'Effacer tous les favoris';

  @override
  String get clearFavoritesConfirm => 'Êtes-vous sûr de vouloir effacer tous vos favoris ?';

  @override
  String get favoritesCleared => 'Tous les favoris ont été supprimés';

  @override
  String get noFavorites => 'Aucun favori';

  @override
  String get addFavoritesHint => 'Ajoutez des mots ou caractères en favoris en cliquant sur l\'icône étoile';

  @override
  String get addedOn => 'Ajouté le';

  @override
  String get removeFavorite => 'Retirer des favoris';

  @override
  String get noHistory => 'Aucun historique';

  @override
  String get yourTextsWillAppear => 'Vos textes tapés apparaîtront ici';

  @override
  String get clearHistoryConfirm => 'Êtes-vous sûr de vouloir effacer tout l\'historique ? Cette action est irréversible.';

  @override
  String get deleteItem => 'Supprimer l\'élément';

  @override
  String deleteConfirm(Object item) {
    return 'Êtes-vous sûr de vouloir supprimer \"$item\" ?';
  }

  @override
  String get itemDeleted => 'Élément supprimé';

  @override
  String get copied => 'Texte copié dans le presse-papier';

  @override
  String get copyError => 'Erreur lors de la copie';

  @override
  String createdOn(Object date) {
    return 'Créé le $date';
  }

  @override
  String get more => 'Plus';

  @override
  String get save => 'Enregistrer';

  @override
  String get copy => 'Copier';

  @override
  String get character => 'Caractère';

  @override
  String get word => 'Mot';

  @override
  String get traditionalArt => 'Art traditionnel';

  @override
  String get traditionalCeremony => 'Cérémonie traditionnelle';

  @override
  String get traditionalCostumes => 'Costumes traditionnels';

  @override
  String get localCrafts => 'Artisanat local';

  @override
  String get cancel => 'Annuler';

  @override
  String get clearAll => 'Effacer tout';
}
