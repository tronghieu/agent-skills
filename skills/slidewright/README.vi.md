# SlideWright

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Dựng slide web sẵn sàng để trình chiếu, giúp người nói dẫn dắt cả khán phòng.

## Cài đặt nhanh

```bash
npx skills add tronghieu/agent-skills --skill slidewright
```

## Thử ngay

```text
/slidewright Dựng deck hội thảo 10 phút về AI agent thực tế cho các trưởng nhóm sản phẩm. Dùng hướng hình ảnh biên tập, ấm áp và kèm speaker note.

/slidewright Biến các ghi chú pitch dự án này thành deck 12 slide cho nhà đầu tư. Địa điểm dùng màn hình 16:9; dùng logo của chúng tôi và giữ narrative dứt khoát, không cường điệu.

/slidewright Restyle deck workshop hiện có để trình chiếu: mỗi slide một ý, phân cấp rõ hơn và chỉ dùng reveal do người nói điều khiển khi nó giúp nhịp bài nói.

/slidewright Tạo deck React có thể tái sử dụng cho buổi engineering review hằng quý, rồi chuẩn bị bản PDF để chia sẻ sau buổi nói.
```

## Vì sao không chỉ dùng chatbot thông thường?

Chatbot thông thường có thể tạo chữ cho slide nhưng dễ đối xử với kết quả như tài liệu đọc hoặc trang web nhỏ. SlideWright bắt đầu từ điều kiện của một bài nói trực tiếp: khán giả theo dõi từ xa, một người trình bày điều khiển deck, và người nói—không phải một màn hình đầy chữ—mang phần chi tiết. Skill giữ chữ đủ lớn để trình chiếu, tách speaker note khỏi hình ảnh cho khán giả, có navigation khi nói trực tiếp và chọn hướng triển khai hợp với deck.

## Dành cho ai và dùng khi nào

Dùng SlideWright cho bài nói, phiên hội thảo, workshop, lớp học, demo, project pitch và trình bày nội bộ sẽ được chiếu lên màn hình hoặc share screen. Skill phù hợp với speaker, giảng viên, consultant, founder và developer. Nó không dành cho tài liệu đọc, dashboard hay website để khán giả trực tiếp thao tác.

## Deck được hình thành như thế nào

1. Chia sẻ kết quả mong muốn của bài nói và một thông điệp khán giả cần nhớ.
2. Định hình narrative ngắn gọn cùng hướng hình ảnh theo khán giả và bối cảnh.
3. Dựng mỗi slide quanh một ý, dùng chữ đủ lớn để đọc trong phòng và hình ảnh khi chúng làm rõ ý.
4. Chỉ thêm chuyển động do người trình bày điều khiển: navigation, reveal từng bước hoặc so sánh phục vụ câu chuyện.
5. Kiểm tra deck theo màn hình đích và chuẩn bị speaker note riêng; yêu cầu PDF khi cần một bản để chia sẻ.

Các quy tắc trình chiếu, layout pattern và cách export chi tiết nằm trong [`references/`](./references/), để trang này tập trung vào kết quả bạn nhận được.

## Chọn hướng triển khai

| Hướng | Chọn khi | Mô hình tư duy |
| --- | --- | --- |
| **Một file HTML** | Bạn cần deck ngắn, giao nhanh, dễ mang đi hoặc không muốn có bước build. | Một deck tự chứa mở trong trình duyệt; phù hợp với bài nói gọn, nhưng sẽ khó quản lý hơn khi deck nhiều nội dung vượt khoảng 15–20 slide. |
| **Vite + React** | Bạn cần nhiều slide, component tái sử dụng, motion phong phú, tương tác do người trình bày điều khiển theo state hoặc một deck sẽ được duy trì. | Một dự án trình chiếu với slide là các component có thứ tự; cần Node.js và package manager. |

Cả hai hướng đều tạo cùng trải nghiệm cho khán giả: deck toàn màn hình, có navigation hiển thị cho người trình bày và số slide. Hãy chọn theo độ phức tạp và vòng đời của deck, không phải theo chất lượng hình ảnh.

## Tương tác: cho người trình bày, không phải khán giả

Người trình bày chuyển bằng bàn phím hoặc navigation ở đáy màn hình và có thể nhảy tới từng slide. Reveal, tab, so sánh, timer hoặc animation chỉ phù hợp khi thay đổi điều người nói đang giải thích. Form, đăng nhập, gửi dữ liệu, thu câu trả lời hoặc lưu dữ liệu của khán giả không thuộc loại deck này.

## Bạn cần cung cấp gì

Hãy mang theo những gì đang có: mục tiêu bài nói, khán giả, thời lượng, thông điệp chính, tài liệu nguồn, số slide yêu cầu, giới hạn địa điểm hoặc màn hình, cùng màu thương hiệu, logo, hình ảnh hay hướng dẫn về giọng điệu. Hãy nói nếu bạn muốn một deck HTML nhanh hay dự án React dễ duy trì; nếu chưa chắc, chỉ cần mô tả deck để skill giúp chọn.

## Bạn sẽ nhận được gì

- Website trình chiếu HTML hoặc React chạy được
- Hướng hình ảnh nhất quán với layout và typography ở cỡ trình chiếu
- Navigation cho người trình bày, số slide, cùng reveal hoặc motion có mục đích
- Một file Markdown riêng cho speaker note
- Hướng dẫn kiểm tra hình ảnh và, khi yêu cầu, PDF trung thực để chia sẻ

## Skill bổ trợ hữu ích

- Bắt đầu với [Brainstorm Coach](../brainstorm-coach/README.vi.md) khi góc tiếp cận, thông điệp trung tâm hoặc ví dụ cho bài nói còn mở; skill này giúp khám phá rồi thu hẹp khả năng trước khi dựng narrative.
- Dùng [Critical Thinking](../critical-thinking/README.vi.md) khi một deck pitch, chiến lược hoặc giàu bằng chứng cần được kiểm tra lập luận; skill này giúp tìm các khẳng định chưa đủ cơ sở và phản đối mạnh nhất trước khi khán giả nêu ra.

## Giới hạn

SlideWright hỗ trợ một người trình bày điều khiển một màn hình trong khi khán giả theo dõi. Nó không xây ứng dụng cho khán giả, không thu hay lưu phản hồi, và không thay thế phán đoán của người trình bày về các khẳng định hoặc tài liệu nguồn. PDF là bản chụp có thể chia sẻ của deck, không thay thế tài liệu nguồn có khả năng truy cập; hãy tập và kiểm tra deck cuối cùng trong môi trường sự kiện thực tế.
