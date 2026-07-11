# Design Thinking (Tư Duy Thiết Kế)

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Skill này biến AI của bạn thành một **người điều phối và bạn đồng hành tư duy thiết kế** thân thiện, có kỷ luật — cùng bạn đi qua vòng lặp Empathize (Thấu cảm) → Define (Định nghĩa) → Ideate (Lên ý tưởng) → Prototype (Nguyên mẫu) → Test (Kiểm chứng), có thể kéo dài qua nhiều phiên làm việc, và luôn cẩn thận không tự bịa ra những gì người dùng của bạn nghĩ.

## Design Thinking là gì?

Nhờ một chatbot thông thường "hiểu người dùng của bạn", nó sẽ vui vẻ bịa ra một persona, viết một câu quote nghe rất thuyết phục, thậm chí phác ra một "kết quả test" — tất cả đều trôi chảy, đều tự tin, và khó phân biệt với nghiên cứu thật chỉ bằng cách đọc qua. Skill này được xây dựng để nhẹ nhàng ngăn đúng chuyện đó xảy ra. Nó giúp bạn thiết kế các công cụ nghiên cứu — bảng hỏi phỏng vấn, kế hoạch quan sát, thí nghiệm có tiêu chí đạt/không đạt rõ ràng — bạn là người đi thu thập dữ liệu thật, và skill sẽ tổng hợp dữ liệu đó một cách cẩn trọng: mỗi insight `[I#]` (một thẻ tham chiếu nhỏ, trỏ thẳng về đúng cuộc phỏng vấn hoặc tài liệu mà nó xuất phát) đều truy được về một bằng chứng đã đăng ký `[S#]` trong `research/sources.md`. Bất cứ điều gì chưa có dữ liệu thật hỗ trợ sẽ được gắn nhãn rõ ràng `(hypothesis — needs validation)` (giả thuyết — cần kiểm chứng) thay vì được trình bày như một sự thật.

Skill này không có ý định làm tư duy thiết kế *thay* bạn — bạn là người phỏng vấn người dùng, chạy các bài test khả dụng, và sở hữu mọi cuộc trò chuyện với thế giới thực. Đổi lại, skill lo phần kỷ luật: giữ mọi thứ ngăn nắp, theo dõi bằng chứng, và cho bạn một workspace tồn tại xuyên suốt nhiều phiên, tự nhiên lặp lại (loop back) đúng như cách các dự án tư duy thiết kế thật vẫn vận hành.

Nhiều công cụ AI thông thường có xu hướng tự bịa ra persona và quote mà không thực sự cố ý — đó chỉ là điều xảy ra khi một mô hình được yêu cầu nghe có vẻ hữu ích trong khi không có dữ liệu thật để dựa vào. Skill này cẩn thận để không bao giờ làm vậy: bất cứ điều gì chưa bắt nguồn từ dữ liệu thật của bạn sẽ luôn được gắn nhãn rõ ràng là một phỏng đoán cần kiểm tra lại, chứ không bao giờ được khoác lên như một phát hiện.

## Vì Sao Nên Dùng?

- **Mọi insight đều đi kèm bằng chứng của nó.** Bất kỳ nhận định nào về việc người dùng nghĩ gì, cảm thấy gì, làm gì đều mang thẻ `[I#]`/`[S#]` hoặc được gắn nhãn rõ ràng là giả thuyết, để bạn luôn có thể kiểm tra nó đến từ đâu.
- **Bạn vận hành thế giới thực, skill vận hành sự nghiêm ngặt.** Skill sẽ không giả lập một cuộc phỏng vấn hay đoán "người dùng có lẽ sẽ nói gì". Phỏng vấn nháp để luyện tập rất hoan nghênh — chỉ cần gắn nhãn là luyện tập, không bao giờ tính là bằng chứng thật.
- **Nghiên cứu bàn giấy bổ sung bối cảnh, chứ không thay thế người dùng thật.** Nguồn thứ cấp giúp làm rõ bức tranh và khảo sát các giải pháp hiện có; chúng có thể chỉ ra một tín hiệu đáng kiểm tra, nhưng sẽ không tự mình trở thành cơ sở duy nhất cho một insight kiểu "người dùng cảm thấy X".
- **Luôn có một lượt rà soát thứ hai ở mỗi cổng gate.** Trước khi Define đóng lại và trước khi Test mở ra, một lượt rà soát độc lập, lấy bằng chứng làm gốc sẽ kiểm tra lại công việc — và bất cứ điều gì tìm được đều được chia sẻ công khai, không âm thầm sửa qua loa.
- **Việc quay lại một bước là bình thường, và luôn được ghi lại.** Nếu một test không như mong đợi, dự án có thể quay lại Define hoặc Ideate; mỗi vòng và lý do của nó đều được ghi vào `phase-state.md` thay vì bị lướt qua.

