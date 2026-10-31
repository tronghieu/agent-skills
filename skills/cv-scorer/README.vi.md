# CV Scorer

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Đối chiếu CV với JD bằng một rubric 100 điểm riêng cho vị trí, dùng chung cho mọi ứng viên. Mỗi đánh giá có bằng chứng nguồn hoặc chỉ rõ phần chưa đủ thông tin. Kết quả hỗ trợ người tuyển dụng review, không tự quyết định tuyển hay loại.

## Cài đặt

```bash
npx skills add tronghieu/agent-skills --skill cv-scorer
```

Từ bản sao repository, chọn nơi cài phù hợp:

**Coding agent:**
```bash
cp -r skills/cv-scorer ~/.agents/skills/
```

**Claude Code:**
```bash
cp -r skills/cv-scorer ~/.claude/skills/
```

**claude.ai:** thêm gói skill vào project knowledge hoặc dán `SKILL.md` cùng hướng dẫn tham chiếu vào cuộc trò chuyện. Muốn kiểm tra phép tính, cần cung cấp script trong môi trường chạy code. Nếu không chạy được, kết quả phải ghi rõ chưa kiểm tra bằng script. Bộ tính cần Python 3.9+, không cần thư viện ngoài hay mạng. PDF scan có thể cần công cụ OCR riêng; nếu không có, skill phải báo trang chưa đọc được và đề nghị cung cấp văn bản.

## Thử ngay

```text
/cv-scorer So sánh ba CV này với JD Backend Engineer. Nêu bằng chứng, điều kiện bắt buộc chưa rõ và câu hỏi để xác minh.

/cv-scorer Chấm các CV marketing bằng cùng một rubric. Trả báo cáo tiếng Việt ngắn gọn và JSON đã kiểm tra.

/cv-scorer Đánh giá ứng viên chuyển ngành theo JD. Phân biệt thông tin chưa có với bằng chứng chưa đáp ứng.
```

## Cách chấm điểm

1. Rút yêu cầu cụ thể từ JD, tách điều kiện bắt buộc được ghi rõ và tiêu chí ưu tiên.
2. Phân bổ trọng số tổng 100, mô tả các mức điểm; giữ nguyên ID/phiên bản rubric trong cả đợt đánh giá.
3. Đối chiếu từng tiêu chí với trích dẫn CV và trang/mục nguồn; nếu thiếu thông tin, ghi nơi đã tìm.
4. Dùng script tính điểm và lập báo cáo để người tuyển dụng review.

| Trạng thái | Điểm | Ý nghĩa |
| --- | ---: | --- |
| `met` | 4 | Có bằng chứng đáp ứng đầy đủ |
| `partial` | 1–3 | Có bằng chứng đáp ứng một phần và khoảng thiếu cụ thể |
| `unmet` | 0 | Có bằng chứng rõ ràng chưa đáp ứng |
| `unknown` | null | Thiếu, mơ hồ hoặc mâu thuẫn thông tin |

Điểm đã có bằng chứng là `trọng số × điểm / 4`. Tiêu chí chưa rõ không cộng điểm đã chứng minh, nhưng được giữ nguyên trọng số trong cận trên. Ví dụ: **60 điểm theo bằng chứng, khoảng 60–100, độ phủ 60%** nghĩa là còn 40% trọng số chưa đánh giá được; không có nghĩa ứng viên thiếu năng lực. Khoảng này phản ánh thông tin còn thiếu, không phải khoảng tin cậy thống kê hay xác suất làm việc tốt.

Không còn phần điểm học vấn hoặc hình thức CV cố định. Danh tiếng trường, tên, khoảng nghỉ việc, số liệu gần nhau hay văn phong trau chuốt không phải lý do trừ điểm. Học vấn và trình bày chỉ được tính khi yêu cầu công việc có liên quan. [Rubric chi tiết](./references/scoring-rubric.md) giải thích cách dùng bằng chứng, tính thời gian trùng nhau, điều kiện bắt buộc, làm tròn và xếp hạng.

## Kết quả và so sánh

