# Market Researcher (Nghiên Cứu Thị Trường)

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Skill này biến AI của bạn thành một **chuyên viên nghiên cứu thị trường bàn giấy (desk research) kỷ luật** — kiểu chuyên viên mà mọi con số bạn đều có thể bấm vào để xem nguồn, từ một lượt quét nhanh go/no-go năm phút đến một báo cáo deep dive nhiều phiên làm việc.

## Market Researcher là gì?

Nhờ một chatbot thông thường định lượng quy mô thị trường, bạn sẽ nhận được một con số rất tự tin nhưng không có cách nào kiểm chứng — một con số TAM 4,2 tỷ đô bịa ra trông y hệt một con số thật. Skill này tồn tại để khiến lỗi đó có thể bị phát hiện: nó nhận một câu hỏi thô như "có thị trường cho X không?", "thị trường Y ở Brazil lớn cỡ nào?", hay "chúng tôi có nên ra mắt sản phẩm này ở Indonesia không?" và trả về một báo cáo mà **mọi nhận định có dữ kiện đều truy được về một nguồn đã đăng ký**. Skill hoạt động với bất kỳ thị trường, quốc gia, ngôn ngữ nào — một thị trường ngách 50 triệu đô ở Kenya được áp dụng kỷ luật y hệt một ngành hàng 50 tỷ đô ở Mỹ.

Skill chỉ chạy **nghiên cứu bàn giấy (desk research)**: nguồn web, dữ liệu công khai, tài liệu do bạn cung cấp. Nó thành thật về giới hạn đó — những gì nó tìm hiểu được về khách hàng chỉ là *tín hiệu* và *giả thuyết*, không bao giờ là insight đã được kiểm chứng (xem nguyên tắc bất di bất dịch số 5 bên dưới). Khi bạn cần kiểm chứng khách hàng thật, skill sẽ bàn giao các câu hỏi mở cho nghiên cứu sơ cấp (primary research) thay vì giả vờ trả lời thay.

## Vì Sao Nên Dùng?

- **Không con số nào thiếu nguồn.** Mọi con số đều mang nhãn nguồn `[S#]` trỏ về một dòng trong `sources.md`, hoặc là một ước tính suy ra rõ ràng có công thức và các đầu vào được trích dẫn, hoặc được gắn nhãn `(assumption A#)` (giả định). Một câu khẳng định dữ kiện mà không có nhãn được xem là một lỗi.
- **Dữ kiện lấy từ web, không lấy từ trí nhớ.** Quy mô thị trường, giá cả, động thái đối thủ, quy định pháp lý — đều được nghiên cứu mới mỗi lần. Dữ liệu huấn luyện đã lỗi thời và tệ hơn, nó nghe có vẻ hợp lý về mặt thống kê; nếu không có quyền truy cập web, skill sẽ nói rõ điều đó và dừng lại thay vì viết một bài luận không trích nguồn.
- **Đối chiếu chéo (triangulate), không bao giờ âm thầm lấy trung bình.** Khi hai nguồn hoặc phương pháp đáng tin cậy chênh nhau hơn khoảng 2 lần, báo cáo sẽ nêu rõ sự mâu thuẫn và chẩn đoán nguyên nhân (định nghĩa thị trường khác nhau, năm khác nhau, tiền tệ khác nhau, doanh thu so với GMV) thay vì hòa trộn chúng lại.
- **Được kiểm chứng trước khi giao.** Một lượt rà soát phản biện (skeptic pass) kiểm tra lại các nhận định quan trọng nhất của báo cáo so với nguồn gốc, tính lại mọi ước tính suy ra, và gắn cờ dữ liệu cũ hoặc chỉ dựa trên một nguồn duy nhất — trước khi bạn nhìn thấy báo cáo.
- **Nghiên cứu bàn giấy chỉ cho ra tín hiệu, không phải insight đã kiểm chứng.** Các persona và nhu cầu khách hàng được tạo ra ở đây là giả thuyết để nghiên cứu sơ cấp kiểm định, luôn được gắn nhãn rõ ràng, và luôn kết thúc bằng các câu hỏi mở cho phỏng vấn hoặc thử nghiệm thật.

## Năm Nguyên Tắc Bất Di Bất Dịch

1. **Mọi nhận định đều truy được nguồn** — một nhãn nguồn `[S#]`, một ước tính suy ra có công thức rõ ràng, hoặc một `(assumption)` (giả định) tường minh.
2. **Dữ kiện mới lấy từ web, không lấy từ trí nhớ** — dữ liệu huấn luyện đã cũ không được phép giả làm nghiên cứu.
3. **Đối chiếu chéo; không bao giờ âm thầm lấy trung bình** — mâu thuẫn giữa các nguồn được nêu ra và chẩn đoán, không bị làm mịn đi.
4. **Một lượt kiểm chứng chạy trước khi giao báo cáo** — một người phản biện rà soát lại các nhận định trọng yếu và phép tính.
5. **Nghiên cứu bàn giấy cho ra tín hiệu, không phải insight khách hàng đã kiểm chứng** — persona và nhu cầu là giả thuyết, luôn được gắn nhãn, luôn được bàn giao cho nghiên cứu sơ cấp xác nhận.

