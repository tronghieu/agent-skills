# Fiction Studio

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Phát triển ý tưởng, bản nháp hoặc series truyện văn xuôi thành tác phẩm do tác giả dẫn dắt, có nền tảng kỹ thuật viết và nhất quán từ tiền đề đến khi sửa bản thảo.

## Cài đặt nhanh

```bash
npx skills add tronghieu/agent-skills --skill fiction-studio
```

## Bắt đầu bằng một yêu cầu

```text
/fiction-studio Tôi có tiền đề trinh thám Gothic. Hãy kiểm tra lời hứa với độc giả, rồi giúp tôi chọn cách lập dàn ý.
```

```text
/fiction-studio Nhân vật chính của tôi quá bị động ở chương 1–3. Hãy xây lại mục tiêu, vết thương tâm lý và các bước ngoặt mà không làm mất cốt truyện hiện có.
```

```text
/fiction-studio Đây là cảnh đối đầu tôi đã viết. Hãy chỉnh hội thoại để có hàm ý và giọng nói riêng, rồi cho tôi các lựa chọn sửa.
```

```text
/fiction-studio Tôi kẹt giữa kết thúc bi kịch và hy vọng cho tiểu thuyết fantasy. Hãy mở phòng biên kịch để kiểm tra kỹ lựa chọn này.
```

## Vì sao dùng thay vì chỉ prompt chatbot thông thường?

Một yêu cầu gửi chatbot thông thường có thể tạo văn xuôi trôi chảy, nhưng hay trộn lập kế hoạch, viết, phê bình và sửa vào một câu trả lời khó lần vết. Fiction Studio tách các việc đó thành lượt riêng, chuyển các quyết định đã thống nhất thành tài liệu làm việc, và dừng lại để tác giả chọn. Các lăng kính viết có tên giúp phản hồi chính xác: lỗi cấu trúc không bị xử như biên tập câu chữ, và phản ứng của độc giả không bị xem là mệnh lệnh.

## Dành cho ai và khi nào nên dùng

Dành cho tác giả mới hoặc có kinh nghiệm viết tiểu thuyết, novella, truyện ngắn và series văn xuôi. Dùng khi bạn muốn:

- biến tiền đề thành kế hoạch truyện có ý thức về thể loại;
- chẩn đoán vấn đề ở plot, nhân vật, bối cảnh, cảnh, văn xuôi hoặc hội thoại;
- viết từ dàn ý có sẵn hoặc sửa bản thảo hiện có;
- nhận phản ứng beta reader tập trung rồi quyết định nên tiếp thu phản hồi nào;
- giữ continuity cho dự án dài hoặc qua nhiều phiên viết.

Với truyện ngắn, quy trình được giữ gọn để không làm chậm đà viết. Với series, bạn có thể thiết lập thế giới chung, lời hứa thể loại và series arc trước khi từng cuốn đi theo pipeline riêng.

## Phương pháp studio

Homer điều phối dự án và trao lại quyền kiểm soát cho tác giả giữa các lượt xử lý tập trung. Các lăng kính của nhóm gồm: Aristotle (cốt truyện và nhịp độ), Fyodor (tâm lý nhân vật), Tolkien (thế giới và quy tắc), Scheherazade (cảnh và viết nháp), Oscar (hội thoại), Max (biên tập phát triển và câu chữ), Virginia (phản ứng của độc giả mục tiêu), Borges (lời hứa thể loại và tựa sách so sánh), và Bloom (phê bình văn học tùy chọn).

Với một tiểu thuyết mới, công việc thường đi theo:

1. Tiền đề và lời hứa thể loại
2. Dàn ý — dàn ý cấu trúc hoặc mở rộng theo phương pháp Snowflake
3. Nhân vật và thế giới
4. Danh sách cảnh và viết nháp văn xuôi
5. Lượt xử lý hội thoại và biên tập phát triển
6. Đọc thử, phân loại phản hồi, và chỉnh sửa cuối
7. Đóng gói: tài liệu giới thiệu và bản thảo đã ghép

Ở mỗi chặng, chuyên gia phù hợp đọc phần việc trước, tạo tài liệu làm việc kế tiếp và trao đổi lại với bạn trước khi dự án đi tiếp. Các mốc kiểm tra chất lượng xem xét cấu trúc, kỳ vọng thể loại, cài cắm và hồi đáp, tính liên tục và chất lượng văn xuôi; chúng hỗ trợ phán đoán chứ không thay thế phán đoán.

