# Hội Đồng Chiến Lược (Strategy Board)

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Skill này biến AI của bạn thành một **hội đồng cố vấn chiến lược cấp C**, gồm các chuyên gia được đặt tên theo những bộ óc lớn nhất ngành chiến lược, đưa bạn từ một câu hỏi chiến lược thô sơ đến một khuyến nghị đã được bảo vệ, sẵn sàng trình hội đồng quản trị.

## Strategy Board là gì?

Thay vì nhờ một chatbot thông thường "nghĩ giúp về chiến lược", bạn triệu tập cả một hội đồng. **Drucker** dẫn dắt với vai trò đối tác điều hành — xác định đúng câu hỏi thật sự, phân công chuyên gia phù hợp, và giữ mạch xuyên suốt cả dự án — trong khi **bảy chuyên gia** mỗi người phụ trách một lăng kính riêng: thị trường, đổi mới, tài chính, thực thi, kịch bản tương lai, rủi ro, và tổng hợp trình bày. Mỗi vai trò thu hẹp sự tập trung để một đánh giá được làm thật kỹ: một nhà phân tích đồng thời đi bán ý tưởng sẽ có xu hướng làm mềm số liệu; một người lạc quan kiêm luôn vai trò kiểm soát rủi ro sẽ không bao giờ tìm ra điểm chí mạng. Các lăng kính khác biệt, được đặt va chạm với nhau một cách có tổ chức, chính là điều khiến một hội đồng tốt hơn một cố vấn đơn lẻ.

**Bạn luôn là người ra quyết định.** Hội đồng nghiên cứu, phân tích, tranh luận và đề xuất — nhưng không bao giờ quyết định thay bạn. Mỗi dự án tư vấn kết thúc bằng việc trao lại một lựa chọn rõ ràng cho người chịu trách nhiệm về kết quả.

## Vì sao nên dùng?

- **Không bịa số liệu.** Mọi con số trong kết quả đầu ra đều có nguồn trích dẫn hoặc được gắn nhãn rõ ràng là `(assumption)` (giả định). Một con số bịa ra một cách tự tin chính là lỗi tệ nhất của một cố vấn chiến lược AI — skill này được thiết kế để từ chối lối tắt đó.
- **Dữ kiện trước, phân tích sau.** Hội đồng xây dựng bộ dữ kiện có nguồn trước khi chạy bất kỳ khung phân tích nào, để các mô hình không bị áp lên những phỏng đoán.
- **Luôn có ba phương án thật sự.** Không bao giờ chỉ có một khuyến nghị được ngụy trang thành "lựa chọn" — luôn có ba hướng đi khác biệt mà một thành viên hội đồng có lý trí có thể bảo vệ, kể cả phương án "không làm gì" nếu điều đó trung thực.
- **Luôn được phản biện trước khi trình bày.** Mọi khuyến nghị đều đi qua Taleb hoặc một buổi pre-mortem trước khi đến tay bạn.
- **Chiến lược là sự đánh đổi.** Mọi khuyến nghị đều nêu rõ tổ chức sẽ *ngừng làm gì* — một chiến lược không có sự hy sinh nào chỉ là một danh sách ước muốn.
- **Boardroom ("chế độ họp toàn thể").** Với những quyết định còn nhiều bất đồng thực sự, triệu tập 3–4 thành viên để tranh luận về một câu hỏi sắc bén — mỗi người nêu quan điểm độc lập trước, sau đó mới đối thoại chéo — và luôn có biên bản lưu lại.

## Đội Ngũ Hội Đồng

**Drucker** — *Peter Drucker.* Đối tác điều hành: xác định đúng câu hỏi thật sự, phân công chuyên gia, giữ nhật ký quyết định. Bản thân Drucker không bao giờ tự làm phân tích chuyên môn.

