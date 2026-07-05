# Skill Chấm Điểm CV (CV Scorer)

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Skill này giúp đánh giá CV (hồ sơ ứng viên) so với một Mô tả Công việc (JD) cụ thể, đưa ra điểm số chi tiết trên thang 100 và khuyến nghị tuyển dụng rõ ràng.

## Skill này dùng cho mục đích gì?

CV Scorer là một công cụ sàng lọc hồ sơ thông minh. Thay vì phải đọc thủ công hàng chục CV để tìm người phù hợp, bạn chỉ cần cung cấp Mô tả Công việc (JD) và các CV cho AI. AI sẽ phân tích kinh nghiệm, kỹ năng và học vấn của ứng viên để đưa ra điểm số khách quan thể hiện mức độ phù hợp với công việc.

## Tại sao nên sử dụng?

- **Tiết kiệm thời gian**: Nhanh chóng lọc ra những ứng viên tiềm năng từ chồng hồ sơ lớn.
- **Đánh giá khách quan**: Áp dụng một khung tiêu chí chấm điểm nhất quán và không thiên vị cho mọi ứng viên.
- **Phát hiện "Cờ đỏ" (Red Flags)**: Tự động cảnh báo các vấn đề tiềm ẩn như khoảng trống sự nghiệp không rõ lý do, số liệu phóng đại, hoặc nội dung trùng lặp/mâu thuẫn.
- **Khuyến nghị rõ ràng**: Phân loại ứng viên thành các nhóm *Đề xuất* (phỏng vấn), *Có thể cân nhắc* (chờ duyệt), hoặc *Loại* (không phù hợp).
- **Hỗ trợ xử lý hàng loạt**: Đánh giá nhiều CV cùng lúc và tự động sắp xếp thứ hạng từ cao xuống thấp để bạn dễ dàng lựa chọn.

## Cách hoạt động

1. **Cung cấp đầu vào**: Bạn gửi **Mô tả Công việc (JD)** và một hoặc nhiều **CV** (định dạng văn bản, Markdown hoặc PDF).
2. **Phân tích JD**: AI trích xuất các yêu cầu cốt lõi (kỹ năng bắt buộc, kỹ năng ưu tiên, số năm kinh nghiệm, học vấn).
3. **Chấm điểm**: AI đánh giá CV dựa trên 5 tiêu chí:
   - **Độ khớp JD (30 điểm)**: Sự tương thích về kỹ năng và công cụ làm việc.
   - **Kinh nghiệm làm việc (25 điểm)**: Độ liên quan của vị trí cũ và cấp độ chuyên môn.
   - **Dự án & Tác động (15 điểm)**: Các thành tựu cụ thể và số liệu chứng minh.
   - **Học vấn & Chứng chỉ (15 điểm)**: Bằng cấp hoặc chứng chỉ chuyên môn phù hợp.
   - **Chất lượng trình bày CV (15 điểm)**: Bố cục, sự rõ ràng và tính chuyên nghiệp.
4. **Đưa ra Khuyến nghị**: Phân loại nhanh dựa trên điểm số (Đề xuất: $\ge 70$, Có thể cân nhắc: $50-69$, Loại: $< 50$).

## Cách kích hoạt

Yêu cầu AI thực hiện các tác vụ như:

```text
Chấm điểm các CV này so với mô tả công việc dưới đây.
```

```text
Lọc hồ sơ ứng viên này và tìm xem có điểm bất thường nào không.
```

```text
Đánh giá mức độ phù hợp của ứng viên cho vị trí Software Engineer và xếp hạng họ.
```
