# Problem Solver

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Biến một sự cố vận hành, kỹ thuật, quy trình hoặc kinh doanh chưa rõ nguyên nhân thành chẩn đoán có thể kiểm tra và kế hoạch xử lý đúng nguyên nhân.

## Cài đặt

```bash
npx skills add tronghieu/agent-skills --skill problem-solver
```

## Bắt đầu với vấn đề thực tế

```text
/problem-solver Đơn hàng bắt đầu giao trễ từ tháng Sáu; chỉ đơn bánh đặt riêng liên quận bị ảnh hưởng. Nên kiểm tra gì trước?
```

```text
/problem-solver Tỷ lệ chuyển đổi giảm 18% tháng này. Chúng tôi đổi giá, onboarding và nhắm quảng cáo; hãy giúp tách các nguyên nhân.
```

```text
/problem-solver Sự cố production cứ quay lại sau mỗi hotfix. Hãy chẩn đoán nguyên nhân gốc trước khi đề xuất cách sửa tiếp theo.
```

## Vì sao không chỉ hỏi chatbot thông thường cách sửa?

Một cuộc chat thông thường có thể tạo ra câu chuyện hợp lý, đầy tự tin từ các dữ kiện còn thiếu. Problem Solver tách điều bạn đã quan sát khỏi điều mới chỉ nghi ngờ, yêu cầu phép kiểm tra rẻ nhất có thể bác bỏ lời giải thích hàng đầu, và không coi một cách sửa hấp dẫn là bằng chứng cho nguyên nhân. Vì vậy, một phép kiểm tra thất bại vẫn là tiến bộ hữu ích—không phải điều bị che đi bằng câu trả lời bóng bẩy.

## Khi nào nên dùng

Dùng khi có lỗi, chậm trễ, tái diễn hoặc thay đổi nhưng nguyên nhân chưa rõ/chưa được kiểm chứng: mẫu giao trễ, chỉ số giảm, incident lặp lại, thay đổi bị đình trệ, hoặc post-mortem cần đi đến hành động. Skill phù hợp với operator, kỹ sư, product/process lead, manager và chủ doanh nghiệp có thể cung cấp quan sát hoặc kiểm tra thực tế.

Đây không phải lựa chọn đầu tiên nếu không có gì hỏng và bạn chỉ cần ý tưởng mở, hoặc nếu câu hỏi thực chất là hiểu nhu cầu và hành vi người dùng.

Nếu bạn xin cách sửa khi chưa biết nguyên nhân, skill nói rõ các ý tưởng có thể nhắm sai chỗ, đề nghị một lượt Định khung nhanh và để bạn chủ động bỏ qua chẩn đoán với rủi ro đó; nếu bỏ qua, công việc chuyển sang Brainstorm Coach.

## Mô hình tư duy: chẩn đoán trước, giải pháp sau

Skill dựa trên ba nguồn sự thật:

- **Sự thật** bạn biết trực tiếp hoặc dữ liệu/tài liệu bạn kiểm tra được mang nhãn `[verified]`.
- **Giả thuyết**, gồm cả linh cảm của bạn và của người hỗ trợ, mang nhãn `[assumed]` cho đến khi thực tế xác nhận.
- **Kiểm chứng** chỉ xảy ra khi bạn đối chiếu với thế giới thật; thấy có vẻ hợp lý không phải kiểm chứng.

Giả định mang tính quyết định được ghi độ tin cậy, tác động nếu sai và phép kiểm tra rẻ nhất. Mỗi ứng viên nguyên nhân gốc phải dự đoán điều sẽ quan sát được và nêu quan sát rẻ nhất có thể bác bỏ nó. Ít nhất hai lời giải thích đối thủ được giữ lại đến khi bằng chứng phân biệt chúng.

## Diễn biến một phiên làm việc

1. **Định khung** — làm rõ triệu chứng quan sát được, thời điểm bắt đầu, tác động, cách đã thử và dấu hiệu “đã sửa xong”; tách sự thật khỏi nguyên nhân và giải pháp được cài sẵn.
2. **Khoanh vùng** — so sánh vấn đề **có** và **không có** ở đâu, khi nào, với ai/cái gì và dưới dạng nào. Khác biệt là manh mối mạnh nhất.
3. **Chẩn đoán** — dùng một hoặc hai phương pháp hợp hình dạng: Five Whys cho chuỗi khả dĩ, fishbone cho nhiều yếu tố, causal loop cho mô thức tái diễn/tự làm nặng hơn, force-field/constraint là phần bổ sung cho thay đổi tổ chức.
4. **Giải pháp** — tạo phương án nhắm vào nguyên nhân đã kiểm chứng và truy vết từng phương án về nguyên nhân đó. Miếng vá triệu chứng cần thiết được gắn nhãn và đi kèm sửa chữa nguyên nhân.
5. **Quyết định** — so sánh trực tiếp hai phương án, hoặc dùng ma trận khi có từ ba phương án; mỗi điểm số phải có bằng chứng hoặc ghi `unknown — assumption`. Bạn là người quyết định.
6. **Kế hoạch** — chọn pilot, triển khai theo giai đoạn, hoặc hiếm khi là big-bang dễ đảo ngược; nêu người phụ trách, chỉ số thành công kế thừa, kiểm tra giả định mở, điểm rà soát và điều kiện đổi hướng.

