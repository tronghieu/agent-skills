# Project Manager

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Biến công việc delivery đầy bất định thành kế hoạch có bằng chứng, dự báo trung thực và dấu vết quyết định rõ ràng.

## Cài đặt nhanh

```bash
npx skills add tronghieu/agent-skills --skill project-manager
```

## Bắt đầu từ nhu cầu dự án thật

Dùng `/project-manager` bằng ngôn ngữ tự nhiên. Ví dụ:

```text
/project-manager Biến phạm vi còn thô này thành kế hoạch theo mốc, có dependency, owner và khoảng ngày hoàn thành đáng tin cậy.
/project-manager Chúng tôi lỡ mốc tích hợp. Hãy lập risk register, chạy pre-mortem và đề xuất quyết định tiếp theo.
/project-manager Soạn báo cáo steering committee tuần này: đưa tin xấu lên đầu, gắn nhãn bằng chứng và nêu các quyết định cần có.
/project-manager Đánh giá yêu cầu thêm SSO này: cho thấy tác động lên scope, tiến độ, chi phí, rủi ro và chất lượng trước khi chấp nhận.
```

## Vì sao dùng skill này thay vì chatbot thông thường?

Chatbot thông thường có thể tạo một kế hoạch đẹp hoặc báo cáo xanh đầy yên tâm từ dữ liệu không đủ. Project Manager được thiết kế để mọi tuyên bố về delivery đều có thể kiểm tra:

- Ngày tháng, ước tính, tiến độ và RAG status đều gắn với bằng chứng, phát biểu có ngày của bạn hoặc giả định công khai.
- Ước tính là khoảng giá trị, được đối chiếu với lịch sử dự án hoặc reference class nêu rõ; buffer luôn được hiện riêng.
- Thay đổi scope, ngày hoặc ngân sách phải có đánh giá tác động và thẩm quyền quyết định được nêu tên trước khi đổi baseline.
- Plan, status report và quyết định thay đổi đều qua một lượt phản biện, để rủi ro và bằng chứng yếu lộ ra trước khi ai đó hành động.

## Dành cho ai

Dùng khi bạn là project manager, program manager, PMO, delivery lead, team lead hoặc sponsor chịu trách nhiệm đưa công việc đã cam kết về đích: scope, tiến độ, ngân sách, rủi ro, stakeholder hoặc báo cáo. Đây là copilot cho dự án đang vận hành—không phải khóa học nhập môn hay công cụ tạo task list chung chung. Bạn vẫn giữ quyền quyết định và cam kết ra bên ngoài.

## Việc skill hỗ trợ

- Khởi động dự án với charter, tiêu chí thành công, thẩm quyền quyết định và phương pháp delivery phù hợp.
- Lập WBS hoặc backlog, dependency, lịch trình theo mốc, critical path và baseline.
- Tạo ước tính theo khoảng, risk register, phương án ROAM, pre-mortem và các lựa chọn khôi phục.
- Soạn cập nhật tuần trung thực, steering pack, giao tiếp stakeholder, action sau họp và decision record.
- Kiểm soát thay đổi, re-baseline minh bạch, ghi lesson và tổng hợp nhiều dự án mà không lấy trung bình để che một dự án đỏ.

## Phương pháp delivery và kỷ luật vận hành

Đây là playbook, không phải tuyến quy trình bắt buộc: bắt đầu từ vấn đề trước mắt, rồi nối các phần việc khi cần. Một vòng delivery thường gồm:

1. **Định hướng:** xác nhận mục tiêu, scope trong/ngoài, tiêu chí thành công, stakeholder, nhịp báo cáo và thẩm quyền.
2. **Lập kế hoạch và ước tính:** phân rã công việc, dependency, chọn khoảng dự báo, làm rõ giả định và buffer, rồi chốt baseline khi sẵn sàng.
3. **Giảm rủi ro và thực hiện:** rà soát rủi ro, action, bằng chứng và tiến độ thực; báo cáo dự báo một cách thẳng thắn.
4. **Quyết định và học:** đánh giá thay đổi trước khi duyệt, giữ baseline cũ và đưa bài học plan-versus-actual vào lần ước tính kế tiếp.

