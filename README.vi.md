# Agent Skills

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Bộ sưu tập các skill có phương pháp dành cho người dùng AI để ra quyết định, vận hành dự án, phân tích bằng chứng, tạo tài liệu và hoàn thành công việc thực tế. Các skill này phù hợp với người dùng chủ động: bạn cung cấp bối cảnh thật và chịu trách nhiệm về quyết định; agent hỗ trợ cấu trúc, phân tích và kiểm tra chất lượng.

## Bắt đầu nhanh

Cài toàn bộ bộ sưu tập:

```bash
npx skills add tronghieu/agent-skills
```

Sau đó gọi skill trong agent:

```text
/market-researcher Đánh giá thị trường cho ý tưởng sản phẩm này tại Việt Nam.
```

Đa số công cụ agent dùng slash command. Codex và ChatGPT dùng `$`; với hai công cụ này, hãy thay ký tự đầu `/` bằng `$`.

## Chọn skill

| Công việc của bạn | Nên bắt đầu với |
|---|---|
| Phát triển hoặc phản biện ý tưởng | [brainstorm-coach](./skills/brainstorm-coach/README.vi.md), [critical-thinking](./skills/critical-thinking/README.vi.md) |
| Chẩn đoán một vấn đề lặp lại | [problem-solver](./skills/problem-solver/README.vi.md) |
| Hiểu khách hàng hoặc thị trường | [design-thinking](./skills/design-thinking/README.vi.md), [market-researcher](./skills/market-researcher/README.vi.md) |
| Quyết định nên xây gì và bàn giao đúng kế hoạch | [product-manager](./skills/product-manager/README.vi.md), [project-manager](./skills/project-manager/README.vi.md) |
| Phân tích dữ liệu hoặc tài liệu dài | [data-scientist](./skills/data-scientist/README.vi.md), [deep-reader](./skills/deep-reader/README.vi.md) |
| Ra quyết định kinh doanh có hệ quả lớn | [strategy-board](./skills/strategy-board/README.vi.md) |
| Tạo tài liệu, prompt, slide hoặc truyện | [diataxis-writer](./skills/diataxis-writer/README.vi.md), [system-prompt-creator](./skills/system-prompt-creator/README.vi.md), [slidewright](./skills/slidewright/README.vi.md), [fiction-studio](./skills/fiction-studio/README.vi.md) |
| Học qua câu hỏi gợi mở | [socratic-questor](./skills/socratic-questor/README.vi.md) |
| So sánh CV với mô tả công việc | [cv-scorer](./skills/cv-scorer/README.vi.md) |
| Hiểu một run coding tự động đã làm gì, hoặc vì sao nó bị kẹt | [bmad-run-inspector](./skills/bmad-run-inspector/README.vi.md) |

## Các skill

### bmad-run-inspector

Dành cho bất kỳ ai đang chạy `bmad-loop` — một orchestrator coding tự động — và cần một cách đọc trung thực về một run: theo dõi run đang chạy, hoặc điều tra run đã hoàn tất, thất bại, hay bị tạm dừng qua đêm. Chỉ hữu ích trong dự án đã dùng `bmad-loop`.

```bash
npx skills add tronghieu/agent-skills --skill bmad-run-inspector
```

[Đọc hướng dẫn bmad-run-inspector](./skills/bmad-run-inspector/README.vi.md)

### brainstorm-coach

Dành cho founder, đội sản phẩm, marketer, creator và bất kỳ ai cần tạo ra nhiều phương án trước khi đánh giá.

```bash
npx skills add tronghieu/agent-skills --skill brainstorm-coach
```

[Đọc hướng dẫn brainstorm-coach](./skills/brainstorm-coach/README.vi.md)

### critical-thinking

Dành cho người ra quyết định, analyst và người viết cần kiểm tra luận điểm, bằng chứng, giả định và lỗ hổng logic trong một tài liệu.

```bash
npx skills add tronghieu/agent-skills --skill critical-thinking
```

[Đọc hướng dẫn critical-thinking](./skills/critical-thinking/README.vi.md)

### cv-scorer

Dành cho recruiter và hiring manager muốn so sánh CV với mô tả công việc bằng một rubric nhất quán. Skill hỗ trợ human review, không tự đưa ra quyết định tuyển dụng.

```bash
npx skills add tronghieu/agent-skills --skill cv-scorer
```

[Đọc hướng dẫn cv-scorer](./skills/cv-scorer/README.vi.md)

### data-scientist

Dành cho người làm dữ liệu và người ra quyết định cần khám phá dữ liệu, phân tích thống kê, xây baseline dự đoán hoặc review một phân tích đã có.

```bash
npx skills add tronghieu/agent-skills --skill data-scientist
```

[Đọc hướng dẫn data-scientist](./skills/data-scientist/README.vi.md)

### deep-reader

Dành cho researcher, sinh viên, analyst và người đọc chuyên sâu đang làm việc với sách, luận văn, paper hoặc tài liệu dài khoảng 50 trang trở lên.

```bash
npx skills add tronghieu/agent-skills --skill deep-reader
```

[Đọc hướng dẫn deep-reader](./skills/deep-reader/README.vi.md)

### design-thinking

Dành cho đội product, design và innovation có khả năng thu thập bằng chứng người dùng thật, từ đó phát triển và kiểm chứng giải pháp.