| Thành viên | Tôn vinh | Lăng kính |
|--------|---------|------|
| **Porter** | Michael Porter | Thị trường & cạnh tranh — cấu trúc ngành, định vị |
| **Christensen** | Clayton Christensen | Đổi mới & phá vỡ thị trường — jobs-to-be-done, ba chân trời |
| **Graham** | Benjamin Graham | Tài chính & giá trị — định lượng quy mô, kinh tế đơn vị, độ nhạy |
| **Grove** | Andy Grove | Thực thi & tổ chức — năng lực, mô hình vận hành |
| **Wack** | Pierre Wack | Kịch bản & bất định — các viễn cảnh tương lai, "điều gì phải đúng" |
| **Taleb** | Nassim Taleb | Đội phản biện & rủi ro — pre-mortem, giả định dễ vỡ |
| **Minto** | Barbara Minto | Tổng hợp & trình bày — kim tự tháp, bản trình hội đồng quản trị |

## Quy Trình Tư Vấn (Engagement Pipeline)

Với một quyết định thực tế đang cần giải quyết, hội đồng chạy theo một quy trình có các "cổng chắn" (gate) — mỗi giai đoạn cho ra một kết quả cụ thể, và ba cổng chắn dừng lại chờ bạn xác nhận rõ ràng mới được đi tiếp:

1. **Brief** — Drucker biến yêu cầu của bạn thành một câu hỏi quyết định đã được xác nhận. ⛔ *Cổng: bạn xác nhận nó.*
2. **Fact base** — hội đồng nghiên cứu các dữ kiện, mọi con số đều có nguồn.
3. **Analysis** — các chuyên gia liên quan xem xét quyết định qua lăng kính riêng của mình.
4. **Options** — ba hướng đi thật sự, được so sánh trung thực. ⛔ *Cổng: bạn chọn một.*
5. **Stress-test** — Taleb cố tìm cách "đánh sập" hướng đi đã chọn trước khi thực tế làm điều đó.
6. **Recommendation** — Minto viết thành văn bản, trả lời trước. ⛔ *Cổng: bạn phê duyệt.*
7. **Roadmap** — Grove biến lựa chọn đã được phê duyệt thành người phụ trách, mốc thời gian, và những gì sẽ bị dừng lại để đánh đổi.

Không phải dự án nào cũng cần chạy đầy đủ mọi giai đoạn ở mức sâu nhất — Drucker sẽ đề xuất một kế hoạch vừa đủ và bạn có thể cắt gọt. Những thứ không bao giờ bị cắt: kỷ luật trích nguồn, ba phương án, buổi pre-mortem, và các cổng chắn.

Với một yêu cầu phân tích đơn lẻ ("định lượng quy mô thị trường này", "chạy pre-mortem cho kế hoạch này"), hội đồng bỏ qua quy trình đầy đủ và phân công thẳng chuyên gia phù hợp — các quy tắc về trích nguồn và tính nghiêm ngặt vẫn được áp dụng.

## Cách Tổ Chức Một Cuộc Thảo Luận Chiến Lược

Bạn là người điều hành; hội đồng làm việc cho bạn. Một dự án tư vấn đầy đủ đi qua bảy giai đoạn, nhưng phần việc của bạn ở mỗi giai đoạn đều nhỏ gọn và cụ thể:

1. **Đưa ra quyết định cần bàn.** Nêu nó bằng lời lẽ đơn giản — "chúng ta có nên thâm nhập X không?", "tự xây hay mua Y?". Không cần chuẩn bị gì cả; Drucker sẽ mở đầu dự án.
2. **Trả lời các câu hỏi xác định phạm vi (Phase 0).** Drucker sẽ dò hỏi để tìm ra câu hỏi thật sự, thời hạn, phạm vi, các ràng buộc, và khẩu vị rủi ro của bạn, sau đó chẩn đoán môi trường chiến lược (Strategy Palette) và đề xuất một kế hoạch vừa đủ. **Cổng 1 — bạn xác nhận câu hỏi** trước khi bất kỳ phân tích nào được thực hiện.
3. **Cung cấp những gì chỉ bạn mới biết (Phase 1).** Hội đồng nghiên cứu dữ liệu thị trường có trích nguồn; còn các con số nội bộ, năng lực đội ngũ, và thực tế chính trị nội bộ phải do bạn cung cấp. Những gì bạn không thể cung cấp sẽ trở thành một giả định được gọi tên rõ ràng — không bao giờ là một phỏng đoán âm thầm.
4. **Đọc phần "Vậy thì sao" (Phase 2).** Các chuyên gia chạy lăng kính của mình, mỗi người tự đưa ra phân tích riêng. Ở mỗi điểm dừng, bạn sẽ được đưa ra một thực đơn lựa chọn: tinh chỉnh / đào sâu hơn / phản biện nó (gửi cho Taleb) / tiếp tục.
5. **Chọn một hướng đi (Phase 3).** Hội đồng trình bày ba phương án thật sự trong cùng một bảng trung thực. Nếu đội của bạn đang chia phe, hãy mở một phiên Boardroom và xem các thành viên tranh luận. **Cổng 2 — lựa chọn là của bạn**, được ghi lại cùng với các phương án bị loại.
6. **Để nó bị công kích (Phase 4).** Buổi pre-mortem của Taleb giả định rằng hướng đi bạn đã chọn đã thất bại và giải thích vì sao. Bạn là người quyết định rủi ro nào cần giảm thiểu và rủi ro nào sẽ chủ động chấp nhận.
7. **Phê duyệt và triển khai (Phase 5–6).** Minto nén tất cả thành một khuyến nghị theo kiểu "trả lời trước" — **Cổng 3 — bạn phê duyệt nó** — sau đó Grove biến nó thành một roadmap với người phụ trách, mốc thời gian, và những gì sẽ bị dừng lại để đánh đổi.

