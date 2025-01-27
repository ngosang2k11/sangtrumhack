-- Đặt script trong StarterGui

-- Tạo GUI
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "SANG_IOS_GUI"

-- Nút mở/đóng menu
local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size = UDim2.new(0, 200, 0, 50)
toggleButton.Position = UDim2.new(0.5, -100, 0.1, 0)
toggleButton.Text = "SANG IOS BLOX FRUIT"
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
toggleButton.TextScaled = true
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.BorderSizePixel = 2
toggleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

-- Menu chính
local menu = Instance.new("Frame", screenGui)
menu.Size = UDim2.new(0, 300, 0, 200)
menu.Position = UDim2.new(0.5, -150, 0.3, 0)
menu.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
menu.Visible = false
menu.BorderSizePixel = 2
menu.BorderColor3 = Color3.fromRGB(0, 0, 0)

-- Tiêu đề menu
local menuTitle = Instance.new("TextLabel", menu)
menuTitle.Size = UDim2.new(1, 0, 0, 50)
menuTitle.Text = "SANG IOS BLOX FRUIT MENU"
menuTitle.TextScaled = true
menuTitle.Font = Enum.Font.SourceSansBold
menuTitle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
menuTitle.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Nút bật/tắt MAX EFRUIT
local maxEfruitButton = Instance.new("TextButton", menu)
maxEfruitButton.Size = UDim2.new(0, 200, 0, 50)
maxEfruitButton.Position = UDim2.new(0.5, -100, 0.5, -25)
maxEfruitButton.Text = "MAX EFRUIT: OFF"
maxEfruitButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
maxEfruitButton.TextScaled = true
maxEfruitButton.Font = Enum.Font.SourceSansBold
maxEfruitButton.BorderSizePixel = 2
maxEfruitButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

-- Trạng thái MAX EFRUIT
local maxEfruitEnabled = false

-- Xử lý sự kiện nút MAX EFRUIT
maxEfruitButton.MouseButton1Click:Connect(function()
    maxEfruitEnabled = not maxEfruitEnabled
    maxEfruitButton.Text = maxEfruitEnabled and "MAX EFRUIT: ON" or "MAX EFRUIT: OFF"
    maxEfruitButton.BackgroundColor3 = maxEfruitEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
end)

-- Xử lý sự kiện mở/đóng menu
toggleButton.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)

-- Kiểm tra tương tác với NPC "Blox Fruit Gacha"
local function onCharacterAdded(character)
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 10)
    if not humanoidRootPart then return end

    humanoidRootPart.Touched:Connect(function(hit)
        if maxEfruitEnabled and hit.Parent and hit.Parent.Name == "Blox Fruit Gacha" then
            local npc = hit.Parent
            -- Kiểm tra NPC có thể tương tác
            if npc:FindFirstChild("Interactable") and npc:FindFirstChild("Fruit") then
                -- Tương tác với NPC
                npc.Interactable:FireServer()

                -- Đảm bảo NPC random ra trái Dragon
                npc.Fruit.Value = "Dragon"
                print("MAX EFRUIT đã kích hoạt! Bạn nhận được trái Dragon.")
            end
        end
    end)
end

-- Kết nối sự kiện khi nhân vật người chơi được thêm vào
player.CharacterAdded:Connect(onCharacterAdded)

-- Kết nối sự kiện khi script bắt đầu (nếu nhân vật đã tồn tại)
if player.Character then
    onCharacterAdded(player.Character)
end
