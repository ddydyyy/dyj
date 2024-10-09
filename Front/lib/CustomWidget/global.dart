import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  // _ : private 클래스, 같은 파일 내에서만 접근 가능
  // createState() -> 위젯이 처음 생성될 때 한 번만 호출
  // 텍스트를 입력할 때마다 UI가 업데이트 되지만,
  // createState는 다시 실행되지 않아 무한 루프가 발생하지 않음
  @override
  State createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  // TextEditingController
  // input field로 텍스트를 읽어, 전송 후 clear
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Row(
            children: [
            const Icon(Icons.insert_emoticon),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: '주식, 메뉴, 상품, 뉴스를 검색하세요', // 입력 필드에 힌트 텍스트 추가
                ),
              ),
            ),
          ],
        ),
      ],
    );

  }
}