Mức độ quy trình tăng theo mức độ rủi ro: vấn đề nhỏ có thể gộp các pha đầu, còn vấn đề tốn kém hoặc lặp lại dùng toàn bộ pipeline. Nếu lời mở đầu đã có ranh giới sắc nét và thay đổi xảy ra cùng thời điểm, skill có thể đề nghị ngay phép kiểm tra phân biệt rẻ thay vì bắt bạn điền bảng hỏi.

## Điểm dừng, con người và cộng tác

Có đúng ba cổng: bạn xác nhận problem statement đã tinh chỉnh; ứng viên nguyên nhân hàng đầu được kiểm chứng—hoặc bạn chấp nhận rõ ràng rủi ro khi tiếp tục; và bạn ra quyết định cuối cùng. Skill không đóng vai stakeholder hay bịa điều họ sẽ nói. Câu hỏi theo góc nhìn chỉ giúp mở rộng fishbone, còn bạn vẫn là nguồn sự thật.

Ở pha Giải pháp, skill bàn giao sang [Brainstorm Coach](../brainstorm-coach/README.vi.md) nếu có để brainstorm phân kỳ theo nguyên nhân. Nếu chưa có, nó tiếp tục một lượt lên ý tưởng nhẹ, ưu tiên ý tưởng của bạn; không bị chặn vì thiếu skill bổ trợ. Skill không thiết lập một nhóm multi-agent hay “party” thường trực.

## Trải nghiệm và đầu ra

Hãy mang theo điều bạn biết: triệu chứng và quy mô quan sát được, thời điểm, trường hợp bị/không bị ảnh hưởng, thay đổi gần đây, cách đã thử, dữ liệu/tài liệu, ràng buộc và định nghĩa thành công. “Chưa biết” là câu trả lời hợp lệ và trở thành khoảng trống cần kiểm tra.

Với vấn đề kéo dài qua nhiều cuộc trò chuyện, skill thường duy trì workspace gọn gồm statement và boundary, diagnosis và phép kiểm tra, assumption log, phương án truy vết nguyên nhân, quyết định và kế hoạch. Khi bạn quay lại, nó đọc trạng thái đó trước, tóm tắt phép kiểm tra đang chờ, cập nhật nhãn/độ tin cậy theo bằng chứng mới rồi tiếp tục đúng pha, không bắt đầu lại. Với vấn đề nhanh, cùng cấu trúc có thể ở ngay trong cuộc trò chuyện.

Bạn nhận được: problem statement đã xác nhận; ranh giới Is/Is-Not; cause tree có nhãn với các ứng viên đối thủ và phép kiểm tra; assumption log; phương án truy vết về nguyên nhân; khuyến nghị có xét bằng chứng; và kế hoạch triển khai kèm chỉ số cùng điều kiện đổi hướng.

## Skill bổ trợ

- [Brainstorm Coach](../brainstorm-coach/README.vi.md) — sau khi đã kiểm chứng nguyên nhân, để mở rộng giải pháp.
- [Design Thinking](../design-thinking/README.vi.md) — khi bất định thực sự nằm ở nhu cầu, cảm nhận, adoption hoặc hành vi người dùng.
- [Critical Thinking](../critical-thinking/README.vi.md) — để kiểm tra lập luận của chẩn đoán hoặc quyết định.
- [Strategy Board](../strategy-board/README.vi.md) — khi cách sửa đã thành một đặt cược chiến lược cấp công ty.
- [Market Researcher](../market-researcher/README.vi.md) — khi nguyên nhân hay phương án phụ thuộc dữ kiện thị trường bạn chưa có.
- [Project Manager](../project-manager/README.vi.md) — khi kế hoạch trở thành dự án nhiều tuần, nhiều luồng việc và stakeholder.

## Giới hạn

Problem Solver không thể tự xem hệ thống của bạn hoặc kiểm chứng dữ kiện bạn chưa cung cấp/chưa kiểm tra. Nó không dựng chuỗi nguyên nhân đẹp mắt, không bảo đảm can thiệp sẽ thành công và không thay thế phán đoán chuyên môn, an toàn, pháp lý hay vận hành. Bạn có thể hành động trước khi kiểm chứng xong, nhưng nhánh đó được đánh dấu rõ là có rủi ro và nên dùng pilot có thể đảo ngược cùng điều kiện đổi hướng.
