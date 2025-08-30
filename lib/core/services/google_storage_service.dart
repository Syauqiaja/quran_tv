import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:quran_tv/data/sources/result.dart';
import 'package:http/http.dart' as http;

final class GoogleStorageService {
  final bucketName = "quranaudio_bucket_1";

  Future<AccessCredentials> obtainCredentials() async {
    final serviceString = await rootBundle.loadString('assets/bucket/quran-recitation-ai-789107c74fa8.json');
    final serviceKeys = jsonDecode(serviceString);

    final serviceAccount = ServiceAccountCredentials.fromJson(serviceKeys);
    final client = http.Client();
    final scopes = ['https://www.googleapis.com/auth/firebase', 'https://www.googleapis.com/auth/cloud-platform.read-only'];

    final credentials = await obtainAccessCredentialsViaServiceAccount(serviceAccount, scopes, client);

    client.close();
    return credentials;
  }

  Future<AuthClient> obtainAuthenticatedClient() async {
    final serviceString = await rootBundle.loadString('assets/bucket/quran-recitation-ai-789107c74fa8.json');
    final serviceKeys = jsonDecode(serviceString);

    final serviceAccount = ServiceAccountCredentials.fromJson(serviceKeys);
    final scopes = ['https://www.googleapis.com/auth/firebase', 'https://www.googleapis.com/auth/cloud-platform.read-only'];

    final credentials = await clientViaServiceAccount(serviceAccount, scopes);

    return credentials;
  }

  Future<Result<Uint8List>> getAudioTest() async {
    final client = await obtainAuthenticatedClient();
    try {
      final response = await client.get(Uri.parse("https://storage.googleapis.com/$bucketName/recitations-surahs/maher-al-muaiqly/96kbps/mp3/001.mp3"));
      return Result.success(response.bodyBytes);
    } catch (e) {
      return Result.error(e);
    }
  }
}