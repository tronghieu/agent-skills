# Project Manager Skill

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Skill này biến AI agent của bạn thành một **cộng sự quản lý dự án kỷ luật (PM/PMO)** — kiểu PM sẽ không đưa bạn một báo cáo trạng thái toàn màu xanh trong khi ba milestone đang âm thầm trễ hẹn, hay một timeline dựng lên chỉ từ sự lạc quan.

## Project Manager Skill là gì?

Yêu cầu một chatbot thông thường "lập kế hoạch dự án" và nó sẽ cho ra ngay một timeline trông rất tự tin — milestone, ngày tháng, phụ thuộc, điền đủ cả, nhưng toàn là bịa. Hỏi nó "báo cáo tiến độ tuần này" giữa lúc dự án đang khủng hoảng, nó sẽ vui vẻ tô màu xanh vì báo cáo trạng thái thì "nên" trông như vậy. Có ba kiểu thất bại giết chết nhiều dự án thật hơn bất cứ điều gì khác, và một AI assistant quá nhiệt tình sẽ làm cả ba kiểu này *tệ hơn* theo mặc định: **planning fallacy** (ước tính lạc quan được trình bày như một cam kết), **watermelon reporting** (xanh vỏ đỏ lòng — một màu trạng thái không truy được về bằng chứng của ai cả), và **scope creep** (những khoản "nhỏ" được âm thầm nhét vào cho đến khi baseline chỉ còn là chuyện hư cấu). Skill này được xây để không kiểu nào trong ba cái đó có thể xảy ra một cách âm thầm: mọi màu trạng thái, mọi phần trăm hoàn thành, mọi ước tính đều mang một nhãn mà bạn bấm vào là biết nó từ đâu ra — một sự kiện đã ghi nhận, một giả định có nêu rõ khoảng dao động, hoặc lời khẳng định của chính bạn kèm ngày tháng. Khi không có bằng chứng, skill sẽ hỏi bạn hoặc đăng ký một giả định trung thực. Nó không bao giờ tô xanh một milestone chỉ để bảng trông đầy đủ.

Đây cũng không phải công cụ tạo tài liệu một lần rồi thôi. Một dự án không kết thúc khi kế hoạch được chốt — vẫn còn lịch trình cần giữ vững, rủi ro cần theo dõi, báo cáo trạng thái cần trung thực tuần này qua tuần khác, scope cần bảo vệ, các cuộc họp cần biến thành hành động có người theo dõi, và một buổi retro cần chạy trước khi sai lầm cũ lặp lại. Skill này vận hành như một **cộng sự cho một dự án đang sống**: một workspace, khởi tạo một lần, mà bạn quay lại trong nhiều tuần, nhiều tháng. Nó nhớ điều gì đã được quyết định và vì sao, để mỗi phiên làm việc bắt đầu bằng "đây là tình hình hiện tại" thay vì bạn phải giải thích lại dự án từ đầu.

Bạn vẫn là project manager. Bạn sở hữu lịch trình, bạn nói chuyện với sponsor, bạn là người quyết định mọi thứ về scope và ngày tháng. Việc của skill là soạn thảo tốt, phản biện khi yêu cầu của bạn mâu thuẫn với các sổ sách đã ghi, tính toán ước tính và rủi ro một cách trung thực, và giữ sổ sách để không có gì bị âm thầm quên, ghi đè, hay tranh cãi lại từ đầu.

## Vì sao nên dùng?

- **Mọi trạng thái và con số đều khai rõ nguồn gốc.** Mỗi màu RAG, phần trăm hoàn thành, ngày dự báo, và ước tính đều gắn nhãn `EV#` (sự kiện đã ghi nhận), `A#` (giả định đã đăng ký với khoảng dao động trung thực), hoặc `(user, <ngày>)`. Một màu trạng thái không nhãn bị coi là lỗi, không phải là một bản tóm tắt.
- **Ước tính phải đối chiếu lịch sử trước khi được đưa ra.** Mọi ước tính là một khoảng, không phải một con số cố định, và được kiểm tra lại với các lesson và số liệu plan-vs-actual trước đó của chính dự án — một ước tính bỏ qua ba lần trễ hẹn gần nhất không phải là ước tính, đó là một điều ước.
- **Thay đổi scope luôn phải qua cổng kiểm soát, không có ngoại lệ.** Bất kỳ thay đổi nào về scope, ngày tháng, hay ngân sách đều cần một đánh giá tác động và một người ra quyết định được nêu tên *trước khi* được chấp nhận, và baseline cũ luôn được giữ lại, không bao giờ bị ghi đè. "Thôi cứ nhét vào luôn" không có cửa xảy ra một cách âm thầm.
- **Có một lượt kiểm tra thứ hai trước khi bạn thấy kết quả.** Kế hoạch baseline, báo cáo trạng thái, và quyết định thay đổi đều trải qua một cuộc audit mang tính phản biện trước khi bạn được yêu cầu hành động theo đó. Phát hiện được ghi thẳng vào tài liệu, không âm thầm sửa đi.
- **Workspace ghi nhớ, để bạn không phải nhớ.** Một nhật ký quyết định chỉ-thêm-không-sửa và một file trạng thái chính là trí nhớ thể chế của dự án: cái gì đã quyết, vì sao, và cái gì đang chờ ai. Ba tháng sau quay lại, skill sẽ đọc nó trước khi nói câu nào.

