# Agent Skills

**Ngôn ngữ / Language / 语言:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

AI có thể hỗ trợ nhiều việc, nhưng lời khuyên chung chung thường thiếu nhất quán hoặc bỏ sót các bước kiểm tra quan trọng. Các skill này cho AI một cách làm việc rõ ràng, thực tế, để bạn nhận được câu trả lời đáng tin hơn, quyết định tốt hơn và kết quả có thể dùng ngay.

Bộ sưu tập này hỗ trợ những công việc thường gặp như chọn ứng viên, hiểu dữ liệu và khách hàng, lên kế hoạch sản phẩm và dự án, chuẩn bị bài thuyết trình, học tập, viết lách và ra quyết định kinh doanh quan trọng.

## Cách Dùng Skill

Hãy chọn skill trước, rồi mô tả điều bạn cần bằng ngôn ngữ bình thường.

- **Codex và ChatGPT:** Gõ `$`, rồi chọn một skill — ví dụ: `$market-researcher Hãy đánh giá ý tưởng kinh doanh này.`
- **Claude, Antigravity và Gemini:** Gõ `/`, chọn một skill rồi mô tả nhu cầu của bạn.

Bạn không cần học thêm câu lệnh đặc biệt nào. Hãy chia sẻ mục tiêu cùng các thông tin, tệp hoặc câu hỏi liên quan như bình thường.

## Các Skill Hiện Có

| Skill | Giúp bạn làm gì |
|---|---|
| [cv-scorer](./skills/cv-scorer/README.vi.md) | So sánh ứng viên công bằng với yêu cầu công việc, chỉ ra người phù hợp nhất và những điểm cần xem xét kỹ hơn. |
| [critical-thinking](./skills/critical-thinking/README.vi.md) | Kiểm tra một đề xuất, báo cáo hoặc lập luận có dựa trên bằng chứng vững chắc hay không; phát hiện giả định yếu trước khi chúng dẫn đến quyết định tốn kém. |
| [data-scientist](./skills/data-scientist/README.vi.md) | Biến dữ liệu thành câu trả lời đáng tin: giải thích điều gì đã thay đổi, kiểm tra kết quả có ý nghĩa không và nêu rõ đánh đổi của từng khuyến nghị. |
| [deep-reader](./skills/deep-reader/README.vi.md) | Đọc kỹ sách và tài liệu dài, tạo ghi chú rõ ràng cùng bản tóm tắt đáng tin để dùng cho các câu hỏi về sau. |
| [design-thinking](./skills/design-thinking/README.vi.md) | Hiểu nhu cầu thực của người dùng, biến nghiên cứu thành insight hữu ích và thử nghiệm giải pháp trước khi đầu tư nhiều nguồn lực. |
| [diataxis-writer](./skills/diataxis-writer/README.vi.md) | Làm tài liệu hướng dẫn, kho kiến thức và bài giải thích dễ theo dõi hơn, để người đọc nhận đúng thông tin vào đúng lúc. |
| [fiction-studio](./skills/fiction-studio/README.vi.md) | Phát triển câu chuyện từ ý tưởng ban đầu đến bản thảo hoàn chỉnh, với hỗ trợ riêng cho cốt truyện, nhân vật, bối cảnh, hội thoại và biên tập. |
| [market-researcher](./skills/market-researcher/README.vi.md) | Đánh giá cơ hội bằng thông tin có nguồn: quy mô thị trường, đối thủ, tín hiệu nhu cầu và xu hướng, để nhìn nhận ý tưởng kinh doanh tự tin hơn. |
| [product-manager](./skills/product-manager/README.vi.md) | Quyết định nên làm gì tiếp theo, biến ý tưởng thành kế hoạch rõ ràng, học từ phản hồi khách hàng và chuẩn bị ra mắt với ít bất ngờ hơn. |
| [project-manager](./skills/project-manager/README.vi.md) | Đưa dự án từ kế hoạch đến bàn giao bằng tiến độ thực tế, rủi ro minh bạch, trách nhiệm rõ ràng và báo cáo trung thực. |
| [slidewright](./skills/slidewright/README.vi.md) | Tạo slide thuyết trình hấp dẫn, dễ nhìn từ cuối phòng và giúp người nói truyền đạt thông điệp rõ ràng hơn. |
| [socratic-questor](./skills/socratic-questor/README.vi.md) | Học sâu qua những câu hỏi gợi mở, giúp bạn tự xây dựng sự hiểu biết thay vì chỉ nhận một đáp án có sẵn. |
| [strategy-board](./skills/strategy-board/README.vi.md) | Xem xét một quyết định kinh doanh lớn từ nhiều góc nhìn chuyên môn: cơ hội, cạnh tranh, tài chính, thực thi và rủi ro. |
| [system-prompt-creator](./skills/system-prompt-creator/README.vi.md) | Xác định cách một trợ lý AI cần hoạt động, để nó đưa ra phản hồi nhất quán và hữu ích hơn cho một công việc cụ thể. |

## Cài Đặt

### Cài tất cả skill

```bash
npx skills add tronghieu/agent-skills
```

### Cài một skill thủ công

Tải file `.zip` của skill đó từ thư mục [`skills/`](./skills), giải nén rồi chép thư mục vừa có vào một trong các vị trí sau:

- `.agents/skills/` hoặc `.claude/skills/` trong thư mục dự án; hoặc
- `~/.agents/skills/` hoặc `~/.claude/skills/` để dùng cho mọi dự án.

Trên Windows, dùng `%USERPROFILE%\.agents\skills\` hoặc `%USERPROFILE%\.claude\skills\` cho thư mục cài đặt chung.

## Đóng Góp

Mọi đóng góp đều được chào đón. Để thêm hoặc cải thiện skill, hãy xem [hướng dẫn đóng góp](./AGENTS.md) của repository. Trước khi mở pull request, hãy bảo đảm skill có mục đích rõ ràng, hướng dẫn thực tế, không chứa thông tin nhạy cảm và đã được thử trên công việc thực tế.

## Chuẩn Mở

Dự án tuân theo [chuẩn mở Agent Skills](https://agentskills.io), vì vậy các skill này có thể dùng với những công cụ AI hỗ trợ chuẩn đó.

## Tài Liệu Tham Khảo

- [Chuẩn Agent Skills](https://agentskills.io)
- [Tài liệu Claude Code Skills](https://code.claude.com/docs/en/skills)
- [Anthropic Skills](https://github.com/anthropics/skills)
- [Skills CLI](https://github.com/vercel-labs/skills)
- [Skills Marketplace](https://skills.sh)

## Giấy Phép

MIT — tự do sử dụng, chỉnh sửa và phân phối.
