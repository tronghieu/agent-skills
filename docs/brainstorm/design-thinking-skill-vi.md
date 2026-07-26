# Brainstorm: Skill Design Thinking

> Ghi chú phiên trao đổi 2026-07-09/10. Mục đích: lưu lại các quyết định thiết kế
> cho skill design-thinking để quay lại xây dựng sau khi hoàn thành skill
> market-researcher (được ưu tiên build trước).

## Trạng thái

- **Quyết định**: build skill market-research trước, design-thinking sau.
- **Lý do**: design-thinking cần năng lực research nặng; tách nó thành skill riêng
  dùng chung được cho cả design-thinking lẫn strategy-board.

## Vì sao design thinking hợp để làm skill

- Quy trình có cấu trúc rõ (Empathize → Define → Ideate → Prototype → Test) —
  quản lý được bằng phase state như strategy-board.
- Mỗi giai đoạn sinh artifact chuẩn: empathy map, persona, POV statement,
  How-Might-We, ý tưởng đã chấm điểm, prototype spec, test plan & kết quả.
- AI mạnh ở phần divergent (brainstorm, SCAMPER, analogous inspiration) và
  convergent có kỷ luật (affinity mapping, chấm điểm desirability/feasibility/viability).

## Non-negotiable số 1: không bịa insight người dùng

Failure mode tệ nhất: bịa persona, bịa insight, bịa kết quả test (tương đương
"invented numbers" của strategy-board). Chặn bằng:

1. Insight phải trace về nguồn: ghi chú phỏng vấn user cung cấp, transcript,
   khảo sát, dữ liệu hành vi — hoặc gắn nhãn rõ `(giả định — cần kiểm chứng)`.
2. Giai đoạn Empathize: AI đóng vai **người thiết kế nghiên cứu** — soạn
   discussion guide, câu hỏi phỏng vấn, kế hoạch quan sát — rồi *đợi user mang
   dữ liệu thật về*, không tự tưởng tượng người dùng.
3. Giai đoạn Test: AI thiết kế thí nghiệm + tiêu chí pass/fail — user chạy test thật.

Bản chất skill: **facilitator + đối tác tư duy**, không phải "AI làm design
thinking hộ user".

## Hình thái đã chốt (theo quyết định của user)

1. **Team đa agent + workspace bền vững** — nhiều lens ở các bước phân tán
   (Ideate), Empathize thì AI chỉ guide/đặt câu hỏi/soạn tài liệu.
2. **Dự án kéo dài qua nhiều phiên chat** — cần re-entry protocol.

### Roster đề xuất

| Vai trò | Phase chính | Ghi chú |
|---|---|---|
| Facilitator (lead) | Xuyên suốt | Giữ phase state, cast specialist, giao tiếp với user |
| Research designer | Empathize | Soạn discussion guide, câu hỏi phỏng vấn — đợi user mang dữ liệu về |
| Desk researcher | Empathize → Prototype | Market research nhẹ, existing solutions, secondary sources |
| Synthesizer | Define | Affinity mapping, persona, POV, HMW |
| Ideators (nhiều lens song song) | Ideate | Chỗ duy nhất fan-out nhiều agent thực sự đáng giá |
| Prototyper | Prototype | Storyboard, spec, paper prototype |
| Test designer | Test | Thiết kế thí nghiệm, tiêu chí pass/fail — user chạy test thật |
| Verifier / skeptic | Phase gates | Fact-check insight, assumption audit, red-team trước khi chuyển phase |

Lưu ý: vai trò = lens phân công cho subagent (như strategy-board), KHÔNG bê kiểu
BMAD "persona có tên + HALT chờ lệnh + menu số".

### Workspace đề xuất

- `project.md` — brief, phạm vi, người dùng mục tiêu
- `phase-state.md` — phase hiện tại, điều kiện chuyển phase, việc đang chờ user
- `research/` — dữ liệu thô user thả vào; `sources.md` đánh mã `[S#]`
- `insights.md` (mã `[I#]` trace về `[S#]`), `personas.md`, `hmw.md`, `ideas.md`,
  `prototypes/`, `tests/`
- `journal.md` — log quyết định theo phiên, phục vụ re-entry

