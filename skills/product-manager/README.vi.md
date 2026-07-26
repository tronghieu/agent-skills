# Product Manager

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Biến bằng chứng sản phẩm thành quyết định có thể bảo vệ, artifact để hành động và hồ sơ để cả đội quay lại.

## Cài đặt

```bash
npx skills add tronghieu/agent-skills --skill product-manager
```

## Thử ngay

```text
/product-manager Ưu tiên các cơ hội này và chỉ ra thứ hạng nào đổi khi giả định thay đổi.
/product-manager Viết PRD cho offline mode từ feedback này và làm rõ ranh giới release.
/product-manager Thiết kế launch plan cho thay đổi billing này, gồm tiêu chí rollback cam kết trước.
/product-manager Chuyển các ticket support này thành cơ hội sản phẩm và cho biết chúng thách thức quyết định nào.
```

## Vì sao dùng thay vì chatbot thông thường?

Một chatbot thông thường có thể tạo bảng RICE hoặc PRD trau chuốt từ những phỏng đoán nghe có vẻ hợp lý. Copilot này giữ bất định ở trạng thái nhìn thấy được: mỗi con số cho quyết định gắn với nguồn, giả định có khoảng, hoặc ước tính có ngày của bạn; kết luận dựa trên giả định được phân tích độ nhạy; và công việc chưa có bằng chứng được ghi rõ là một bet. PRD, ưu tiên và launch plan đều được kiểm tra phản biện công khai trước khi bạn hành động.

## Dành cho ai

Dùng cho product manager, product lead, product owner và founder sở hữu quyết định sản phẩm, phối hợp với người dùng, engineering, design, support, sales và các stakeholder kinh doanh. Bạn vẫn chịu trách nhiệm cho quyết định cuối cùng; copilot đóng khung lựa chọn, nêu mâu thuẫn với bằng chứng hiện có và giữ dấu vết quyết định.

Các trường hợp dùng điển hình:

- Biến feedback thô thành cơ hội gắn bằng chứng, thay vì danh sách feature request.
- Ưu tiên các cơ hội độc lập bằng RICE và sensitivity analysis; dùng Kano để kiểm tra loại kỳ vọng, không giả tạo thứ hạng.
- Xác định vấn đề trong PRD bằng job story, story map, acceptance criteria có thể kiểm thử và ranh giới Won't-have rõ ràng.
- Xác định north-star metric, metrics tree, guardrail và OKR hướng outcome.
- Thiết kế experiment có tiêu chí pass, fail và hành động tiếp theo được định trước khi có kết quả.
- Lập rollout theo rủi ro, stage gate định lượng, tiêu chí rollback và post-launch review.
- Quyết định platform-versus-feature hoặc đưa ra lựa chọn pricing và packaging gọn, dựa trên bằng chứng.

## Kỷ luật PM

Đây là playbook, không phải quy trình theo pha cố định: hãy đi vào từ quyết định bạn cần ngay lúc này. Với công việc tiếp diễn, nó quay lại trạng thái hiện tại và các quyết định trước đó trước khi làm tiếp; với yêu cầu một lần, nó tạo artifact mà không bắt bạn dựng nghi thức.

Vòng lặp là: ghi nhận bằng chứng và feedback → đóng khung user job và cơ hội → ưu tiên → đặc tả và scope → đo lường → kiểm tra niềm tin rủi ro nhất → launch an toàn → đưa bài học vào quyết định kế tiếp. Workspace sản phẩm giữ evidence registry, giả định, cơ hội, metrics, artifacts, decision log và trạng thái hiện tại xuyên qua nhiều phiên. Mỗi quyết định lưu lý do, ý kiến bất đồng khi cần và điều kiện xem xét lại.

Mỗi framework ở đúng độ cao của nó: job story đóng khung vấn đề; RICE so sánh cơ hội; story mapping phân rã cơ hội đã chọn; MoSCoW vạch release line; Kano kiểm tra loại kỳ vọng. Input còn thiếu được hỏi hoặc đăng ký thành giả định trung thực có khoảng, không tự điền âm thầm.

## Các lens và quality gate

Một PM chuyển lens theo nhu cầu công việc:

| Lens | Trách nhiệm |
| --- | --- |
| Sao — Compass | Hướng đi, positioning, platform-versus-feature, pricing |
| Minh — Scope | PRD, story map, user story, release scope |
| Lam — Scale | Cơ hội, RICE, sensitivity, Kano |
| Kim — Gauge | North star, metric tree, OKR |
| Mai — Lab | Experiment có thể bác bỏ giả định |
| Phong — Ramp | Launch theo rủi ro và rollback |
| Thanh — Echo | Triage feedback và voice of customer |
| Bao — Judge | Kiểm tra phản biện PRD, ưu tiên và launch plan |

Bao kiểm tra provenance, traceability, tính kiểm thử, scope, sensitivity và biện pháp bảo vệ khi launch trước khi artifact liên quan được trình để hành động. Khi có agent riêng, Bao chạy độc lập; nếu không, audit vẫn công khai và các phát hiện vẫn nằm trong artifact. Các lens khác tiến hành tuần tự cùng bạn trong cuộc trò chuyện.

## Cần mang gì, nhận gì

Hãy mang bất cứ gì bạn có: bối cảnh sản phẩm, người dùng dự kiến, feedback, research, analytics, ràng buộc kinh doanh, ước tính engineering và quyết định cần giải. Bạn không cần dữ liệu hoàn chỉnh. Copilot phân biệt bằng chứng với giả thuyết và nêu rõ thông tin nào có thể thay đổi khuyến nghị.

Tùy play, bạn nhận được backlog cơ hội gắn bằng chứng; thứ tự ưu tiên có sensitivity; PRD và story map; định nghĩa metrics hoặc OKR có baseline được gắn nhãn; experiment card được chốt trước; launch plan có điều kiện rollback; hoặc quyết định platform, feature hay pricing được ghi lại. Phản hồi nêu trực tiếp khuyến nghị và caveat, thay vì giấu kết luận trong workspace.

## Skill bổ trợ

Đây là các skill tùy chọn, không phải điều kiện tiên quyết:

- [design-thinking](../design-thinking/README.vi.md) — dùng khi cần discovery sâu: interview, field research, prototype testing, hoặc hiểu vì sao và cách người dùng trải nghiệm vấn đề. Bằng chứng của nó có thể đưa vào workspace sản phẩm này.
- [market-researcher](../market-researcher/README.vi.md) — dùng khi cần dữ kiện thị trường bên ngoài: bối cảnh đối thủ, market sizing, pricing benchmark hoặc bằng chứng willingness-to-pay có nguồn vượt quá vài kiểm tra nhanh.
- [strategy-board](../strategy-board/README.vi.md) — dùng khi quyết định vượt quá độ cao sản phẩm, như vào thị trường mới, build-versus-buy hoặc dừng một product line.

## Giới hạn

Skill không bịa user research, dữ kiện thị trường, analytics, ước tính engineering, kết quả experiment hay trích dẫn khách hàng. Nó thiết kế experiment nhưng không mô phỏng kết quả; primary discovery thuộc design-thinking và chiến lược công ty rộng hơn thuộc strategy-board. Nó hỗ trợ quyết định sản phẩm và handoff, không triển khai sản phẩm.

Xem các play và schema chi tiết trong [`references/`](./references/).
