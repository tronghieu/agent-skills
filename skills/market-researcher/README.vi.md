# Market Researcher

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Đưa ra quyết định thị trường dựa trên nghiên cứu bàn giấy mới, có trích nguồn—thay vì câu trả lời chatbot không thể kiểm chứng.

## Cài đặt

```bash
npx skills add tronghieu/agent-skills --skill market-researcher
```

Thử ngay:

```text
/market-researcher Dịch vụ meal-kit theo gói cho người sống một mình tại Đức có đáng theo đuổi không? Hãy quét nhanh.
```

```text
/market-researcher Ước lượng TAM, SAM và SOM năm thứ ba cho phần mềm quản lý chi phí B2B tại Đông Nam Á.
```

```text
/market-researcher Đâu là đối thủ trực tiếp, sản phẩm thay thế và “giữ nguyên hiện trạng” của SaaS kế toán tầm trung tại Canada?
```

```text
/market-researcher Deep dive: quy định, hành vi thanh toán và xu hướng nào có thể tạo điều kiện hoặc triệt tiêu một doanh nghiệp sạc xe điện tại Việt Nam?
```

Khác với câu trả lời từ chatbot thông thường, mọi nhận định thực tế đều gắn với nguồn đã đăng ký, ước lượng nêu đầu vào và công thức, còn mâu thuẫn hay giả định chưa giải quyết vẫn được trình bày rõ.

## Phù hợp với ai

Dùng khi founder, đội product hoặc growth, strategist, consultant, business-development lead hay analyst cần bằng chứng cho một quyết định thị trường. Các quyết định thường gặp gồm xây dựng, ra mắt, thâm nhập, định giá, định vị hoặc quyết định có nên tìm hiểu tiếp hay không.

Skill có thể tập trung vào một hay nhiều mảng:

- định nghĩa thị trường, TAM/SAM/SOM và khoảng tăng trưởng;
- đối thủ trực tiếp, gián tiếp, thay thế và “giữ nguyên hiện trạng”;
- tín hiệu nhu cầu và sẵn lòng chi trả từ nguồn công khai; hoặc
- xu hướng, công nghệ và quy định có ý nghĩa với quyết định.

## Nghiên cứu được giữ chặt chẽ thế nào

Trước hết, agent xác nhận quyết định, khách hàng mục tiêu, địa lý và ràng buộc. Sau đó nó nghiên cứu bằng chứng web mới và tài liệu bạn cung cấp, ghi lại từng nguồn cùng ngày tháng và mức độ tin cậy, đồng thời phân biệt dữ kiện có nguồn với giả định.

Phần định lượng quy mô dùng định nghĩa thị trường rõ ràng và các phương pháp kiểm chứng được, chẳng hạn số đơn vị mua × giá. Quick Scan dùng một phương pháp kèm kiểm tra hợp lý và đưa ra khoảng rộng; Deep Dive dùng ít nhất hai phương pháp độc lập. Chênh lệch đáng kể sẽ được giải thích—ví dụ khác năm, định nghĩa, tiền tệ, thước đo doanh thu hay GMV—chứ không bị lấy trung bình cho qua.

Phân tích đối thủ lập bản đồ các lựa chọn mà người mua thực sự có, kể cả không làm gì. Phân tích nhu cầu khai thác review, cộng đồng, tin tuyển dụng và giá công khai để tìm tín hiệu; nó phân biệt phàn nàn phổ biến với bằng chứng người dùng đang chi tiền cho giải pháp tạm. Phân tích vĩ mô và xu hướng chỉ tập trung vào các yếu tố có thể đổi chiều cơ hội này, và nêu hàm ý cho quyết định của từng yếu tố.

Trước khi bàn giao, một lượt rà soát phản biện kiểm tra lại các nhận định then chốt, phép tính, ngày tháng và mức độ tập trung nguồn. Bất định còn lại sẽ thành lưu ý rõ ràng, không phải khoảng trống bị che đi.

## Bạn sẽ làm việc như thế nào

Hãy bắt đầu bằng quyết định cần đưa ra. Nếu đã biết, hãy nêu sản phẩm hoặc dịch vụ, người mua, địa lý, khoảng thời gian, ràng buộc và bằng chứng nào sẽ khiến bạn đổi ý. Agent mặc định chạy Quick Scan và sẽ xác nhận khung nghiên cứu trước khi bắt đầu.

| Chế độ | Phù hợp khi | Phạm vi |
| --- | --- | --- |
| **Quick Scan** (mặc định) | “Có đáng tìm hiểu thêm không?” | Brief go/no-go trong một phiên: một phương pháp định lượng kèm kiểm tra, 5–10 đối thủ, tín hiệu nhu cầu chính, và 2–3 động lực hoặc yếu tố triệt tiêu. |
| **Deep Dive** | “Chúng ta thực sự sẽ bước vào điều gì?” | Báo cáo có thể tiếp tục qua nhiều phiên, chỉ gồm các mảng bạn chọn: quy mô, đối thủ, nhu cầu và/hoặc vĩ mô. |

Bạn nhận được khuyến nghị có nêu mức độ tin cậy, các dữ kiện chi phối, lưu ý lớn nhất và câu hỏi mở cho nghiên cứu sơ cấp. Phần hỗ trợ gồm sổ nguồn, phát hiện truy được về nguồn, đầu vào tính toán cùng giả định, và báo cáo.

Ở mảng nhu cầu, mọi persona đều được ghi rõ là **giả thuyết cần kiểm chứng**, không phải dữ kiện về khách hàng. Mỗi persona gắn với bằng chứng sẵn có hoặc được đánh dấu là giả định, đồng thời có cách kiểm tra.

Khi agent có thể phân công, các mảng nghiên cứu có thể chạy song song với dải mã nguồn riêng; nếu không, chúng chạy tuần tự. Dù theo cách nào, phần tổng hợp và kiểm chứng cuối cùng vẫn theo cùng quy tắc trích dẫn.

## Kết hợp với các skill khác

- Dùng [Design Thinking](../design-thinking/README.vi.md) sau nghiên cứu này khi bạn cần phỏng vấn, thử nghiệm hoặc prototype để kiểm chứng giả thuyết nhu cầu và mức sẵn lòng chi trả mà bằng chứng công khai không thể chứng minh.
- Dùng [Strategy Board](../strategy-board/README.vi.md) khi cần cân nhắc bằng chứng thị trường này cùng năng lực công ty, đánh đổi và các lựa chọn chiến lược.
- Dùng [Critical Thinking](../critical-thinking/README.vi.md) khi khuyến nghị có mức độ quan trọng cao và bạn muốn phản biện giả định, lập luận và giới hạn bằng chứng.

## Giới hạn

Đây là nghiên cứu bàn giấy: nó dựa vào nguồn web có thể truy cập và tài liệu bạn cung cấp. Nó không thay thế phỏng vấn khách hàng, khảo sát, quan sát hành vi hay tư vấn tài chính và pháp lý. Tín hiệu công khai có thể gợi ý nhu cầu và sẵn lòng chi trả, nhưng không thể khẳng định một khách hàng cụ thể sẽ mua gì. Nếu không thể nghiên cứu web hiện tại, skill cần nói rõ thay vì dùng trí nhớ làm bằng chứng.
