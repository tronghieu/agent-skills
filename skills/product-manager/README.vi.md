# Product Manager Skill

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Skill này biến AI agent của bạn thành một **cộng sự product management kỷ luật** — kiểu PM sẽ không đưa bạn một bảng RICE với những con số reach bịa ra, hay một PRD trích lời khách hàng chưa từng nói câu đó, chỉ để trông có vẻ chỉn chu.

## Product Manager Skill là gì?

Yêu cầu một chatbot thông thường "ưu tiên backlog giúp tôi" và nó sẽ cho ra ngay một bảng RICE trông rất tự tin — reach, impact, effort điền đủ, xếp hạng chính xác đến hai chữ số thập phân. Không có cái nào là thật cả. Đó chỉ là một phỏng đoán hợp lý khoác áo phân tích, và một khi đã lên slide thì không ai phân biệt được nó với một bảng dựa trên số liệu thật. Skill này được xây để khiến kiểu lỗi đó không thể trốn được: mọi con số trong một bảng ưu tiên, mọi chỉ số trong OKR, mọi tuyên bố trong PRD đều mang một nhãn mà bạn có thể bấm vào để biết nó từ đâu ra — một nguồn thật, một giả định có ghi rõ khoảng dao động, hoặc ước tính của chính bạn được ghi lại có ngày tháng. Nếu con số đó chưa tồn tại, skill sẽ hỏi bạn hoặc đăng ký nó thành một giả định trung thực. Nó không bao giờ điền đại vào ô cho bảng trông gọn gàng.

Đây cũng không phải công cụ tạo tài liệu một lần rồi thôi. Product management không kết thúc khi PRD được gửi đi — vẫn còn backlog cần chăm sóc, OKR cần theo dõi, feedback chất đống, một lần ra mắt cần theo sát và có thể phải rollback. Skill này vận hành như một **cộng sự cho một sản phẩm đang sống**: một workspace, khởi tạo một lần, mà bạn quay lại trong nhiều tuần, nhiều tháng. Nó nhớ điều gì đã được quyết định và vì sao, để mỗi phiên làm việc bắt đầu bằng "đây là chỗ chúng ta dừng lại lần trước" thay vì bạn phải giải thích lại từ đầu.

Bạn vẫn là product manager. Bạn sở hữu sản phẩm, bạn nói chuyện với người dùng, bạn là người quyết định cái gì được build. Việc của skill là soạn thảo tốt, phản biện khi yêu cầu của bạn mâu thuẫn với bằng chứng chính bạn đã có, tính toán trung thực, và giữ sổ sách để không có gì bị âm thầm quên hay tranh cãi lại từ đầu.

## Vì sao nên dùng?

- **Mọi con số đều khai rõ nguồn gốc.** Reach, impact, effort, baseline, tỷ lệ chuyển đổi — mỗi con số được gắn nhãn `[S#]` (nguồn thật), `A#` (giả định đã đăng ký với khoảng dao động trung thực), hoặc `(user estimate, <ngày>)`. Một con số không nhãn bị coi là lỗi, không phải là đường tắt được phép.
- **Bảng xếp hạng được stress-test, không chỉ tính ra rồi thôi.** Bất kỳ bảng ưu tiên nào dựa trên giả định đều được chạy lại ở đầu thấp và đầu cao của mỗi khoảng dao động, để bạn thấy kết luận nào chắc chắn, kết luận nào đổi tùy vào một phỏng đoán, và cái nào thực sự chưa đủ rõ để phân định — trước khi bạn đặt cược cả một quý vào nó.
- **Mỗi tính năng đều truy được về một lý do, hoặc thừa nhận là không có.** Một PRD hay một mục backlog phải trỏ về bằng chứng thật về vấn đề người dùng, hoặc được gắn nhãn rõ ràng là một cú đặt cược. Không có chuyện gắn lý do hồi tố cho có vẻ dựa trên bằng chứng.
- **Có một lượt kiểm tra thứ hai trước khi bạn thấy kết quả.** PRD, bảng ưu tiên, và kế hoạch ra mắt đều trải qua một cuộc audit mang tính phản biện — kiểm tra con số trần trụi không nhãn, tiêu chí chấp nhận chưa kiểm chứng được, ngưỡng rollback còn thiếu — trước khi bạn được yêu cầu hành động theo đó. Phát hiện được ghi thẳng vào tài liệu, không âm thầm sửa đi.
- **Workspace ghi nhớ, để bạn không phải nhớ.** Một nhật ký quyết định liên tục chính là trí nhớ thể chế của sản phẩm: cái gì đã quyết, vì sao, cái gì bị bác và vì sao, và điều kiện gì sẽ khiến bạn quay lại xem xét nó. Ba tháng sau quay lại, skill sẽ đọc nó trước khi nói câu nào.

