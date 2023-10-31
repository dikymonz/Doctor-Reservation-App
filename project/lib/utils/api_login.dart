import 'package:dio/dio.dart';

class ApiLogin {
  final Dio _dio = Dio();
  Future<bool> inputCheck(String username, String password) async {
    try {
      Response response =
          await _dio.get('https://651fca72906e276284c382db.mockapi.io/profile');
      print('Response data: ${response.data}');

      List<dynamic> users = response.data;
      var user = users.firstWhere(
          (user) =>
              user['username'].toString() == username &&
              user['password'].toString() == password,
          orElse: () => null);

      return user != null;
    } catch (error) {
      throw Exception('Failed to check input: $error');
    }
  }

  Future<void> signUp(String username, String password) async {
    final dio = Dio();
    final baseUrl =
        'https://651fca72906e276284c382db.mockapi.io/profile'; // Ganti dengan URL API Anda

    try {
      final response = await dio.post(
        '$baseUrl/register', // Ganti dengan endpoint pendaftaran di API Anda
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Pendaftaran berhasil
        // Anda dapat menyimpan informasi pengguna yang terdaftar ke dalam penyimpanan lokal jika diperlukan
      } else {
        // Pendaftaran gagal, tangani kesalahan di sini
        // Anda dapat menampilkan pesan kesalahan kepada pengguna atau mengambil alih tindakan lain sesuai kebutuhan
      }
    } catch (e) {
      // Tangani kesalahan jaringan atau kesalahan lainnya
      print('Error during sign-up: $e');
      // Anda dapat menampilkan pesan kesalahan kepada pengguna atau mengambil tindakan lain sesuai kebutuhan
    }
  }
}
