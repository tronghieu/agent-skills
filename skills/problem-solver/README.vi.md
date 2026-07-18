# Problem Solver (Chẩn Đoán Vấn Đề)

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Một người bạn đồng hành chẩn đoán cho AI agent của bạn — trước khi giúp bạn sửa bất cứ điều gì, nó giúp bạn tìm ra thứ thật sự đang hỏng và vì sao. Cứ hình dung nó là kỷ luật đứng giữa "có gì đó không ổn" và "đây là việc cần làm": biến một lời than phiền mơ hồ thành một phát biểu vấn đề chính xác, đã được xác nhận, truy ra nguyên nhân thật thay vì câu chuyện nghe có vẻ hợp lý đầu tiên, và chỉ sau đó mới chuyển sang tìm giải pháp.

## Vì Sao Skill Này Tồn Tại

Hỏi một AI thông thường "vì sao doanh số giảm?" và nó sẽ đưa cho bạn một lời giải thích nghe rất tự tin chỉ trong một hơi thở — nghe hợp lý, có cấu trúc, và thường là bịa hoàn toàn, vì AI chẳng có quyền truy cập vào dữ liệu, đội ngũ, hay khách hàng của bạn. Một chuỗi nguyên nhân gọn gàng được dựng từ những sự thật bịa đặt còn tệ hơn một câu "tôi chưa biết" trung thực, vì nó khiến bạn đi sửa sai chỗ với sự tự tin tuyệt đối.

Skill này làm ngược lại: **sự thật đến từ bạn, giả định luôn được gắn nhãn, và không có gì được gọi là nguyên nhân cho đến khi thực tế xác nhận điều đó.** Mọi luận điểm nhân quả trong phiên làm việc đều đi kèm nhãn `[verified]` (đã xác minh) hoặc `[assumed]` (giả định), mọi giả định trọng yếu đều được ghi vào sổ kèm cách kiểm tra rẻ nhất, và ít nhất hai giả thuyết đối lập luôn được giữ sống cho đến khi bằng chứng — không phải một cuộc bỏ phiếu, không phải linh cảm — chọn ra người thắng cuộc. Nếu bạn xin giải pháp trước khi biết nguyên nhân, nó sẽ nói thẳng điều đó và để bạn chọn, thay vì âm thầm bỏ qua phần khó.

## Bạn Có Thể Yêu Cầu Gì

**Có gì đó đang hỏng và bạn không biết vì sao** — trường hợp cốt lõi.
> "Doanh số giảm 15% tháng trước và chúng tôi không biết vì sao."
> "Đơn hàng cứ bị trễ hoài. Tôi đã thử vài cách, chẳng cách nào ăn thua."

**Có gì đó cứ lặp lại, hoặc các bản sửa cứ thất bại.**
> "Con bug này cứ quay lại dù đã vá bao nhiêu lần."
> "Mỗi lần sửa xong tỷ lệ rớt ở bước onboarding, lại có chỗ khác hỏng."

**Bạn muốn một phiên tìm nguyên nhân gốc có cấu trúc.**
> "Chạy giúp tôi five whys cho sự cố này."
> "Làm post-mortem cùng tôi — hệ thống production sập 2 tiếng hôm qua."

**Bạn xin giải pháp, nhưng nguyên nhân chưa rõ.**
> "Cho tôi ý tưởng để cứu doanh số đang giảm." *(skill sẽ chỉ ra đây là một yêu cầu chẩn đoán đang đội lốt brainstorm, và để bạn tự chọn hướng đi)*

Nó hoạt động y hệt vậy dù bạn viết bằng tiếng Việt, tiếng Anh, hay bất kỳ ngôn ngữ nào khác:
> "Why do orders keep arriving late and we don't know why?"
> "Find the root cause of our dropping sales for me."

Bạn không cần gọi tên một phương pháp cụ thể — "chúng tôi không biết vì sao X cứ xảy ra hoài" là đủ để bắt đầu.

## Một Phiên Làm Việc Trông Như Thế Nào

**Frame (Định hình).** Một lượt hỏi thăm gọn gàng, không phải một biểu mẫu: chuyện gì đang xảy ra theo cách quan sát được, bắt đầu từ khi nào, ai/cái gì bị ảnh hưởng và đang tốn kém ra sao, đã thử gì rồi, và "đã sửa xong" sẽ trông như thế nào. Nếu tin nhắn mở đầu của bạn đã trao sẵn một manh mối sắc — một ranh giới cộng với một thay đổi trùng thời điểm — nó sẽ đề xuất một cách kiểm tra rẻ cho manh mối đó ngay trong câu trả lời đầu tiên, thay vì để dành. Sau đó nó đọc lại cho bạn phát biểu vấn đề đã được tinh gọn, đã tách hết mọi giả định-về-nguyên-nhân hay giải pháp-nhảy-cóc ẩn bên trong, và chờ bạn xác nhận trước khi đi tiếp.

