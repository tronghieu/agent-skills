# Brainstorm Coach

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Biến một câu hỏi chưa rõ thành các phương án độc đáo, có thể truy vết và bước tiếp theo thiết thực mà không giao phó việc suy nghĩ cho AI.

## Cài đặt

```bash
npx skills add tronghieu/agent-skills --skill brainstorm-coach
```

## Thử ngay

```text
/brainstorm-coach Giúp tôi đặt tên cho một ứng dụng tài chính ưu tiên quyền riêng tư.
/brainstorm-coach Khám phá ý tưởng ra mắt thư viện cho mượn dụng cụ trong khu phố; chúng tôi có 200 USD và một cuối tuần.
/brainstorm-coach Party mode: cho các ý tưởng chuyển nghề của tôi nhiều góc nhìn, rồi phản biện danh sách rút gọn.
```

## Vì sao dùng thay vì prompt chatbot thông thường?

Một prompt thông thường thường trả về danh sách trau chuốt trước khi bạn kịp suy nghĩ. Brainstorm Coach xem phiên làm việc là sự cộng tác: bạn đóng góp trước, lời của bạn được giữ nguyên, và AI bổ sung một số ít ý phát triển được gắn nhãn rõ ràng. Skill giữ đánh giá ra khỏi giai đoạn khám phá, chọn kỹ thuật phù hợp với dạng câu hỏi, rồi mới giúp bạn gom nhóm, kiểm tra và chọn hướng. Kết quả không chỉ là nhiều ý tưởng hơn mà còn là hồ sơ cho biết chúng đến từ đâu và vì sao các ý tưởng triển vọng được giữ lại.

## Ai nên dùng

Hãy dùng khi bạn đang khám phá tên gọi, tính năng, chiến dịch, sự kiện, hướng sản phẩm, dự án sáng tạo hoặc lựa chọn nghề nghiệp. Skill phù hợp với founder, đội sản phẩm và marketing, designer, người viết, cùng bất kỳ ai cần thêm khả năng nhưng không muốn trở thành khán giả của một màn AI liệt kê ý tưởng.

Nó đặc biệt hữu ích khi chủ đề còn mở, đã cũ ý tưởng, hoặc đầy những linh cảm chưa thành hình. Bạn có thể mang theo brief hẹp hoặc một câu hỏi mơ hồ; cả hai đều là điểm bắt đầu hợp lệ.

## Phương pháp: chọn chế độ hợp với câu hỏi

Coach có thể đề xuất kỹ thuật, đưa một menu ngắn phù hợp, chọn ngẫu nhiên, hoặc dẫn dắt một luồng từ khám phá rộng đến thu hẹp. Nó ở lại với một kỹ thuật khi kỹ thuật đó còn hiệu quả thay vì máy móc đi hết danh sách.

Một số cách tiếp cận có sẵn gồm:

- **Mở không gian:** Tình huống What-if, tư duy tương tự, đảo ngược và tư duy từ nguyên lý đầu tiên thách thức khung quen thuộc.
- **Thêm cấu trúc:** SCAMPER cải thiện sản phẩm hoặc quy trình cụ thể; Sáu chiếc mũ tư duy tách các góc nhìn; sơ đồ tư duy tổ chức các mạch liên quan.
- **Tạo đà hoặc độ rộng:** Yes-and, brainwriting luân phiên và kích thích ngẫu nhiên hữu ích khi năng lượng thấp hoặc một ý tưởng đang neo cả phiên.
- **Đi sâu hoặc sắc hơn:** Năm lần Tại sao theo hướng khám phá tìm nhu cầu gốc; phân tích hình thái kết hợp các chiều; khiêu khích, đảo giả định, nhập vai, ràng buộc, ẩn dụ và bão câu hỏi làm lệch một khung đang bế tắc.

Một phiên đầy đủ có thể dùng hai đến bốn kỹ thuật, nhưng một kỹ thuật tốt vẫn hơn việc lướt hời hợt qua quá nhiều kỹ thuật.

## Cuộc trò chuyện diễn ra thế nào