## Năm điều skill không bao giờ thỏa hiệp

1. **Không bịa số.** Mọi input định lượng là một nguồn thật, một giả định có nhãn kèm khoảng dao động, hoặc ước tính có ngày tháng của chính bạn — không bao giờ là một phỏng đoán hợp lý khoác áo để lấp đầy ô.
2. **Sensitivity trước độ chính xác.** Một bảng xếp hạng dựng trên giả định phải được kiểm tra trên toàn bộ khoảng dao động trung thực trước khi được trình bày như một kết luận — một điểm số hai chữ số thập phân đầy tự tin dựa trên con số đoán mò chỉ là màn kịch của sự chính xác.
3. **Kết quả thật quan trọng hơn sản phẩm bàn giao.** Mọi cơ hội và mọi PRD phải truy về một vấn đề người dùng thật và nêu rõ chỉ số nó cần dịch chuyển. Việc không truy được về đâu vẫn được phép — đặt cược là có thật — nhưng nó phải rõ ràng là một cú đặt cược, không bao giờ được âm thầm đổi tên cho có vẻ chính danh.
4. **Workspace là nguồn sự thật, không phải trí nhớ.** Skill đọc nhật ký quyết định và trạng thái hiện tại trước khi làm bất cứ điều gì, mỗi lần, và phản ánh lại cho bạn. Một điều chỉnh phải lan ra mọi nơi nó được lặp lại, không chỉ ở file bạn đang xem.
5. **Không gì được ra mắt mà thiếu một lượt kiểm tra thứ hai.** PRD, bảng ưu tiên, kế hoạch ra mắt đều trải qua một audit độc lập trước khi bạn được yêu cầu hành động — và bất kỳ điều gì audit tìm thấy đều được cho bạn thấy, không âm thầm dọn sạch.

Câu hỏi mà mọi tài liệu phải vượt qua: **"con số này thực sự từ đâu ra — và nếu nó sai, quyết định có thay đổi không?"**

## Đội ngũ các lăng kính

Mỗi vai giờ đã có tên, nhưng bạn không bao giờ phải "gọi" ai cả — vẫn là một PM duy nhất đổi vai theo yêu cầu công việc, không phải một danh sách nhân vật để bạn chọn.

| Lăng kính | Mối quan tâm | Bạn sẽ gặp nó khi... |
|------|---------|------------------------|
| **Sao** (Compass) | Định hướng — tầm nhìn, định vị, những cú đặt cược lớn về cấu trúc | Bạn hỏi "cái này nên là sản phẩm riêng hay chỉ là một tính năng?" hoặc cần tư vấn về giá |
| **Minh** (Scope) | Định nghĩa — biến một vấn đề thành một bản spec | Bạn yêu cầu một PRD, một story map, hoặc user stories |
| **Lam** (Scale) | Sắp thứ tự — cái gì làm trước, vì sao | Bạn yêu cầu ưu tiên backlog |
| **Kim** (Gauge) | Đo lường — "tốt" trông như thế nào | Bạn yêu cầu định nghĩa north-star metric hoặc đặt OKR |
| **Mai** (Lab) | Học hỏi — kiểm chứng một niềm tin rủi ro trước khi đặt cược vào nó | Bạn yêu cầu thiết kế A/B test hoặc kiểm chứng một giả định |
| **Phong** (Ramp) | Ra mắt — đưa tính năng ra thị trường một cách an toàn | Bạn yêu cầu lên kế hoạch ra mắt, kèm tiêu chí rollback |
| **Thanh** (Echo) | Lắng nghe — biến feedback thô thành tín hiệu | Bạn đổ một đống ticket hỗ trợ hoặc review vào để phân loại |
| **Bao** (Judge) | Kiểm toán — cái nhìn hoài nghi thứ hai | Tự động, trước khi một PRD, bảng ưu tiên, hay kế hoạch ra mắt được trao cho bạn |

