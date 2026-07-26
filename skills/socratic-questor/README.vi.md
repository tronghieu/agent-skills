# Socratic Questor

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Học bằng cách suy nghĩ thành lời cùng Gadfly, người bạn đối thoại Socrates giúp bạn tự khám phá và kiểm tra ý tưởng qua câu hỏi thay vì bài giảng.

## Cài đặt

```bash
npx skills add tronghieu/agent-skills --skill socratic-questor
```

## Bắt đầu đối thoại

```text
/socratic-questor Giúp tôi hiểu chi phí cơ hội thông qua câu hỏi.
/socratic-questor Kiểm tra tôi về lập luận trong bài viết này: [dán văn bản].
/socratic-questor Tôi cho rằng làm việc từ xa tăng năng suất. Hãy phản biện lập luận của tôi.
/socratic-questor Hãy hỏi tôi cho đến khi tôi có thể tự giải thích quang hợp.
```

## Vì sao không dùng chatbot thông thường?

Chatbot thông thường thường đưa ra một câu trả lời trau chuốt để bạn tiếp nhận. Gadfly làm rõ mô hình hiểu biết hiện tại của bạn, rồi kiểm tra giả định, bằng chứng, góc nhìn khác và hệ quả của nó. Bạn được luyện lập luận—không chỉ nhận thêm một lời giải thích để ghi nhớ.

## Dành cho ai và dùng khi nào

Hãy dùng Socratic Questor nếu bạn là học sinh, người tự học, giáo viên, mentor hoặc chuyên gia muốn xem xét sự hiểu biết của mình qua đối thoại. Skill đặc biệt hữu ích khi bạn muốn:

- học một khái niệm bằng cách tự diễn đạt;
- kiểm tra xem mình có thể giải thích chủ đề hoặc văn bản nguồn bằng lời của chính mình không;
- thách thức một nhận định trước khi quyết định dựa vào nó; hoặc
- khám phá giả định, bằng chứng, quan điểm cạnh tranh và hệ quả.

## Phương pháp đặt câu hỏi

Gadfly theo khung đặt câu hỏi Socrates của Paul & Elder như một phễu linh hoạt:

```text
Làm rõ → Giả định → Bằng chứng → Góc nhìn → Hệ quả → Siêu phản tư
```

Phiên đối thoại luôn bắt đầu bằng bước làm rõ để Gadfly nghe cách bạn đóng khung vấn đề. Sau đó, Gadfly theo điều câu trả lời của bạn gợi ra: câu trả lời mơ hồ cần làm rõ thêm; nhận định thiếu căn cứ cần xem xét bằng chứng; lập luận một chiều cần thêm góc nhìn. Trình tự là la bàn, không phải kịch bản. Xem [khung câu hỏi chi tiết](./references/questioning-framework.md).

## Trải nghiệm học tập diễn ra thế nào

Gadfly thân thiện, tò mò và hơi khiêu khích—persona này được đặt theo “con ruồi trâu của Athens” của Socrates. Gadfly ghi nhận ngắn gọn một ý hay, rồi hỏi một hoặc hai câu hỏi thực sự và cho bạn không gian trả lời. Gadfly dùng cùng ngôn ngữ với bạn.

Đối thoại liên tục điều chỉnh theo chất lượng từng câu trả lời:

- **Mới với chủ đề:** làm rõ chậm hơn, câu hỏi nhỏ hoặc cụ thể hơn, và nhiều giàn giáo hơn.
- **Đã có nền tảng:** phản biện nhẹ nhàng, chú ý kỹ hơn đến giả định và bằng chứng.
- **Nền tảng vững:** nhanh hơn đến phản biện đối lập, hệ quả và phản tư về lập luận.

Khi bạn mắc kẹt, Gadfly thu hẹp hoặc diễn đạt lại câu hỏi, hoặc dùng tình huống hay phép tương tự cụ thể. Gadfly vẫn không đưa ra đáp án; điều đó giữ nguyên cam kết học bằng tự khám phá.

## Bạn mang đến; bạn sẽ nhận được

| Bạn mang đến | Bạn sẽ nhận được |
| --- | --- |
| Một chủ đề để khám phá, như khái niệm, quyết định hoặc nhận định | Chuỗi câu hỏi có nhịp độ phù hợp, mỗi lượt một hoặc hai câu |
| Hoặc văn bản/tài liệu bạn muốn hiểu | Ghi nhận ngắn gọn rồi các câu hỏi đào sâu dựa trên câu trả lời của bạn |
| Câu trả lời trung thực, kể cả chưa hoàn chỉnh | Câu hỏi được điều chỉnh theo lập luận bạn thể hiện, không theo nhãn bạn tự nhận |

## Skills bổ trợ

- Dùng [Critical Thinking](../critical-thinking/README.vi.md) khi cần đánh giá có cấu trúc một lập luận sau đối thoại; skill này giúp biến các nhận định và bằng chứng đã lộ ra thành đánh giá có chủ đích.
- Dùng [Deep Reader](../deep-reader/README.vi.md) khi tài liệu đầu vào là sách hoặc bài báo dài; skill này cung cấp quy trình đọc có hệ thống trước hoặc song song với thảo luận Socrates.
- Dùng [Diataxis Writer](../diataxis-writer/README.vi.md) khi muốn biến điều đã học thành tài liệu rõ ràng; skill này tách hướng dẫn học, hướng dẫn làm việc, tham chiếu và giải thích theo đúng người đọc.

## Giới hạn

Gadfly dạy bằng câu hỏi, không phải diễn giải trực tiếp. Đây không phải lựa chọn phù hợp khi bạn cần ngay một dữ kiện, lời giải mẫu hoặc kiểm chứng sự thật. Hãy xem các nhận định xuất hiện trong đối thoại là điểm khởi đầu để kiểm tra thêm, nhất là trong bối cảnh quan trọng.
