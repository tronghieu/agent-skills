# Tư duy thiết kế (Design Thinking)

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Biến bằng chứng người dùng thật thành vấn đề trọng tâm, danh mục concept và các phép thử có thể bác bỏ giả thuyết—không bịa persona, câu nói hay kết quả nghiên cứu.

```bash
npx skills add tronghieu/agent-skills --skill design-thinking
```

## Ví dụ nhanh

```text
/design-thinking Người dùng rời ứng dụng học tập sau tuần đầu. Hãy giúp tôi định khung vấn đề và tạo kế hoạch phỏng vấn không dẫn dắt cho người học trưởng thành.

/design-thinking Tôi có tám transcript phỏng vấn về tiểu thương nhận thanh toán số. Hãy tổng hợp thành insight có bằng chứng, chỉ tạo persona nếu phân khúc là thật, rồi đề xuất câu hỏi HMW.

/design-thinking Chúng tôi đã có prototype checkout có thể nhấp. Hãy lập bản đồ các giả định rủi ro nhất và thiết kế usability test với tiêu chí đạt/không đạt được chốt trước.
```

## Vì sao nên dùng thay vì hỏi chatbot thông thường?

Một cuộc chat thông thường có thể nhanh chóng tạo ra ý tưởng nghe hợp lý—và cả “insight người dùng” hư cấu nhưng cũng nghe hợp lý. Skill bổ sung kỷ luật phương pháp:

- Mỗi nguồn bằng chứng có mã `[S#]`; mỗi insight `[I#]` phải truy ngược được về nguồn.
- Nhận định chưa được hỗ trợ luôn mang nhãn giả thuyết; persona không được tô điểm bằng chi tiết bịa.
- Hồ sơ dự án liên tục lưu quyết định, câu hỏi mở và các vòng quay lại qua nhiều phiên.
- Các cổng rõ ràng ngăn quy trình đi tiếp khi chưa đủ bằng chứng hoặc chưa có quyết định của bạn.
- Các lens ý tưởng độc lập giúp giảm neo tư duy; audit đối nghịch thách thức kết luận hấp dẫn nhưng yếu.
- Phép thử nhắm vào giả định rủi ro nhất và chốt tiêu chí trước khi xem kết quả.

## Skill này là gì và dành cho ai?

Design Thinking (tư duy thiết kế) là phương pháp lặp lấy con người làm trung tâm, giúp tìm hiểu nhu cầu thực trước khi cam kết xây một giải pháp. Skill điều phối trọn vòng **Empathize → Define → Ideate → Prototype → Test**, hoặc chỉ hỗ trợ một pha như soạn discussion guide hay kiểm thử prototype có sẵn.

Skill phù hợp với product manager, UX researcher, designer, service team, founder và đội innovation. Bạn cần tiếp cận được người dùng thật hoặc có bằng chứng thật như ghi chú phỏng vấn, transcript, support ticket, khảo sát, analytics hay kết quả test.

## Phương pháp thực hiện

| Pha | Điều gì diễn ra | Cổng hoặc điểm bàn giao |
| --- | --- | --- |
| **Kickoff** | Định khung vấn đề, người dùng mục tiêu, phạm vi, ràng buộc và bằng chứng hiện có. | Bạn xác nhận khung. |
| **Empathize** | Thiết kế câu hỏi nghiên cứu, tiêu chí tuyển người, guide phỏng vấn/quan sát và câu hỏi không dẫn dắt, ưu tiên hành vi trong quá khứ. | Skill dừng để bạn thực hiện nghiên cứu và mang dữ liệu thật trở lại. |
| **Define** | Trích quan sát, affinity map theo mâu thuẫn, hình thành insight có bằng chứng và chỉ tạo persona khi dữ liệu thật sự cho thấy các phân khúc khác biệt. Sau đó tạo POV và câu hỏi How Might We (HMW). | Insight audit kiểm tra nguồn, câu trích, giả định, cách giải thích thay thế và chi tiết persona; bạn chọn 3–5 HMW. |
| **Ideate** | Mở rộng không phán xét, rồi thu hẹp ở một lượt riêng. Các lens độc lập—nguyên lý đầu tiên, lĩnh vực tương đồng, SCAMPER, người dùng cực biên, đảo ngược và công nghệ—tạo nhiều hướng. Shortlist được thảo luận theo desirability, feasibility và viability. | Bạn chọn 1–3 concept và làm rõ các giả định còn mở. |
| **Prototype** | Tạo artifact có độ trung thực thấp nhất nhưng đủ trả lời một câu hỏi: storyboard, wireframe, concierge/Wizard-of-Oz, fake door hoặc functional slice. Spec nói rõ phần thật, phần giả lập và hành vi cần quan sát. | Prototype chỉ sẵn sàng khi có thể dùng cho một phép thử đo được. |
| **Test** | Lập bản đồ giả định, chọn giả định có tác động cao nhất và ít chắc chắn nhất, rồi đăng ký trước test card gồm người tham gia, quy trình, chỉ số và ngưỡng đạt/không đạt. | Assumption audit chạy trước khi bạn thực hiện test; kết quả tạo thành learning card. |