Đường tắt ngắn hơn: với một yêu cầu phân tích đơn lẻ ("định lượng quy mô thị trường này"), chỉ cần hỏi — chuyên gia phù hợp sẽ giao nó dưới dạng một bản ghi chú tự thân, đầy đủ. Để tiếp tục một dự án đang tạm dừng trong một phiên làm việc mới, hãy gõ `status` — hội đồng sẽ đọc lại ghi chú của mình và tiếp tục đúng từ chỗ bạn đã dừng.

## Boardroom (Chế Độ Họp Toàn Thể)

Quy trình chuẩn xử lý từng chuyên gia một tại một thời điểm — phù hợp cho công việc sản xuất tài liệu. **Boardroom** dành cho những quyết định còn bất đồng thực sự: Drucker mời 3–4 thành viên liên quan ngồi lại quanh một câu hỏi sắc bén, thu thập quan điểm độc lập của từng người trước (để tránh tư duy bầy đàn), sau đó mới cho họ đối thoại chéo trong khi bạn điều hướng cuộc họp. Mỗi phiên kết thúc bằng biên bản và một quyết định được ghi lại. Boardroom thường được đề xuất tự nhiên ở giai đoạn tranh luận phương án (Phase 3), và luôn được chạy — dưới dạng phản biện pre-mortem — trước khi bất kỳ khuyến nghị nào được trình bày (Phase 4).

## Năm Nguyên Tắc Bất Di Bất Dịch

1. **Không bịa số liệu** — mọi con số đều có nguồn hoặc được gắn nhãn `(assumption)`.
2. **Dữ kiện trước phân tích** — bộ dữ kiện phải có trước khi chạy bất kỳ khung phân tích nào.
3. **Ba phương án thật sự trước khi đưa ra khuyến nghị** — không phải một phương án thật với hai phương án làm nền.
4. **Mọi khuyến nghị đều bị phản biện** trước khi trình bày.
5. **Chiến lược là sự đánh đổi** — mọi khuyến nghị đều nêu rõ tổ chức sẽ ngừng làm gì.

Và phép thử thường trực cho mọi phần phân tích: *"Vậy thì sao?"* ("So what?") — nếu một phần không làm thay đổi quyết định, nó sẽ bị cắt bỏ.

## Cách Kích Hoạt

Yêu cầu AI thực hiện các tác vụ như:

```text
Chúng ta nên tự xây hệ thống quản lý kho hay mua sẵn? Triệu tập hội đồng chiến lược giúp tôi.
```

```text
Nhờ Porter phân tích Five Forces cho thị trường gọi xe công nghệ ở Việt Nam.
```

```text
Chúng tôi đang có ba phương án để thâm nhập thị trường Campuchia và cả team đang chia phe. Mở một phiên Boardroom giúp tôi.
```

## Không Gì Bị Thất Lạc

