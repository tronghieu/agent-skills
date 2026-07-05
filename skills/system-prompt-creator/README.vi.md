# Skill Tạo System Prompt (System Prompt Creator)

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Skill này đồng hành cùng bạn qua một quy trình chuyên nghiệp để thiết kế và tối ưu hóa các system prompt (chỉ dẫn hệ thống) hiệu quả cao cho mọi mô hình AI (Claude, ChatGPT, Gemini, v.v.).

## Skill này dùng cho mục đích gì?

System prompt là tập hợp các chỉ dẫn gốc định hình tính cách, vai trò, quy tắc hoạt động và định dạng đầu ra của AI. Skill này đóng vai trò như một kỹ sư prompt chuyên nghiệp (Prompt Engineer), giúp bạn thiết kế, soạn thảo và tinh chỉnh các bộ chỉ dẫn này để chatbot, AI agent hoặc các ứng dụng AI của bạn hoạt động chính xác nhất.

## Tại sao nên sử dụng?

- **Tối ưu hóa theo từng mô hình**: Tự động điều chỉnh cấu trúc prompt phù hợp nhất với mô hình bạn chọn (ví dụ: dùng thẻ XML cho Claude, định dạng tham số chặt chẽ cho GPT, hoặc tối ưu hóa temperature cho Gemini).
- **Tránh các lỗi AI thường gặp**: Hướng dẫn xây dựng kịch bản vận hành (playbooks) rõ ràng giúp AI không bị nhầm lẫn giữa dữ liệu đầu vào và mệnh lệnh, tránh việc AI bỏ qua các quy tắc quan trọng.
- **Cấu trúc phân tầng khoa học**: Tổ chức prompt thành các phần tách biệt (Vai trò, Bối cảnh, Chỉ dẫn, Ví dụ mẫu, Rào cản an toàn) giúp AI dễ đọc hiểu và làm theo.
- **Áp dụng 12 nguyên tắc chuẩn**: Được phát triển dựa trên tài liệu hướng dẫn kỹ thuật prompt chính thức từ Anthropic, OpenAI và Google.
- **Tiết kiệm thời gian thử nghiệm**: Hướng dẫn bạn qua một buổi phỏng vấn nhanh để thu thập đầy đủ yêu cầu trước khi viết, giảm thiểu tối đa việc phải chỉnh sửa prompt nhiều lần.

## Cách hoạt động

1. **Phỏng vấn thu thập yêu cầu**: AI sẽ hỏi bạn một số câu hỏi trọng tâm về mô hình mục tiêu, đối tượng sử dụng, giọng điệu, các quy tắc nghiêm ngặt và ví dụ mong muốn.
2. **Phân tích độ phức tạp**: Đánh giá quy mô tác vụ (Đơn giản, Trung bình, Phức tạp) để thiết kế cấu trúc phù hợp.
3. **Thiết lập cấu trúc**: Sử dụng các thẻ XML (như `<role>`, `<instructions>`, `<guardrails>`) hoặc tiêu đề Markdown để phân tách rõ ràng.
4. **Soạn thảo và Tối ưu**: Áp dụng các nguyên tắc viết (như giải thích lý do tại sao quy tắc tồn tại, dùng lối viết khẳng định hành vi nên làm thay vì chỉ cấm đoán).
5. **Đánh giá lại**: Kiểm tra độ nhất quán, các trường hợp ngoại lệ và cung cấp các prompt kiểm thử để bạn chạy thử nghiệm thực tế.

## Cách kích hoạt

Yêu cầu AI thực hiện các tác vụ như:

```text
Giúp tôi viết một system prompt cho chatbot hỗ trợ khách hàng.
```

```text
Tạo chỉ dẫn tùy chỉnh (custom instructions) cho một AI agent chuyên review code Python.
```

```text
Tối ưu hóa prompt hiện tại của tôi để nó hoạt động tốt hơn trên Claude.
```