Judge chạy như một lượt độc lập bất cứ khi nào agent có thể khởi tạo một subagent riêng — tự chấm bài của chính mình thì không đáng tin mấy, nên nó cố tình không tự chấm điểm mình. Mọi thứ khác diễn ra như một PM duy nhất đi cùng bạn trong cuộc trò chuyện, ngay trong phòng với bạn.

## Bạn có thể yêu cầu gì

Không có thứ tự cố định, không có "giai đoạn 1 trên 5" — bạn bước vào ở bất cứ điểm nào tình huống cần, và skill sẽ tự định tuyến đến đúng lăng kính:

- **"Ưu tiên backlog giúp tôi"** — lăng kính Scale: chấm điểm RICE (hoặc Kano, để phân loại một tính năng thuộc kỳ vọng nào) với mọi input được gắn nhãn và một lượt đọc sensitivity trên bảng xếp hạng.
- **"Viết PRD cho X"** — lăng kính Scope: problem statement gắn với bằng chứng, một story map, user stories có thể kiểm chứng được, một danh sách Won't-have rõ ràng.
- **"Triage đống feedback khách hàng này"** — lăng kính Echo: feedback thô được sắp xếp vào backlog thành các cơ hội thật, không chỉ đếm số lượng.
- **"Lên kế hoạch OKR cho quý này"** / **"North-star metric của chúng ta nên là gì?"** — lăng kính Gauge: một cây chỉ số với baseline có nhãn rõ, không phải một chỉ số được chọn vì nghe hay.
- **"Thiết kế A/B test cho..."** — lăng kính Lab: một test card với ngưỡng pass/fail được đặt ra *trước khi* test chạy, không diễn giải sau đó để khớp với kết quả bạn muốn.
- **"Lên kế hoạch ra mắt..."** — lăng kính Ramp: một kế hoạch rollout phù hợp với mức rủi ro thật, với ngưỡng rollback bằng số được cố định trước.
- **"Cái này nên là platform hay là feature?"** / **"Nên định giá thế nào?"** — lăng kính Compass: những quyết định mang tính cấu trúc định hình mọi thứ về sau.

Một yêu cầu một lần cũng được phục vụ chỉn chu mà không cần nghi thức rườm rà — bạn không cần dựng cả một workspace chỉ để có một câu trả lời gọn — nhưng con số vẫn luôn được gắn nhãn kể cả trong một lượt xử lý nhanh. Skill cũng hoạt động ở bất kỳ ngôn ngữ nào bạn dùng; nó dừng lại ở user stories hoàn chỉnh và giao phần còn lại cho đội kỹ thuật.

## Workspace mà skill tạo ra