1. **Định khung phiên.** Nêu chủ đề, các ràng buộc cứng và việc bạn muốn khám phá rộng hay tìm câu trả lời hẹp.
2. **Cùng tạo ý tưởng.** Mỗi vòng dùng một câu hỏi. Bạn trả lời trước; ý của bạn được ghi nguyên văn là `(user)`. Sau đó AI đưa ra vài phần mở rộng hoặc hướng mới là `(AI)`.
3. **Kiểm tra năng lượng.** Sau vài vòng, quyết định tiếp tục, đổi kỹ thuật hay hội tụ. Trong lúc mở rộng, ý tưởng không bị xếp hạng hoặc gạt bỏ.
4. **Hội tụ có chủ đích.** Gom các ý liên quan, giữ nhãn nguồn gốc và giải thích lý do cho mọi xếp hạng để bạn có thể phản biện.
5. **Cam kết bước tiếp.** Bạn chọn ba ưu tiên trước khi coach đưa ra lựa chọn của mình; mỗi ưu tiên có hành động nhỏ nhất tiếp theo và cách học xem có đáng theo đuổi không.

## Party mode: góc nhìn, không phải diễn kịch

Party mode là tùy chọn: yêu cầu trực tiếp, dùng khi phiên bắt đầu lặp lại, hoặc yêu cầu một lượt red-team cho danh sách rút gọn. Nó chọn ba hoặc bốn **lăng kính vai trò** theo chủ đề—ví dụ một nhóm khách hàng cụ thể, người phải vận hành ý tưởng, một người ngoài cuộc và một người khiêu khích.

Đây là các góc nhìn làm việc ngắn gọn, không phải nhân vật có tên, tiểu sử hay cuộc đối thoại mô phỏng của một hội đồng. Bạn vẫn đưa ý trước. Coach tổng hợp các lăng kính thành một bản tóm lược ngắn, gắn nhãn như `(AI:operator)` và giới hạn tổng số ý. Trong lúc khám phá, lăng kính hoài nghi biến phản đối thành câu hỏi mở; khi hội tụ, lượt red-team nêu phản đối mạnh nhất, điều gì sẽ bác bỏ ý tưởng và cách rẻ nhất để giảm rủi ro.

## Bạn mang gì, bạn nhận gì

Hãy mang chủ đề, kết quả mong muốn, ràng buộc và các ý tưởng đang có—ghi chú thô cũng được. Bạn cũng có thể chọn có muốn lưu tài liệu phiên hay không.

Bạn nhận được hồ sơ ý tưởng có thể truy vết, các cụm chủ đề, bốn nhóm thực dụng (cơ hội có thể làm ngay, đổi mới tương lai, moonshot và insight), ba ưu tiên của bạn, bước tiếp theo và một bãi đỗ cho các nhánh hữu ích. Nếu lưu tài liệu, tài liệu sẽ ghi chủ đề, ràng buộc, chế độ, kỹ thuật đã dùng, ý tưởng, phân loại và hành động tiếp theo.

## Dùng cùng các skill này

- Bắt đầu với [Problem Solver](../problem-solver/README.vi.md) khi có việc đang hỏng mà chưa rõ nguyên nhân; chẩn đoán trước khi nghĩ cách sửa.
- Dùng [Design Thinking](../design-thinking/README.vi.md) khi điều chưa rõ là con người cần gì và bạn cần nghiên cứu lấy người dùng làm trung tâm.
- Dùng [Market Researcher](../market-researcher/README.vi.md) khi một ý tưởng triển vọng cần kiểm chứng nhu cầu, đối thủ hoặc quy mô thị trường.
- Dùng [Strategy Board](../strategy-board/README.vi.md) khi lựa chọn đã trở thành một cược chiến lược cấp công ty.
- Dùng [Critical Thinking](../critical-thinking/README.vi.md) khi bạn đã biến ý tưởng thành đề xuất và muốn kiểm tra chặt chẽ lập luận.

## Giới hạn

Brainstorm Coach tạo và tổ chức các khả năng; nó không chứng minh nhu cầu thị trường, thực hiện nghiên cứu người dùng, chẩn đoán nguyên nhân gốc hay quyết định thay bạn. Nó cũng không giữ mọi ý tưởng hoang dã bằng cách giả vờ mọi ý tưởng đều sẵn sàng như nhau—đánh giá diễn ra sau giai đoạn mở rộng và cần dựa trên lý do cùng thử nghiệm được nêu rõ.
