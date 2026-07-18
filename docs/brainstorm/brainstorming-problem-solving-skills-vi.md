# Brainstorm: Skill brainstorm-coach + problem-solver

> Ghi chú phiên trao đổi 2026-07-18. Mục đích: lưu quyết định thiết kế cho hai
> skill mới (brainstorm-coach, problem-solver) trước khi build bằng skill-creator.

## Trạng thái

- **Quyết định**: build 2 skill mới — `brainstorm-coach` và `problem-solver`.
  KHÔNG build innovation-strategist (lãnh địa đã thuộc strategy-board).
- **Đã chốt với user**: (1) brainstorm-coach chạy chế độ **hybrid commit-first**
  (user sinh ý trước mỗi vòng, AI bồi sau có dán nhãn); (2) problem-solver dừng
  ở problem→solution, decision lớn đẩy sang strategy-board.
- **Chiến lược họ skill**: khuyến khích user cài các skill cùng bộ thay vì skill
  ôm đồm. Đến handoff moment, agent tự invoke skill phù hợp nếu đã cài, hoặc
  gợi ý cài nếu chưa thấy (kèm fallback nhẹ inline, không chặn công việc).

## Vì sao cần skill riêng (kết quả khảo sát)

- `design-thinking` Ideate có 6 lens nhưng khóa sau cổng Define (cần HMW +
  `[I#]` + `[S#]`); không có cửa vào cho "brainstorm nhanh về X". Mở cửa
  standalone sẽ đục lỗ kỷ luật evidence-traced — thứ làm skill đó thắng eval —
  và làm loãng description/trigger.
- `critical-thinking` thuần đánh giá, zero generative.
- Toàn repo không có gì về root cause (5 Whys, fishbone, TRIZ), lateral
  thinking, systematic problem solving (grep 0 kết quả).
- Innovation strategy (kiểu Victor/BMAD CIS) chồng lấn trực tiếp strategy-board
  (Christensen ngồi sẵn trong board) → không làm.

## Ranh giới trigger giữa các skill trong họ

| Tín hiệu từ user | Skill dẫn |
|---|---|
| "Cho tôi ý tưởng về X", topic mở, chưa cần chẩn đoán | **brainstorm-coach** |
| "X đang hỏng/đau mà chưa rõ vì sao" — vận hành/quy trình/kỹ thuật | **problem-solver** |
| Vấn đề xoay quanh *người dùng*, cần research thật | design-thinking |
| "Lập luận/tài liệu này có ổn không" | critical-thinking |
| Quyết định chiến lược cấp công ty | strategy-board |

Điểm nóng phải xử trong description: design-thinking đang claim "users are
churning and we don't know why". Phân xử: churn về **hành vi người dùng** →
design-thinking; nghẽn về **vận hành/quy trình/kỹ thuật** → problem-solver.

## Skill 1: brainstorm-coach

Bản chất: **facilitator + đối tác hybrid**, không phải máy phun ý tưởng.

### Cơ chế hybrid commit-first (chữ ký của skill)

Mỗi vòng kỹ thuật: AI đặt prompt → **user sinh ý trước** → AI bồi thêm
("yes-and", biến thể, ý mới) với nhãn rõ ràng phân biệt ý user / ý AI. Ý user
ghi **nguyên văn** (bài học copy-never-retype từ eval trước). Nếu user bí, AI
mồi 1-2 ý rồi trả sân.

### Thư viện kỹ thuật

`references/techniques.md` — ~20 kỹ thuật, 5 nhóm (tự viết lại, không copy BMAD):

1. **Mở rộng sáng tạo**: What-if scenarios, Analogical thinking,
   Reversal/Inversion, First principles
2. **Framework có cấu trúc**: SCAMPER, Six Thinking Hats, Mind mapping
3. **Cộng tác**: Yes-and building, Brainwriting/round robin, Random stimulation
4. **Đào sâu**: Five Whys (dạng khám phá), Morphological analysis, Provocation (PO)
5. **Nâng cao**: Forced relationships, Assumption reversal, Role playing,
   Time shifting, Resource constraints, Metaphor mapping, Question storming

Mỗi kỹ thuật: mô tả 2-3 dòng + cách facilitate (prompt mẫu) + hợp với loại
topic nào.

### Session flow

1. **Setup** — 4 câu hỏi: chủ đề? ràng buộc? mở rộng hay tập trung? cần doc
   output không (mặc định có)?
2. **Chọn kỹ thuật** — 4 mode: user tự chọn / AI đề xuất theo ngữ cảnh /
   random / progressive flow (broad → narrow).
3. **Diverge** — MỘT kỹ thuật một lúc, MỘT câu hỏi một lúc, chờ user trả lời.
   Đổi kỹ thuật khi user muốn hoặc khi energy checkpoint báo đuối. Capture ý
   liên tục vào doc.
4. **Converge** — nhóm ý (affinity), khử trùng lặp. Không đánh giá trong lúc
   diverge.
5. **Synthesize** — phân loại: Immediate Opportunities / Future Innovations /
   Moonshots / Insights & Learnings; user chọn top 3 + next steps.

### Output & phạm vi