## Năm điều skill không bao giờ thỏa hiệp

1. **Mọi trạng thái và con số đều khai rõ nguồn gốc.** Mỗi màu RAG, phần trăm hoàn thành, ngày dự báo, và ước tính mang nhãn `EV#`, `A#`, hoặc `(user, <ngày>)` — không bao giờ là một màu được chọn cho bảng trông đầy đủ.
2. **Ước tính phải đối chiếu lịch sử trước khi được đưa ra.** Mọi ước tính là một khoảng, nêu rõ căn cứ, và được kiểm tra lại với lesson của chính dự án hoặc một reference class rõ ràng. Buffer là một dòng riêng, nhìn thấy được, không bao giờ là phần đệm giấu trong task.
3. **Thay đổi scope phải qua cổng kiểm soát.** Bất kỳ thay đổi nào về scope, ngày tháng, hay ngân sách đều cần một đánh giá tác động và một quyết định rõ ràng từ người có thẩm quyền được nêu tên *trước khi* được chấp nhận. Re-baseline là một sự kiện được ghi lại; baseline cũ được giữ, không bị ghi đè.
4. **Workspace là nguồn sự thật, không phải trí nhớ.** Khi vào lại dự án, skill đọc file trạng thái, bản báo cáo mới nhất, và các quyết định gần đây trước khi làm bất cứ điều gì, rồi phản ánh lại tình hình dự án bằng chính từ ngữ của dự án — tên milestone thật, tên người thật.
5. **Không gì được ra mắt mà thiếu một lượt kiểm tra thứ hai.** Kế hoạch baseline, báo cáo trạng thái, và quyết định thay đổi đều trải qua một audit mang tính phản biện trước khi bạn được yêu cầu hành động theo đó — và bất kỳ điều gì audit tìm thấy đều được cho bạn thấy, không âm thầm dọn sạch.

Câu hỏi mà mọi tài liệu phải vượt qua: **"nếu sponsor kiểm tra từng con số trong tài liệu này, cái gì sẽ không trụ nổi — và quyết định có thay đổi không?"**

## Đội ngũ các lăng kính

Mỗi vai giờ đã có tên, nhưng bạn không bao giờ phải "gọi" ai cả — vẫn là một PM duy nhất đổi vai theo yêu cầu công việc, không phải một danh sách nhân vật để bạn chọn. Tên các lăng kính là những triết gia Hy Lạp, chọn theo đúng điều mỗi người nổi tiếng.

| Lăng kính | Mối quan tâm | Bạn sẽ gặp nó khi... |
|------|---------|------------------------|
| **Plato** · Anchor | Bối cảnh — giữ hình mẫu lý tưởng của dự án: charter, sự phù hợp về phương pháp luận, "xong" nghĩa là gì | Bạn khởi động một dự án hoặc cần chọn giữa predictive/agile/hybrid |
| **Aristotle** · Frame | Cấu trúc — WBS/backlog, lịch trình, phụ thuộc, critical path | Bạn yêu cầu một kế hoạch dự án, timeline, hoặc WBS |
| **Pythagoras** · Gauge | Ước tính — chỉ tin những con số có nguồn gốc rõ ràng | Bạn hỏi việc gì đó sẽ mất bao lâu |
| **Epictetus** · Watch | Rủi ro — tách bạch cái bạn kiểm soát được và cái bạn phải chấp nhận (ROAM) | Bạn yêu cầu dựng hoặc rà lại risk register |
| **Diogenes** · Pulse | Nói thật — cầm chiếc đèn lồng đi tìm những báo cáo xanh vỏ đỏ lòng | Bạn yêu cầu một báo cáo trạng thái |
| **Zeno** · Gate | Kiểm soát thay đổi — không để gì lọt qua cổng mà chưa được xem xét | Scope, ngày tháng, hoặc ngân sách muốn thay đổi |
| **Socrates** · Bridge | Con người — bản đồ stakeholder, kế hoạch giao tiếp, họp hành biến thành hành động, làm việc bằng đối thoại | Bạn cần bản đồ stakeholder hoặc muốn biến một cuộc họp thành hành động |
| **Heraclitus** · Loop | Học hỏi — biết rằng kế hoạch là một dòng sông; retro nuôi ngược vào ước tính kế tiếp | Bạn yêu cầu chạy một buổi retro hoặc ghi lại lesson |
| **Solon** · Judge | Kiểm toán — viết ra luật mà mọi tài liệu phải tuân theo | Tự động, trước khi một kế hoạch, báo cáo, hay quyết định thay đổi được gửi đi |

