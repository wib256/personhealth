
import 'dart:convert';

void main() {
  final String token = 'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2Mjc4MzE5MzEsInVzZXIiOnsicGFzc3dvcmQiOm51bGwsImF1dGhvcml0aWVzIjpbIlBBVElFTlQiXSwidXNlcm5hbWUiOiIwOTM2NTg4ODU0In19.3qvu5W8vw_4Wrz2IgHo4lgtxj4a--xlvhqJrBuVIW88';
  final parts = token.split('.');
  final payload = parts[1];
  print(payload);
  final String decoded = utf8.decode(base64Url.decode(payload));
  if (decoded.contains('PATIENT')) {
    print('True');
  } else {
    print('Fail');
  }
  print(decoded);
}