## Năm Cam Kết Của Skill

1. **Không tự bịa insight người dùng** — mọi insight `[I#]` đều truy được về bằng chứng `[S#]` mà bạn thực sự đã thu thập; mọi thứ khác được gắn nhãn `(hypothesis — needs validation)` thay vì khẳng định như sự thật.
2. **Skill thiết kế nghiên cứu, bạn là người thực hiện** — bảng hỏi thảo luận, câu hỏi phỏng vấn, thiết kế thí nghiệm đến từ skill, sau đó skill chờ dữ liệu thật của bạn. Không phỏng vấn giả lập, không quote bịa.
3. **Nghiên cứu bàn giấy hỗ trợ, không thay thế** — nguồn thứ cấp cho bối cảnh và tín hiệu, luôn được trích dẫn `[S#]`, nhưng không bao giờ thay thế việc lắng nghe người dùng thật.
4. **Luôn có một lượt rà soát mới ở mỗi cổng pha** — một lượt kiểm tra insight vào cuối Define, một lượt kiểm tra giả định trước Test, cả hai đều cẩn trọng và lấy bằng chứng làm gốc.
5. **Quy trình được thiết kế để lặp lại** — khi một giả định không đứng vững, dự án sẵn lòng quay lại Define hoặc Ideate một cách có chủ đích, và mỗi lần lặp được ghi lại kèm số vòng và lý do.

## Đội Ngũ Các Lăng Kính (Lenses)

Bạn làm việc với **Helm** mặc định, người khoác lên một lăng kính chức năng tại một thời điểm — không phải các persona có tên, không có menu để chọn.

| Lăng kính | Pha | Làm gì |
|------|-------|--------------|
| **Helm** (mặc định) | Xuyên suốt | Giữ trạng thái pha, chuyển lăng kính, chạy các gate, trò chuyện với bạn, ghi journal |
| **Lens** | Empathize | Kế hoạch nghiên cứu, bảng hỏi thảo luận, câu hỏi phỏng vấn, kế hoạch quan sát — rồi chờ dữ liệu |
| **Radar** | Empathize → Prototype | Bối cảnh thị trường, khảo sát giải pháp hiện có, kiểm tra tính khả thi |
| **Loom** | Define | Affinity mapping, insight `[I#]`, persona giả thuyết, POV statement, câu hỏi HMW |
| **Prism** | Ideate | Sinh ý tưởng song song, mỗi lăng kính một subagent — nơi duy nhất việc chạy song song thật sự đáng giá |
| **Forge** | Prototype | Storyboard, đặc tả paper-prototype, brief nguyên mẫu, mỗi cái được xây để trả lời một câu hỏi |
| **Probe** | Test | Bản đồ giả định, chọn giả định rủi ro nhất, test card có tiêu chí đạt/không đạt |
| **Judge** | Các cổng gate | Rà soát insight và rà soát giả định — chạy độc lập khi có subagent, để việc rà soát giữ được sự khách quan |

Chỉ Ideate mới chạy song song thành các subagent (mỗi subagent đóng vai một lăng kính Prism); Judge chạy như một lượt độc lập riêng ở các gate. Mọi thứ còn lại là chuyển lăng kính tuần tự trong cuộc hội thoại chính — Helm nên ở trong phòng cùng bạn.

## Vòng Lặp Các Pha

```
0 Kickoff    → Helm              → project.md              ⛔ người dùng xác nhận khung
1 Empathize  → Lens              → kế hoạch nghiên cứu, guide  ⏸ chờ dữ liệu người dùng → research/
2 Define     → Loom              → insight, persona, hmw   ⛔ Judge rà soát insight + người dùng chọn HMW
3 Ideate     → Prism (fan-out)   → ideas.md                ⛔ người dùng chọn (các) concept
4 Prototype  → Forge             → prototypes/*
5 Test       → Probe             → tests/*                 ⛔ Judge rà soát giả định → ⏸ người dùng chạy test
↺ Loop       → Helm              → journal, phase-state    (ghi số vòng + lý do, quay lại đúng pha)
```