**Re-entry protocol**: workspace tồn tại → đọc `phase-state.md` + `journal.md`
trước, nói lại "lần trước dừng ở đây, đang chờ X".

**Quy trình lặp, không tuyến tính**: Test thường đẩy ngược về Define/Ideate.
Phase state phải cho phép quay lui có chủ đích ("vòng 2, quay lại Define vì test
bác giả định A3").

## Fact-check / verify / market research nằm ở đâu

- **Market research (desk research)**: Empathize/Define (secondary research bổ
  trợ — không thay thế — dữ liệu phỏng vấn thật), Ideate (quét existing
  solutions, tránh phát minh lại), trước Prototype (feasibility/viability nhanh).
- **Verifier chạy ở phase gate**: cuối Define (audit insight/POV — cái nào trace
  được về dữ liệu thật, cái nào là giả định đội lốt insight); trước Test (soát
  assumption map, bảo đảm test nhắm vào riskiest assumption).
- Cơ chế trích nguồn tái dùng pattern strategy-board: `[I#]` → `[S#]`.

## Kết quả khảo sát 2 bộ tham khảo BMAD

### `BMAD-METHOD-EXP/expansion-packs/bmad-market-researcher`

- 4 persona có tên (Maya lead / Alex data / Sofia consumer / Marcus competitive),
  workflow comprehensive 2–4 tuần → báo cáo 40–50 trang; có
  `quick-market-assessment` 1–2 ngày (go/no-go) — **bản quick là quy mô mặc định
  nên theo**, comprehensive là opt-in.
- **Chưa hoàn chỉnh**: ~25 task + 13 template được khai báo, chỉ 4 task + 4
  template + 1 checklist tồn tại. Là skeleton/spec, không phải thứ chạy được.
- **Citation/fact-check chỉ là văn tự răn**, không có schema hay cơ chế bắt buộc
  — điểm yếu nhất, phải làm tốt hơn hẳn.
- Tài liệu tái dùng được ngay: `frameworks/pestel-analysis.md`,
  `frameworks/customer-journey-mapping.md`,
  `frameworks/competitive-intelligence-framework.md`, `data/bmad-kb.md` —
  nhấc vào `references/` của skill mới.
- Chính nó cũng xem research là node trong pipeline (mục "Integration APIs"
  định nghĩa file bàn giao cho product-manager/strategy-consultant).

### `vtech/seli/.agents/skills/bmad-technical-research`

- Minh chứng cho pattern composition: technical/market/domain research là **ba
  skill độc lập cùng khuôn dạng**, compose qua menu của persona "analyst".
- Mỗi skill: 6 step file tuần tự, ~15+ web search, output có `_Source: [URL]_`,
  state resume được qua frontmatter (`stepsCompleted`/`lastStep`).
- Mỗi step file 120–500 dòng scaffolding — nhét vào skill lớn sẽ nuốt chửng
  phần còn lại → củng cố quyết định tách.

## Kiến trúc đã chốt: composition, không đóng gói

Tiêu chí: **dính chặt phase state/gate → ở trong skill; nặng + tái sử dụng +
contract sạch → tách ra.**

- **Trong design-thinking**: process/phases/workspace/journal/re-entry, verifier
  ở phase gate, desk research nhẹ (quét nhanh, vài web search).
- **Tách skill market-research riêng**: TAM/SAM/SOM, competitor analysis sâu,
  trend analysis. Dùng chung cho strategy-board (fact-base) và design-thinking.
- **Contract giữa các skill**:
  - Input: câu hỏi research + scope + đường dẫn workspace của caller
  - Output: markdown thả vào `research/` của workspace caller, mọi claim theo
    schema `[S#]` (nguồn, URL, ngày truy cập, độ tin cậy)
  - Cách gọi: SKILL.md của caller gợi ý user chạy skill research, hoặc spawn
    subagent chạy nó

## Lộ trình

1. ✅ Chốt thiết kế (tài liệu này)
2. ⏳ **Build skill market-researcher** (đang làm — cân nhắc tên khác hay hơn)
3. Build skill design-thinking (desk research nhẹ inline + verifier ở gate)
4. Nối contract vào cả design-thinking lẫn strategy-board
