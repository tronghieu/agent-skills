# Data Scientist

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Biến một quyết định kinh doanh thực tế và dữ liệu liên quan thành bằng chứng có thể bảo vệ, kết luận có nêu bất định và báo cáo sẵn sàng cho quyết định.

## Cài đặt

```bash
npx skills add tronghieu/agent-skills --skill data-scientist
```

## Thử ngay

```text
/data-scientist Khám phá orders.csv: file có gì, có đáng tin không, và nên kiểm định những giả thuyết nào?
```

```text
/data-scientist Mức tăng chuyển đổi của variant B có thật không? Hãy nêu effect size, khoảng tin cậy và hàm ý về cỡ mẫu.
```

```text
/data-scientist Xây baseline dự báo nhu cầu theo tuần từ sales.parquet; sai số thiếu hàng tốn kém hơn tồn kho.
```

```text
/data-scientist Hãy red-team notebook churn này trước khi trình lãnh đạo: tái lập các con số chính và tìm leakage hoặc biến nhiễu.
```

## Vì sao không dùng chatbot thông thường?

Chatbot thông thường có thể đi ngay tới biểu đồ, p-value hoặc model phức tạp. Skill này bắt đầu bằng quyết định cần hỗ trợ, grain dữ liệu, phạm vi bao phủ và thông tin có sẵn tại thời điểm ra quyết định. Nó yêu cầu bằng chứng được tính bằng code, bất định quanh mọi ước lượng, baseline đơn giản trước khi tăng độ phức tạp, và một lượt review cố gắng bác bỏ kết luận. Kết quả không chỉ là phân tích nghe hợp lý mà là phân tích cho người ra quyết định thấy rõ giới hạn và đánh đổi.

## Dành cho ai và khi nào nên dùng

Hãy dùng khi bạn có CSV, Parquet, Excel, kết quả truy vấn, dữ liệu API, notebook hoặc model sẵn có và cần:

- Khám phá, kiểm tra bộ dữ liệu lạ trước khi tin nó.
- Chẩn đoán một chỉ số thay đổi, đồng thời phân biệt tương quan với nhân quả.
- Thiết kế hoặc diễn giải A/B test, so sánh, khoảng tin cậy hay cỡ mẫu.
- Xây và đánh giá baseline cho phân loại, hồi quy, scoring, segmentation hoặc dự báo.
- Review phân tích, notebook hoặc model trước khi nó ảnh hưởng đến quyết định.
- Chuyển kết quả kỹ thuật thành báo cáo ngắn gọn cho stakeholder.

Skill phù hợp với analyst, data scientist, nhóm product/business và người ra quyết định cần bằng chứng có thể chất vấn, thay vì một câu chuyện đẹp mắt.

## Cách làm việc

Skill trước hết định khung công việc thành mô tả (điều gì đã xảy ra), chẩn đoán (vì sao), dự đoán (điều gì có thể xảy ra) hoặc khuyến nghị (chọn đánh đổi nào). Skill xác nhận quyết định cần đưa ra, đơn vị phân tích, định nghĩa target, thời điểm thông tin được phép dùng, tiêu chí thành công và chi phí mỗi loại sai số. Nếu model được yêu cầu không thể thay đổi hành động nào, skill có thể chuyển hướng sang câu hỏi hữu ích hơn.

Sau đó, công việc đi theo lộ trình chặt chẽ:

1. **Kiểm định dữ liệu.** Xác nhận nguồn gốc, grain từng dòng, phạm vi, khóa, định nghĩa, missingness, outlier, tính đúng đắn của target và dữ liệu có phù hợp mục đích không.
2. **Khám phá có định hướng.** Xem phân phối, phân khúc, cấu trúc thời gian và các cách giải thích khả dĩ; kết thúc bằng giả thuyết có thể bác bỏ, được xếp hạng, thay vì một loạt biểu đồ.
3. **Phân tích hoặc dự đoán.** Dùng kiểm định và effect size phù hợp cho câu hỏi chẩn đoán, hoặc so sánh model dự đoán với baseline đơn giản qua cách chia dữ liệu giống thực tế triển khai.
4. **Xác thực trước khi tin.** Gắn khoảng tin cậy hoặc độ phân tán cross-validation; kiểm tra giả định, multiple comparisons, ý nghĩa thực tiễn, calibration, hiệu năng theo phân khúc quan trọng và leakage.
5. **Red-team trước khi chia sẻ.** Chủ động chuyển vai từ analyst sang reviewer đối kháng: kiểm tra lại phép tính then chốt, selection effect, biến nhiễu, ngôn ngữ nhân quả, cách chia/định nghĩa thay thế và điều gì có thể đảo ngược kết luận.
6. **Truyền đạt quyết định.** Mở đầu bằng câu trả lời theo đơn vị kinh doanh, bất định, bằng chứng, các lựa chọn đã lượng hóa và giới hạn cụ thể. Skill khuyến nghị; người sở hữu quyết định lựa chọn.

