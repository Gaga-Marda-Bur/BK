import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../widgets/3d_card.dart';
import '../constants/colors.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _currentlyPlayingIndex;

  final List<Map<String, String>> characterInfo = const [
    {'code': '16EA0', 'char': '𖺠', 'name': 'BERIA ERFE CAPITAL LETTER ARKAB', 'audio': 'arkab.mp3'},
    {'code': '16EA1', 'char': '𖺡', 'name': 'BERIA ERFE CAPITAL LETTER BASIGNA', 'audio': 'basigna.mp3'},
    {'code': '16EA2', 'char': '𖺢', 'name': 'BERIA ERFE CAPITAL LETTER DARBAI', 'audio': 'darbai.mp3'},
    {'code': '16EA3', 'char': '𖺣', 'name': 'BERIA ERFE CAPITAL LETTER EH', 'audio': 'eh.mp3'},
    {'code': '16EA4', 'char': '𖺤', 'name': 'BERIA ERFE CAPITAL LETTER FITKO', 'audio': 'fitko.mp3'},
    {'code': '16EA5', 'char': '𖺥', 'name': 'BERIA ERFE CAPITAL LETTER GOWAY', 'audio': 'goway.mp3'},
    {'code': '16EA6', 'char': '𖺦', 'name': 'BERIA ERFE CAPITAL LETTER HIRDEABO', 'audio': 'hirdeabo.mp3'},
    {'code': '16EA7', 'char': '𖺧', 'name': 'BERIA ERFE CAPITAL LETTER I', 'audio': 'i.mp3'},
    {'code': '16EA8', 'char': '𖺨', 'name': 'BERIA ERFE CAPITAL LETTER DJAI', 'audio': 'djai.mp3'},
    {'code': '16EA9', 'char': '𖺩', 'name': 'BERIA ERFE CAPITAL LETTER KOBO', 'audio': 'kobo.mp3'},
    {'code': '16EAA', 'char': '𖺪', 'name': 'BERIA ERFE CAPITAL LETTER LAKKO', 'audio': 'lakko.mp3'},
    {'code': '16EAB', 'char': '𖺫', 'name': 'BERIA ERFE CAPITAL LETTER MERI', 'audio': 'meri.mp3'},
    {'code': '16EAC', 'char': '𖺬', 'name': 'BERIA ERFE CAPITAL LETTER NINI', 'audio': 'nini.mp3'},
    {'code': '16EAD', 'char': '𖺭', 'name': 'BERIA ERFE CAPITAL LETTER GNA', 'audio': 'gna.mp3'},
    {'code': '16EAE', 'char': '𖺮', 'name': 'BERIA ERFE CAPITAL LETTER NGAY', 'audio': 'ngay.mp3'},
    {'code': '16EAF', 'char': '𖺯', 'name': 'BERIA ERFE CAPITAL LETTER OI', 'audio': 'oi.mp3'},
    {'code': '16EB0', 'char': '𖺰', 'name': 'BERIA ERFE CAPITAL LETTER PI', 'audio': 'pi.mp3'},
    {'code': '16EB1', 'char': '𖺱', 'name': 'BERIA ERFE CAPITAL LETTER ERIGO', 'audio': 'erigo.mp3'},
    {'code': '16EB2', 'char': '𖺲', 'name': 'BERIA ERFE CAPITAL LETTER ERIGO TAMURA', 'audio': 'erigo_tamura.mp3'},
    {'code': '16EB3', 'char': '𖺳', 'name': 'BERIA ERFE CAPITAL LETTER SERI', 'audio': 'seri.mp3'},
    {'code': '16EB4', 'char': '𖺴', 'name': 'BERIA ERFE CAPITAL LETTER SHEP', 'audio': 'shep.mp3'},
    {'code': '16EB5', 'char': '𖺵', 'name': 'BERIA ERFE CAPITAL LETTER TATASUWE', 'audio': 'tatasuwe.mp3'},
    {'code': '16EB6', 'char': '𖺶', 'name': 'BERIA ERFE CAPITAL LETTER UI', 'audio': 'ui.mp3'},
    {'code': '16EB7', 'char': '𖺷', 'name': 'BERIA ERFE CAPITAL LETTER WASSE', 'audio': 'wasse.mp3'},
    {'code': '16EB8', 'char': '𖺸', 'name': 'BERIA ERFE CAPITAL LETTER AY', 'audio': 'ay.mp3'},
  ];
  
  bool get _isLoading => false;

  Future<void> _playAudio(int index) async {
    if (_currentlyPlayingIndex == index) {
      await _audioPlayer.stop();
      setState(() => _currentlyPlayingIndex = null);
      return;
    }

    setState(() => _currentlyPlayingIndex = index);

    try {
      await _audioPlayer.play(AssetSource('audio/${characterInfo[index]['audio']}'));
      _audioPlayer.onPlayerComplete.listen((event) {
        setState(() => _currentlyPlayingIndex = null);
      });
    } catch (e) {
      print('Erreur de lecture audio: $e');
      setState(() => _currentlyPlayingIndex = null);
    }
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Impossible d\'ouvrir le lien : $url'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    if (_isLoading) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.gold),
    );
  }

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Material( // AJOUT: Encapsuler avec Material
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.darkGreen, AppColors.darkerGreen],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThreeDCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.aboutBeriaErfe,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.gold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          loc.aboutBeriaErfeDescription,
                          style: const TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  ThreeDCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.resourcesLabel,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.gold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildResourceItem(
                          icon: Icons.language,
                          title: loc.unicodeAnnouncement,
                          subtitle: 'blog.unicode.org',
                          url: 'https://blog.unicode.org/',
                        ),
                        _buildResourceItem(
                          icon: Icons.font_download,
                          title: loc.kedebideriFont,
                          subtitle: 'software.sil.org/kedebideri',
                          url: 'https://software.sil.org/kedebideri/',
                        ),
                        _buildResourceItem(
                          icon: Icons.keyboard,
                          title: loc.keymanKeyboard,
                          subtitle: 'keyman.com/keyboards/beria_erfe_phonetic',
                          url: 'https://keyman.com/keyboards/beria_erfe_phonetic',
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  ThreeDCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.characterReference,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.gold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 400,
                          child: ListView.builder(
                            itemCount: characterInfo.length,
                            itemBuilder: (context, index) {
                              final info = characterInfo[index];
                              return GestureDetector(
                                onTap: () => _playAudio(index),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: _currentlyPlayingIndex == index
                                        ? AppColors.goldOpacity03
                                        : AppColors.darkGreen,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: _currentlyPlayingIndex == index
                                          ? AppColors.gold
                                          : AppColors.goldOpacity03,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.goldOpacity02,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Text(
                                              info['char']!,
                                              style: const TextStyle(
                                                fontFamily: 'Kedebideri',
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                            if (_currentlyPlayingIndex == index)
                                              const Positioned(
                                                right: 0,
                                                top: 0,
                                                child: Icon(
                                                  Icons.volume_up,
                                                  size: 12,
                                                  color: AppColors.gold,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              info['code']!,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            Text(
                                              info['name']!,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        _currentlyPlayingIndex == index
                                            ? Icons.volume_up
                                            : Icons.volume_down,
                                        color: AppColors.gold,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResourceItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String url,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.gold),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
      onTap: () => _launchURL(url),
      contentPadding: EdgeInsets.zero,
      trailing: Icon(Icons.open_in_new, color: AppColors.gold, size: 20),
    );
  }
}