```bash
npx skills add tronghieu/agent-skills --skill design-thinking
```

[Đọc hướng dẫn design-thinking](./skills/design-thinking/README.vi.md)

### diataxis-writer

Dành cho technical writer, người sở hữu tài liệu, developer advocate và các đội đang cải thiện tutorial, how-to guide, reference, explanation hoặc knowledge base.

```bash
npx skills add tronghieu/agent-skills --skill diataxis-writer
```

[Đọc hướng dẫn diataxis-writer](./skills/diataxis-writer/README.vi.md)

### fiction-studio

Dành cho tác giả viết truyện văn xuôi, từ phát triển tiền đề và dàn ý đến viết nháp, chỉnh sửa và kiểm tra tính nhất quán.

```bash
npx skills add tronghieu/agent-skills --skill fiction-studio
```

[Đọc hướng dẫn fiction-studio](./skills/fiction-studio/README.vi.md)

### market-researcher

Dành cho founder, đội sản phẩm, strategist, consultant và analyst cần nghiên cứu bàn giấy có trích nguồn về quy mô thị trường, đối thủ, tín hiệu nhu cầu hoặc xu hướng.

```bash
npx skills add tronghieu/agent-skills --skill market-researcher
```

[Đọc hướng dẫn market-researcher](./skills/market-researcher/README.vi.md)

### problem-solver

Dành cho operator, technical lead và business owner cần kiểm chứng nguyên nhân gốc trước khi chọn giải pháp.

```bash
npx skills add tronghieu/agent-skills --skill problem-solver
```

[Đọc hướng dẫn problem-solver](./skills/problem-solver/README.vi.md)

### product-manager

Dành cho product manager, product lead và founder đang quyết định nên xây gì, đo lường ra sao và ra mắt như thế nào.

```bash
npx skills add tronghieu/agent-skills --skill product-manager
```

[Đọc hướng dẫn product-manager](./skills/product-manager/README.vi.md)

### project-manager

Dành cho project manager, PMO, delivery lead và team lead cần lập kế hoạch, theo dõi, giảm rủi ro hoặc cứu một dự án thật.

```bash
npx skills add tronghieu/agent-skills --skill project-manager
```

[Đọc hướng dẫn project-manager](./skills/project-manager/README.vi.md)

### slidewright

Dành cho speaker, giảng viên, consultant và founder cần dựng slide dạng web cho một buổi thuyết trình trực tiếp.

```bash
npx skills add tronghieu/agent-skills --skill slidewright
```

[Đọc hướng dẫn slidewright](./skills/slidewright/README.vi.md)

### socratic-questor

Dành cho người học và người dạy muốn xây dựng hoặc kiểm tra sự hiểu biết thông qua đối thoại Socrates.

```bash
npx skills add tronghieu/agent-skills --skill socratic-questor
```

[Đọc hướng dẫn socratic-questor](./skills/socratic-questor/README.vi.md)

### strategy-board

Dành cho founder, lãnh đạo và người phụ trách chiến lược đang xử lý các lựa chọn quan trọng như vào thị trường, đầu tư, build-versus-buy, định giá hoặc chuyển đổi.

```bash
npx skills add tronghieu/agent-skills --skill strategy-board
```

[Đọc hướng dẫn strategy-board](./skills/strategy-board/README.vi.md)

### system-prompt-creator

Dành cho AI product builder, developer, đội automation và power user cần tạo system prompt hoặc custom instructions rõ ràng, nhất quán và có thể kiểm thử.

```bash
npx skills add tronghieu/agent-skills --skill system-prompt-creator
```

[Đọc hướng dẫn system-prompt-creator](./skills/system-prompt-creator/README.vi.md)

## Cài đặt thủ công

Tải thư mục skill hoặc file `.zip` đã đóng gói, giải nén rồi copy thư mục vào:

- Phạm vi dự án: `.agents/skills/` hoặc `.claude/skills/`
- Phạm vi người dùng trên macOS/Linux: `~/.agents/skills/` hoặc `~/.claude/skills/`
- Phạm vi người dùng trên Windows: `%USERPROFILE%\.agents\skills\` hoặc `%USERPROFILE%\.claude\skills\`

Vị trí chính xác phụ thuộc vào agent bạn đang sử dụng.

## Đóng góp

Chúng tôi hoan nghênh đóng góp. Để đề xuất thay đổi:

1. Fork repository và tạo một branch có phạm vi rõ ràng.
2. Đặt mỗi skill trong `skills/<tên-skill>/`, gồm `SKILL.md`, script hoặc reference cần thiết và các README dành cho người dùng.
3. Kiểm thử skill bằng các prompt đại diện, bao gồm ít nhất một tình huống khó hoặc failure case.
4. Đóng gói lại `skills/<tên-skill>.zip`.
5. Gửi pull request, trong đó giải thích skill dành cho ai, khi nào nên kích hoạt, bạn đã kiểm thử gì và còn giới hạn nào.

Với skill mới có phạm vi lớn, bạn nên mở issue trước để thống nhất phạm vi và tránh trùng lặp công việc.

Repo tuân theo [chuẩn Agent Skills mở](https://agentskills.io). Khả năng tương thích phụ thuộc vào cách từng công cụ triển khai chuẩn này.

## Giấy phép

MIT