Skill điều chỉnh dạng artifact theo dự án, không ép dự án theo phương pháp: predictive dùng WBS, critical path và stage gate; agile dùng backlog theo capacity, release hoặc sprint, burnup và flow measure; hybrid kết hợp milestone spine với delivery lặp. Kỷ luật luôn như nhau: không bịa dữ kiện, đưa tin xấu lên đầu, ghi quyết định kèm điều kiện xem xét lại và làm rõ bất định.

Ba cổng review bảo vệ các artifact quan trọng. Trước baseline, plan được kiểm tra owner, bằng chứng nghiệm thu, dependency, buffer, kết quả pre-mortem, sự khớp scope và xử lý risk. Trước status report, kiểm tra nguồn gốc dữ liệu, tiến độ trung thực, action phục hồi, độ tin cậy của forecast và sự nhất quán giữa góc nhìn lãnh đạo/đội ngũ. Trước khi thực thi thay đổi, kiểm tra tác động tiến độ, chi phí, rủi ro và chất lượng; thẩm quyền; baseline; và các cập nhật liên quan.

## Cách phối hợp

Với công việc kéo dài, skill duy trì workspace `_project/` gồm bối cảnh dự án, kế hoạch, status snapshot theo ngày và các register về bằng chứng, giả định, rủi ro, action, thay đổi, quyết định và lesson. Khi bạn quay lại, skill dùng trạng thái hiện có và quyết định gần đây thay vì giả vờ nhớ.

Skill chỉ hỏi input còn thiếu cho play hiện tại, nêu rõ mâu thuẫn với hồ sơ và vẫn có thể đưa bản nháp có nhãn giả định khi chưa đủ dữ kiện. Skill không tự bịa ý kiến đồng đội hoặc âm thầm chấp nhận thay đổi. PM chuyển giữa các lens: charter, cấu trúc, ước tính, rủi ro, nói thật, kiểm soát thay đổi, stakeholder, học hỏi và audit. **Solon**, lens audit, thực hiện review phản biện riêng trước khi gửi plan, status report hoặc quyết định thay đổi; khi có agent riêng, lượt review này có thể độc lập.

## Bạn cần đưa gì và sẽ nhận gì

Hãy đưa mọi thứ sẵn có: mục tiêu, scope hiện tại, ràng buộc, ngày mục tiêu, capacity đội ngũ, stakeholder, dependency đã biết, tiến độ hiện tại, nguồn dữ liệu, ước tính hoặc actual trước đây và người có thẩm quyền quyết định. Thông tin thiếu được ghi thành giả định hoặc câu hỏi, không được ngụy trang thành dữ kiện.

Bạn có thể nhận charter; schedule hoặc backlog; khoảng ước tính; risk, evidence, decision, change hoặc action register; status report hoặc steering pack; giao tiếp stakeholder; kết quả cuộc họp; khuyến nghị khôi phục; hoặc portfolio roll-up. Câu trả lời luôn bắt đầu bằng tình hình delivery, bằng chứng cho các con số quyết định và quyết định hay hành động cần có.

## Skill dùng kèm

- Cần quyết định **xây gì, cho ai hoặc ưu tiên thế nào** trước khi cam kết delivery? Dùng [Product Manager](../product-manager/README.vi.md) cho ưu tiên, PRD và bằng chứng sản phẩm; đưa scope đã duyệt vào plan dự án.
- Cần quyết định cấp điều hành về **đầu tư, ưu tiên portfolio, kill/continue hoặc tái phạm vi lớn**? Dùng [Strategy Board](../strategy-board/README.vi.md). Project Manager cung cấp sự thật về delivery; board đánh giá lựa chọn chiến lược.
- Cần kiểm tra lập luận trong **cam kết của vendor, đề xuất cứu dự án hoặc quyết định hệ trọng**? Dùng [Critical Thinking](../critical-thinking/README.vi.md) để audit lập luận, rồi ghi nhận phát hiện có cơ sở thành bằng chứng dự án.

## Giới hạn

Skill không thể biết tiến độ thực, capacity, cam kết của vendor, chính trị nội bộ hoặc dữ liệu lịch sử nếu bạn không cung cấp tài liệu. Skill hỗ trợ và phản biện quyết định; không phê duyệt scope, cam kết thay bạn, thay thế phán đoán chuyên môn/pháp lý/tài chính/nhân sự hoặc bảo đảm kết quả. Xem play, schema và quy ước bằng chứng chi tiết trong [`references/`](./references/).
