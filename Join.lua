-- ========================================================
-- SCRIPT TỰ ĐỘNG CHẠM MÀN HÌNH ĐỂ VÀO GAME (DÀNH RIÊNG CHO MOBILE)
-- ========================================================

-- Chờ game load hoàn toàn các dịch vụ cơ bản
repeat task.wait() until game:IsLoaded()
task.wait(1.5) -- Tránh tình trạng chạm quá nhanh khi UI chưa kịp render

local VirtualInputService = game:GetService("VirtualInputService")

local function autoTouchScreen()
    -- Lấy kích thước màn hình hiện tại của điện thoại
    local camera = workspace.CurrentCamera
    if camera then
        local viewportSize = camera.ViewportSize
        -- Tính toán vị trí chính giữa màn hình
        local centerX = viewportSize.X / 2
        local centerY = viewportSize.Y / 2
        
        -- Tạo một ID ngẫu nhiên cho ngón tay giả lập
        local touchId = math.random(1000, 9999)
        
        -- Thực hiện hành động: Chạm xuống -> Giữ một chút -> Nhấc ngón tay lên
        local success, _ = pcall(function()
            -- 1. Chạm ngón tay xuống giữa màn hình
            VirtualInputService:FireTouchInputEvent(Enum.UserInputState.Begin, Vector2.new(centerX, centerY), touchId, game)
            task.wait(0.1)
            -- 2. Nhấc ngón tay lên để hoàn thành 1 cú Click (Tap)
            VirtualInputService:FireTouchInputEvent(Enum.UserInputState.End, Vector2.new(centerX, centerY), touchId, game)
        end)
        
        -- Giải pháp dự phòng: Nếu hàm trên bị chặn, dùng VirtualUser gửi tín hiệu click phần cứng
        if not success then
            local VirtualUser = game:GetService("VirtualUser")
            VirtualUser:CaptureController()
            VirtualUser:Button1Down(Vector2.new(centerX, centerY))
            task.wait(0.1)
            VirtualUser:Button1Up(Vector2.new(centerX, centerY))
        end
    end
end

-- Chạy vòng lặp thử chạm màn hình 3 lần, mỗi lần cách nhau 1 giây để đảm bảo ăn chắc
for i = 1, 3 do
    autoTouchScreen()
    task.wait(1)
end