Judge (Solon) chạy như một lượt độc lập bất cứ khi nào agent có thể khởi tạo một subagent riêng — tự chấm bài của chính mình thì không đáng tin mấy, nên nó cố tình không tự chấm điểm mình. Mọi thứ khác diễn ra như một PM duy nhất đi cùng bạn trong cuộc trò chuyện, ngay trong phòng với bạn.

## Bạn có thể yêu cầu gì

Không có thứ tự cố định, không có "giai đoạn 1 trên 5" — bạn bước vào ở bất cứ điểm nào tình huống cần, và skill sẽ tự định tuyến đến đúng lăng kính:

- **"Khởi động dự án này"** — lăng kính Anchor: một charter với mục tiêu, scope trong/ngoài, sponsor và người có thẩm quyền quyết định, cùng gợi ý chọn phương pháp luận nếu bạn còn phân vân.
- **"Lập kế hoạch dự án / timeline / WBS"** — lăng kính Frame: một lịch trình theo đúng hình dạng phương pháp luận của bạn — WBS và critical path, hoặc backlog và release, hoặc một trục milestone với các vòng lặp bên trong.
- **"Ước tính việc này mất bao lâu"** — lăng kính Gauge: một ước tính dạng khoảng với căn cứ nêu rõ, đối chiếu với lesson của chính dự án hoặc một reference class, buffer là dòng riêng nhìn thấy được.
- **"Dựng risk register"** — lăng kính Watch: xác suất × tác động, phân loại ROAM, mỗi rủi ro có chủ sở hữu được nêu tên, và một pre-mortem khi mức độ rủi ro đòi hỏi.
- **"Viết báo cáo tiến độ tuần này"** — lăng kính Pulse: một báo cáo RAG mà mỗi màu đều trích dẫn bằng chứng, tin xấu đi trước, và dự báo phải đối chiếu với lịch sử trễ hẹn.
- **"Deadline bị trễ rồi, giờ sao"** — lăng kính Gate: một đánh giá tác động trên lịch trình/chi phí/rủi ro/chất lượng, chuyển đến đúng người có thẩm quyền quyết định, baseline được giữ nguyên dù kết quả thế nào.
- **"Chuẩn bị họp steering committee"** / **"Theo dõi action từ cuộc họp này"** — lăng kính Bridge: một kế hoạch giao tiếp phân theo tầng stakeholder, hoặc biên bản họp biến thành các action có chủ, có hạn.
- **"Chạy một buổi retro"** / **"Ghi lại lesson từ sprint này"** — lăng kính Loop: một lesson nêu rõ nó sẽ đổi estimate class hay checklist nào, không phải một dòng nhật ký.
- **"Rà soát portfolio dự án của tôi"** — phần mở rộng PMO: một bản tổng hợp trên mọi dự án bạn nêu tên, tô màu theo bằng chứng đáng tin nhất (không phải trung bình), kèm xung đột nguồn lực và khuyến nghị stage-gate để bạn quyết định.

Một yêu cầu một lần cũng được phục vụ chỉn chu mà không cần dựng cả workspace — bạn không cần setup gì to tát chỉ để có một báo cáo trạng thái gọn gàng — nhưng con số vẫn luôn được gắn nhãn kể cả trong một lượt xử lý nhanh.

## Workspace mà skill tạo ra

```bash
bash scripts/init-project.sh "<tên dự án>" [thư-mục-cha]
```

Script này idempotent — an toàn khi chạy lại trên một workspace đã sống nhiều tháng, vì nó không bao giờ ghi đè file đã tồn tại. Nó luôn tạo workspace tại một đường dẫn cố định: `<thư-mục-cha>/_project/`.

