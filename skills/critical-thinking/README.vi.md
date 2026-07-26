# Critical Thinking

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Kiểm tra lập luận trong memo, đề xuất, bản phân tích, bài viết hoặc bản nháp—và rèn khả năng tự phán đoán thay vì giao phán đoán cho AI.

```bash
npx skills add tronghieu/agent-skills --skill critical-thinking
```

## Bắt đầu nhanh

Gửi toàn bộ văn bản hoặc lập luận khi có thể và nêu quyết định mà nó cần hỗ trợ. Bắt đầu với một trong các prompt sau:

```text
/critical-thinking Quick-audit đề xuất nhà cung cấp này. Hôm nay chúng tôi phải quyết định có đưa họ vào shortlist không; hãy nêu ba vấn đề có khả năng thay đổi quyết định nhất.
```

```text
/critical-thinking Deep-audit memo đầu tư này. Lập bản đồ các luận điểm chịu tải, kiểm tra warrant và độ tin cậy của nguồn, rồi cho tôi biết bằng chứng nào sẽ bác bỏ khuyến nghị.
```

```text
/critical-thinking Review bản nháp cho hội đồng quản trị của tôi. Giữ phần đang vững, đưa cách sửa cụ thể cho mỗi lỗ hổng quan trọng và steelman phản đối mạnh nhất trước khi gửi cho độc giả khó tính.
```

```text
/critical-thinking Tôi đã hoàn thành tám lượt audit. Hãy progress review: loại lỗi lặp lại, độ hiệu chỉnh tự tin, tỷ lệ skip commit và một điều cần chú ý tiếp theo.
```

## Vì sao không chỉ hỏi chatbot?

Chatbot thông thường có thể đưa ra một lời phê bình nghe hợp lý. Skill này khiến việc phản biện có thể kiểm tra lại và hữu ích cho việc học:

- Mỗi phát hiện được neo vào câu trích dẫn nguyên văn và vị trí, để bạn kiểm tra audit thay vì tin vào giọng điệu của nó.
- Skill tách suy luận lỗi khỏi dữ kiện chưa kiểm chứng, giả định ngầm và bất đồng quan điểm trung thực.
- Skill chỉ xem các luận điểm chịu tải cho kết luận, rồi xếp vấn đề theo tác động lên quyết định.
- Mặc định, skill hỏi nhận định của bạn trước để audit trở thành phần so sánh và một bài luyện—không phải thứ thay thế phán đoán của bạn.

Bạn vẫn chịu trách nhiệm cho quyết định. Skill là một lượt kiểm tra đối kháng có cấu trúc đối với lập luận đang được trình bày cho bạn.

## Skill này dành cho ai

Dùng skill này khi bạn cần biết một tài liệu thực sự chứng minh được gì, chỉ ngầm giả định điều gì và cần xác minh gì trước khi hành động. Skill phù hợp với người ra quyết định, analyst, consultant, reviewer, founder và người viết đang xử lý memo đầu tư, đề xuất nhà cung cấp, tài liệu hội đồng quản trị, ghi chú chiến lược, bài bình luận hoặc bản nháp của chính mình.

## Mô hình tư duy: văn phong không phải là lập luận

Audit dựng lại lập luận nằm dưới tài liệu thay vì tóm tắt các mục của nó.

1. **Xác định yêu cầu quyết định.** Skill tách quyết định được yêu cầu (ví dụ “duyệt ngân sách”) khỏi niềm tin dùng để biện minh cho quyết định đó (ví dụ “thị trường này sẽ tăng 30%”).
2. **Tìm luận điểm chịu tải.** Skill nhận diện khoảng 3–7 luận điểm mà nếu sai, kết luận sẽ sụp đổ, và neo từng luận điểm vào nguyên văn.
3. **Làm lộ cây cầu suy luận.** Với mỗi luận điểm, bản đồ Toulmin ghi grounds (bằng chứng), warrant (vì sao bằng chứng phải ủng hộ luận điểm), qualifier (mức độ khẳng định) và cách xử lý rebuttal (phản ví dụ). Warrant thường bị ẩn chính là nơi nhiều lập luận trau chuốt bị gãy.
4. **Thử bác bỏ.** Audit nêu giả định ngầm, kiểm tra độ tin cậy của nguồn và các phương án thay thế, chỉ quét ngụy biện hay thiên kiến có neo nguyên văn sau khi đã lập bản đồ, rồi hỏi bằng chứng quan sát được nào sẽ chứng minh kết luận là sai.

Mỗi phát hiện chỉ có một nhãn trung thực:

| Nhãn | Ý nghĩa |
| --- | --- |
| `[GAP]` / `[LEAP]` | Thiếu bằng chứng / có bằng chứng nhưng không suy ra được kết luận |
| `[ASSUME]` / `[CONFLICT]` | Tiền đề ngầm chịu tải / các phát biểu không thể đồng thời đúng |
| `[FALLACY]` | Một mẫu suy luận được đặt tên và neo vào trích dẫn—không chỉ là điều auditor không thích |
| `[OPINION]` / `[CANNOT-ASSESS]` | Bất đồng trung thực / luận điểm cần chuyên môn hoặc dữ liệu ngoài |

