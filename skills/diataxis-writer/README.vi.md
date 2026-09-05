# Diataxis Writer

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Diataxis là framework tổ chức tài liệu theo nhu cầu tức thời của người đọc: **học** qua thực hành, **làm** một việc, **tra cứu** dữ kiện hoặc **hiểu** một khái niệm. Skill này dùng sự phân biệt đó để biến tài liệu lẫn lộn, khó điều hướng thành các trang có lời hứa rõ ràng—dễ dùng hơn và dễ bảo trì hơn.

## Cài đặt nhanh

```bash
npx skills add tronghieu/agent-skills --skill diataxis-writer
```

## Ví dụ nhanh

```text
/diataxis-writer Review hướng dẫn getting started này. Hãy tìm các phần bị trộn và đề xuất cấu trúc tutorial, how-to, reference và explanation.
```

```text
/diataxis-writer Chuyển quy trình deploy này thành how-to guide tập trung vào tác vụ. Giữ lại điều kiện tiên quyết, cách kiểm tra và hướng dẫn khôi phục.
```

```text
/diataxis-writer Tạo tài liệu reference dễ quét cho các CLI option, giá trị mặc định, giới hạn và ví dụ này.
```

```text
/diataxis-writer Giải thích thiết kế xác thực này cho kỹ sư mới, gồm mental model, tradeoff và hệ quả.
```

## Vì sao không chỉ bảo chatbot “cải thiện tài liệu”?

Một yêu cầu rộng như vậy có thể làm câu chữ mượt hơn nhưng vẫn để mục đích của trang mơ hồ—hoặc trộn việc dạy người mới, các bước làm việc, dữ kiện tra cứu và lý do vào cùng một chỗ. Skill này bắt đầu từ reader job, đặt một lời hứa chính cho mỗi trang và chỉ ra nội dung cần giữ, chuyển, tách hoặc liên kết. Kết quả là cấu trúc tài liệu, không chỉ là văn phong trau chuốt hơn.

## Skill này dành cho ai

Technical writer, developer advocate, người sở hữu tài liệu, đội product và engineering, knowledge manager và operator đang duy trì tài liệu cho người dùng hoặc nội bộ.

## Khi nào nên dùng

- Tutorial onboarding, bài viết help center và tài liệu quy trình nội bộ
- How-to guide, runbook, tài liệu cấu hình, migration và troubleshooting
- Reference cho API, command, policy và configuration
- Explanation về khái niệm, bối cảnh kiến trúc và lý do thiết kế
- Audit một trang khó hiểu hoặc tổ chức lại cả bộ tài liệu

## Bốn nhóm Diataxis

| Ý định của người đọc | Loại tài liệu | Lời hứa của trang |
| --- | --- | --- |
| Học qua thực hành | Tutorial | Đi theo một lộ trình có hướng dẫn để có năng lực cơ bản. |
| Hoàn thành một việc | How-to guide | Đạt một kết quả cụ thể. |
| Tra cứu dữ kiện | Reference | Tìm thông tin chính xác, đầy đủ thật nhanh. |
| Hiểu bối cảnh | Explanation | Hiểu khái niệm, quyết định và đánh đổi. |

## Cách phân loại và tái cấu trúc

1. Xác định người đọc, mục tiêu trước mắt và lời hứa ngầm của trang.
2. Phân loại nội dung hiện có theo bốn ý định của người đọc.
3. Chọn một loại chính cho mỗi trang; nội dung hỗ trợ nên thuộc một trang liên quan hoặc một liên kết ngắn gọn.
4. Giữ, chuyển, tách hoặc viết lại các phần bị trộn, rồi liên kết các trang kết quả để người đọc đi được giữa học, làm, tra cứu và hiểu.
5. Kiểm tra title, phần mở đầu, cấu trúc và độ sâu có thực hiện đúng reader job đã hứa hay không.

Xem pattern và template chi tiết tại [Diataxis patterns](./references/diataxis-patterns.md).

## Bạn cần cung cấp gì và sẽ nhận được gì

Hãy đưa tài liệu hoặc bộ tài liệu, độc giả mục tiêu, bối cảnh sản phẩm hoặc quy trình và kết quả mong muốn. Ví dụ hiện có, câu hỏi support và dữ liệu tìm kiếm có thể giúp ích.

Bạn sẽ nhận được phân loại, các phát hiện theo section về nội dung lẫn mục đích, kiến trúc thông tin mục tiêu, cùng kế hoạch viết lại cụ thể hoặc nội dung đã viết lại. Bản review cũng có checklist kiểm tra.

## Skill bổ trợ

- Dùng [Deep Reader](../deep-reader/README.vi.md) **trước skill này** khi bộ tài liệu lớn hoặc dày cần được đọc kỹ và có thể truy nguyên; nó tạo nền tảng hiểu nguồn mà việc tái cấu trúc cần có.
- Dùng [Critical Thinking](../critical-thinking/README.vi.md) khi tài liệu đưa ra claim hoặc khuyến nghị quan trọng; skill này kiểm tra bằng chứng và lập luận, còn Diataxis tổ chức trải nghiệm người đọc.
- Dùng [System Prompt Creator](../system-prompt-creator/README.vi.md) khi quy trình làm tài liệu cần trở thành hành vi lặp lại trong sản phẩm LLM; nó chuyển workflow và guardrail mong muốn thành system prompt có thể kiểm thử.
- Dùng [Humanizer](https://github.com/blader/humanizer) **sau skill này** để loại bỏ các dấu hiệu văn phong AI khỏi bản văn hoàn chỉnh. Diataxis Writer tự động gọi nó khi skill này đã được cài, và dùng checklist tích hợp ngắn gọn hơn khi chưa cài. Cài đặt bằng `npx skills add blader/humanizer`.

## Giới hạn

Diataxis phù hợp khi tài liệu có nhiệm vụ giúp con người học, làm, tra cứu hoặc hiểu. Đây không phải định dạng phổ quát cho marketing copy, sales proposal, legal contract, press release, fiction hoặc nội dung đặt thuyết phục lên hàng đầu. Một trang có thể dùng thông tin từ nhiều loại, nhưng vẫn nên có một reader job chính.
