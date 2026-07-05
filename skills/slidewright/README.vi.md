# Skill Dựng Slide Thuyết Trình Tương Tác (SlideWright)

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Skill này giúp bạn nhanh chóng xây dựng các slide trình chiếu chuyên nghiệp, sắc nét, hoạt động như một trang web và tối ưu cho việc thuyết trình trực tiếp trước đám đông.

## SlideWright là gì?

SlideWright là một công cụ tạo slide thuyết trình dưới dạng trang web gọn nhẹ. Thay vì phải kéo thả phức tạp trên PowerPoint hay Keynote, bạn có thể viết slide bằng Markdown hoặc React. SlideWright tự động thiết lập một hệ thống thiết kế (Design System) chuẩn mực, đảm bảo bài thuyết trình của bạn trông hiện đại, tinh tế và cực kỳ dễ đọc ngay cả từ cuối khán phòng.

## Tại sao nên sử dụng?

- **Tiêu chuẩn thiết kế trình chiếu chuyên nghiệp**: Ép các quy tắc trực quan bắt buộc cho việc trình chiếu, chẳng hạn như "sàn kích thước chữ" (chữ luôn lớn hơn hoặc bằng 40px để đọc được từ xa) và các mẫu bố cục trực quan chuẩn.
- **Hai hướng triển khai linh hoạt**:
  - **Plain HTML (Không cần cài đặt/build)**: Chỉ một file `index.html` duy nhất chạy ngay lập tức trên mọi trình duyệt. Phù hợp cho các bài thuyết trình nhanh, nhỏ gọn dưới 20 slide.
  - **Vite + React**: Khởi tạo một dự án React hoàn chỉnh sử dụng Tailwind CSS và Framer Motion để tạo ra các hiệu ứng chuyển động, chuyển slide mượt mà và chuyên nghiệp.
- **Tập trung vào người thuyết trình**: Slide chỉ chứa hình ảnh và từ khóa tối giản. Kịch bản/ghi chú chi tiết của bạn (speaker notes) sẽ được lưu tự động ở một tệp Markdown riêng biệt (`*-notes.md`) để tiện theo dõi khi nói.
- **Xuất PDF dễ dàng**: Đi kèm các công cụ xuất toàn bộ slide sang tệp PDF sẵn sàng để in ấn hoặc chia sẻ.

## Quy tắc thiết kế slide cốt lõi

Khác với website thông thường, slide thuyết trình tuân theo các nguyên tắc:
- **Chữ phải đủ lớn**: Tuyệt đối không dùng cỡ chữ đọc web thông thường (`16px`, `text-sm`).
- **Không có tính năng tương tác phức tạp**: Không có form nhập liệu, đăng nhập hay nút gửi dữ liệu. Tương tác duy nhất là việc bạn bấm nút để chuyển slide hoặc hiển thị dần nội dung.
- **Mỗi slide một ý tưởng**: Giúp khán giả tập trung nghe bạn nói thay vì mải đọc chữ trên màn hình.

## Cách kích hoạt

Yêu cầu AI thực hiện các tác vụ như:

```text
Giúp tôi dựng một bộ slide cho buổi chia sẻ công nghệ tuần tới.
```

```text
Khởi tạo một dự án slide mới về chủ đề AI Agent dùng HTML track.
```

```text
Soạn thảo nội dung slide và ghi chú thuyết trình cho bài gọi vốn 10 phút.
```