## Hai Chế Độ

| | **Quick Scan** (mặc định) | **Deep Dive** (tùy chọn) |
|---|---|---|
| Câu hỏi | "Có đáng để tìm hiểu sâu hơn không?" | "Chúng ta đang bước vào chuyện gì, chính xác thì?" |
| Thời lượng | Một phiên làm việc | Nhiều phiên, có thể tiếp tục dở dang |
| Định lượng quy mô | Một phương pháp + kiểm tra sanity, khoảng ước lượng rộng và trung thực | ≥2 phương pháp, đối chiếu chéo |
| Đối thủ | Xác định 5–10 đối thủ, hồ sơ một dòng | Phân tích sâu top 3–5 |
| Khách hàng | Tín hiệu nhu cầu nổi bật | Khai thác tín hiệu đầy đủ + persona giả thuyết |
| Vĩ mô | Chỉ 2–3 yếu tố giết chết cơ hội / lực đẩy | PESTEL có cấu trúc + xu hướng |
| Đầu ra | Bản tóm tắt go/no-go (~4–8 trang) | Báo cáo theo module |

Agent mặc định chạy Quick Scan và nói rõ điều này ngay từ đầu. Quick Scan chạy với ngân sách cứng khoảng **15 nguồn đã đăng ký cho mỗi lane** — đủ để khoanh vùng câu trả lời, không phải để chốt hạ nó. Deep Dive chạy theo module: bạn chọn những lane quan trọng (định lượng quy mô, đối thủ, nhu cầu, vĩ mô) thay vì chạy đủ cả bốn một cách máy móc, và có thể tiếp tục qua nhiều phiên — chỉ cần gõ `status` ở phiên mới, agent sẽ đọc `state.md` và tiếp tục đúng từ chỗ đã dừng.

## Bốn Lane Nghiên Cứu

| Lane | Cho ra kết quả gì |
|---|---|
| **Thị trường & định lượng quy mô** | TAM/SAM/SOM qua phương pháp bottom-up và/hoặc top-down, khoảng ước lượng đối chiếu chéo gắn với các giả định được đặt tên |
| **Phân tích đối thủ** | Đối thủ trực tiếp, gián tiếp, thay thế, và "giữ nguyên hiện trạng" — phân tầng, lập hồ sơ, đọc định vị cạnh tranh |
| **Tín hiệu nhu cầu** | Jobs-to-be-Done, khai thác điểm đau, tín hiệu sẵn lòng chi trả, persona giả thuyết được gắn nhãn trung thực |
| **Xu hướng & vĩ mô (PESTEL)** | Điều gì trong môi trường hỗ trợ hoặc giết chết cụ thể cơ hội này — không bao giờ là một bài học địa lý chung chung |

Mỗi lane có thể chạy như một subagent song song, với ngân sách nguồn riêng, file kết quả riêng, và một dải id `[S#]` được dành riêng để công việc song song không bị va chạm.

## Hợp Đồng Kết Hợp (Composition Contract): Được Gọi Bởi Các Skill Khác

Market Researcher được thiết kế để các skill và quy trình khác dùng làm cỗ máy nghiên cứu — một hội đồng chiến lược (strategy board) đang xây bộ dữ kiện, một không gian design-thinking đang kiểm định vấn đề, hay bất kỳ quy trình lập product brief nào cần dữ kiện thị trường bên ngoài. Hợp đồng rất đơn giản:

- **Đầu vào:** bên gọi cung cấp câu hỏi nghiên cứu và bối cảnh quyết định, định nghĩa thị trường (hoặc nhờ skill này soạn giúp), chế độ và các lane cần chạy, và một thư mục đích nằm trong không gian làm việc của chính nó.
- **Đầu ra:** skill này ghi vào thư mục đó — nối thêm vào một `sources.md` đã có sẵn và **tiếp tục đánh số `[S#]`, không bao giờ đánh số lại** những gì đã có — cùng với `findings-*.md` và `report.md`, tất cả tuân theo cùng một schema trích dẫn để bên gọi có thể trích `[S#]` trực tiếp mà không cần biết nghiên cứu được thực hiện ra sao.
- **Ranh giới:** skill này trả lời các câu hỏi thị trường bằng nghiên cứu bàn giấy. Nó nói rõ ràng — thay vì cố gồng — khi yêu cầu là nghiên cứu ngoài phạm vi thị trường, hoặc cần nghiên cứu sơ cấp thật với khách hàng.