⛔ đánh dấu một gate: skill dừng lại, cho bạn xem artifact, và chờ quyết định của bạn. ⏸ đánh dấu điểm mà skill đã làm xong phần của nó, còn việc thu thập dữ liệu thực tế nằm trong tay bạn — skill sẽ nói rõ nó đang chờ gì và gợi ý việc làm song song hữu ích (thường là nghiên cứu bàn giấy) trong lúc chờ.

**Bắt đầu giữa chừng hoàn toàn bình thường.** Đến với một chồng ghi chú phỏng vấn, skill bắt đầu ở Define; đến với một nguyên mẫu, skill bắt đầu ở Test. Kickoff chạy nhẹ nhàng — xác nhận khung, khởi tạo workspace, đăng ký những gì bạn mang đến làm nguồn — rồi nhảy thẳng đến đúng pha.

**Chưa có dữ liệu sơ cấp? Không sao cả.** Bạn có thể bước vào Define chỉ với nghiên cứu bàn giấy và giả định được khai báo, sau khi skill đã nói rõ cái đánh đổi. Mọi persona xây theo cách đó là một **proto-persona** tường minh, mọi insight là giả thuyết, và Test là nơi thực tế lên tiếng lần đầu tiên.

## Cấu Trúc Workspace Được Tạo Ra

```text
<project-dir>/
  project.md        # bản brief: vấn đề, người dùng mục tiêu, phạm vi, ràng buộc
  phase-state.md    # vòng + pha hiện tại, trạng thái gate, đang chờ gì từ người dùng
  journal.md        # nhật ký quyết định theo phiên — xương sống cho việc quay lại
  research/
    sources.md      # sổ đăng ký bằng chứng [S#] (cùng schema với market-researcher)
    raw/             # dữ liệu người dùng đưa vào: ghi chú, transcript, file khảo sát
    market/          # kết quả từ market-researcher nằm ở đây
  insights.md        # insight [I#], mỗi cái truy được về bằng chứng [S#]
  personas.md        # persona — gắn nhãn trung thực theo độ mạnh bằng chứng
  hmw.md             # POV statement và câu hỏi How-Might-We
  ideas.md           # danh mục ý tưởng đã chấm điểm
  prototypes/        # một đặc tả cho mỗi nguyên mẫu
  tests/             # bản đồ giả định, test card, kết quả, learning card
```

**Quay lại dễ dàng.** Khi thư mục dự án đã tồn tại, skill đọc `phase-state.md` và `journal.md` trước tiên, rồi phản chiếu lại trạng thái cho bạn trước khi làm bất cứ điều gì khác — "Phiên trước kết thúc ở Define, vòng 2; lượt rà soát insight gắn cờ I4 là chưa đủ bằng chứng; đang chờ ba cuộc phỏng vấn còn lại của bạn." Skill tin vào các file, không tin vào trí nhớ, và sẽ không âm thầm làm lại hay ghi đè lên công việc bạn đã hoàn thành.

## Kết Hợp Với Skill Market-Researcher

Tư duy thiết kế cần bối cảnh thị trường ở nhiều thời điểm — làm nền cho Empathize và Define, khảo sát các giải pháp hiện có trước Ideate, kiểm tra tính khả thi trước Prototype. Với bất cứ điều gì vượt quá một vài lượt tìm kiếm nhanh (định lượng quy mô thị trường, phân tích sâu đối thủ, khai thác tín hiệu nhu cầu), skill này dùng **[market-researcher](../market-researcher/)** làm cỗ máy nghiên cứu, nếu skill đó đã được cài đặt: nó gọi market-researcher theo đúng composition contract, trỏ vào `<project-dir>/research/market/`, và market-researcher sẽ nối thêm vào `research/sources.md` **tiếp tục đánh số `[S#]` đã có** — nhờ vậy insight và ý tưởng có thể trích dẫn nguồn của nó trực tiếp.

