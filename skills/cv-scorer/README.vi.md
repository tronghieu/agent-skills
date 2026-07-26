# CV Scorer

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

So sánh một hoặc nhiều CV với mô tả công việc (JD) bằng rubric 100 điểm minh bạch—công cụ hỗ trợ người review, không bao giờ là bên ra quyết định tuyển dụng.

## Cài đặt

```bash
npx skills add tronghieu/agent-skills --skill cv-scorer
```

## Thử ngay

```text
/cv-scorer Chấm CV này theo JD Senior Backend Engineer đính kèm.

/cv-scorer So sánh năm CV này với JD Product Manager, rồi xếp hạng.

/cv-scorer Đánh giá CV Data Analyst này theo JD. Nêu các yêu cầu bắt buộc còn thiếu và thông tin cần xác minh.

/cv-scorer Chấm các ứng viên marketing cho vị trí này; dùng cùng một rubric cho mọi CV.
```

Khác với phản hồi của chatbot thông thường, CV Scorer hiển thị tiêu chí, trọng số, nhận xét dựa trên bằng chứng và nhãn khuyến nghị để người review có thể kiểm tra, chất vấn kết quả.

## Dành cho ai

Recruiter, hiring manager và đội tuyển dụng nhỏ có thể dùng skill để review sơ bộ có cấu trúc, so sánh nhất quán theo lô, hoặc chuẩn bị câu hỏi về thông tin thiếu và mâu thuẫn. Skill không thay thế phỏng vấn, kiểm tra tham chiếu hay quy trình tuyển dụng của tổ chức.

## Cách chấm điểm

Skill trước hết trích xuất yêu cầu bắt buộc, tiêu chí ưu tiên, kinh nghiệm, học vấn và yêu cầu đặc biệt từ JD. Sau đó skill đối chiếu các yêu cầu này với những thông tin được nêu trong từng CV; không nên lấp khoảng trống bằng giả định. Mỗi tiêu chí được chấm 1–10 và quy đổi thành tổng điểm trên 100.

| Tiêu chí | Trọng số | Tối đa |
| --- | ---: | ---: |
| Mức độ khớp JD | ×3 | 30 |
| Kinh nghiệm làm việc | ×2.5 | 25 |
| Dự án và tác động | ×1.5 | 15 |
| Học vấn | ×1.5 | 15 |
| Chất lượng CV | ×1.5 | 15 |

Các thang chi tiết đánh giá mức đáp ứng JD, độ liên quan và phát triển kinh nghiệm, số liệu dự án đáng tin, học vấn hoặc chứng chỉ, cùng cấu trúc và tính nhất quán của CV. Xem [rubric chấm điểm](./references/scoring-rubric.md) đầy đủ khi cần các mức điểm hoặc khoản trừ cụ thể.

Nhãn mặc định là **Recommend** (từ 70), **Maybe** (50–69) và **Pass** (dưới 50). Đây là tín hiệu để con người review—không phải quyết định tự động mời phỏng vấn, loại, hay tuyển dụng.

## Đầu vào và kết quả

Hãy cung cấp JD đầy đủ và một hoặc nhiều CV dạng text, Markdown hoặc PDF. Phản hồi theo [định dạng đầu ra](./references/output-format.md): JSON gồm điểm chi tiết, nhận xét cho từng tiêu chí, tóm tắt, điểm nổi bật và các red flag có thể có. Với nhiều CV, skill chấm độc lập từng CV trước, rồi trả về bảng xếp hạng từ cao xuống thấp. Phản hồi dùng ngôn ngữ của bạn.

Hãy xem red flag, thông tin còn thiếu hoặc mâu thuẫn có vẻ có như một điểm cần xác minh, không phải kết luận về sự thiếu trung thực. Kiểm tra các thông tin CV đứng sau mọi điểm số, nhất là với ứng viên sát ngưỡng.

## Skill bổ trợ

- Dùng [Critical Thinking](../critical-thinking/README.vi.md) khi cần audit lập luận trong memo, chính sách hay khuyến nghị tuyển dụng; skill này tách claim, bằng chứng, giả định và lỗ hổng, với nhận định neo vào văn bản nguồn.
- Dùng [Deep Reader](../deep-reader/README.vi.md) cho chính sách tuyển dụng, portfolio hoặc tài liệu hỗ trợ dài (khoảng 50+ trang); ghi chú đọc nhiều lượt giúp tài liệu lớn vẫn có thể truy vết trước khi được dùng để review.

## Giới hạn và sử dụng có trách nhiệm

- Cùng một rubric được áp dụng nhất quán **không** khiến điểm số trở nên khách quan hoặc không thiên vị; CV cũng không thể chứng minh hiệu suất công việc trong tương lai.
- Không suy luận hoặc đánh giá đặc điểm nhạy cảm hay được pháp luật bảo vệ—như tuổi, giới tính, sắc tộc, khuyết tật, tôn giáo hoặc yếu tố cá nhân không liên quan đến công việc.
- Không loại ứng viên chỉ vì điểm hay thứ hạng được tạo ra. Người có thẩm quyền phải review bằng chứng và đưa ra quyết định.
- CV là hồ sơ tự khai, không đầy đủ; hãy xác minh các tuyên bố quan trọng bằng những bước tuyển dụng phù hợp và hợp pháp.
- Tuân thủ luật lao động, nghĩa vụ bảo mật dữ liệu và chính sách tổ chức hiện hành, bao gồm mọi yêu cầu về lưu hồ sơ hoặc review bổ sung.