```text
<product-dir>/
  product.md              # tầm nhìn, định vị, người dùng, ràng buộc — sự thật cốt lõi
  state.md                 # cái gì đang mở, cái gì đang chờ bạn
  decisions.md              # nhật ký quyết định append-only — lý do bạn có thể rời đi rồi quay lại
  discovery/
    sources.md             # [S#] mọi nguồn, chỉ bằng chứng thật
    insights.md             # [I#] insight người dùng, tự đăng ký hoặc nhập từ design-thinking
    feedback-log.md         # FB# feedback thô, được triage theo thời gian
  strategy/
    metrics.md               # north-star metric + cây chỉ số + guardrail
    okrs-<period>.md          # một file cho mỗi kỳ OKR
  backlog/
    opportunities.md         # OP# các vấn đề đáng giải quyết, viết dưới dạng job story
    assumptions.md            # A# giả định đã đăng ký — nội dung, căn cứ, khoảng dao động trung thực, trạng thái
    prioritization-<date>.md  # các lượt RICE/Kano theo ngày, không bao giờ ghi đè — đây là lịch sử ưu tiên của bạn
  specs/                    # prd-<feature>.md — PRD, story map, stories
  experiments/               # exp-<slug>.md — test card và những gì học được
  launches/                  # launch-<release>.md — kế hoạch, tiêu chí rollback, đánh giá sau ra mắt
```

**Quay lại rất dễ dàng.** Bước vào một product directory đã tồn tại và gõ "status" — skill sẽ đọc `decisions.md` và `state.md` trước, rồi cho bạn biết mọi thứ đang ở đâu trước khi làm bất cứ điều gì khác: "Lần trước chúng ta đã chốt bảng ưu tiên Q3; PRD của offline-mode đã soạn xong, đang chờ ước tính effort từ đội kỹ thuật; hai thí nghiệm đang chạy." Nó tin vào file hơn là trí nhớ của chính nó, và sẽ không âm thầm làm lại hay ghi đè công việc bạn đã hoàn thành.

## Hoạt động cùng các skill đồng hành

Product management liên tục chạm vào nghiên cứu người dùng và dữ liệu thị trường, nhưng skill này không được xây để tự làm cả hai từ đầu — ba skill đồng hành phụ trách phần đó, mỗi cái đều tùy chọn và chỉ được gợi ý một lần:

- **[design-thinking](../design-thinking/)** — cho việc khám phá người dùng sâu: phỏng vấn, nghiên cứu thực địa, test prototype, kiểm chứng một job story dạng giả thuyết một cách nghiêm túc thay vì đoán mò. Skill này chỉ tiêu thụ insight của nó (các khối `[I#]` nhập thẳng vào `discovery/insights.md`, đánh số tiếp nối) — nó không bao giờ tự đi làm nghiên cứu thực địa. Cài đặt: `npx skills add tronghieu/agent-skills --skill design-thinking` — thông tin: https://github.com/tronghieu/agent-skills#design-thinking
- **[market-researcher](../market-researcher/)** — cho dữ liệu thị trường bên ngoài vượt quá một cuộc tìm kiếm nhanh: benchmark giá, bối cảnh đối thủ, sizing thị trường cho một giả định về reach. Nó ghi thẳng vào `discovery/` của workspace này, tiếp nối đánh số `[S#]`, để tài liệu của bạn trích dẫn nguồn của nó trực tiếp. Cài đặt: `npx skills add tronghieu/agent-skills --skill market-researcher` — thông tin: https://github.com/tronghieu/agent-skills#market-researcher
- **[strategy-board](../strategy-board/)** — cho các quyết định ở tầm cao hơn sản phẩm: vào một thị trường mới, build-vs-buy, khai tử một dòng sản phẩm — những cú đặt cược cấp công ty mà một playbook của PM không nên tự quyết một mình. Khuyến nghị của nó quay lại làm input cho file `strategy/` của bạn và một mục trong nhật ký quyết định. Cài đặt: `npx skills add tronghieu/agent-skills --skill strategy-board` — thông tin: https://github.com/tronghieu/agent-skills#strategy-board

Nếu một skill đồng hành chưa được cài, skill này chỉ nhắc một lần và, nếu bạn không muốn thêm nó, sẽ tự xoay xở bằng desk research nhẹ hoặc giả thuyết gắn nhãn rõ ràng thay thế. Không bao giờ là bắt buộc, luôn là lựa chọn của bạn.

## Cách kích hoạt

Yêu cầu AI agent của bạn những việc như:

```text
Prioritize these 6 features for next quarter using RICE.
```

```text
Write me a PRD for offline mode — here's what we know about the problem.
```

```text
Here's three months of support tickets and app-store reviews — triage this into our backlog.
```

```text
Should this be its own product or a feature of what we already have?
```

```text
Hãy giúp tôi ưu tiên backlog quý này và viết PRD cho tính năng được chọn.
```

```text
今四半期のOKRを一緒に決めたいです。ノーススターメトリクスから考えましょう。
```

Skill cũng kích hoạt khi bạn gõ `status` bên trong một product workspace đã tồn tại, và với bất kỳ câu hỏi nào về sản phẩm nói chung — bạn không bao giờ cần nói "hãy đóng vai product manager" để nó chạy.

## Cài đặt

### 1. Dùng CLI (Khuyến nghị)

```bash
npx skills add tronghieu/agent-skills --skill product-manager
```

### 2. Cài đặt thủ công (Dành cho người không rành kỹ thuật)

1. **Tải về:** Vào thư mục `skills/` trong repository này và tải `product-manager.zip`.
2. **Giải nén & Sao chép:** Giải nén `product-manager.zip` và sao chép thư mục `product-manager` vào một trong các thư mục sau:

**Cho một dự án cụ thể:**
Sao chép thư mục `product-manager` vào `.agents/skills/` hoặc `.claude/skills/` ở thư mục gốc của dự án.

**Toàn cục (dùng cho mọi dự án):**
* **Mac / Linux:** `~/.agents/skills/` hoặc `~/.claude/skills/`
* **Windows:** `%USERPROFILE%\.agents\skills\` hoặc `%USERPROFILE%\.claude\skills\` (thường là `C:\Users\<TênNgườiDùng>`)

## Ví dụ sử dụng

> **Bạn:** Ưu tiên 6 tính năng này bằng RICE — đăng nhập Google, chế độ offline, dark mode, xuất CSV, phân quyền theo team, và chat trong app.
>
> **Agent:** Tôi có thể chạy ngay — nhưng tôi chưa có số liệu reach, impact, hay effort cho bất kỳ tính năng nào, nên nếu chấm điểm bây giờ sẽ là đoán mò trừ khi bạn cho tôi vài con số. Bạn có dữ liệu analytics về việc mỗi tính năng ảnh hưởng đến bao nhiêu người dùng không, và đội kỹ thuật đã ước tính effort cho cái nào chưa?
>
> **Bạn:** Chưa có ước tính effort, và tôi chỉ có dữ liệu sử dụng thật cho xuất CSV và phân quyền theo team.
>
> **Agent:** Rõ rồi — tôi sẽ chấm cả 6 tính năng ngay bây giờ: xuất CSV và phân quyền theo team dùng số liệu reach thật `[S2]` `[S3]`, bốn tính năng còn lại dùng giả định đã đăng ký với khoảng dao động trung thực (`A1`–`A6` trong `backlog/assumptions.md`), và effort là giả định có nhãn với khoảng dao động cho cả 6 cho đến khi đội dev cho ý kiến.
>
> *(dựng bảng RICE, chạy sensitivity trên khoảng dao động của từng giả định, ghi lại các giả định và bảng xếp hạng tạm thời)*
>
> **Agent:** Xếp hạng tạm thời: **chế độ offline và đăng nhập Google là chắc chắn** — chúng đứng đầu ở mọi khoảng dao động trung thực tôi thử. **Xuất CSV và dark mode đổi chỗ nhau ở #3/#4** tùy vào effort thực tế của mỗi cái, nên cặp này thực sự chưa ngã ngũ cho đến khi bạn cho tôi ước tính thật. Tôi đã ghi đây là một quyết định tạm thời trong `decisions.md` kèm điều kiện xem xét lại — ngay khi đội kỹ thuật ước tính effort xong, tôi sẽ chốt lại bảng xếp hạng thay vì để nó dựa trên phỏng đoán.
