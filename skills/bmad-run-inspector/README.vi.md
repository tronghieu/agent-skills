# BMAD Run Inspector

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Đọc xem một lượt chạy code tự động của `bmad-loop` thực sự đã làm gì — và từ chối trả lời dựa vào đúng cái file hay nói dối.

```bash
npx skills add tronghieu/agent-skills --skill bmad-run-inspector
```

## Bắt đầu nhanh

```text
Loop có còn đang chạy không, và nó có bị kẹt không?
```

```text
Lượt chạy bmad-loop tối qua đã làm gì? Vì sao story auth-3 fail?
```

```text
Token của lượt chạy này đã đi đâu?
```

```text
Lượt chạy đã pause. Nó đang chờ gì, và tôi cần chạy lệnh gì tiếp theo?
```

## Vì sao không chỉ grep log?

`bmad-loop` chạy coding CLI bên trong một pane tmux hoặc psmux và capture lại pane đó, nên file lớn nhất trong một run directory — `logs/<task-id>.log` — là một video tuần tự hóa của màn hình, không phải một bản transcript. Các dòng bị vẽ lại (repaint) hàng trăm lần khi đang gõ, khoảng trắng bị mất giữa các lần vẽ lại, và output dài của tool bị thu gọn phía sau `… +N lines (ctrl+o to expand)` — và không bao giờ được vẽ ra cả.

Bản tóm tắt kết quả test nằm chính trong những khối bị thu gọn đó. `grep` log tìm `FAIL` hay `passed` sẽ ra kết quả sạch sẽ — đọc lên tưởng là một lượt chạy xanh (pass), nhưng thực ra đó là một file chưa từng nhận được bằng chứng. Đó chính là cái bẫy mà skill này tồn tại để tránh: nó không bao giờ báo pass/fail dựa trên log, mà chỉ ra đúng những nguồn có thể thực sự trả lời được câu hỏi đó — journal có cấu trúc của run, machine state của nó, hoặc tự bạn chạy lại lệnh verify.

## Skill này dành cho ai

Dành cho bất kỳ ai đang điều khiển `bmad-loop` và cần một cái nhìn trung thực về một run: đang theo dõi một run còn sống ("nó có bị kẹt không, có cần lo không?"), hoặc đang điều tra pháp y (forensics) một run đã hoàn tất, fail, hay pause qua đêm ("chuyện gì đã xảy ra, token đi đâu, vì sao story này fail?").

## Cách làm việc

1. **Xác định trước CLI và stack của repo.** Các heuristic đọc log ở những bước dưới đây là stack-specific và fail âm thầm, nên trước khi đọc bất cứ thứ gì, skill xác nhận coding CLI nào đang lái pane và repo này chạy stack gì, dựa vào `_project/bmad-loop/environment.toml` (các giá trị) và `environment.md` (bối cảnh, các phán đoán đã chốt). Nếu một giá trị còn đánh dấu `TODO(confirm: …)`, skill hỏi lại thay vì đoán — một `coding_cli` sai khiến bộ trích xuất không khớp được gì mà vẫn trả về một kết quả đọc lên tưởng sạch.
2. **Probe trạng thái.** `scripts/run_probe.py` đọc trực tiếp `state.json` và `journal.jsonl` — không parse log — và báo cáo health flags, phase/attempt/review-cycle của từng story, tuổi của heartbeat, cùng các finding được xếp theo ba mức độ nghiêm trọng. Nó tự chụp lại snapshot của chính mình để lượt probe tiếp theo có thể báo cáo điều gì đã thay đổi — đó chính là điều phân biệt "đang chạy" với "bị treo".
3. **Dựng lại diễn biến, một cách cẩn trọng.** `scripts/extract_transcript.py` loại bỏ các mã escape của terminal và dựng lại từng dòng logic từ biến thể được vẽ lại (repaint) dài nhất của nó, rút gọn một bản capture nhiều megabyte xuống còn vài chục dòng đã được phân loại: tool call, chi phí subagent, kết quả streaming, văn bản thường, và bộ đếm tiến độ (progress counter) riêng của CLI. Một lượt chạy với `--collapsed` báo cáo bao nhiêu phần của story không thể đọc được về mặt cấu trúc, để con số đó có thể được trích dẫn thẳng thay vì phải nói vòng vo (hedge).
4. **Đối chiếu chéo với working tree.** Log cho biết agent đã thử làm gì; git cho biết cái gì thực sự đã được đưa vào. Diff so với baseline commit đã ghi nhận của story sẽ bắt được khoảng cách giữa một agent thực sự viết code và một agent chỉ tường thuật lại việc viết code.
5. **Đọc đúng phán quyết thật.** `session-end.status` trông như là câu trả lời nhưng không phải — nó chỉ cho biết phiên CLI kết thúc như thế nào, không cho biết công việc có được chấp nhận hay không. Kết quả thật nằm ở `dev-decision.action`, loại journal kết thúc (`story-done`, `story-deferred`, `story-escalated`, `story-awaiting-operator`), và phase kết thúc của story, theo đúng thứ tự đó. Nếu người dùng cần các assertion thất bại thực tế, skill sẽ chạy lại lệnh verify thay vì đoán từ journal. Riêng escalation cần thêm một bước: bmad-loop cắt lý do escalation ở mốc 2.000 ký tự, và mọi bản sao trong thư mục run đều bị cắt y hệt, nên skill đọc phần kết quả trong spec của story thay vì giải thích lần pause đó bằng một notice đã bị cắt.