## Trải nghiệm làm việc

Bạn chỉ cần mang theo phần việc đang có. Một ý tưởng thô có thể bắt đầu ở tiền đề; dàn ý, cảnh hoặc bản thảo có thể đi thẳng vào lượt cần thiết. Bạn nhận một số lựa chọn thực chất—như nâng mức độ đánh cược, đổi chuyển biến giá trị của cảnh, thử động cơ nhân vật, hoặc chọn một hướng táo bạo hơn—thay vì để studio âm thầm quyết định câu chuyện. Bạn phê duyệt hướng đi và luôn giữ quyền tác giả.

## Đầu vào, đầu ra và tài liệu làm việc

Đầu vào hữu ích gồm tiền đề hoặc văn bản, thể loại và độc giả mục tiêu, giọng điệu, ràng buộc, tác phẩm tham chiếu, cùng các quyết định phải giữ làm canon.

Tùy phạm vi, studio có thể tạo hoặc cập nhật tiền đề, dàn ý, hồ sơ nhân vật, world bible, danh sách cảnh và các chương bản thảo. Dự án dài còn có thể giữ canon máy-đọc được cho tên, sự kiện, dòng thời gian, quy tắc và cài cắm; ghi chú đọc thử; kế hoạch sửa có ưu tiên; và pitch kit gồm logline, blurb, synopsis, tựa sách so sánh, metadata và query letter tùy chọn. Các tài liệu bền vững này giúp phiên sau tiếp tục từ công việc đã có thay vì trí nhớ mơ hồ.

## Writers' Room: party mode đa vai trò

Quy trình thông thường dùng một vai trò tập trung tại một thời điểm cho việc sản xuất như viết nháp và biên tập. Party mode khác: nó đưa ba hoặc bốn tiếng nói phù hợp vào cùng bàn khi khám phá ý tưởng cần sự bất đồng hữu ích—thường nhất là lúc định hình tiền đề, hoặc tại nút rẽ lớn như kết thúc, đổi thể loại hay nhân vật bị bế tắc.

Phòng thảo luận đặt một câu hỏi, thu các góc nhìn riêng, để chúng kiểm tra lẫn nhau, rồi trao lựa chọn lại cho bạn. Cuối buổi, hướng đã chọn, các phương án còn mở và câu hỏi chưa giải quyết được ghi vào dự án. Chế độ này cố ý không dùng cho biên tập câu chữ, viết nháp hoặc kiểm tra tính liên tục thường lệ, vì một lượt tập trung sẽ rõ ràng hơn.

## Skill nên kết hợp

- Dùng [Brainstorm Coach](../brainstorm-coach/README.vi.md) trước Fiction Studio khi ý tưởng còn quá mở và bạn muốn khám phá, ưu tiên hóa các khả năng trước khi chốt tiền đề.
- Dùng [Deep Reader](../deep-reader/README.vi.md) khi truyện dựa trên nguồn dài—như tác phẩm public domain, tư liệu lịch sử hoặc nhiều sách cùng thể loại—và bạn cần ghi chú có thể lần vết trước khi biến hiểu biết đó thành lựa chọn truyện.
- Dùng [Market Researcher](../market-researcher/README.vi.md) khi định vị thể loại, tín hiệu độc giả hoặc giả định về thị trường xuất bản cần nghiên cứu bàn giấy có trích dẫn và cập nhật; đưa kết quả trở lại để tinh chỉnh lời hứa thể loại và tựa sách so sánh.

## Giới hạn

Studio hỗ trợ truyện văn xuôi, không phải dịch vụ đầy đủ về xuất bản, pháp lý, quyền sử dụng hay rà soát độ nhạy cảm chuyên nghiệp. Quy ước thể loại và phản ứng đọc thử là lăng kính, không phải luật; tác giả quyết định giữ, sửa hay từ chối. Hồ sơ tính liên tục và các kiểm tra chất lượng bắt được nhiều rủi ro, nhưng không thể bảo đảm chất lượng văn xuôi, độ chính xác văn hóa, thành công thị trường hay độ đúng của dữ kiện trong truyện cần nhiều nghiên cứu.