**Bound (Khoanh vùng).** Một lượt phân tích Is/Is-Not: vấn đề xuất hiện ở đâu so với không xuất hiện ở đâu, khi nào so với khi nào không, ai so với ai không. Manh mối sắc nhất nằm ở chỗ khác biệt giữa hai cột.

**Diagnose (Chẩn đoán).** Nó chọn phương pháp phù hợp với hình dạng của vấn đề — Five Whys cho một triệu chứng có khả năng là một chuỗi nguyên nhân tuyến tính, fishbone khi có nhiều yếu tố góp phần khả dĩ, causal loops khi vấn đề cứ quay lại hoặc càng sửa càng tệ — rồi cùng bạn dựng cây nguyên nhân, từng câu hỏi một, gắn nhãn `[verified]` hoặc `[assumed]` cho từng liên kết ngay khi nó xuất hiện. Ít nhất hai ứng viên đối lập luôn được giữ trên bàn cho đến khi một phép kiểm tra phân tách được chúng. Không có gì chuyển sang giải pháp cho đến khi nguyên nhân dẫn đầu được xác minh, hoặc bạn chủ động chọn tiến tới với rủi ro đã biết.

**Solve (Giải quyết).** Khi nguyên nhân đã được xác nhận, nó tạo ra các giải pháp nhắm thẳng vào *nguyên nhân đó* — chuyển giao cho brainstorm-coach để phát triển ý tưởng thật sự đa hướng nếu skill đó đã được cài. Mọi giải pháp đều nêu rõ nguyên nhân gốc nó nhắm tới; bất cứ giải pháp nào không làm được điều đó sẽ bị gắn nhãn là một bản vá triệu chứng, không phải một cách sửa thật sự.

**Decide (Quyết định).** Bạn đặt ra tiêu chí (hiệu quả, chi phí, thời gian, rủi ro — của bạn có thể khác). Mọi điểm số đều trích dẫn bằng chứng hoặc được gắn nhãn trung thực "chưa biết — giả định". Một khuyến nghị duy nhất, kèm điều gì sẽ làm thay đổi nó.

**Plan (Lên kế hoạch).** Một cách triển khai (mặc định là thí điểm khi độ tin cậy chưa cao), người phụ trách cho các bước đầu tiên, các chỉ số thành công gắn lại với "đã sửa xong" nghĩa là gì từ bước Frame, và các "pivot trigger" — quy tắc rõ ràng cho việc khi nào một kế hoạch không hiệu quả có nghĩa là chẩn đoán sai, chứ không chỉ là cần thực thi mạnh hơn.

## Kỷ Luật Bằng Chứng

Đây là phần khiến skill này đáng tin thay vì chỉ nói hay. Ba quy tắc xuyên suốt mọi giai đoạn:

- Không có gì được phát biểu như một sự thật về thế giới của bạn trừ khi chính bạn nói ra hoặc cho xem. Một sự thật còn thiếu trở thành một câu hỏi hoặc một nhãn `[assumed]` — không bao giờ là một phỏng đoán được điền vào cho đủ.
- Mỗi ứng viên nguyên nhân gốc đều mang theo một phép kiểm tra: "nếu đây đúng là nguyên nhân, ta sẽ thấy ___" cộng với cách rẻ nhất để kiểm tra xem nó có sai không. Một nguyên nhân mà không gì có thể bác bỏ được ("do thiếu giao tiếp") thì chưa phải là một chẩn đoán.
- Độ tin cậy *giảm xuống* cũng được tính là tiến bộ. Một giả định được kiểm tra và loại bỏ vừa cứu bạn khỏi việc xây giải pháp trên cát — và skill xem đó là một chiến thắng, nói thẳng ra, chứ không phải một bước lùi.

## Một Ví Dụ Cụ Thể

