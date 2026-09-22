# Manual Testing

**Language:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Test một app đang chạy bằng tay, theo cách của một tester hoài nghi, và chứng minh mọi phát hiện bằng database trước khi gọi nó là bug.

```bash
npx skills add tronghieu/agent-skills --skill manual-testing
```

## Bắt đầu nhanh

```text
Phiên khám phá luồng mời thành viên. Giới hạn 30 phút.
```

```text
Xác minh bản fix cho bug #214: tổng đơn hàng bỏ qua chiết khấu.
```

```text
Smoke test sau khi deploy: đăng nhập, tạo một bản ghi, kiểm tra danh sách.
```

```text
Review bản dịch tiếng Việt của màn hình thanh toán.
```

```text
Hỏi trợ lý trong app năm câu về đơn hàng của tenant này và đối chiếu câu trả lời với database.
```

## Vì sao không chỉ bấm thử?

Một agent điều khiển trình duyệt chỉ thấy những gì trang hiển thị. Trang có thể nói dối: toast báo "đã lưu" nhưng dòng dữ liệu chưa hề được ghi, danh sách trống vì filter sai, lỗi bị nuốt trước khi lên màn hình. Một báo cáo chỉ dựa trên ảnh chụp sinh ra bug giả, và một bug giả làm mất nhiều niềm tin hơn mười bug thật gây dựng được.

Skill này coi UI là một trong ba nhân chứng. Mỗi phát hiện đều được đối chiếu ba chiều: màn hình hiển thị gì, dòng dữ liệu nói gì, network và console ghi lại gì. "Tôi không test được" là UNVERIFIED, không bao giờ là FAIL. Những nhận định cảm tính như câu chữ khó hiểu được giữ ở dạng OBSERVATION cho con người quyết, không kèm phán quyết.

## Dành cho ai

Những đội có bộ test tự động chuyên kiểm tra lại các cam kết đã biết, và cần ai đó tìm phần còn lại: bug chưa ai đoán, một bản fix làm hỏng thứ bên cạnh, một màn hình đọc sai ở một ngôn ngữ, một trợ lý AI trả lời tự tin nhưng sai.

## Cách hoạt động

1. **Nạp chính sách test của dự án.** `scripts/resolve_customization.py` gộp mặc định của skill với override của đội trong `_project/testing/manual-testing.toml` và override cá nhân `.user.toml`. Các tài liệu chính sách được nêu ở đó nằm trong ngữ cảnh suốt phiên và thắng mặc định của skill.
2. **Đọc adapter của dự án.** Port, service, tài khoản seed, phương thức xác thực, đường dẫn output và các bước preflight lấy từ `_project/testing/environment.toml`. Snapshot "trạng thái hiện tại" có ghi ngày và các hướng dẫn lấy từ `environment.md`. SQL chỉ đọc lấy từ `verification-queries.md`. Với repo mới, skill dựng adapter từ template, đọc từng giá trị từ một file thật, đánh dấu những gì chưa xác nhận được, và hỏi trước khi chạy phiên đầu tiên.
3. **Chọn chế độ và viết nhiệm vụ.** Khám phá (một charter), xác minh (một khẳng định có thể bác bỏ), smoke (danh sách cố định theo chiều rộng), đánh giá (một lăng kính trên một nhóm màn hình), hoặc AI probe (bộ câu hỏi có đối chiếu). Khi được giao test design hay mã test case, skill phân loại trước điều kiện nào thực sự cần con người.
4. **Thao tác và ghi log.** Tự động hoá trình duyệt kèm log liên tục: hành động, quan sát, kết luận. Sau mỗi bước: console, network, key i18n, rò rỉ tenant, ranh giới quyền, lỗi im lặng.
5. **Xác minh trước khi phán quyết.** SELECT chỉ đọc trên database local. Tự kiểm tra trước bất kỳ FAIL nào: đúng tài khoản, đúng phần tử, trang đã tải, tái hiện được hai lần từ trạng thái sạch.
6. **Báo cáo.** Một session note kèm bản đồ độ phủ, một bug report cho mỗi FAIL, và các ứng viên tự động hoá viết dưới dạng kịch bản cộng oracle.

## Kết quả nhận được

- Một session note, kể cả khi không tìm thấy gì, ghi rõ đã đi qua đâu, bỏ qua đâu, chưa tới đâu.
- Một bug report cho mỗi lỗi, đủ để một developer không có mặt vẫn tái hiện được.
- Các quan sát cần con người phán xét, tách khỏi phán quyết.
- Ứng viên tự động hoá: thứ nên chuyển sang bộ e2e hoặc integration tiếp theo.

## Giới hạn

Skill chỉ chạy trên dev stack local. Không bao giờ ghi vào database và luôn hỏi trước hành động không thể hoàn tác. Việc xác minh database giả định có một SQL database truy cập được bằng `psql` hoặc một client chỉ đọc tương đương. Skill không viết test tự động; nó chỉ ra thứ nên tự động hoá. Độ tin cậy của phát hiện bị giới hạn bởi adapter: một `environment.md` cũ sinh ra phát hiện tự tin về một phiên bản app không còn tồn tại, nên adapter luôn có ngày và được viết lại tại chỗ, không nối thêm.