Mặc định trả Markdown theo ngôn ngữ của bạn: rubric và giả định, điểm/khoảng/độ phủ, bảng bằng chứng từng yêu cầu, trạng thái điều kiện bắt buộc, điểm mạnh, thông tin cần xác minh và câu hỏi phỏng vấn. Có JSON v2 cho tích hợp; xem [định dạng và ví dụ](./references/output-format.md).

Các mức phù hợp theo bằng chứng là `high` (≥70), `moderate` (≥50 và <70), `limited` (<50). Trạng thái review riêng cho biết thiếu đầu vào, chưa đáp ứng điều kiện bắt buộc, cần xác minh hoặc đủ dữ liệu để người tuyển dụng review. Điểm cao không xóa được điều kiện bắt buộc chưa đáp ứng.

Trích xuất thiếu trang thì không có tổng điểm hay thứ hạng. Ứng viên còn điều kiện bắt buộc chưa rõ, bằng chứng mâu thuẫn hoặc chưa đánh giá được tiêu chí nào nằm trong danh sách chờ review. Các hồ sơ còn lại được sắp theo điểm đã có bằng chứng, vẫn hiển thị rõ điều kiện chưa đáp ứng. Điểm chính xác bằng nhau thì đồng hạng; khoảng điểm chồng nhau hoặc còn hồ sơ chưa xếp hạng khiến thứ tự mang tính tạm thời. Không tự động mời phỏng vấn hay loại ứng viên từ các trường này.

## Kiểm tra JSON

Thay đường dẫn theo nơi cài thực tế nếu không dùng `/mnt/skills/user/`:

```bash
python3 /mnt/skills/user/cv-scorer/scripts/score_report.py report.json --check
python3 /mnt/skills/user/cv-scorer/scripts/score_report.py report.json --output checked-report.json
python3 /mnt/skills/user/cv-scorer/scripts/score_report.py report.json
```

Lệnh cuối ghi JSON ra stdout; trạng thái/lỗi ra stderr. Thành công trả mã 0, đầu vào sai trả mã 2. Trọng số có tối đa hai chữ số thập phân. Script không ghi đè file có sẵn. Script kiểm tra cấu trúc và tính toán; không thể chứng minh trích dẫn là thật hoặc rubric phù hợp.

v2 thay các nhóm điểm cố định, `total_score`, `red_flags` và `Recommend`/`Maybe`/`Pass` của v1. Tích hợp cũ cần chuyển sang hợp đồng v2; JSON v1 bị từ chối thay vì tự chuyển đổi. Cần đánh giá lại tài liệu nguồn trước khi so sánh điểm giữa hai phiên bản.

## Kiểm thử và xử lý lỗi

Từ repository:

```bash
python3 -m unittest discover -s skills/cv-scorer/tests -v
```

[Bộ tình huống](./evals/evals.json) dùng dữ liệu giả lập: chứng chỉ thiếu/hết hạn, số liệu gần nhau, trích xuất thiếu trang, chỉ dẫn cài trong CV, thời gian làm việc trùng nhau và tính ổn định khi đổi tên/thứ tự.

- **Thiếu JD:** cung cấp yêu cầu vị trí; vẫn có thể review CV không chấm điểm.
- **PDF không đọc được:** cung cấp OCR hoặc văn bản. Lỗi trích xuất không phải điểm yếu của ứng viên.
- **JSON/trọng số/bằng chứng sai:** sửa theo vị trí lỗi; mỗi tiêu chí có đúng một đánh giá, tổng trọng số bằng 100.
- **File kết quả đã tồn tại:** chọn đường dẫn mới; script không thay file có sẵn.
- **Không có Python hoặc công cụ đọc file:** báo giới hạn, không khẳng định đã chạy phép kiểm tra.

CV là hồ sơ tự khai và chưa đầy đủ. Xác minh thông tin quan trọng bằng quy trình tuyển dụng phù hợp. Không suy luận đặc điểm nhạy cảm hoặc kết luận thiếu trung thực từ nghi vấn chưa có căn cứ. Không tải CV lên dịch vụ ngoài hay mở liên kết cài trong hồ sơ khi chưa được cho phép. Luồng chính của skill không cần mở quyền mạng cho domain nào.