```text
_project/
  context/                # sự thật thay đổi chậm, điền dần khi các play cần
    charter.md            # vì sao dự án tồn tại: mục tiêu, scope trong/ngoài, tiêu chí thành công, sponsor
    methodology.md        # predictive / agile / hybrid — lựa chọn + tùy biến + nhịp độ
    team.md                # danh sách nhân sự, vai trò, năng lực, RACI
    stakeholders.md        # bản đồ stakeholder + kế hoạch giao tiếp
    environment.md         # công cụ, lịch, phụ thuộc bên ngoài, ràng buộc
    glossary.md            # từ vựng riêng của dự án
  registers/              # sổ sách sống — thay đổi hàng tuần
    risks.md               # R# xác suất × tác động, ROAM, chủ sở hữu, trigger
    decisions.md            # nhật ký quyết định chỉ-thêm-không-sửa — xương sống khi quay lại
    changes.md              # CH# thay đổi scope/ngày/ngân sách kèm tác động + quyết định
    actions.md              # AC# action item với chủ, hạn, nguồn, trạng thái
    assumptions.md          # A# nội dung, căn cứ, khoảng dao động, dùng ở đâu, trạng thái
    lessons.md              # L# lesson plan-vs-actual nuôi ngược vào ước tính tương lai
    evidence.md             # EV# sổ đăng ký sự kiện: demo pass, file export nhận được, ngày đạt mốc
  plan/
    schedule.md            # M# milestone, phụ thuộc, critical path
    estimates.md            # ước tính dạng khoảng với nhãn căn cứ và reference class
    baseline-<date>.md      # bản snapshot đóng băng — giữ lại ở mỗi lần baseline và re-baseline
  status/
    status-<date>.md        # snapshot RAG-kèm-bằng-chứng theo ngày — giữ lại, không bao giờ ghi đè
  state.md                  # play nào đang mở, đang chờ user, phiên làm việc gần nhất
```

**Quay lại rất dễ dàng.** Bước vào một `_project/` đã tồn tại và hỏi bất cứ điều gì — skill sẽ đọc `state.md`, snapshot trạng thái mới nhất, và các quyết định gần đây trước, rồi cho bạn biết mọi thứ đang ở đâu trước khi làm bất cứ điều gì khác: "Milestone M3 đang báo vàng vì trễ hẹn API của vendor (R4, do Priya phụ trách); một change request đang chờ sponsor quyết; ba action đã quá hạn." Nó tin vào file hơn là trí nhớ của chính nó, và sẽ không âm thầm làm lại hay ghi đè công việc bạn đã hoàn thành.

## Phương pháp luận là ngữ cảnh, không phải bản sắc

Skill này mang tính tổng quát; *dự án của bạn* mới là nơi có phương pháp luận. Play `initiate` ghi lại lựa chọn — predictive, agile, hay hybrid — và mỗi play sẽ điều chỉnh hình dạng tài liệu của mình theo đó. Một skill, ba phương ngữ:

| Play | Predictive | Agile | Hybrid |
|------|-----------|-------|--------|
| plan | WBS, lịch trình kiểu Gantt, critical path | backlog, release/sprint, năng lực | trục milestone + vòng lặp bên trong |
| estimate | bottom-up + reference class | dựa trên velocity + reference class | cả hai, đối chiếu lẫn nhau |
| report-status | kiểu milestone/EVM | burnup, chỉ số flow | trục milestone + chi tiết flow |

Các nguyên tắc không bao giờ đổi tùy theo phương ngữ: một biểu đồ burnup agile với velocity bịa ra cũng giả dối y hệt một biểu đồ Gantt với ngày tháng bịa ra.

## Hoạt động cùng các skill đồng hành

Việc triển khai dự án liên tục chạm vào quyết định sản phẩm và những cú đặt cược cấp công ty, nhưng skill này không được xây để tự quyết định cả hai — các skill đồng hành phụ trách phần đó, mỗi cái đều tùy chọn và chỉ được gợi ý một lần:

- **[product-manager](../product-manager/)** — cho câu hỏi ở tầm cao hơn một bậc: *cái gì* nên build hoặc theo thứ tự nào, chứ không phải liệu công việc đã cam kết có về đích đúng hẹn hay không. Roadmap và PRD của nó trở thành input cho `context/charter.md` và `plan/` của skill này, kèm nhãn nguồn. Cài đặt: `npx skills add tronghieu/agent-skills --skill product-manager`
- **[strategy-board](../strategy-board/)** — cho các quyết định ở tầm cao hơn dự án: kill/tiếp tục, tái cấu trúc scope lớn, những cú đặt cược đầu tư cấp portfolio mà một playbook triển khai không nên tự quyết một mình. Khuyến nghị của hội đồng quay lại thành một quyết định được ghi log và có thể kèm một change request. Cài đặt: `npx skills add tronghieu/agent-skills --skill strategy-board`
- **[critical-thinking](../critical-thinking/)** — khi một quyết định dự án mức độ cao đang dựa trên một lập luận còn gây tranh cãi: tuyên bố của vendor, logic của một kế hoạch cứu vãn. Kết luận của cuộc audit được trích dẫn làm bằng chứng trong nhật ký quyết định. Cài đặt: `npx skills add tronghieu/agent-skills --skill critical-thinking`

