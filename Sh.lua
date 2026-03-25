-- إنشاء الواجهة (GUI)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local CollectButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")

-- إعدادات الواجهة
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true -- تسمح لك بتحريك الواجهة بالماوس

UICorner.Parent = MainFrame

Title.Parent = MainFrame
Title.Text = "Kingdom Helper"
Title.Size = UDim2.new(1, 0, 0.3, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- إعدادات زر الجمع
CollectButton.Name = "CollectButton"
CollectButton.Parent = MainFrame
CollectButton.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
CollectButton.Position = UDim2.new(0.1, 0, 0.45, 0)
CollectButton.Size = UDim2.new(0.8, 0, 0.4, 0)
CollectButton.Font = Enum.Font.Gotham
CollectButton.Text = "جمع الموارد (Teleport)"
CollectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CollectButton.TextSize = 14

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.Parent = CollectButton

-- منطق البرمجة (الجمع عن طريق الانتقال)
CollectButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    -- ملاحظة: استبدل "Tycoon" أو "Factories" بالمسار الصحيح لمصانعك في اللعبة
    -- عادة ما تكون الموارد موجودة في Workspace تحت اسم مملكتك
    local myKingdom = game.Workspace:FindFirstChild(player.Name .. "'s Kingdom") -- مثال لمسار شائع

    if myKingdom then
        -- البحث عن كل ما يمكن جمعه (مثلاً الأجزاء التي تسمى "Collector" أو "Generator")
        for _, obj in pairs(myKingdom:GetDescendants()) do
            if obj.Name == "CollectPart" or obj:FindFirstChild("TouchInterest") then 
                -- الانتقال إلى مكان المورد
                character.HumanoidRootPart.CFrame = obj.CFrame
                wait(0.2) -- وقت قصير لضمان اللعبة سجلت اللمس
            end
        end
        print("تم الانتهاء من دورة الجمع!")
    else
        warn("لم يتم العثور على مجلد المملكة الخاصة بك، يرجى التأكد من المسار.")
    end
end)
