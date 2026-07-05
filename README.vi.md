# Agent Skills

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Bộ sưu tập skills dành cho các AI coding agent. Tương thích với [Claude Code](https://code.claude.com), [Cursor](https://cursor.com), [GitHub Copilot](https://github.com/features/copilot) và [20+ công cụ AI khác](https://agentskills.io) hỗ trợ chuẩn mở [Agent Skills](https://agentskills.io).

## Các Skill Hiện Có

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

## Cài Đặt

```bash
# Dùng skills CLI (khuyến nghị)
npx skills add tronghieu/agent-skills

# Hoặc cài thủ công cho Claude Code
cp -r skills/cv-scorer ~/.claude/skills/
cp -r skills/system-prompt-creator ~/.claude/skills/
cp -r skills/socratic-questor ~/.claude/skills/
cp -r skills/fiction-studio ~/.claude/skills/
cp -r skills/slidewright ~/.claude/skills/
cp -r skills/diataxis-writer ~/.claude/skills/
```

## Cấu Trúc Skill

```
skills/
  cv-scorer/
    SKILL.md                    # Skill chính (quy trình + rubric chấm điểm)
    references/
      scoring-rubric.md         # Rubric 5 tiêu chí chi tiết kèm hướng dẫn chấm
      output-format.md          # Template JSON đầu ra (CV đơn + hàng loạt)
  system-prompt-creator/
    SKILL.md                    # Skill chính (quy trình + 12 nguyên tắc)
    references/
      principles.md             # Nguyên tắc chi tiết kèm ví dụ
      model-specific.md         # Mẹo cho Claude / GPT-5 / Gemini
      templates.md              # 7 template (chatbot, agent, extractor, v.v.)
  socratic-questor/
    SKILL.md                    # Skill chính (nhân vật Gadfly + quy trình)
    references/
      questioning-framework.md  # Khung 6 loại câu hỏi của Paul & Elder + chiến lược thích ứng
  fiction-studio/
    SKILL.md                    # Skill chính (đội 10 agent + quy trình + Phòng Biên Kịch)
    references/                 # agents/, workflow, craft, genres, qa, party-mode
    templates/                  # premise, outline, character, world-bible, canon.json, ...
    checklists/                 # plot-structure, continuity, foreshadowing, sensitivity, ...
    scripts/
      continuity_check.py       # Trình kiểm tra nhất quán không phụ thuộc thư viện
  slidewright/
    SKILL.md                    # Skill chính (tư duy trình chiếu + quy trình + chọn track)
    references/
      design-system.md          # Sàn cỡ chữ, mẫu layout, chuyển động, bảng màu
      html-track.md             # Deck một file HTML không cần build
      react-track.md            # Kiến trúc Vite + React (Deck/Slide/slides)
      export-pdf.md             # Xuất PDF + quy ước speaker notes
    scripts/
      new-html-deck.sh          # Scaffold deck HTML không cần build
      new-react-deck.sh         # Scaffold deck Vite + React (deps mới nhất, không pin)
      export-deck-pdf.py        # Xuất PDF đủ nội dung (đợi render, bung nội dung ẩn)
  diataxis-writer/
    SKILL.md                    # Skill chính (viết, phân loại, tái cấu trúc, review theo Diataxis)
    README.md                   # README skill tiếng Anh
    README.vi.md                # README skill tiếng Việt
    README.zh.md                # README skill tiếng Trung
    references/
      diataxis-patterns.md      # Mẫu Diataxis, chẩn đoán và ví dụ
    scripts/
      classify-doc.sh           # Phân loại tài liệu theo kiểu Diataxis
    evals/
      evals.json                # Bộ ca đánh giá
```

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
