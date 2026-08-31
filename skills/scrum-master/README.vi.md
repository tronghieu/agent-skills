# Scrum Master

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Giúp đội phần mềm vận hành sprint tập trung, phát hiện vấn đề sớm và theo sát action sau mỗi retrospective.

## Cài đặt nhanh

```bash
npx skills add tronghieu/agent-skills --skill scrum-master
```

## Bắt đầu từ nhu cầu thật của đội

Dùng `/scrum-master` bằng ngôn ngữ tự nhiên. Ví dụ:

```text
/scrum-master Lập kế hoạch sprint tiếp theo từ backlog, capacity của đội và kết quả ba sprint gần nhất.
/scrum-master Cho tôi sprint pulse hôm nay. Điều gì đang đe dọa sprint goal?
/scrum-master Chuẩn bị retrospective ngày mai và kiểm tra các action từ retro trước đã hoàn thành chưa.
/scrum-master Blocker này đã mở chín ngày. Hãy soạn nội dung escalation và cho biết ai cần hành động.
```

## Vì sao dùng skill này thay vì chatbot thông thường?

Chatbot thông thường có thể soạn agenda cho một ceremony, nhưng dễ quên action cũ hoặc nhận định sprint khi chưa có dữ liệu đáng tin cậy. Scrum Master giúp lịch sử vận hành của đội luôn rõ ràng:

- Metric của sprint phải gắn với tracker, bản export có ngày hoặc giả định được nêu rõ. Dữ liệu thiếu được ghi là chưa biết, không được biến thành con số có vẻ hợp lý.
- Action từ retrospective được giữ mở cho đến khi đội hoàn thành hoặc chủ động đóng.
- Công việc thêm vào hoặc bỏ khỏi sprint được ghi nhận là thay đổi scope.
- Blocker và vấn đề quy trình lặp lại được đối chiếu giữa nhiều sprint, không bị xem là vấn đề mới mỗi lần.
- Trao đổi, thương lượng và escalation vẫn do con người thực hiện. Skill soạn nội dung bàn giao và ghi rõ ai cần follow up.

## Dành cho ai

Dùng khi bạn là Scrum Master, engineering manager, tech lead, delivery lead, product owner hoặc thành viên đang hỗ trợ một đội phần mềm làm việc theo sprint. Skill có thể giữ vai trò Scrum Master chính khi đội chưa có người phụ trách, hoặc làm copilot cho Scrum Master hiện tại.

Đội vẫn quyết định cách áp dụng Scrum, working agreement và các cuộc trao đổi với con người.

## Việc skill hỗ trợ

- Tiếp nhận một đội đang vận hành và kết nối các artifact Scrum hiện có.
- Lập kế hoạch sprint với goal rõ ràng, capacity thực tế và công việc đủ sẵn sàng.
- Tạo sprint pulse ngắn, đưa rủi ro, blocker và thay đổi scope lên trước.
- Đóng sprint bằng snapshot ổn định để so sánh về sau.
- Chuẩn bị và follow up retrospective, bao gồm action cải tiến chưa hoàn thành.
- Theo dõi impediment, soạn escalation và kiểm tra thời gian mở cùng owner.
- Quét lịch sử sprint để phát hiện vấn đề lặp lại và ceremony mất hiệu quả.
- Coach đội bằng những cải tiến quy trình nhỏ, thực tế.

## Cách duy trì công việc nhất quán

Với công việc kéo dài, skill duy trì workspace `_project/scrum-master/` gồm bối cảnh đội, hồ sơ sprint, impediment, action từ retrospective và báo cáo sức khỏe theo ngày. Ở phiên tiếp theo, skill đọc workspace này trước khi đưa khuyến nghị.

Bạn có thể kết nối tracker như Jira, Linear hoặc GitHub Projects qua `_project/tools.md`. Nếu chưa truy cập được tracker, hãy cung cấp bản export hoặc tóm tắt có ngày. Skill vẫn có thể chuẩn bị bản nháp hữu ích, nhưng sẽ ghi rõ giả định và dữ kiện còn thiếu.

Khởi tạo workspace một lần khi cần:

```bash
bash /mnt/skills/user/scrum-master/scripts/init-scrum.sh "<tên đội hoặc dự án>" [parent-dir]
```

## Bạn cần đưa gì và sẽ nhận gì

Hãy cung cấp những gì đang có: sprint goal, backlog, capacity của đội, Definition of Done, bản export từ tracker, blocker hiện tại, kết quả các sprint gần đây và action từ retrospective trước. Bạn không cần chuẩn bị đủ mọi thứ rồi mới bắt đầu.

Tùy yêu cầu, bạn sẽ nhận sprint plan, pulse, close summary, retrospective pack, cập nhật impediment, bản nháp escalation hoặc báo cáo sức khỏe quy trình. Câu trả lời nêu kết luận trước, chỉ rõ nguồn dữ liệu và tách dữ kiện khỏi giả định.

## Skill dùng kèm

- [Project Manager](../project-manager/README.vi.md) — dùng khi câu hỏi chuyển từ quy trình của đội sang ngày delivery, ngân sách, project risk hoặc báo cáo stakeholder.
- [Product Manager](../product-manager/README.vi.md) — dùng khi cần quyết định xây gì, vì sao cần xây hoặc ưu tiên backlog thế nào.

## Giới hạn

Skill không thể quan sát động lực trong đội hoặc biết trạng thái board hiện tại nếu bạn không cung cấp quyền truy cập hay dữ liệu. Skill không gửi tin nhắn, tự giải quyết xung đột, đưa ra cam kết hoặc thay thế phán đoán của con người. Skill hỗ trợ sức khỏe quy trình Scrum; không sở hữu chiến lược sản phẩm, ngân sách dự án hay cam kết delivery.

Xem [SKILL.md](./SKILL.md) để biết quy tắc vận hành và [`references/`](./references/) để đọc chi tiết từng play.