Deep audit còn xem xét độ rõ ràng, chính xác, cụ thể, liên quan, chiều sâu, độ rộng, logic, tầm quan trọng, tính công bằng và độ tin cậy của nguồn. Các chiều này không bị gộp thành một điểm số dễ gây yên tâm: tài liệu rõ ràng nhưng kết luận không theo từ bằng chứng vẫn là lập luận yếu.

## Một lượt audit diễn ra thế nào

1. **Gửi tài liệu và mức độ quan trọng.** Nêu quyết định mà tài liệu cần hỗ trợ, cùng tệp còn thiếu, thời hạn hoặc rủi ro cần ưu tiên.
2. **Chọn độ sâu.** Dùng quick audit để sàng lọc, deep audit cho quyết định hệ trọng, hoặc draft review để củng cố bài viết của bạn.
3. **Cam kết trước (thông thường).** Trước khi thấy audit, nêu nhận định: Lập luận có đứng vững không? Bạn tự tin bao nhiêu? Điểm yếu nhất là gì? Deep audit hỏi thêm một giả định ngầm. Bạn có thể nói `skip` khi đang gấp.
4. **Nhận audit.** Báo cáo mở đầu bằng kết luận có thể hành động, rồi đến bản đồ lập luận và phát hiện xếp theo mức độ nghiêm trọng, kèm trích dẫn chính xác. Nó cũng nói rõ phần nào chưa được xem xét thay vì giả vờ đầy đủ.
5. **So sánh và học.** Nếu đã cam kết trước, báo cáo cho thấy điều bạn bắt được, bỏ sót hoặc nghi ngờ không có cơ sở, rồi đối chiếu mức tự tin với kết quả. Dùng lặp lại có thể tạo reasoning profile tùy chọn, ghi nhận mẫu và độ hiệu chỉnh có bằng chứng—không phán xét tính cách.

## Chọn chế độ

| Chế độ | Dùng khi | Bạn nhận được |
| --- | --- | --- |
| **Quick audit** | Tài liệu ngắn, rủi ro thấp hoặc thiếu thời gian | Kết luận, khung lập luận và ba vấn đề có khả năng đổi quyết định nhất |
| **Deep audit** | Quyết định hoặc tài liệu mang tính chịu tải | Bản đồ đầy đủ, giả định, kiểm tra nguồn và ngụy biện, phép thử khả bác, và câu hỏi gửi tác giả |
| **Draft review** | Tài liệu là do bạn viết | Phần đã vững, cách sửa các lỗi quan trọng, phản đối mạnh nhất và stage-gate hoặc tiêu chí go/no-go còn thiếu |
| **Progress review** | Bạn đã dùng skill nhiều lần | Cơ cấu audit, loại lỗi lặp lại, độ hiệu chỉnh tự tin và một mục tiêu luyện tập tiếp theo |

## Bạn sẽ nhận được gì

Hãy chờ một kết luận trước, tiếp theo là bản đồ lập luận và các phát hiện được đánh số theo mức độ nghiêm trọng, không theo thứ tự tài liệu. Deep audit có thể bổ sung sổ giả định, đánh giá khả bác, phần “honest corner” tách riêng `[OPINION]` và `[CANNOT-ASSESS]`, cùng câu hỏi để gửi lại tác giả. Draft review thêm hướng sửa và cấu trúc quyết định; progress review chỉ mô tả những mẫu mà hồ sơ đủ chứng minh.

## Skill nên dùng kèm

- Dùng [Market Researcher](../market-researcher/README.vi.md) khi audit gắn `[CANNOT-ASSESS]` cho quy mô thị trường, dữ kiện đối thủ hay một dữ kiện ngoài khác; hãy xác lập dữ kiện trước rồi audit lại lập luận dựa trên chúng.
- Dùng [Strategy Board](../strategy-board/README.vi.md) khi audit tài liệu cho thấy đây là một lựa chọn chiến lược cấp công ty cần nhiều góc nhìn điều hành và khuyến nghị đầy đủ.
- Dùng [Design Thinking](../design-thinking/README.vi.md) khi đề xuất nói “người dùng muốn X”; skill này kiểm tra lập luận đã có, còn Design Thinking tìm hiểu người dùng thực sự cần gì.
- Dùng [Socratic Questor](../socratic-questor/README.vi.md) khi mục tiêu chuyển sang học một chủ đề bằng đối thoại có hướng dẫn thay vì kiểm tra một lập luận cụ thể.

## Giới hạn

Đây là audit các lập luận có trong tài liệu, không phải bảo đảm mọi dữ kiện chuyên ngành đều đúng. Phần thiếu dữ liệu hoặc chuyên môn sẽ được đánh dấu để kiểm chứng thay vì suy đoán. Trích dẫn giúp công việc có thể kiểm tra, không khiến nó không thể sai; quyết định pháp lý, y tế, tài chính, kỹ thuật hoặc quy định hệ trọng vẫn cần chuyên gia phù hợp review.
