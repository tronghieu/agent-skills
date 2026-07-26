# Deep Reader

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Đọc sách, paper, luận văn và giáo trình dài bằng một phương pháp có thể truy nguyên, thay vì chỉ yêu cầu chatbot tóm tắt một lần.

## Cài đặt nhanh

```bash
npx skills add tronghieu/agent-skills --skill deep-reader
```

## Ví dụ nhanh

```text
/deep-reader Nghiên cứu cuốn sách chính sách công 320 trang này để tôi viết literature review. Hãy truy vết lập luận nhân quả, bằng chứng và các giả định chưa được giải quyết của tác giả.
```

```text
/deep-reader Cho tôi bản overview cuốn sách quản trị này trước thứ Sáu. Tập trung vào khuyến nghị nào áp dụng được cho công ty phần mềm 30 người và chỗ nào bằng chứng còn yếu.
```

```text
/deep-reader Đọc đồng chủ đề ba paper này về retrieval-augmented generation. Hãy tái dựng phương pháp, tách kết quả khỏi diễn giải và chỉ ra nơi khác biệt thuật ngữ che giấu bất đồng.
```

## Skill này dành cho ai

Deep Reader dành cho nhà nghiên cứu, nghiên cứu sinh, analyst, giảng viên và người đọc chuyên sâu đang làm việc với tài liệu dài khoảng 50 trang trở lên. Skill đặc biệt hữu ích khi bạn cần hiểu lập luận, lưu lại bằng chứng, so sánh nhiều nguồn hoặc tiếp tục đặt câu hỏi ở các phiên sau.

Với tài liệu ngắn có thể đọc thoải mái trong một cuộc hội thoại, đọc trực tiếp thường nhanh hơn.

## Vì sao nên dùng skill thay vì hỏi chatbot thông thường?

Khi được yêu cầu “tóm tắt cuốn sách 500 trang này”, chatbot có thể nén nội dung quá sớm, bỏ quên thông tin nằm giữa tài liệu hoặc tạo câu trả lời trôi chảy nhưng khó đối chiếu nguồn. Deep Reader thay đổi cách làm việc:

- Xác định bạn muốn đạt được gì trước khi chọn phần cần đọc sâu.
- Đọc qua nhiều lượt thay vì nhồi toàn bộ tài liệu vào một prompt lớn.
- Lưu ghi chú neo theo trang như bộ nhớ ngoài bền vững qua nhiều chương và nhiều phiên.
- Tách bạch khẳng định, lập luận, bằng chứng của tác giả và phán đoán của người đọc.
- Kiểm tra trích dẫn và các luận điểm then chốt trước khi trình bày bản tổng hợp.

Kết quả chậm hơn một bản tóm tắt nhanh, nhưng có thể tái sử dụng, kiểm tra và phù hợp hơn cho việc học nghiêm túc.

## Phương pháp đọc

Deep Reader kết hợp ba phương pháp đã được công nhận:

1. **Đọc khảo sát — Adler:** lập bản đồ toàn bộ tác phẩm trước. Xác định câu hỏi trung tâm, tính thống nhất, cấu trúc, thể loại và các chương liên quan nhất đến mục đích đọc.
2. **Đọc phân tích — Adler:** đọc kỹ từng đơn vị lập luận quan trọng. Theo dõi thuật ngữ chính, mệnh đề chủ đạo, tiền đề, kết luận, bằng chứng, điểm căng thẳng và câu hỏi còn mở.
3. **Tự thuật lại — bước Recite của SQ3R:** sau khi viết ghi chú, tự diễn đạt lại chương từ trí nhớ rồi đối chiếu với văn bản. Việc này bắt lỗi hiểu sai khi nội dung vẫn còn mới.
4. **Tổng hợp — bốn câu hỏi của Adler:** tác phẩm nói về điều gì như một tổng thể; nói chi tiết ra sao; đúng hoặc đầy đủ đến mức nào; và điều đó có ý nghĩa gì với mục đích thực tế của bạn.
5. **Đọc đồng chủ đề — Adler:** khi một câu hỏi trải trên nhiều tác phẩm, phân tích từng nguồn riêng rồi so sánh điểm đồng thuận, xung đột và thuật ngữ mà không để một tác giả định nghĩa toàn bộ cuộc tranh luận.

Việc phê phán chỉ bắt đầu sau khi đã diễn đạt công bằng quan điểm của tác giả. Đánh giá cuối cùng phân biệt rõ “sai”, “chưa đầy đủ” và “không thể kiểm chứng”, thay vì biến bất đồng thành ý kiến thiếu căn cứ.

### Với paper, luận văn và bài tổng quan

Tài liệu học thuật được đọc theo ba lượt của Keshav:

- **Lượt 1:** đọc tiêu đề, abstract, mở đầu, các đề mục, kết luận và tài liệu tham khảo để nắm ý chính.
- **Lượt 2:** đọc cẩn thận, ghi lại bằng chứng quan trọng và đánh dấu chứng minh, phép suy diễn hoặc tài liệu dẫn cần xem tiếp.
- **Lượt 3:** tự tái dựng lập luận hoặc phương pháp rồi so sánh với bài gốc. Lượt tốn công này chỉ dành cho các phần quan trọng với mục đích đọc.

