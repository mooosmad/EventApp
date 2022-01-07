// ignore_for_file: file_names

import 'package:eventapp/services/firestore/evenement.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share/share.dart';

class ShareUrl {
  Evenement? evenement;
  String? uid;
  ShareUrl({this.evenement, this.uid});
  FirebaseDynamicLinks firebaseDynamicLinks = FirebaseDynamicLinks.instance;

  Uri? uri;
  Future<void> creationLink() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      link: Uri.parse(
        "https://kitokosmad.page.link.com/invitationPage?uid=$uid&dateCreation=${evenement!.dateCreation}",
      ),
      uriPrefix: "https://kitokosmad.page.link",
      androidParameters: const AndroidParameters(
        packageName: "com.example.eventapp",
        minimumVersion: 1,
      ),
      iosParameters: const IOSParameters(
        appStoreId: "123456789",
        bundleId: "com.example.eventapp",
        minimumVersion: "1",
      ), // pour ios je n'ai pas gérer (besoin d'un mac , il ya des trucks à ajouter dans info.plist...) voir https://firebase.flutter.dev/docs/dynamic-links/usage
    );
    final ShortDynamicLink shortLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    uri = shortLink.shortUrl;

    print(uri);
  }

  sendUrl() async {
    await creationLink();
    Share.share("$uri");
  }
}