- Một doc duy nhất `brainstorm-<slug>-<date>.md`, không cần workspace bền vững.
- Anti-patterns chặn: AI dump 30 ý một lượt; đánh giá len vào lúc diverge;
  scoring theatre lúc converge; bám kỹ thuật đã chết.

### Handoff trong họ

- Ý tưởng cần hiểu người dùng thật → design-thinking
- Chủ đề hóa ra là vấn đề cần chẩn đoán nguyên nhân → problem-solver
- Ý tưởng cần validate thị trường → market-researcher
- Ý tưởng thành bet chiến lược → strategy-board

## Skill 2: problem-solver

Bản chất: **chẩn đoán trước, giải pháp sau** — với kỷ luật anti-fabrication:
AI không bịa fact về tổ chức/hệ thống của user (hỏi user); nguyên nhân chưa
kiểm chứng luôn mang nhãn hypothesis.

### Pipeline 6 bước (có gate như design-thinking)

1. **Frame** — intake (chuyện gì / phát hiện thế nào / ảnh hưởng / thành công
   trông ra sao) → Problem Statement Refinement: biến phàn nàn mơ hồ thành
   statement chính xác. Gate: user xác nhận statement.
2. **Bound** — **Is/Is-Not analysis**: xảy ra ở đâu/khi nào/với ai vs KHÔNG
   xảy ra ở đâu/khi nào/với ai → boundary patterns (kỹ thuật đắt giá nhất học
   từ Quinn/BMAD CIS).
3. **Diagnose** — chọn 2-3 phương pháp theo *hình dạng* vấn đề:
   - chuỗi tuyến tính → Five Whys
   - đa nhân tố → Fishbone/Ishikawa
   - vòng lặp hệ thống → causal loops + system archetypes
   Mỗi mắt xích nhân quả đánh nhãn `verified` / `assumed`. Mỗi root cause
   candidate kèm **test kiểm chứng** ("nếu đây là nguyên nhân, ta sẽ thấy X").
   Force Field / constraint analysis: optional khi vấn đề dính thay đổi tổ chức.
4. **Solve** — sinh giải pháp: **gọi brainstorm-coach nếu đã cài** (composition
   trong họ), chưa cài thì gợi ý cài + chạy bản divergence nhẹ inline (2-3 kỹ
   thuật). Mọi giải pháp phải map về root cause cụ thể (trace discipline như
   design-thinking).
5. **Decide** — tiêu chí (hiệu quả, khả thi, chi phí, thời gian, rủi ro) →
   decision matrix. Chấm điểm phải cite evidence hoặc nhãn
   `unknown — assumption`; chống scoring theatre. Khuyến nghị 1 giải pháp.
6. **Plan** — chiến lược pilot/phased/big-bang, action + owner, metrics,
   **pivot triggers**, kế hoạch validate các assumption còn mở.

### Assumption log (học từ pack bmad-problem-solver của bạn user)

`assumptions.md`: mỗi assumption có statement, category, confidence (5 mức),
validation plan, và **confidence delta** sau khi kiểm chứng (0.70 → 0.10 là
một kết quả hợp lệ và đáng giá). Đây là mảnh ghép hợp nhất với khẩu vị
anti-fabrication của cả họ skill.

KHÔNG bê về: kiến trúc 5-persona + consensus Fist-to-Five (strategy-board đã
làm multi-persona debate; pack đó cũng là bằng chứng chi phí bảo trì — docs hứa
Cynefin/OODA/Blue Ocean/25 patterns nhưng file không tồn tại).

### Workspace

`_problem/<slug>/` — vấn đề thường kéo dài qua phiên (phải đi verify nguyên
nhân, chạy pilot):

- `statement.md` — problem statement + Is/Is-Not
- `diagnosis.md` — cause tree với nhãn verified/assumed + verification tests
- `assumptions.md` — log như trên
- `solutions.md`, `decision.md`, `plan.md`
- Re-entry nhẹ: quay lại phiên sau → đọc trạng thái, nói "lần trước dừng ở
  đây, đang chờ kết quả verify X".

## Convention họ skill (áp dụng cho cả hai + dần dần cho skill cũ)

Mỗi SKILL.md có mục **"Related skills in this family"**:

1. Đến handoff moment → kiểm tra skill đích có trong danh sách available không.
2. **Có** → gợi ý user chuyển / invoke trực tiếp khi phù hợp.
3. **Không** → nói rõ: "Trong cùng bộ có skill X chuyên việc này — cài từ
   github.com/tronghieu/agent-skills" → rồi fallback bản nhẹ inline. Fallback
   là bắt buộc: không bao giờ chặn công việc vì user chưa cài skill.

## Lộ trình

1. ✅ Chốt thiết kế (tài liệu này)
2. ⏳ Build `brainstorm-coach` trước (nhẹ hơn, là dependency của bước Solve
   trong problem-solver)
3. Build `problem-solver`
4. Eval từng skill theo quy trình skill-creator (clean-room, re-run baseline
   cho delta sạch — bài học từ critical-thinking)
5. Description optimization cả hai + rà lại description design-thinking để
   phân xử vụ "churn"
