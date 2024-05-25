import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coba_uas/notification_service.dart';

class AlarmView extends StatefulWidget {
  const AlarmView({Key? key}) : super(key: key);

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  final Map<String, String> alarms = {
    'Alarm1': 'audio/suara1ppl.mp3',
    'Alarm2': 'audio/suara2ppl.mp3',
    'Alarm3': 'audio/suara3ppl.mp3',
  };
  bool isPlaying = false;
  String? currentPlayingAlarm;
  late final AudioPlayer player;
  final NotificationService notificationService = NotificationService();
  String? currentNotificationSound;

  @override
  void initState() {
    player = AudioPlayer();
    notificationService.initNotification();
    _loadNotificationSound();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> _loadNotificationSound() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentNotificationSound = prefs.getString('notificationSound');
    });
  }

  Future<void> _saveNotificationSound(String sound) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('notificationSound', sound);
  }

  Future<void> playAlarm(String alarmName) async {
    final String audioPath = alarms[alarmName]!;
    if (alarmName != currentPlayingAlarm) {
      await player.stop();
      currentPlayingAlarm = alarmName;
    }
    await player.play(AssetSource(audioPath));
    isPlaying = true;
    setState(() {});
  }

  void pausePlaying() async {
    if (isPlaying && currentPlayingAlarm != null) {
      await player.pause();
      isPlaying = false;
      setState(() {});
    }
  }

  void updateNotificationSound(
      String alarmName, String sound, String channelId) async {
    setState(() {
      currentNotificationSound = sound;
    });
    await notificationService.updateNotificationSound(sound, channelId);
    _saveNotificationSound(sound);
  }

  void _showConfirmationDialog(
      String alarmName, String sound, String channelId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Ubah suara alarm?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                updateNotificationSound(alarmName, sound, channelId);
                Get.back();
              },
              child: Text(
                'Ya',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF30E5D0),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Tidak',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF83E3E),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Alarm',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF30E5D0),
        leading: BackButtonWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: alarms.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  final String alarmName = alarms.keys.elementAt(index);
                  final String sound = alarmName == 'Alarm1'
                      ? 'suara1ppl'
                      : alarmName == 'Alarm2'
                          ? 'suara2ppl'
                          : 'suara3ppl';
                  final String channelId = alarmName == 'Alarm1'
                      ? 'channel_id_5'
                      : alarmName == 'Alarm2'
                          ? 'channel_id_6'
                          : 'channel_id_8';
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFE6EBF0),
                    ),
                    child: ListTile(
                      title: Text(
                        alarmName,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              if (alarmName == currentPlayingAlarm &&
                                  isPlaying) {
                                pausePlaying();
                              } else {
                                playAlarm(alarmName);
                              }
                            },
                            child: Icon(
                              alarmName == currentPlayingAlarm && isPlaying
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                if (currentNotificationSound == sound)
                                  BoxShadow(
                                    color: Color(0xFF30E5D0).withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                    offset: Offset(0, 0),
                                  ),
                              ],
                            ),
                            child: Switch(
                              value: currentNotificationSound == sound,
                              onChanged: (bool value) {
                                if (value) {
                                  _showConfirmationDialog(
                                      alarmName, sound, channelId);
                                }
                              },
                              activeTrackColor: Color(0xFF30E5D0),
                              activeColor: Colors.white,
                            ),
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
    );
  }
}

class BackButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }
}