Nếu market-researcher chưa được cài, skill này chỉ nhắc đến một lần — cài đặt từ https://github.com/tronghieu/agent-skills#market-researcher (`npx skills add tronghieu/agent-skills --skill market-researcher`) — và hoàn toàn tôn trọng câu trả lời "không": nó sẽ tiếp tục với nghiên cứu bàn giấy nhẹ nhàng ngay trong hội thoại, mọi nhận định vẫn được trích dẫn theo cùng schema `[S#]`, chỉ là không chạy một lượt định lượng quy mô hay phân tích đối thủ đầy đủ. Đây là một người bạn đồng hành tùy chọn, không phải điều kiện bắt buộc.

## Cách Kích Hoạt

Yêu cầu AI thực hiện các tác vụ như:

```text
Our users are churning and we don't know why — help us figure out what's going on.
```

```text
Here are 12 interview transcripts from our onboarding research — synthesize them into insights and personas.
```

```text
We picked a concept — design an experiment to test whether people will actually pay for it.
```

```text
Chúng tôi muốn hiểu vì sao khách hàng bỏ giỏ hàng — bắt đầu một dự án tư duy thiết kế giúp tôi.
```

```text
先週インタビューした5人分のメモがあります。インサイトとペルソナにまとめてください。
```

Skill cũng kích hoạt khi bạn gõ `status` bên trong một thư mục dự án đã có, để tiếp tục đúng từ chỗ đã dừng — không cần phải nói đúng cụm từ "design thinking".

## Cài Đặt

### 1. Dùng CLI (Khuyến nghị)

```bash
npx skills add tronghieu/agent-skills --skill design-thinking
```

### 2. Cài Đặt Thủ Công (Cho người dùng cơ bản)

1. **Tải về:** Truy cập thư mục `skills/` trong kho lưu trữ này và tải file `design-thinking.zip`.
2. **Giải nén & Copy:** Giải nén file `design-thinking.zip` và copy thư mục `design-thinking` vào một trong các vị trí sau:

**Cho một dự án cụ thể:**
Copy thư mục `design-thinking` vào `.agents/skills/` hoặc `.claude/skills/` trong thư mục gốc dự án của bạn.

**Cài đặt toàn cục (Dùng cho mọi dự án):**
* **Mac / Linux:** `~/.agents/skills/` hoặc `~/.claude/skills/`
* **Windows:** `%USERPROFILE%\.agents\skills\` hoặc `%USERPROFILE%\.claude\skills\` (thường là `C:\Users\<Tên_Của_Bạn>`)

## Ví Dụ Sử Dụng

> **Bạn:** Người dùng của chúng tôi bỏ đi sau tuần đầu tiên và chúng tôi không biết vì sao. Bạn giúp chúng tôi hiểu chuyện gì đang xảy ra được không?
>
> **Agent:** Tôi sẽ chạy việc này như một dự án tư duy thiết kế, bắt đầu ở Empathize. Hỏi nhanh để xác định khung: "bỏ đi" nghĩa là hủy tài khoản, hay chỉ im lặng không dùng nữa mà chưa hủy — và bạn đã có sẵn tiếp xúc nào với người dùng chưa (quyền phỏng vấn, ticket hỗ trợ, analytics), hay chúng ta bắt đầu từ con số không?
>
> *(xác nhận khung câu hỏi, khởi tạo workspace dự án, soạn kế hoạch nghiên cứu và bảng hỏi bán cấu trúc nhắm vào tình trạng rớt người dùng tuần đầu, đăng ký file xuất ticket hỗ trợ của bạn thành `[S1]`–`[S6]` trong `research/sources.md`)*
>
> **Agent:** Kế hoạch nghiên cứu và bảng hỏi thảo luận đã sẵn sàng trong `research/`. Tôi đã rút ra ba tín hiệu sớm từ các ticket hỗ trợ bạn đã có [S2][S4] — nhưng đó là tín hiệu bàn giấy, chưa phải insight đã kiểm chứng, nên tôi đã gắn nhãn giả thuyết cho chúng. Tôi sẽ không đoán người dùng của bạn có thể nói gì trong một cuộc phỏng vấn. Khi bạn thực hiện xong 5–6 cuộc trò chuyện như vậy và đưa ghi chú vào `research/raw/`, tôi sẽ tổng hợp insight thật và chúng ta chuyển sang Define.