## Cấu Trúc Workspace Được Tạo Ra

```text
research/market/<topic-slug>/
  sources.md          # sổ đăng ký nguồn: ID, URL, nhà xuất bản, các ngày, độ tin cậy
  findings-sizing.md         # một file kết quả cho mỗi lane đã chạy
  findings-competitors.md
  findings-demand.md
  findings-macro.md
  report.md            # sản phẩm giao: kết luận, các dữ kiện then chốt, lưu ý, câu hỏi mở
  state.md              # chế độ, lane đã xong, trạng thái kiểm chứng — để tiếp tục sau
```

`scripts/init-research.sh` dựng sẵn workspace này (idempotent — không bao giờ ghi đè các file đã tồn tại, nên an toàn khi chạy lại trên workspace của bên gọi đã có sẵn `sources.md`).

## Cách Kích Hoạt

Yêu cầu AI thực hiện các tác vụ như:

```text
Có thị trường cho dịch vụ meal-kit theo gói cho người sống một mình ở Đức không?
```

```text
TAM của phần mềm quản lý chi phí B2B ở Đông Nam Á lớn cỡ nào?
```

```text
Đối thủ của một SaaS kế toán tầm trung ở Canada là ai, và khoảng trống thị trường nằm ở đâu?
```

```text
Nghiên cứu thị trường xe điện hai bánh tại Việt Nam — có đáng để làm không?
```

```text
市場調査をお願いします。日本の高齢者向け配食サービス市場は参入する価値がありますか？
```

Skill được kích hoạt khi có yêu cầu nghiên cứu, định lượng quy mô, kiểm định, hoặc thâm nhập một thị trường, ở bất kỳ ngôn ngữ và quốc gia nào — không cần phải nói đúng cụm từ "nghiên cứu thị trường".

## Cài Đặt

### 1. Dùng CLI (Khuyến nghị)

```bash
npx skills add tronghieu/agent-skills --skill market-researcher
```

### 2. Cài Đặt Thủ Công (Cho người dùng cơ bản)

1. **Tải về:** Truy cập thư mục `skills/` trong kho lưu trữ này và tải file `market-researcher.zip`.
2. **Giải nén & Copy:** Giải nén file `market-researcher.zip` và copy thư mục `market-researcher` vào một trong các vị trí sau:

**Cho một dự án cụ thể:**
Copy thư mục `market-researcher` vào `.agents/skills/` hoặc `.claude/skills/` trong thư mục gốc dự án của bạn.

**Cài đặt toàn cục (Dùng cho mọi dự án):**
* **Mac / Linux:** `~/.agents/skills/` hoặc `~/.claude/skills/`
* **Windows:** `%USERPROFILE%\.agents\skills\` hoặc `%USERPROFILE%\.claude\skills\` (thường là `C:\Users\<Tên_Của_Bạn>`)

## Ví Dụ Sử Dụng

> **Bạn:** Chúng tôi đang cân nhắc ra mắt một SaaS xuất hóa đơn B2B ở Mexico. Thị trường này có đáng theo đuổi không?
>
> **Agent:** Tôi sẽ chạy Quick Scan trước — một lượt đọc rộng, trung thực, trong một phiên làm việc; chúng ta có thể deep-dive vào bất kỳ lane nào trông có tính quyết định. Hỏi nhanh: bạn nhắm tới doanh nghiệp nhỏ, tầm trung, hay cả hai, và đây là chỉ riêng Mexico hay là bàn đạp cho cả LatAm?
>
> *(xác nhận khung câu hỏi, khởi tạo workspace, chạy các lane định lượng quy mô / đối thủ / nhu cầu / vĩ mô — mỗi lane đọc nguồn web mới, gắn nhãn mọi nhận định, đăng ký nguồn với id `[S#]`)*
>
> **Agent:** Kết luận: **nên làm, với độ tin cậy trung bình.** Phân khúc SMB chính thức ở Mexico có quy mô đáng kể và chưa được các đơn vị nội địa phục vụ tốt [S4][S11], nhưng tín hiệu sẵn lòng chi trả mạnh nhất lại đến từ các doanh nghiệp *đã* dùng một phần mềm xuất hóa đơn nào đó [S9] — tín hiệu về nhóm đa số thuộc khu vực phi chính thức mà bạn cần chuyển đổi thì mỏng hơn nhiều. Lưu ý lớn nhất từ bước kiểm chứng: hai trong ba con số quy mô thị trường đều truy về cùng một chuỗi báo cáo của một nhà cung cấp [S3][S7], nên cẩn trọng với cận trên của khoảng ước lượng. Báo cáo đầy đủ, nguồn trích dẫn và câu hỏi mở cho nghiên cứu sơ cấp nằm trong `research/market/mx-invoicing-saas/report.md`.
