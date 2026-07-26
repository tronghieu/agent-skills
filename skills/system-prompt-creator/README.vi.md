# System Prompt Creator

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Biến bản mô tả sản phẩm hoặc quy trình thành system prompt rõ ràng, phù hợp với model và có cách kiểm thử thực tế.

## Cài đặt

```bash
npx skills add tronghieu/agent-skills --skill system-prompt-creator
```

## Bắt đầu từ một công việc thực tế

```text
/system-prompt-creator Tạo system prompt cho trợ lý nội bộ review code Python. Trợ lý cần giải thích ngắn gọn phát hiện và không được làm lộ bí mật.

/system-prompt-creator Chuyển bản mô tả trích xuất hóa đơn này thành prompt trả về JSON. Giữ lại từng giá trị nguồn, đánh dấu chỗ không chắc chắn và đưa ra ba test case.

/system-prompt-creator Thiết kế agent chăm sóc khách hàng cho câu hỏi đơn hàng và hoàn tiền. Agent được tra cứu đơn nhưng phải hỏi trước khi sửa đơn.

/system-prompt-creator Cải thiện prompt GPT này cho trợ lý nghiên cứu. Mục tiêu là GPT-5, trích dẫn nguồn được cung cấp và tách dữ kiện khỏi suy luận: [dán prompt]
```

Khác với prompt cho chatbot thông thường chỉ điều hướng một cuộc trò chuyện, system prompt xác định hành vi lặp lại được: phạm vi, cách ra quyết định, dùng tool, hợp đồng đầu ra và ranh giới để đánh giá trên nhiều input.

## Dành cho ai và khi nào nên dùng

Hãy dùng skill này nếu bạn xây sản phẩm AI, tự động hóa quy trình hoặc cần custom instructions đáng tin cậy. Nó phù hợp với assistant và chatbot, trợ lý code, công cụ viết nội dung, trích xuất dữ liệu, quy trình nghiên cứu, agent dùng tool và prompt cần chuyển giữa các họ model. Dùng khi kết quả thiếu nhất quán, tác vụ cần đầu ra có cấu trúc hoặc hệ thống cần quy định về an toàn, escalation và cách xử lý lỗi.

## Cách làm việc

Hãy mô tả công việc bằng ngôn ngữ thông thường. Skill sẽ phỏng vấn về model mục tiêu, người dùng, input, output, giọng điệu, tool, ràng buộc, ví dụ và các yêu cầu lân cận có thể phát sinh. Khi thiếu chi tiết, skill có thể đề xuất mặc định hợp lý để bạn xác nhận.

Sau đó, skill ước lượng độ phức tạp, tách role, context, instructions, hợp đồng đầu ra, ví dụ, quy tắc tool và guardrail, rồi chỉ dùng XML hoặc Markdown khi cấu trúc đó phù hợp. Bản nháp ưu tiên ý định rõ ràng, quy tắc không mâu thuẫn, hướng dẫn tích cực và ví dụ cho trường hợp thông thường, biên và ngoài phạm vi. Cuối cùng, skill đưa test prompt và chỉnh sửa theo các lỗi quan sát được.

Với prompt agentic, thiết kế có thể thêm playbook vận hành theo tên, các mức hành động an toàn/cần thận trọng/phải xác nhận, quy tắc dùng tool, quản lý trạng thái và vòng tự kiểm tra. Với thiết kế multi-agent, hãy nêu rõ trách nhiệm, bàn giao và khi nào nên giao việc song song; đừng giả định chúng tự xuất hiện từ một persona chung chung.

## Cần cung cấp gì và sẽ nhận được gì

Hãy cung cấp những gì bạn biết:

- Nhà cung cấp, model và version mục tiêu; use case; đối tượng dùng; và persona mong muốn.
- Loại input, format output bắt buộc, tone, tool, quyền hạn, ràng buộc cứng, ví dụ hữu ích hoặc lỗi đã biết.
- Với quy trình có tác động lớn, dữ liệu đại diện và các quyết định bắt buộc phải được con người xác nhận.

Bạn sẽ nhận được bản nháp system prompt sẵn sàng sao chép, các giả định và ghi chú kiến trúc chính, điều chỉnh liên quan đến model khi có cơ sở, cùng 3–5 prompt kiểm thử với hành vi mong đợi. Thiết kế trích xuất có thể giữ giá trị nguồn và thể hiện mức độ không chắc chắn; thiết kế agent có thể xác định playbook và ranh giới hành động.

## Xác minh cho model bạn thực sự triển khai

Hãy xem khuyến nghị riêng theo nhà cung cấp, tham số API và hành vi model là hướng dẫn theo phiên bản, không phải sự thật vĩnh viễn. Xác nhận tên/version model và tài liệu chính thức hiện hành của nhà cung cấp, sau đó chạy các test có sẵn (cùng các ca đại diện hoặc đối kháng của bạn) với đúng thiết lập triển khai. Kiểm thử lại khi đổi model, context window, tool, tham số API hoặc chính sách sản phẩm. Xem [ghi chú theo model](./references/model-specific.md), [nguyên tắc](./references/principles.md) và [mẫu](./references/templates.md).

## Skill bổ trợ

- Dùng [Diataxis Writer](../diataxis-writer/README.vi.md) khi đầu ra của prompt cần trở thành tài liệu hướng dẫn, how-to, reference hoặc giải thích bền vững cho người đọc.
- Dùng [Critical Thinking](../critical-thinking/README.vi.md) khi prompt có chính sách, tuyên bố hoặc quyết định quan trọng cần được kiểm tra độc lập về lập luận và bằng chứng.
- Dùng [Data Scientist](../data-scientist/README.vi.md) khi việc đánh giá thay đổi prompt cần phân tích test set, chỉ số hoặc mẫu lỗi.
- Dùng [Design Thinking](../design-thinking/README.vi.md) trước khi viết prompt khi điều chưa rõ thực sự là nhu cầu, hành vi hoặc mức độ chấp nhận của người dùng, thay vì câu chữ.

## Giới hạn

Prompt được thiết kế tốt có thể tăng tính nhất quán, nhưng không bảo đảm tính đúng, an toàn, tuân thủ, thành công khi dùng tool hay hành vi giống hệt giữa các model và version. Prompt không thay thế kiểm soát quyền hạn, chất lượng retrieval, chính sách sản phẩm, đánh giá của con người hoặc evaluation trong môi trường production.
