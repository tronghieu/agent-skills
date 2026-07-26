# Strategy Board

**Ngôn ngữ:** [Tiếng Việt](./README.vi.md) | [English](./README.md) | [中文](./README.zh.md)

Biến một câu hỏi kinh doanh hệ trọng thành khuyến nghị có nguồn, được stress-test và đủ rõ để người điều hành thật sự lựa chọn.

## Cài đặt

```bash
npx skills add tronghieu/agent-skills --skill strategy-board
```

## Bắt đầu từ một quyết định

Dùng `/strategy-board` bằng ngôn ngữ tự nhiên. Ví dụ:

```text
/strategy-board Chúng ta có nên vào Indonesia năm tới không, và nên bắt đầu ở phân khúc nào?
/strategy-board So sánh tự xây, mua và hợp tác cho hệ thống quản lý kho của chúng ta.
/strategy-board Hãy stress-test thương vụ mua lại dự kiến trước khi xin hội đồng phê duyệt.
/strategy-board Chúng ta cần kế hoạch năm phân bổ lại nguồn lực giữa các sản phẩm.
```

## Vì sao dùng một hội đồng thay vì chatbot thông thường?

Một cuộc chat thông thường có thể cho câu trả lời nghe hợp lý chỉ trong một lượt. Strategy Board được thiết kế để quyết định có thể bảo vệ được hơn:

- Lập fact base trước khi kết luận; số liệu có nguồn hoặc được ghi rõ là giả định.
- So sánh ít nhất ba phương án thật, khác biệt đáng kể—không phải một đáp án ưa thích cùng hai phương án rơm.
- Tách riêng góc nhìn thị trường, đổi mới, tài chính, thực thi, bất định và rủi ro, để sự lạc quan ở một nơi không che khuất điểm yếu ở nơi khác.
- Red-team hướng đã chọn trước khuyến nghị, ghi nhận rủi ro còn lại và làm rõ đánh đổi—kể cả điều không làm.

## Dành cho ai

Dùng khi founder, executive, business-unit leader, strategy lead hoặc consultant chịu trách nhiệm cho một lựa chọn lớn: vào thị trường, đầu tư, build-vs-buy, định giá, ưu tiên portfolio, chuyển đổi, phản ứng cạnh tranh, turnaround, M&A hoặc kế hoạch năm. Một phân tích đơn lẻ có trọng tâm, như pre-mortem hay sizing cơ hội, cũng có thể gọi đúng chuyên gia mà không cần full engagement.

## Một engagement diễn ra thế nào

Managing partner trước hết xác nhận quyết định thật, phạm vi, tiêu chí thành công, ràng buộc, khẩu vị rủi ro và môi trường chiến lược. Full engagement sau đó đi qua các điểm duyệt rõ ràng:

1. **Brief:** đóng khung quyết định và xác nhận câu hỏi với executive.
2. **Fact base:** thu thập bằng chứng công khai và dữ kiện nội bộ bạn cung cấp; ghi khoảng trống thành giả định có tên.
3. **Phân tích có chọn lọc:** chỉ dùng các lăng kính phù hợp với câu hỏi.
4. **Phương án:** so sánh ba hướng có thể bảo vệ theo cùng tiêu chí; executive chọn một hướng.
5. **Stress test:** kiểm tra đường thất bại, kịch bản, bằng chứng và các phụ thuộc thực thi trước khuyến nghị.
6. **Khuyến nghị:** trình bày lập luận sẵn sàng cho hội đồng, trả lời trước, bao gồm phương án bị loại, rủi ro chấp nhận và hy sinh rõ ràng; executive phê duyệt hoặc chỉnh sửa.
7. **Roadmap:** chuyển lựa chọn đã duyệt thành owner, hành động 90 ngày, output metric, tái phân bổ nguồn lực, signpost và điều kiện review.

Hội đồng dừng ở các cổng brief, phương án và khuyến nghị. Bạn có thể chỉnh, đào sâu, phản biện hoặc tiếp tục; thông tin nội bộ còn thiếu vẫn là giả định, không trở thành sự chắc chắn bịa đặt.

## Bạn cần cung cấp

Hãy đưa quyết định và deadline, kết quả mong muốn, phạm vi, ràng buộc cứng, mức chấp nhận rủi ro, stakeholder, dữ liệu kinh tế và năng lực nội bộ liên quan, các nỗ lực trước đây và loại bằng chứng có thể khiến bạn đổi ý. Hội đồng có thể nghiên cứu nguồn công khai, nhưng không thể biết thực tế nội bộ nếu bạn không cung cấp.

## Bạn nhận được gì

- Decision brief đã xác nhận cùng sổ bằng chứng/giả định
- Phân tích từ các chuyên gia liên quan và hàm ý đối với quyết định
- So sánh công bằng giữa các phương án chiến lược
- Pre-mortem hoặc stress test kịch bản, kèm dấu hiệu cảnh báo và phương án giảm thiểu
- Khuyến nghị sẵn sàng cho hội đồng, decision record và—sau phê duyệt—roadmap thực thi

Với một phân tích đơn lẻ, đầu ra chính là một memo tự đủ; tài liệu hỗ trợ là phụ lục, không phải phần bắt buộc phải đọc.

## Hội đồng và thảo luận Boardroom

**Drucker** điều phối engagement và chất vấn cách đóng khung. Các chuyên gia đại diện cho trách nhiệm riêng: **Porter** (thị trường và cạnh tranh), **Christensen** (đổi mới và job của khách hàng), **Graham** (giá trị và kinh tế học downside), **Grove** (năng lực và thực thi), **Wack** (kịch bản và bất định), **Taleb** (red-team rủi ro) và **Minto** (tổng hợp trả lời trước).

Với lựa chọn còn tranh luận thật sự, bạn có thể triệu tập phiên Boardroom. Ba hoặc bốn thành viên phù hợp đưa ra lập trường độc lập trước—có thể là các workstream song song—rồi mới xem quan điểm của nhau. Bạn sẽ thấy điểm đồng thuận, bất đồng thực chất, phản biện ngắn và dissent được ghi lại; trình tự này giảm groupthink và chỉ ra giả định hoặc đánh đổi thật sự cần phán đoán của bạn. Hội đồng khuyến nghị và ghi nhận. Bạn vẫn là executive ngồi ghế chủ tọa.

## Skill bổ trợ

- **Cần nhiều bằng chứng bên ngoài?** Dùng [Market Researcher](../market-researcher/README.vi.md) trước hoặc cùng hội đồng để có market sizing, competitor mapping, demand signal và nghiên cứu vĩ mô có trích nguồn; các kết quả có nguồn có thể đi vào fact base.
- **Cần trình bày lập luận đã duyệt trực tiếp?** Dùng [SlideWright](../slidewright/README.vi.md) sau khuyến nghị để dựng web slide do người trình bày điều khiển. Strategy Board cung cấp lập luận và số liệu có nguồn; SlideWright biến chúng thành hình ảnh trình bày.

## Giới hạn

Strategy Board là cố vấn: không tự quyết, phê duyệt đầu tư, thay thế phán đoán của executive hay bịa dữ kiện. Bằng chứng công khai không thể xác nhận năng lực nội bộ hoặc điều từng khách hàng sẽ mua. Các quyết định quan trọng vẫn cần review tài chính, pháp lý, vận hành và chuyên ngành phù hợp. Phương pháp làm rõ bất định, dissent và rủi ro còn lại; nó không thể loại bỏ chúng.