## Bạn sẽ nhận được gì

Một lượt kiểm tra theo dõi trực tiếp (live-watch) không phát hiện vấn đề gì chỉ dài một hai dòng — không phải một bức tường chữ xanh khiến bạn quen dần với việc ngừng đọc. Khi có điều cần chú ý, báo cáo mở đầu bằng trạng thái hiện tại (story, phase, attempt, thời gian đã trôi qua), những gì đã thay đổi kể từ lần kiểm tra trước, finding kèm bằng chứng, và lệnh chính xác cần chạy tiếp theo.

Các finding được xếp hạng theo mức độ khẩn cấp, không theo thứ tự phát hiện:

| Mức | Ví dụ | Cách xử lý thường gặp |
| --- | --- | --- |
| **1 — cần người can thiệp ngay** | Engine bị crash, một run pause vì escalation, engine pid đã chết, có notice `ATTENTION` mới hoặc chưa được giải quyết | `bmad-loop resolve <run-id>`, `bmad-loop resume <run-id>`, hoặc `bmad-loop diagnose` |
| **2 — sắp fail** | Attempt dev cuối cùng trước khi chạm cap của story, review cycle không hội tụ, heartbeat đã cũ, session budget gần cạn giữa lúc đang implement | Theo dõi sát; can thiệp trước khi lượt fail tự động tiếp theo xảy ra |
| **3 — mục ruỗng âm thầm** | Log vẫn tăng trong khi progress counter đứng yên và không có gì mới đang stream, các tool call giống hệt nhau lặp lại, deferred-work ledger phình to trong khi sweep đang bị tắt | So sánh hai lượt probe; không gì khác trong run tự lộ ra những điều này |

Mức 3 chính là lý do skill này tồn tại: mức 1 và 2 đã hiện sẵn trong `bmad-loop tui`; mức 3 chỉ hiện ra với thứ gì đó đọc artifact và so sánh chúng theo thời gian.

## Giới hạn

Skill này cần `bmad-loop` và đọc trực tiếp các run directory của nó — nó không có tác dụng gì ngoài một project đang chạy `bmad-loop`. Các heuristic đọc log trong `extract_transcript.py` được pattern-match theo giao diện terminal của một coding CLI cụ thể (từ vựng spinner của nó, ký hiệu tool-call `⏺` của nó, marker thu gọn của nó) và theo log từ các project chạy một test stack cụ thể. Trỏ nó vào một coding CLI khác bên trong `bmad-loop` và nó sẽ không báo lỗi — nó suy giảm âm thầm, khớp được ít pattern hơn hoặc không khớp được pattern nào của một phần, trong khi vẫn trả về một kết quả — đọc lên tưởng là một run sạch nhưng không phải vậy. Nếu một phần trông mỏng một cách khó tin, hãy đối chiếu lại `_project/bmad-loop/environment.toml` và `environment.md` — nơi coding CLI và stack thực tế của repo được ghi nhận và xác nhận — trước khi tin vào output; adapter làm giảm rủi ro lệch âm thầm chứ không loại bỏ hết, vì các hằng số matching của bộ trích xuất vẫn chỉ là pattern cố định (literal).

Nó cũng không thể cho bạn biết test có pass hay không — không gì làm được điều đó, chỉ từ file này. Phán quyết đến từ journal và working tree, hoặc từ việc tự bạn chạy lại verify.
