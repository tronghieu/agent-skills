# Agent Skills

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Bộ sưu tập skills dành cho các AI coding agent. Tương thích với [Claude Code](https://code.claude.com), [Cursor](https://cursor.com), [GitHub Copilot](https://github.com/features/copilot) và [20+ công cụ AI khác](https://agentskills.io) hỗ trợ chuẩn mở [Agent Skills](https://agentskills.io).

## Các Skill Hiện Có

| Skill | Chức năng |
|-------|-----------|
| [cv-scorer](#cv-scorer) | Chấm điểm CV ứng viên trên thang 100 điểm so với Mô tả Công việc |
| [critical-thinking](#critical-thinking) | Soi lập luận của bất kỳ tài liệu nào — memo, đề xuất, bản phân tích — chỉ ra chính xác luận điểm nào không đứng vững, đồng thời giúp người đọc tự sắc bén hơn |
| [data-scientist](#data-scientist) | Đóng vai một nhà khoa học dữ liệu đầu-cuối, nghiêm ngặt — khung câu hỏi, khám phá, kiểm định, xây model, và truyền đạt |
| [deep-reader](#deep-reader) | Đọc sâu sách và bài báo dài bằng phương pháp của Adler, dùng ghi chú neo theo trang làm bộ nhớ ngoài |
| [design-thinking](#design-thinking) | Một người điều phối tư duy thiết kế thân thiện, đồng hành cùng bạn qua vòng lặp Empathize→Define→Ideate→Prototype→Test như một dự án lâu dài — skill thiết kế nghiên cứu, bạn thực hiện, mọi insight đều có bằng chứng đi kèm |
| [diataxis-writer](#diataxis-writer) | Viết, tái cấu trúc, phân loại và review tài liệu bằng khung Diataxis |
| [fiction-studio](#fiction-studio) | Một xưởng viết truyện hư cấu hoàn chỉnh, vận hành bởi đội agent chuyên gia được đặt tên |
| [market-researcher](#market-researcher) | Nghiên cứu thị trường bàn giấy kỷ luật trích dẫn — quét nhanh go/no-go và đào sâu quy mô thị trường, đối thủ, nhu cầu, xu hướng |
| [product-manager](#product-manager) | Một PM copilot kỷ luật, vận hành trọn vòng lặp sản phẩm — ưu tiên hóa, PRD, OKR, thí nghiệm, ra mắt, xử lý feedback — trong một workspace bền vững theo từng sản phẩm, nơi mọi con số đều khai rõ nguồn gốc |
| [slidewright](#slidewright) | Dựng website thuyết trình tương tác — slide deck để chiếu lên màn lớn |
| [socratic-questor](#socratic-questor) | Người bạn đặt câu hỏi Socrates (Gadfly) để học sâu thông qua đối thoại |
| [strategy-board](#strategy-board) | Một hội đồng cố vấn chiến lược cấp C do các agent chuyên gia được đặt tên vận hành — từ câu hỏi thô đến khuyến nghị đã được bảo vệ |
| [system-prompt-creator](#system-prompt-creator) | Tạo system prompt chất lượng cao, tối ưu theo từng mô hình cho bất kỳ LLM nào |

### cv-scorer

Chấm điểm CV ứng viên trên thang 100 điểm so với Mô tả Công việc (JD).

**README của skill:** [cv-scorer](./skills/cv-scorer/README.vi.md)

**Chức năng:**
- Chấm điểm CV theo 5 tiêu chí có trọng số: Khớp JD, Kinh nghiệm làm việc, Dự án & Tác động, Học vấn, Chất lượng CV
- Phát hiện cờ đỏ: nội dung lặp lại, số liệu phóng đại, thông tin mâu thuẫn
- Xuất JSON có cấu trúc với điểm từng tiêu chí, điểm nổi bật, cờ đỏ và khuyến nghị (Đề xuất / Có thể / Loại)
- Hỗ trợ xử lý hàng loạt: chấm điểm nhiều CV độc lập rồi xếp hạng

**Câu kích hoạt:** "xem xét CV", "lọc hồ sơ", "chấm điểm ứng viên", "đánh giá candidates", "shortlist ứng viên", "khớp resume với JD"

**Cài đặt:**
```bash
npx skills add tronghieu/agent-skills --skill cv-scorer
```

### critical-thinking

Soi lập luận của bất kỳ tài liệu nào — memo, đề xuất, bản phân tích đầu tư, tài liệu trình hội đồng quản trị, bài viết, hay bản nháp của chính bạn — và nhận lại cái gì đứng vững, cái gì không, và chính xác vấn đề nằm ở câu nào.

**README của skill:** [critical-thinking](./skills/critical-thinking/README.vi.md)

**Chức năng:**
- Bóc tách tài liệu thành khung lập luận của nó — luận điểm, bằng chứng, giả định không nói ra, lỗ hổng logic — với mọi phát hiện đều trỏ về đúng một câu trích dẫn, không bao giờ là một lời buộc tội mơ hồ
- Chạy vòng lặp huấn luyện commit-first: hỏi ý kiến của người dùng trước khi để lộ bản soi của chính nó, rồi cho thấy họ tự bắt được gì và bỏ sót gì, để mỗi lượt soi cũng là một bài luyện tập cho khả năng phán đoán của người dùng
- Thừa nhận cái nó không đánh giá được thay vì bịa, và tách bạch "lập luận này sai" khỏi "tôi cá nhân không đồng ý" — cả hai đều được gắn nhãn trung thực, không bao giờ nhập nhằng
- Bốn chế độ: soi nhanh (vài phút, vấn đề lớn nhất), soi sâu (quyết định trọng yếu), soi bản nháp (củng cố bài viết của người dùng trước một độc giả khó tính, kiểm tra tiêu chí đi tiếp/dừng lại còn thiếu), và xem lại tiến bộ tư duy (theo dõi điểm mù lặp lại và độ chuẩn xác của sự tự tin theo thời gian trong một hồ sơ tư duy bền vững)
- Hoạt động ở bất kỳ ngôn ngữ nào; trong kiểm tra mù trên bốn kịch bản thực tế, đạt 25/26 tiêu chí chất lượng, so với 12/26 của cùng một AI không dùng skill

**Câu kích hoạt:** "audit this argument", "poke holes in this proposal", "review the logic of my draft", "phản biện giúp tôi", "soi lập luận này", "tài liệu này có lỗ hổng gì", "đánh giá đề xuất này giúp tôi"

**Cài đặt:**
```bash
npx skills add tronghieu/agent-skills --skill critical-thinking
```

### data-scientist

Đóng vai một nhà khoa học dữ liệu đầu-cuối, nghiêm ngặt: khung một câu hỏi kinh doanh thành bài toán dữ liệu, khám phá và kiểm tra bộ dữ liệu, chạy phân tích thống kê có thể bảo vệ được, xây dựng và kiểm định model dự đoán, và biến kết quả thành báo cáo sẵn sàng cho quyết định.

**README của skill:** [data-scientist](./skills/data-scientist/README.vi.md)

**Chức năng:**
- Điều phối mọi câu hỏi dữ liệu qua thang 4 cấp phân tích (mô tả/chẩn đoán/dự đoán/khuyến nghị) vào 6 flow: Full engagement, Explore, Inquire, Predict, Review, Communicate
- Thực thi 5 nguyên tắc bất di bất dịch: nhìn dữ liệu trước, mọi con số từ code đã chạy, baseline trước khi phức tạp, mọi ước lượng đi kèm độ bất định, checklist rò rỉ trước khi tin bất kỳ chỉ số model nào
- Hai script đi kèm: `profile_data.py` (profiling bộ dữ liệu kèm cảnh báo chất lượng) và `baseline_model.py` (baseline dummy + tuyến tính an toàn rò rỉ với cross-validation)
- **Flow Review** đóng vai chuyên gia thẩm định cho một phân tích, notebook, hoặc model đã có sẵn — một vòng đối kháng trước khi bất kỳ kết luận nào được công bố
- Khuyến nghị luôn đi kèm đánh đổi được lượng hóa; quyết định luôn được trao lại cho chủ sở hữu — không giải các bài toán tối ưu hóa đầy đủ, không thuộc phạm vi Data Engineering/MLOps

**Câu kích hoạt:** "phân tích bộ dữ liệu này", "điều gì gây ra thay đổi này?", "sự khác biệt này có ý nghĩa thống kê không?", "kiểm định A/B", "xây model dự đoán...", "review phân tích/notebook này", "phân tích dữ liệu", "xây model dự đoán", "kiểm định A/B"

**Cài đặt:**
```bash
npx skills add tronghieu/agent-skills --skill data-scientist
```

### deep-reader

Đọc sâu sách và bài báo dài bằng phương pháp inspectional/analytical/syntopical của Adler, bước Recite của SQ3R, và phương pháp ba lượt đọc (three-pass) của Keshav cho bài báo, với ghi chú neo theo số trang làm bộ nhớ ngoài.

**README của skill:** [deep-reader](./skills/deep-reader/README.vi.md)

**Chức năng:**
- Đọc theo từng lượt — trước tiên nắm cấu trúc, sau đó đọc từng chương — thay vì nạp cả cuốn sách vào một context window
- Hai chế độ: **overview** (lượt đọc kiểm tra + tóm tắt bám sát mục đích đọc) và **study** (pipeline đầy đủ: ghi chú phân tích theo từng chương kèm xác minh Recite, rồi tổng hợp phân cấp)
- Ghi mọi thứ ra ngoài vào một workspace ghi chú neo theo số trang, để phiên sau có thể trả lời câu hỏi tiếp theo bằng cách tìm trong ghi chú thay vì đọc lại cuốn sách
- Xác minh bằng máy mọi trích dẫn so với số trang được ghi, để bắt trích dẫn bịa đặt và trích dẫn sai trang

**Câu kích hoạt:** "đọc cuốn sách này giúp tôi", "nghiên cứu file PDF này", "tóm tắt cuốn giáo trình này", "phân tích bài paper này", "đọc kỹ luận án này", "tóm tắt sách", "phân tích luận án"

**Cài đặt:**
```bash
npx skills add tronghieu/agent-skills --skill deep-reader
```

### design-thinking

Một người điều phối tư duy thiết kế (design-thinking) và bạn đồng hành tư duy thân thiện, cùng bạn đi trọn vòng lặp Empathize→Define→Ideate→Prototype→Test như một dự án nhiều phiên với workspace bền vững; AI thiết kế công cụ nghiên cứu và thí nghiệm, tổng hợp dữ liệu thật mà bạn mang về, và luôn giữ cho mọi insight người dùng có bằng chứng đi kèm.

**README của skill:** [design-thinking](./skills/design-thinking/README.vi.md)

**Chức năng:**
- Mọi insight đều mang thẻ [I#] truy vết về bằng chứng đã đăng ký [S#] (ghi chú phỏng vấn, bản ghi, khảo sát, nguồn desk research) hoặc được gắn nhãn `(hypothesis — needs validation)`, nhờ vậy dữ liệu giả lập không bao giờ lọt vào cơ sở bằng chứng
- AI thiết kế các công cụ (discussion guide, kế hoạch quan sát, test card kèm ngưỡng pass/fail đăng ký trước), người dùng thực hiện các cuộc phỏng vấn và test thật
- Một Verifier chạy tại các cổng pha — rà soát insight sau Define, rà soát giả định trước Test — với phát hiện được chia sẻ công khai
- Ideate phân nhánh song song các ideator subagent với góc nhìn khác nhau, sau đó hội tụ bằng chấm điểm Desirability/Feasibility/Viability cùng người dùng
- Workspace bền vững (phase-state.md, journal.md, sources/insights/personas/hmw/ideas/prototypes/tests) với giao thức quay lại phiên làm việc và các bước loop-back có chủ đích — cộng thêm khả năng kết hợp tùy chọn với skill market-researcher cho các câu hỏi thị trường nặng hơn (chỉ nhắc đến một lần nếu chưa có, hoàn toàn tùy chọn)

**Câu kích hoạt:** "run design thinking", "understand our users", "design user interviews", "synthesize these interview notes", "build personas", "How might we…", "design an experiment to validate…", "tư duy thiết kế", "nghiên cứu người dùng", "デザイン思考 / 设计思维"

**Cài đặt:**
```bash
npx skills add tronghieu/agent-skills --skill design-thinking
```

### diataxis-writer

Viết, tái cấu trúc, phân loại và review tài liệu bằng khung Diataxis.

**README của skill:** [diataxis-writer](./skills/diataxis-writer/README.vi.md)

**Chức năng:**
- Phân loại tài liệu thành tutorial, how-to guide, reference và explanation
- Viết và tái cấu trúc docs, knowledge base, tài liệu onboarding/quy trình, tài liệu product/API
- Review tài liệu theo độ khớp Diataxis, ý định độc giả, luồng tác vụ và phần ngữ cảnh còn thiếu
- Giúp biến tài liệu lẫn lộn hoặc rối thành nội dung học, làm, tra cứu hoặc hiểu rõ ràng hơn

**Câu kích hoạt:** "dùng Diataxis", "phân loại tài liệu này", "tái cấu trúc documentation", "review bộ docs này", "viết how-to guide", "tạo tài liệu API reference", "cải thiện docs onboarding", "sắp xếp knowledge base"

**Cài đặt:**
```bash
npx skills add tronghieu/agent-skills --skill diataxis-writer
```

### fiction-studio

Một xưởng viết truyện hư cấu hoàn chỉnh, vận hành như một đội các agent chuyên gia được đặt tên, dẫn dắt tác giả từ một ý tưởng thô đến bản thảo hoàn thiện.

**README của skill:** [fiction-studio](./skills/fiction-studio/README.vi.md)

**Chức năng:**
- Vận hành đội 10 chuyên gia mang tên các bậc thầy văn chương, do **Homer** điều phối: Aristotle (cốt truyện), Fyodor (nhân vật), Tolkien (thế giới), Scheherazade (viết nháp), Oscar (đối thoại), Max (biên tập), Virginia (đọc thử), Borges (thể loại), Bloom (phê bình)
- Chạy quy trình đầu-cuối — tiền đề → dàn ý → nhân vật → thế giới → danh sách cảnh → nháp → đối thoại → biên tập → đọc thử → phân loại sửa → mài giũa → đóng gói — kèm các cổng chất lượng về thể loại, tính nhất quán, cài cắm–hồi đáp, và độ nhạy cảm
- **Phòng Biên Kịch (party mode):** triệu tập 3-4 chuyên gia liên quan để cùng brainstorm tiền đề hoặc gỡ một ngã ba sáng tạo, rồi ghi lại quyết định ra file
- **QA tính nhất quán:** một trình kiểm tra liên tục không phụ thuộc thư viện (`scripts/continuity_check.py`) cùng nguồn sự thật có cấu trúc `canon.json` giữ cho bản thảo nhiều phiên vẫn mạch lạc
- Thích ứng với tiểu thuyết, truyện vừa, truyện ngắn hay series; có biến thể dàn ý Snowflake và tự khớp ngôn ngữ của tác giả

**Câu kích hoạt:** "giúp tôi viết tiểu thuyết", "tôi có ý tưởng cho một câu chuyện", "phát triển nhân vật", "xây dựng thế giới fantasy", "lập dàn ý cốt truyện", "sửa cảnh này", "đối thoại của tôi nhạt quá", "cho tôi nhận xét kiểu beta-reader"

**Cài đặt:**
```bash
npx skills add tronghieu/agent-skills --skill fiction-studio
```

### market-researcher

Nghiên cứu thị trường bàn giấy (desk research) kỷ luật trích dẫn: quét nhanh go/no-go cho thị trường và các lượt đào sâu theo module — định lượng quy mô thị trường (TAM/SAM/SOM), phân tích đối thủ, tín hiệu nhu cầu, và xu hướng/vĩ mô (PESTEL) — cho bất kỳ thị trường nào, bằng bất kỳ ngôn ngữ nào.

**README của skill:** [market-researcher](./skills/market-researcher/README.vi.md)

**Chức năng:**
- Mọi luận điểm đều truy vết về một nguồn đăng ký `[S#]` (URL, đơn vị xuất bản, ngày tháng, mức độ tin cậy) hoặc được gắn nhãn là giả định — không có câu kiểu "thị trường đang tăng trưởng nhanh" mà không có trích dẫn
- Hai chế độ: **Quick Scan** (mặc định, brief go/no-go trong một phiên) và **Deep Dive** (tùy chọn, các lane theo module — định lượng quy mô / đối thủ / nhu cầu / vĩ mô — nhiều phiên, có thể tiếp tục)
- Vòng xác minh đối kháng tích hợp sẵn: kiểm tra lại luận điểm so với nguồn và tính lại toàn bộ phép tính ước lượng trước khi giao kết quả
- **Composition contract** cho phép các skill khác (ví dụ strategy-board) gọi skill này để thêm dữ kiện có trích dẫn thẳng vào workspace của chính chúng
- Ranh giới trung thực: nghiên cứu bàn giấy tạo ra tín hiệu nhu cầu và persona giả định để nghiên cứu sơ cấp kiểm chứng — không bao giờ bịa "insight"

**Câu kích hoạt:** "nghiên cứu thị trường cho...", "thị trường này lớn cỡ nào...", "đối thủ cạnh tranh của... là ai", "có nên xây/ra mắt/bán...", "thẩm định ý tưởng kinh doanh này", "nghiên cứu thị trường", "market research for...", "how big is the market for..."

**Cài đặt:**
```bash
npx skills add tronghieu/agent-skills --skill market-researcher
```

### product-manager

Một PM copilot kỷ luật cho một sản phẩm đang sống, không phải công cụ sinh tài liệu dùng một lần: skill ghi nhận cơ hội dưới dạng job story, ưu tiên hóa bằng RICE kèm sensitivity analysis, viết PRD với story map và user story có thể kiểm chứng, lên kế hoạch OKR, thí nghiệm và ra mắt kèm tiêu chí rollback, và xử lý (triage) feedback — đồng thời từ chối bịa số liệu.

**README của skill:** [product-manager](./skills/product-manager/README.vi.md)

**Chức năng:**
- Vận hành trọn vòng lặp sản phẩm đầu-cuối — cơ hội → ưu tiên hóa RICE → PRD → story map → OKR → thí nghiệm → kế hoạch ra mắt → xử lý feedback — tất cả trong một workspace bền vững theo từng sản phẩm
- Ghi nhận cơ hội dưới dạng job story và ưu tiên hóa bằng điểm RICE kèm sensitivity analysis trên các input, để thứ hạng không phụ thuộc vào một con số đoán mò duy nhất
- Viết PRD với story map và user story có thể kiểm chứng (Given/When/Then); lên kế hoạch OKR, thiết kế thí nghiệm kèm tiêu chí pass/fail, và soạn kế hoạch ra mắt kèm tiêu chí rollback
- Từ chối bịa số liệu: mọi con số đều truy vết về một nguồn trích dẫn, một giả định được gắn nhãn kèm khoảng giá trị, hoặc ước lượng tự thân có ghi ngày
- Một vòng audit đối kháng rà soát từng PRD, bảng ưu tiên hóa, hoặc kế hoạch ra mắt trước khi bạn được yêu cầu hành động theo đó
- Hoạt động bằng bất kỳ ngôn ngữ nào; kết hợp tự nhiên với design-thinking (khám phá người dùng), market-researcher (dữ kiện thị trường), và strategy-board (các đặt cược cấp công ty)

**Câu kích hoạt:** "ưu tiên hóa roadmap", "viết PRD cho...", "chấm điểm RICE cho các tính năng này", "lên kế hoạch OKR cho quý này", "thiết kế thí nghiệm cho...", "lên kế hoạch ra mắt", "xử lý feedback này"

**Cài đặt:**
```bash
npx skills add tronghieu/agent-skills --skill product-manager
```

### slidewright

Dựng website thuyết trình tương tác — slide deck để chiếu lên màn lớn, do một người trình bày điều khiển.

**README của skill:** [slidewright](./skills/slidewright/README.vi.md)

**Skill này làm gì:**
- Hai hướng: **một file HTML không cần build** (mở là chạy, không cài đặt) hoặc một dự án **Vite + React + TypeScript** — tự chọn hướng phù hợp
- Scaffold bằng một lệnh; bản React chạy tool Vite chính thức và cài **bản mới nhất** của React, Tailwind, Framer Motion, Lucide (không pin version, để mỗi deck luôn khởi đầu trên công cụ hiện hành)
- Ép kỷ luật trình chiếu: sàn cỡ chữ để đọc được từ cuối phòng, bắt buộc có thanh điều hướng + số slide, và tương tác chỉ dành cho người trình bày (không form, không thu thập dữ liệu)
- Kèm các mẫu layout (title, bullet, so sánh 2 cột, số liệu lớn, trích dẫn, ảnh full-bleed), quy ước speaker notes, và hướng dẫn xuất PDF

**Câu kích hoạt:** "dựng bài thuyết trình", "làm slide deck", "website trình chiếu tương tác", "dựng deck / làm slide / bài thuyết trình", "thêm slide vào deck", "xuất slide ra PDF"

**Cài đặt:**
```bash
npx skills add tronghieu/agent-skills --skill slidewright
```

### socratic-questor

Người bạn đặt câu hỏi Socrates (Gadfly) để học sâu thông qua đối thoại.

**README của skill:** [socratic-questor](./skills/socratic-questor/README.vi.md)

**Chức năng:**
- Dạy bất kỳ chủ đề nào bằng cách đặt câu hỏi, không bao giờ giải thích trực tiếp — người học tự khám phá sự hiểu biết qua đối thoại
- Tuân theo khung câu hỏi Socrates 6 loại của Paul & Elder: Làm rõ, Giả định, Bằng chứng, Quan điểm, Hàm ý, Siêu câu hỏi
- Điều chỉnh độ khó dựa trên trình độ người học (mới bắt đầu, trung cấp, nâng cao) được phát hiện qua chất lượng phản hồi
- Hỗ trợ khi người học bị mắc kẹt — câu hỏi phụ đơn giản hơn và ví dụ cụ thể, không bao giờ đưa ra đáp án trực tiếp
- Tự động khớp ngôn ngữ của người học

**Câu kích hoạt:** "dạy tôi về...", "giúp tôi hiểu...", "đặt câu hỏi về...", "kiểm tra tôi", "phương pháp Socrates", "Gadfly"

**Cài đặt:**
```bash
npx skills add tronghieu/agent-skills --skill socratic-questor
```

### strategy-board

Một hội đồng cố vấn chiến lược cấp C, vận hành như một đội các agent chuyên gia được đặt tên, đưa nhà điều hành từ một câu hỏi chiến lược thô sơ đến một khuyến nghị đã được bảo vệ, sẵn sàng trình hội đồng quản trị.

**README của skill:** [strategy-board](./skills/strategy-board/README.vi.md)

**Chức năng:**
- Vận hành đội 8 chuyên gia được đặt tên, do **Drucker** dẫn dắt (đối tác điều hành): Porter (thị trường & cạnh tranh), Christensen (đổi mới & phá vỡ thị trường), Graham (tài chính & giá trị), Grove (thực thi & tổ chức), Wack (kịch bản & bất định), Taleb (rủi ro & đội phản biện), Minto (tổng hợp & trình bày)
- Chạy quy trình tư vấn có "cổng chắn" — brief → fact base → phân tích → phương án → phản biện → khuyến nghị → lộ trình — với các cổng yêu cầu nhà điều hành xác nhận câu hỏi, hướng đi, và khuyến nghị cuối cùng
- **Boardroom (chế độ họp toàn thể):** triệu tập 3-4 thành viên liên quan để tranh luận một câu hỏi sắc bén, mỗi người nêu quan điểm độc lập trước qua các subagent chạy song song (để tránh tư duy bầy đàn), sau đó mới đối thoại chéo, có biên bản lưu lại
- Nguyên tắc bất di bất dịch: không bịa số liệu (mọi con số đều có nguồn từ fact base hoặc được gắn nhãn giả định), ba phương án thật sự trước khi đưa khuyến nghị, bắt buộc chạy pre-mortem trước khi trình bày, và "chiến lược là sự đánh đổi" — mọi khuyến nghị đều nêu rõ điều cần ngừng làm

**Câu kích hoạt:** "nên đầu tư / xây dựng / mua / thâm nhập…", "xây dựng chiến lược", "đánh giá cơ hội này", "stress-test kế hoạch này", "chạy pre-mortem", "triệu tập hội đồng"

**Cài đặt:**
```bash
npx skills add tronghieu/agent-skills --skill strategy-board
```

### system-prompt-creator

Tạo system prompt chất lượng cao, tối ưu theo từng mô hình cho bất kỳ LLM nào (Claude, GPT, Gemini, open-source).

**README của skill:** [system-prompt-creator](./skills/system-prompt-creator/README.vi.md)

**Chức năng:**
- Dẫn dắt qua quy trình 5 bước có cấu trúc: Phỏng vấn, Phân tích, Cấu trúc, Soạn thảo, Đánh giá
- Áp dụng 12 nguyên tắc phổ quát rút ra từ hướng dẫn prompting chính thức của Anthropic, OpenAI và Google
- Tạo tối ưu hóa riêng cho từng mô hình (XML tags cho Claude, tham số verbosity cho GPT-5, cài đặt temperature cho Gemini)
- Bao gồm các mẫu theo lĩnh vực: playbook vận hành, bảo toàn dữ liệu thô, chấm điểm độ tin cậy
- Cung cấp 7 template sẵn sàng tùy chỉnh cho các trường hợp phổ biến

**Câu kích hoạt:** "tạo system prompt", "viết system instructions", "prompt engineering", "xây dựng chatbot prompt", "thiết kế agent prompt"

**Cài đặt:**
```bash
npx skills add tronghieu/agent-skills --skill system-prompt-creator
```

## Cài Đặt

### 1. Dùng CLI (Khuyến nghị)

```bash
npx skills add tronghieu/agent-skills
```

### 2. Cài Đặt Thủ Công (Cho người dùng cơ bản)

Bạn có thể tải các file `.zip` đã đóng gói sẵn cho từng skill và giải nén vào thư mục mong muốn.

1. **Tải về:** Truy cập thư mục `skills/` trong kho lưu trữ này và tải file `.zip` của skill bạn muốn.
2. **Giải nén & Copy:** Giải nén file `.zip` và copy thư mục skill vào một trong các vị trí sau:

**Cho một dự án cụ thể:**
Copy thư mục vào `.agents/skills/` hoặc `.claude/skills/` trong thư mục gốc dự án của bạn.

**Cài đặt toàn cục (Dùng cho mọi dự án):**
* **Mac / Linux:** `~/.agents/skills/` hoặc `~/.claude/skills/`
* **Windows:** `%USERPROFILE%\.agents\skills\` hoặc `%USERPROFILE%\.claude\skills\` (thường là `C:\Users\<Tên_Của_Bạn>`)

## Đóng Góp

Chúng tôi hoan nghênh đóng góp từ cộng đồng! Dự án này tuân theo chuẩn mở [Agent Skills](https://agentskills.io) và tương thích với 30+ công cụ AI coding.

### Cách đóng góp

1. **Fork** repository này
2. **Tạo một skill** theo cấu trúc bên dưới
3. **Kiểm thử** skill với ít nhất 2-3 prompt thực tế
4. **Gửi PR** với mô tả rõ ràng về chức năng và thời điểm kích hoạt của skill

### Tạo skill mới

```bash
# Tạo khung cho skill mới
mkdir -p skills/ten-skill-cua-ban/references

# Tạo SKILL.md bắt buộc
cat > skills/ten-skill-cua-ban/SKILL.md << 'EOF'
---
name: ten-skill-cua-ban
description: Chức năng + khi nào kích hoạt + từ khóa liên quan
---

# Tên Skill Của Bạn

Hướng dẫn cho agent khi skill này được kích hoạt.
EOF
```

Xem [AGENTS.md](./AGENTS.md) để có hướng dẫn tạo skill đầy đủ, bao gồm cấu trúc thư mục, quy ước đặt tên, định dạng SKILL.md và hướng dẫn đóng gói.

### Checklist chất lượng skill

Trước khi gửi PR, hãy đảm bảo skill của bạn:

- [ ] Có `SKILL.md` với `name` và `description` trong frontmatter
- [ ] Mô tả rõ ràng về **khi nào** kích hoạt (không chỉ mô tả chức năng)
- [ ] Hướng dẫn rõ ràng, có thể thực hiện được và giải thích *lý do* đằng sau các quy tắc
- [ ] Có ví dụ ở những nơi định dạng/độ chính xác quan trọng
- [ ] Giữ `SKILL.md` dưới 500 dòng (dùng `references/` cho tài liệu chi tiết)
- [ ] Không chứa bí mật, thông tin xác thực hoặc dữ liệu nhạy cảm
- [ ] Đã được kiểm thử với các prompt thực tế

### Ý tưởng đóng góp

- Template skill mới cho các lĩnh vực cụ thể (DevOps, data science, mobile, v.v.)
- Dịch các skill hiện có sang ngôn ngữ khác
- Cải tiến các skill hiện có dựa trên trải nghiệm thực tế
- Sửa lỗi và cập nhật tài liệu

## Chuẩn Mở

Dự án này được xây dựng trên [chuẩn mở Agent Skills](https://agentskills.io), ban đầu phát triển bởi Anthropic và hiện đã được 30+ nền tảng AI áp dụng bao gồm Claude Code, Cursor, GitHub Copilot, Codex, Gemini CLI và nhiều hơn nữa.

Các skill bạn tạo ra ở đây hoạt động ở mọi nơi hỗ trợ chuẩn này. Không bị khóa nhà cung cấp.

| Nền tảng | Hỗ trợ |
|----------|---------|
| Claude Code | Native |
| Cursor | Native |
| GitHub Copilot | Native |
| Codex (OpenAI) | Native |
| Gemini CLI | Native |
| Windsurf, Cline, Roo Code, ... | Native |

Danh sách đầy đủ tại [agentskills.io](https://agentskills.io).

## Tài Liệu Tham Khảo

| Tài nguyên | URL |
|----------|-----|
| Chuẩn Agent Skills | https://agentskills.io |
| Tài liệu Claude Code Skills | https://code.claude.com/docs/en/skills |
| Anthropic Skills (chính thức) | https://github.com/anthropics/skills |
| Skills CLI (Vercel) | https://github.com/vercel-labs/skills |
| Skills Marketplace | https://skills.sh |

## Giấy Phép

MIT — tự do sử dụng, chỉnh sửa và phân phối.
