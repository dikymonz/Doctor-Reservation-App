import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:project/views/reservation_page.dart';

class ChatAi extends StatefulWidget {
  const ChatAi({super.key, required this.title});

  final String title;

  @override
  State<ChatAi> createState() => _ChatAiState();
}

class _ChatAiState extends State<ChatAi> {
  var jawaban = "";
  TextEditingController pertanyaanController = TextEditingController();

  void _askGPT() async {
    String apiKey = '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';
    Dio dio = Dio(BaseOptions(
      baseUrl: 'https://api.openai.com/v1',
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
    ));

    String promptData = pertanyaanController.text;
    Map<String, dynamic> data = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content":
              "kamu adalah seorang asisten dokter yang berpengalaman dalam bidang kesehatan gigi. Jika kamu diberi pertanyaan diluar bidang kamu, jawab saja saya tidak tau.",
        },
        {
          "role": "user",
          "content": promptData,
        },
      ],
      "temperature": 1,
      "max_tokens": 256,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0
    };

    try {
      Response response = await dio
          .post('https://api.openai.com/v1/chat/completions', data: data);

      Map<String, dynamic> responseData = response.data;

      if (responseData.containsKey('choices') &&
          responseData['choices'].isNotEmpty) {
        String answerText = responseData['choices'][0]['message']['content'];
        setState(() {
          jawaban = answerText;
        });
      }
    } on Exception catch (e) {
      print(e);
    }
    print("submit");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  LineIcons.arrowCircleLeft,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Open Questions',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Docs Reservations',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Docs Profile
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(children: [
                    Container(
                      child: Row(children: [
                        //animasi atau gambar
                        Container(
                          height: 100,
                          width: 100,
                          child: Lottie.network(
                              'https://lottie.host/8fa3c648-163a-49d2-981e-5ed194e64e12/mnKVtijzqy.json'),
                        )
                      ]),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    // button
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Butuh Solusi',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'jangan ragu tanyakan sekarang',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              // Aksi yang akan dijalankan saat CategoryCard diklik
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReservationPage(),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue[200],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(child: Text('Konsultasi Gratis')),
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
                ),
              ),
              // Form Pertanyaan
              Container(
                margin: EdgeInsets.all(16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.blue),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Pertanyaan Anda',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: pertanyaanController,
                      decoration: InputDecoration(
                        labelText: 'Masukkan pertanyaan',
                        contentPadding: EdgeInsets.all(12.0),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        _askGPT();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(16.0)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              // Jawaban
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "Jawaban",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        jawaban,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