Với nghiên cứu thực nghiệm, skill tách phương pháp, kết quả và diễn giải của tác giả để không đánh đồng một kết quả vững với một kết luận bị thổi phồng.

## Chọn độ sâu

- **Overview:** bản đồ khảo sát nhanh và bản tóm tắt theo mục đích cho hai đến bốn phần liên quan nhất. Phù hợp để định hướng, sàng lọc hoặc quyết định có nên nghiên cứu sâu cuốn sách hay không.
- **Study:** quy trình đầy đủ—ghi chú phân tích theo chương hoặc đơn vị lập luận, kiểm tra Recite, thuật ngữ xuyên chương, tổng hợp, bản đồ khái niệm và kiểm chứng. Phù hợp cho nghiên cứu, giảng dạy, viết review hoặc quyết định quan trọng.

Nếu chưa chắc, hãy nêu mục đích và thời hạn; skill sẽ đề xuất chế độ để bạn xác nhận.

## Trải nghiệm sử dụng

1. Bạn cung cấp tài liệu và cho biết mình muốn học, quyết định, giảng dạy hoặc tạo ra sản phẩm gì.
2. Skill lập bản đồ tác phẩm trước khi đọc sâu và đề xuất kế hoạch đọc.
3. Ở chế độ Study, skill đọc từng đơn vị lập luận mạch lạc và lưu ghi chú có liên kết trang.
4. Phương pháp được điều chỉnh theo thể loại: lập luận cho triết học, nguồn và góc nhìn cho lịch sử, chứng minh hoặc thí nghiệm cho khoa học, nhân vật và chủ đề cho văn học, bài tập cho giáo trình.
5. Skill tổng hợp từ ghi chú đã kiểm tra, không dựa vào ký ức mơ hồ của một context quá lớn.
6. Khi bạn hỏi tiếp ở phiên sau, skill tìm trong ghi chú hiện có trước và chỉ quay lại tài liệu gốc nếu thiếu chi tiết.

Với tác phẩm rất dài, skill có thể chia các nhóm chương sang những context hoặc agent đọc độc lập. Một đầu mối vẫn chịu trách nhiệm cho bản đồ sách, hệ thuật ngữ chung và bản tổng hợp cuối, vì vậy bạn nhận được một cách diễn giải thống nhất thay vì nhiều bản tóm tắt rời rạc.

## Bạn cần cung cấp gì

- File PDF, EPUB, DOCX, text hoặc Markdown
- Mục đích đọc hoặc quyết định cần hỗ trợ
- Câu hỏi hay chủ đề bạn quan tâm
- Độ sâu, thời hạn và ngôn ngữ đầu ra mong muốn
- Các tác phẩm khác cần so sánh nếu muốn đọc đồng chủ đề

## Bạn sẽ nhận được gì

- **Overview:** bản đồ câu hỏi trung tâm, tính thống nhất, cấu trúc và các phần giá trị cao, kèm bản tóm tắt bám sát mục đích đọc.
- **Study bổ sung:** ghi chú theo chương hoặc phần, có neo trang cho luận điểm, bằng chứng, thuật ngữ và câu hỏi mở; bản đồ khái niệm và thuật ngữ xuyên chương; bản tổng hợp theo mục đích, trả lời bốn câu hỏi của Adler; trích dẫn đã đối chiếu cùng nhật ký kiểm chứng các diễn giải then chốt; và bộ ghi chú tái sử dụng để trả lời câu hỏi sau mà không phải đọc lại toàn bộ nguồn.

## Các skill có thể kết hợp với Deep Reader

Đây là các gợi ý dùng tiếp theo, không phải yêu cầu bắt buộc:

- Dùng [Critical Thinking](../critical-thinking/README.vi.md) khi bạn muốn kiểm toán riêng lập luận trong nguồn hoặc quyết định được xây dựng từ bản tổng hợp.
- Dùng [Socratic Questor](../socratic-questor/README.vi.md) khi bạn muốn biến ghi chú thành đối thoại học có hướng dẫn, luyện vấn đáp hoặc active recall.
- Dùng [Data Scientist](../data-scientist/README.vi.md) khi tài liệu có dataset hoặc khẳng định định lượng cần phân tích lại, thay vì chỉ đánh giá bằng văn bản.

## Giới hạn

Neo trang của EPUB, DOCX, text và Markdown là tọa độ được tạo ra, không phải số trang bản in. Chất lượng trích xuất cũng có thể bị ảnh hưởng bởi bản scan, bố cục phức tạp, công thức và bảng. Trích dẫn quan trọng cho học thuật, pháp lý, y khoa hoặc xuất bản vẫn cần được đối chiếu với ấn bản gốc.

Deep Reader giúp bạn hiểu và đánh giá một nguồn; skill không khiến nguồn đó trở nên đúng, không thay thế chuyên gia lĩnh vực và không tự tái lập thí nghiệm khi thiếu dữ liệu.