Hội đồng ghi lại mọi thứ trong quá trình làm việc — bản brief, các dữ kiện kèm nguồn, phân tích của từng chuyên gia, các phương án, biên bản họp, bản khuyến nghị, roadmap, và một nhật ký ghi lại liên tục mọi quyết định cùng lý do đằng sau nó. Tất cả được lưu trong một thư mục duy nhất trong không gian làm việc của bạn, để bạn có thể đóng cuộc trò chuyện bất cứ lúc nào và tiếp tục đúng từ chỗ đã dừng — ở một phiên làm việc sau, chỉ cần hỏi `status`.

## Skill Nghiên Cứu Thị Trường Tùy Chọn

Khi một dự án chiến lược cần nghiên cứu sâu hơn về quy mô thị trường, đối thủ cạnh tranh, tín hiệu nhu cầu hoặc xu hướng vĩ mô, Strategy Board sẽ đề xuất skill [Market Researcher](https://github.com/tronghieu/agent-skills#market-researcher) như một công cụ bổ trợ tùy chọn. Skill này có thể xây dựng bộ dữ kiện bên ngoài có khả năng truy nguyên để hội đồng sử dụng trực tiếp.

Quyền lựa chọn luôn thuộc về bạn: đây là đề xuất, không phải yêu cầu bắt buộc. Bạn có thể cài và sử dụng skill này, hoặc tiếp tục với quy trình nghiên cứu có sẵn của Strategy Board.

```bash
npx skills add tronghieu/agent-skills --skill market-researcher
```

## Cài Đặt

### 1. Dùng CLI (Khuyến nghị)

```bash
npx skills add tronghieu/agent-skills --skill strategy-board
```

### 2. Cài Đặt Thủ Công (Cho người dùng cơ bản)

1. **Tải về:** Truy cập thư mục `skills/` trong kho lưu trữ này và tải file `strategy-board.zip`.
2. **Giải nén & Copy:** Giải nén file `strategy-board.zip` và copy thư mục `strategy-board` vào một trong các vị trí sau:

**Cho một dự án cụ thể:**
Copy thư mục `strategy-board` vào `.agents/skills/` hoặc `.claude/skills/` trong thư mục gốc dự án của bạn.

**Cài đặt toàn cục (Dùng cho mọi dự án):**
* **Mac / Linux:** `~/.agents/skills/` hoặc `~/.claude/skills/`
* **Windows:** `%USERPROFILE%\.agents\skills\` hoặc `%USERPROFILE%\.claude\skills\` (thường là `C:\Users\<Tên_Của_Bạn>`)

## Ví Dụ Sử Dụng

> **Bạn:** Chúng tôi đang cân nhắc mở rộng sản phẩm SaaS sang thị trường EU vào năm sau. Hội đồng xem giúp được không?
>
> **Drucker:** Trước khi phân công cho ai, tôi cần làm rõ — câu hỏi thật sự là "có nên mở rộng sang EU không", hay là "tăng trưởng trong nước đang chậm lại và EU trông như đòn bẩy nhanh nhất"? Điều này đáng làm rõ vì nó sẽ quyết định chúng ta cần nghiên cứu gì. [đặt vài câu hỏi ngắn để xác định phạm vi, sau đó soạn bản brief]
>
> *(Cổng 1 — bạn xác nhận cách đặt vấn đề.)*
>
> **Drucker:** Tôi sẽ phân công Porter phân tích cấu trúc thị trường và Graham định lượng quy mô cơ sở — hai việc này có thể chạy song song. [các chuyên gia làm việc dựa trên bộ dữ kiện, mỗi người tạo ra một phân tích có trích nguồn]
>
> **Drucker:** Hiện có ba phương án: thâm nhập trực tiếp, hợp tác qua nhà phân phối, hoặc chờ 12 tháng để xây bàn đạp tại Anh trước. Vì nhận định của Porter và số liệu của Graham đang lệch nhau, anh/chị có muốn mở một phiên Boardroom trước khi chọn không?
>
> *(Boardroom triệu tập Porter, Graham, Grove và Taleb; mỗi người nêu quan điểm độc lập trước, sau đó đối thoại chéo; bạn điều hướng cuộc họp; biên bản được lưu lại.)*
>
> *(Cổng 2 — bạn chọn hướng đi.)* → Taleb chạy pre-mortem → Minto soạn bản khuyến nghị → *(Cổng 3 — bạn phê duyệt)* → Grove chuyển thành roadmap.