Nếu một skill đồng hành chưa được cài, skill này chỉ nhắc một lần và, nếu bạn không muốn thêm nó, sẽ tự xoay xở tiếp. Không bao giờ là bắt buộc, luôn là lựa chọn của bạn.

## Cách kích hoạt

Yêu cầu AI agent của bạn những việc như:

```text
Khởi động một dự án mới — redesign app di động, ra mắt quý 3.
```

```text
Dựng risk register cho dự án migration này giúp tôi.
```

```text
Deadline bị trễ hai tuần rồi — tác động thế nào và tôi nên nói gì với sponsor?
```

```text
Viết báo cáo tiến độ tuần này cho steering committee.
```

```text
Quản lý dự án này giúp tôi — chuẩn bị báo cáo tiến độ cho sếp tuần này.
```

```text
プロジェクトのリスクレジスターを作成してください。
```

Skill cũng tự kích hoạt bất cứ khi nào có thư mục `_project/` trong cây làm việc và bạn hỏi bất kỳ điều gì về lịch trình, deadline, rủi ro, trạng thái, scope, ngân sách, hay stakeholder — bạn không bao giờ cần nói "hãy đóng vai project manager" để nó chạy.

## Cài đặt

### 1. Dùng CLI (Khuyến nghị)

```bash
npx skills add tronghieu/agent-skills --skill project-manager
```

### 2. Cài đặt thủ công (Dành cho người không rành kỹ thuật)

1. **Tải về:** Vào thư mục `skills/` trong repository này và tải `project-manager.zip`.
2. **Giải nén & Sao chép:** Giải nén `project-manager.zip` và sao chép thư mục `project-manager` vào một trong các thư mục sau:

**Cho một dự án cụ thể:**
Sao chép thư mục `project-manager` vào `.agents/skills/` hoặc `.claude/skills/` ở thư mục gốc của dự án.

**Toàn cục (dùng cho mọi dự án):**
* **Mac / Linux:** `~/.agents/skills/` hoặc `~/.claude/skills/`
* **Windows:** `%USERPROFILE%\.agents\skills\` hoặc `%USERPROFILE%\.claude\skills\` (thường là `C:\Users\<TênNgườiDùng>`)

## Ví dụ sử dụng

> **Bạn:** Viết báo cáo tiến độ tuần này — chiều nay tôi phải gửi cho steering committee, mà thật lòng M3 đang không ổn lắm.
>
> **Agent:** Trước khi soạn — workspace đang cho thấy M3 tuần trước đã báo vàng vì trễ hẹn API của vendor (`R4`), và chưa có bằng chứng nào cho thấy trễ hẹn đã được giải quyết. Nếu tôi viết xanh, đó sẽ là một báo cáo xanh vỏ đỏ lòng. Tôi nên báo vàng kèm trích dẫn rủi ro vendor, hay có sự kiện gì tôi đang bỏ sót — vendor đã giao hàng từ thứ Ba tuần trước chưa?
>
> **Bạn:** Chưa, vẫn kẹt. Cứ báo cáo trung thực đi.
>
> **Agent:** *(soạn báo cáo: M3 màu vàng, trích dẫn `R4` và ngày cập nhật vendor gần nhất làm bằng chứng; ngày dự báo dời lại kèm căn cứ nêu rõ; hai milestone còn lại giữ màu xanh với bằng chứng riêng; tin xấu dẫn đầu báo cáo, thành tích đi sau)*
>
> Đây là bản nháp — M3 dẫn đầu ở mức vàng với lý do trễ hẹn vendor và ngày dự báo mới, dựa trên `R4` và lịch sử trạng thái có ngày tháng. Tôi đã chạy qua audit của Judge: một phát hiện — độ trễ dự báo chưa phản ánh xu hướng trong sổ lesson của bạn (`L2` từng ghi nhận phụ thuộc vendor là nguồn trễ hẹn lặp lại), nên tôi đã thêm ngữ cảnh đó vào ghi chú rủi ro thay vì coi đây là chuyện đơn lẻ. Đã ghi lại thành snapshot hôm nay trong `status/`, và quyết định báo vàng được lưu trong `decisions.md` kèm điều kiện xem xét lại khi vendor phản hồi.