Kết quả không mặc định là “tiếp tục”. Bằng chứng dẫn tới một trong bốn quyết định: **persevere** (giữ hướng), **iterate** prototype, **pivot** về định khung vấn đề hoặc **stop**. Mỗi vòng lặp đều ghi số vòng và lý do.

## Trải nghiệm điều phối

Skill giao tiếp qua **Helm**, điều phối viên chính giữ trạng thái dự án, dẫn dắt quyết định và đổi lens theo công việc:

- **Lens** thiết kế nghiên cứu người dùng; **Radar** bổ sung bối cảnh thị trường và tính khả thi.
- **Loom** tổng hợp bằng chứng thành insight, persona, POV và HMW.
- **Prism** triển khai ideation qua nhiều góc nhìn độc lập.
- **Forge** đặc tả prototype phục vụ học hỏi; **Probe** thiết kế phép thử có thể bác bỏ.
- **Judge** audit độc lập insight và giả định tại hai cổng quan trọng.

Đây là các góc nhìn chức năng, không phải nhân vật bạn phải quản lý. Helm sẽ cho biết mode đang hoạt động, trình bày artifact và dừng tại điểm cần bạn quyết định. Ở Ideate, nhiều Prism lens có thể đóng góp độc lập trước khi so sánh ý tưởng; Judge cũng có thể review độc lập để tránh tự phê duyệt chính lập luận vừa tạo.

Hãy chờ đợi những khoảng dừng có chủ đích: skill thiết kế nghiên cứu và test, nhưng **bạn hoặc đội của bạn phải thực hiện chúng**. Skill có thể role-play phỏng vấn thử để cải thiện guide, nhưng luôn ghi rõ đó là mô phỏng và không bao giờ coi là bằng chứng. Khi bạn quay lại ở phiên sau, skill tiếp tục từ pha đã ghi thay vì làm lại từ đầu.

## Bạn cần cung cấp gì?

Hãy bắt đầu bằng bất cứ thứ gì đang có:

- Vấn đề hoặc quyết định, người dùng mục tiêu, phạm vi, ràng buộc và định nghĩa thành công.
- Bằng chứng thô sẵn có, kèm đủ bối cảnh nguồn để đăng ký trung thực.
- Khả năng tiếp cận người có thể được phỏng vấn hoặc thử prototype.
- Concept hay prototype có sẵn nếu muốn bắt đầu thẳng từ Prototype hoặc Test.

Nếu chưa có nghiên cứu sơ cấp, bạn vẫn có thể chủ động chọn chế độ chỉ-giả-thuyết. Khi đó insight tiếp tục mang nhãn giả thuyết, persona được ghi rõ là **proto-persona**, và Test là lần đầu thực tế có quyền xác nhận hoặc bác bỏ.

## Bạn sẽ nhận được gì?

Tùy điểm bắt đầu: kế hoạch nghiên cứu và discussion guide; sổ đăng ký nguồn; insight và persona có bằng chứng; POV và HMW; danh mục ý tưởng đã chấm; prototype brief; bản đồ giả định; test card đăng ký trước; learning card; cùng nhật ký quyết định cho công việc nhiều phiên.

## Skill bổ trợ được khuyến nghị

Đây là các khuyến nghị bổ trợ, không phải điều kiện bắt buộc:

- [`market-researcher`](../market-researcher/README.vi.md) khi cần market sizing, phân tích sâu đối thủ, xu hướng hoặc tín hiệu nhu cầu rộng hơn. Nghiên cứu bàn giấy của skill này cung cấp bối cảnh có nguồn, nhưng không thay thế nghiên cứu người dùng sơ cấp.
- [`product-manager`](../product-manager/README.vi.md) sau khi nhu cầu và concept đã rõ hơn, khi bạn cần ưu tiên sản phẩm, viết đặc tả, chọn roadmap, thiết kế metric hoặc lập kế hoạch ra mắt.

## Giới hạn quan trọng

Nghiên cứu bàn giấy không thể chứng minh người dùng *của bạn* nghĩ gì hoặc sẽ mua gì. Skill không bịa dữ liệu phỏng vấn hay âm thầm nâng giả định thành sự thật. Skill cũng không thể tự tuyển người tham gia hoặc thực hiện phiên ngoài đời thay bạn; kết quả test hỗ trợ chứ không thay thế phán đoán, đạo đức và chuyên môn ngành của bạn. Với fake door hoặc phép thử cam kết, đừng nhận tiền nếu không thể thực hiện hoặc hoàn tiền một cách trung thực.

Phương pháp chi tiết từng pha và schema bằng chứng nằm trong [`references/`](./references/).