> **Bạn:** Đơn hàng cứ trễ hoài, chắc khoảng 1/4. Bắt đầu từ đầu tháng 6. Đã nhắc nhân viên làm nhanh hơn nhưng không ăn thua.
>
> **Agent:** Một câu hỏi làm rõ nhanh trước khi tôi chốt phát biểu vấn đề — sự trễ có tập trung vào một loại đơn nào đó không, hay dàn đều? Và có gì khác thay đổi từ đầu tháng 6 không — thực đơn, nhân sự, đơn vị giao hàng?
>
> **Bạn:** Bạn nhắc mới nhớ, chủ yếu là đơn bánh custom. Và đúng là có một bài đăng thực đơn lên xu hướng đúng khoảng thời gian đó.
>
> **Agent:** Thông tin này hữu ích — đây là phát biểu tôi muốn bạn xác nhận: *"Từ đầu tháng 6, khoảng 1/4 đơn hàng đến trễ, tập trung ở đơn bánh custom; một bài đăng thực đơn lên xu hướng đúng tuần đó."* Đúng không? Nếu đúng, một cách kiểm tra rẻ trước khi đi tiếp: nếu khối lượng đơn bánh custom tăng vượt quá năng lực chuẩn bị, thời gian chuẩn bị trung bình cho mỗi bánh custom sẽ tiến dần đến hoặc vượt qua khung giờ giao hàng — bạn có thể bấm giờ 5 đơn tiếp theo không?
>
> **Bạn:** Đúng vậy đó. Tôi sẽ bấm giờ 5 đơn tiếp theo.
>
> **Agent:** *(ghi lại kế hoạch, đánh dấu "năng lực chuẩn bị so với khối lượng đơn bánh custom" là ứng viên `[assumed]` dẫn đầu kèm phép kiểm tra đang chờ, giữ "đơn vị giao hàng xuống cấp" sống như một giả thuyết đối lập, và tạm dừng ở đây cho đến khi bạn quay lại với kết quả bấm giờ.)*

## Phương Pháp, Khớp Với Hình Dạng Của Vấn Đề

`references/diagnosis.md` chứa kho phương pháp — Five Whys, fishbone, causal loops và system archetypes, cộng thêm force-field và phân tích ràng buộc (constraint) cho các nỗ lực thay đổi bị mắc kẹt — mỗi phương pháp kèm khi nào nên dùng và một ví dụ minh họa. Agent chọn dựa trên hình dạng thật sự của vấn đề bạn đang gặp (một triệu chứng vs. nhiều yếu tố góp phần vs. một vấn đề "chống trả" mọi lần sửa), không bao giờ chọn theo thói quen hay để trông có vẻ kỹ lưỡng.

## Kết Hợp Với Các Skill Khác Trong Gia Đình

Skill này nằm trong một gia đình nhỏ các skill (github.com/tronghieu/agent-skills) được xây để nhường lời cho nhau đúng lúc. Nếu skill tiếp theo chưa được cài, agent chỉ nhắc tên nó, cho biết có thể cài từ cùng kho lưu trữ, rồi tiếp tục với một phiên bản nhẹ hơn ngay trong hội thoại.

| Khi nào | Sẽ chuyển sang |
|---|---|
| Nguyên nhân đã được xác minh và bạn cần phát triển ý tưởng thật sự đa hướng trên đó | **brainstorm-coach** |
| "Vấn đề" thật ra là về việc người dùng của bạn là ai và họ cần gì | **design-thinking** |
| Bản chẩn đoán hoặc bản quyết định cần được kiểm tra lại lập luận | **critical-thinking** |
| Cách sửa đã lớn thành một canh bạc chiến lược cấp công ty | **strategy-board** |
| Một nguyên nhân hoặc giải pháp phụ thuộc vào dữ kiện thị trường bạn chưa có | **market-researcher** |
| Kế hoạch đang trở thành một dự án nhiều tuần thật sự cần theo dõi | **project-manager** |

## Bắt Đầu

Cài đặt bằng cách dán dòng này vào terminal:

```bash
npx skills add tronghieu/agent-skills --skill problem-solver
```

Sau đó chỉ cần nói cho AI agent của bạn biết cái gì đang hỏng:

```text
Doanh số giảm 15% tháng trước và chúng tôi không biết vì sao.
```

```text
Chuyện này cứ lặp lại dù đã thử đủ cách — giúp tôi tìm nguyên nhân thật sự.
```

```text
Làm post-mortem cùng tôi về sự cố hôm qua.
```

```text
Sales dropped 15% last month and we don't know why.
```

Bạn không cần phải nói "problem solver" — "chúng tôi không biết vì sao X cứ xảy ra hoài" là đủ để nó bắt lấy mạch chuyện.