## Kỷ luật về bằng chứng và bất định

Mọi con số được báo cáo phải truy được về phân tích đã chạy. Ước lượng đi kèm khoảng tin cậy, biên sai số hoặc độ phân tán validation. Mẫu hình quan sát được diễn đạt là **mối liên hệ**; chỉ dùng ngôn ngữ nhân quả khi có thí nghiệm ngẫu nhiên hoặc thiết kế nhân quả được bảo vệ rõ ràng. Một model có vẻ chính xác bất thường được xem là đáng ngờ cho tới khi kiểm tra thời điểm của feature và leakage trong validation.

Với dự đoán, model phức tạp chỉ được giữ khi vượt dummy và linear baseline nhiều hơn biến thiên validation thông thường. Ngưỡng được trình bày như các lựa chọn kinh doanh—được gì, tốn gì, ai chịu tác động—chứ không mặc định là 0.5 hay để skill tự quyết.

## Bạn cung cấp gì và cách phối hợp

Hãy chia sẻ dữ liệu hoặc vị trí dữ liệu, quyết định/câu hỏi, nhóm đối tượng và khoảng thời gian, các định nghĩa/ràng buộc đã biết, cùng data dictionary nếu có. Với bài toán dự đoán, hãy nêu thời điểm dự báo, input nào hợp lệ ở thời điểm đó, dự báo được dùng ra sao và loại sai số nào tốn kém hơn.

Hãy chờ các câu hỏi làm rõ ngắn gọn trước khi phân tích nếu những lựa chọn này chưa rõ. Bạn cũng có thể đưa notebook hoặc kết quả hiện có: route review sẽ kiểm tra độc lập các con số then chốt và xếp vấn đề thành fatal, material hoặc minor, kèm cách sửa cụ thể.

## Bạn sẽ nhận được gì

Tùy route, công việc tạo một bộ artifact ngắn gọn, có thể tái lập:

| Artifact | Mục đích |
| --- | --- |
| Project brief | Quyết định, target, grain, tiêu chí thành công và giả định được nêu rõ |
| Data profile và EDA report | Kết luận chất lượng dữ liệu, phát hiện chính, giả thuyết xếp hạng và leakage watchlist |
| Diễn giải thống kê | Effect size, bất định, giả định và ý nghĩa thực tiễn |
| Experiment log và model card | Các lần chạy so sánh được, thiết kế validation, so với baseline, đánh đổi vận hành và giới hạn |
| Insight hoặc critique report | Trả lời trước; bằng chứng, lựa chọn khuyến nghị và điều có thể thay đổi kết luận |

## Skill bổ trợ hữu ích

- [Critical Thinking](../critical-thinking/README.vi.md) — dùng cùng một khuyến nghị quan trọng khi cần phản biện rộng hơn về lập luận, giả định và logic quyết định.
- [Market Researcher](../market-researcher/README.vi.md) — dùng khi câu hỏi còn cần bằng chứng thị trường, đối thủ hoặc ngành có trích dẫn; skill này sẽ phân tích dữ liệu bạn có.
- [Diataxis Writer](../diataxis-writer/README.vi.md) — dùng sau phân tích khi cần tài liệu tutorial, how-to, reference hoặc explanation bền vững cho các nhóm độc giả khác nhau.

## Giới hạn

Skill này không thay thế data engineering, MLOps production, kiểm chứng chuyên ngành, công việc bảo mật/quyền riêng tư, hoặc review pháp lý và đạo đức. Nó không đưa ra quyết định kinh doanh thay bạn hay xây bộ tối ưu hóa hoàn chỉnh cho định giá hoặc phân bổ nguồn lực. Dữ liệu yếu, thiếu, thiên lệch hoặc không đại diện có thể dẫn tới kết luận "không phù hợp mục đích"; đó là kết quả hợp lệ, không phải lý do để phóng đại độ chắc chắn.
