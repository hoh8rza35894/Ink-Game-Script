local universeId = game.GameId
local scptName = "DevNick - " .. universeId

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SidebarUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- 🌑 พื้นหลัง Frame หลัก
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 800, 0, 500)
mainFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true 
mainFrame.Draggable = true  
mainFrame.BackgroundTransparency = 0.3 -- 0 = ทึบ, 1 = โปร่งใส

local function toggleBlur(state)
	if state then
		if not game:GetService("Lighting"):FindFirstChildOfClass("BlurEffect") then
			local blur = Instance.new("BlurEffect")
			blur.Size = 12
			blur.Parent = game:GetService("Lighting")
		end
	else
		local existing = game:GetService("Lighting"):FindFirstChildOfClass("BlurEffect")
		if existing then existing:Destroy() end
	end
end
toggleBlur(true)

-- 🧱 Header ด้านบน
local header = Instance.new("Frame")
header.Name = "HeaderBar"
header.Size = UDim2.new(1, 0, 0, 40)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
header.BackgroundTransparency = 0.3
header.Parent = mainFrame
header.Active = false
header.Draggable = false

-- 🏷️ Label หัวข้อ (ชื่อแท็บปัจจุบัน)
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -150, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 18
titleLabel.Text = scptName -- หรือให้เปลี่ยนตามแท็บก็ได้
titleLabel.Parent = header

-- 💠 Sidebar ด้านซ้าย
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 100, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
sidebar.Parent = mainFrame
sidebar.BackgroundTransparency = 0.3


-- 📁 พื้นที่เนื้อหาหลัก
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -100, 1, -40)
contentFrame.Position = UDim2.new(0, 100, 0, 40)
contentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
contentFrame.Parent = mainFrame
contentFrame.BackgroundTransparency = 0.3


-- ✨ สร้างหน้าแต่ละแท็บ
local tabs = {
    Player = "Player",
    Script = "Other Script",
    Setting = "Seting"
}

local tabContent = {}
for tabName, displayText in pairs(tabs) do
    local tab = Instance.new("TextLabel")
    tab.Name = tabName
    tab.Size = UDim2.new(1, 0, 1, 0)
    tab.BackgroundTransparency = 1
    tab.Visible = false
    tab.TextYAlignment = Enum.TextYAlignment.Top
    tab.TextXAlignment = Enum.TextXAlignment.Left -- หรือ Left ก็ได้ถ้าจะชิดซ้าย
    tab.TextStrokeTransparency = 0.8 -- เสริมให้ดูเด่น
    tab.TextSize = 12 -- ขนาดใหญ่กำลังดี
    tab.Parent = contentFrame
    tab.Text = "" -- ลบข้อความ
    tab.TextTransparency = 1 -- หรือซ่อนตัวอักษรโดยตรง
    tabContent[tabName] = tab
end

-- 🧠 ฟังก์ชันสลับแท็บ
local function switchTab(tabName)
    for name, tab in pairs(tabContent) do
        tab.Visible = (name == tabName)
    end
   titleLabel.Text = scptName .. " " .. (tabs[tabName] or "")
end

-- 🎛️ ปุ่มใน Sidebar
local y = 20
for tabName, _ in pairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Text = tabName
    btn.Parent = sidebar

    btn.MouseButton1Click:Connect(function()
        switchTab(tabName)
    end)

    y = y + 40
end

-- 🔘 ปุ่มปิดทั้งหมด
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 60, 0, 25)
closeBtn.Position = UDim2.new(1, -70, 0.5, -12)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Text = "ปิด"
closeBtn.Parent = header

closeBtn.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
    toggleBlur(false)
end)

-- 🌟 ปุ่มซ่อนหน้าต่าง (อยู่ใน mainFrame)
local hideBtn = Instance.new("TextButton")
hideBtn.Size = UDim2.new(0, 60, 0, 25)
hideBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
hideBtn.TextColor3 = Color3.new(1, 1, 1)
hideBtn.Text = "ซ่อน"
hideBtn.Parent = header
hideBtn.Position = UDim2.new(1, -140, 0.5, -12)

local miniIcon = Instance.new("TextButton")
miniIcon.Size = UDim2.new(0, 100, 0, 30)
miniIcon.Position = UDim2.new(0, 10, 0, 10)
miniIcon.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
miniIcon.TextColor3 = Color3.new(1, 1, 1)
miniIcon.Text = "🔲 เปิดหน้าต่าง"
miniIcon.Visible = false
miniIcon.Parent = screenGui
miniIcon.Active = true
miniIcon.Draggable = true -- ✅ ให้ลาก icon ได้
-- 💡 ฟังก์ชันซ่อนหน้าต่าง
local function hideBtnClick()
    mainFrame.Visible = false
    miniIcon.Visible = true
    toggleBlur(false) -- ✅ ซ่อนหน้าต่าง = เลิกเบลอ
end

-- 💡 ฟังก์ชันเปิดหน้าต่าง
local function miniIconClick()
    mainFrame.Visible = true
    miniIcon.Visible = false
    toggleBlur(true) -- ✅ เปิดหน้าต่าง = เบลอ
end

-- 💡 เมื่อกดปุ่มซ่อน
hideBtn.MouseButton1Click:Connect(function()
    hideBtnClick()
end)

-- 💡 เมื่อกด icon เพื่อเปิดกลับ
miniIcon.MouseButton1Click:Connect(function()
    miniIconClick()
end)

-- 🎹 คีย์ลัด X = ปิด | Z = ซ่อน/เปิด
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.KeyCode == Enum.KeyCode.X then
		hideBtnClick()
	elseif input.KeyCode == Enum.KeyCode.Z then
		if mainFrame.Visible then
			hideBtnClick()
		else
			miniIconClick()
		end
	end
end)

hideBtnClick()

-- 💤 Toggle Switch AFK
local isAFK = false

-- พื้นหลังสวิตช์ (Track)
local afkSwitch = Instance.new("Frame")
afkSwitch.Size = UDim2.new(0, 60, 0, 30)
afkSwitch.Position = UDim2.new(0, 20, 0, 20)
afkSwitch.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
afkSwitch.BackgroundTransparency = 0
afkSwitch.BorderSizePixel = 0
afkSwitch.ClipsDescendants = true
afkSwitch.Parent = tabContent["Player"]
afkSwitch.Name = "AFKSwitch"
afkSwitch.AnchorPoint = Vector2.new(0, 0)

-- ปุ่มกลม (Thumb)
local thumb = Instance.new("Frame")
thumb.Size = UDim2.new(0, 24, 0, 24)
thumb.Position = UDim2.new(0, 3, 0.5, 0)
thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
thumb.BorderSizePixel = 0
thumb.Parent = afkSwitch
thumb.Name = "Thumb"
thumb.ZIndex = 2
thumb.AnchorPoint = Vector2.new(0, 0.5)
thumb.BackgroundTransparency = 0
thumb:SetAttribute("IsRound", true)

-- สร้างมุมกลม
local uicorner1 = Instance.new("UICorner", afkSwitch)
uicorner1.CornerRadius = UDim.new(1, 0)
local uicorner2 = Instance.new("UICorner", thumb)
uicorner2.CornerRadius = UDim.new(1, 0)

-- ป้ายแสดงสถานะ (วางนอกสวิตช์)
local afkLabel = Instance.new("TextLabel")
afkLabel.Size = UDim2.new(0, 80, 0, 25)
afkLabel.Position = UDim2.new(0, 90, 0, 20)
afkLabel.BackgroundTransparency = 1
afkLabel.Text = "AFK: ปิด"
afkLabel.TextColor3 = Color3.new(1, 1, 1)
afkLabel.Font = Enum.Font.SourceSans
afkLabel.TextSize = 18
afkLabel.Parent = tabContent["Player"] -- ✅ เปลี่ยนจาก afkSwitch

local isAFK = false
local afkLoop = nil  -- 🌙 สำหรับหยุดลูปเมื่อปิด AFK

-- 🧠 ฟังก์ชันกระโดด
local function jump()
	local char = player.Character
	if char then
		local humanoid = char:FindFirstChildWhichIsA("Humanoid")
		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end

-- 🚶 เดิน 1 ก้าวแบบกำหนดทิศทาง
local function stepMove(direction , radius)
	local char = player.Character
	if not char then return end

	local humanoid = char:FindFirstChildWhichIsA("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")
	if not humanoid or not root then return end

	-- กำหนดทิศทาง
	local dirVector = Vector3.zero
	if direction == "forward" then
		dirVector = Vector3.new(0, 0, -1)
	elseif direction == "back" then
		dirVector = Vector3.new(0, 0, 1)
	elseif direction == "left" then
		dirVector = Vector3.new(-1, 0, 0)
	elseif direction == "right" then
		dirVector = Vector3.new(1, 0, 0)
	else
		warn("⚠️ ทิศทางไม่ถูกต้อง: " .. tostring(direction))
		return
	end

	local goalPos = root.Position + (dirVector * radius) -- ระยะก้าว

	-- เดินจริง
	humanoid:MoveTo(goalPos)
	humanoid.MoveToFinished:Wait(1)
end



-- 👆 คลิกเพื่อเปลี่ยนสถานะ
afkSwitch.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isAFK = not isAFK

		if isAFK then
			-- ✅ เปิด AFK
			afkSwitch.BackgroundColor3 = Color3.fromRGB(80, 200, 100)
			thumb:TweenPosition(UDim2.new(1, -27, 0.5, 0), "Out", "Quad", 0.2, true)
			afkLabel.Text = "AFK: เปิด"

			-- 🔁 เริ่มลูป AFK
      afkLoop = coroutine.create(function()
        while isAFK do
          jump()
          wait(1)
          stepMove("forward" , 3) -- เดินหน้า
          wait(1)
          stepMove("back" , 3)    -- ถอยหลัง
          wait(1)
          stepMove("left" , 3)    -- ซ้าย
          wait(1)
          stepMove("right" , 3)   -- ขวา

          wait(5)
        end
      end)
      coroutine.resume(afkLoop)


		else
			-- ❌ ปิด AFK
			afkSwitch.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			thumb:TweenPosition(UDim2.new(0, 3, 0.5, 0), "Out", "Quad", 0.2, true)
			afkLabel.Text = "AFK: ปิด"

			-- 🛑 หยุดลูปกระโดด
			if afkLoop and coroutine.status(afkLoop) == "suspended" then
				coroutine.close(afkLoop)
			end
			afkLoop = nil
		end
	end
end)




-- 🔽 Dropdown "Select Script" ในแท็บ Script
local dropdownLabel = Instance.new("TextLabel")
dropdownLabel.Size = UDim2.new(0, 200, 0, 25)
dropdownLabel.Position = UDim2.new(0, 20, 0, 20)
dropdownLabel.BackgroundTransparency = 1
dropdownLabel.TextColor3 = Color3.new(1, 1, 1)
dropdownLabel.Text = "Select Script"
dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
dropdownLabel.Parent = tabContent["Script"]

local dropdownBtn = Instance.new("TextButton")
dropdownBtn.Size = UDim2.new(0, 200, 0, 30)
dropdownBtn.Position = UDim2.new(0, 20, 0, 50)
dropdownBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
dropdownBtn.TextColor3 = Color3.new(1, 1, 1)
dropdownBtn.Text = "Select..."
dropdownBtn.Parent = tabContent["Script"]

local dropdownMenu = Instance.new("Frame")
dropdownMenu.Size = UDim2.new(0, 200, 0, 90)
dropdownMenu.Position = UDim2.new(0, 20, 0, 80)
dropdownMenu.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
dropdownMenu.Visible = false
dropdownMenu.Parent = tabContent["Script"]

local selectedScript = nil

local options = {"Infinit", "Build Island", "Ink Game by AlexScriptX"}
for i, option in ipairs(options) do
	local item = Instance.new("TextButton")
	item.Size = UDim2.new(1, 0, 0, 30)
	item.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
	item.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	item.TextColor3 = Color3.new(1, 1, 1)
	item.Text = option
	item.Parent = dropdownMenu

	item.MouseButton1Click:Connect(function()
		dropdownBtn.Text = option
    selectedScript = option -- ✅ เก็บชื่อ script
    dropdownMenu.Visible = false
	end)
end

dropdownBtn.MouseButton1Click:Connect(function()
	dropdownMenu.Visible = not dropdownMenu.Visible
end)

-- ปุ่ม Execute ขนาดเล็ก แบบ Icon-only 🚀
local execBtn = Instance.new("TextButton")
execBtn.Size = UDim2.new(0, 40, 0, 30)
execBtn.Position = UDim2.new(0, 230, 0, 50) -- อยู่ถัดจาก dropdownBtn
execBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
execBtn.TextColor3 = Color3.new(1, 1, 1)
execBtn.Text = "🚀"
execBtn.Font = Enum.Font.SourceSansBold
execBtn.TextSize = 18
execBtn.Parent = tabContent["Script"]
execBtn.AutoButtonColor = true
execBtn.Name = "ExecuteBtn"

execBtn.MouseButton1Click:Connect(function()
	if not selectedScript then
		warn("ยังไม่ได้เลือก Script")
		return
	end

	if selectedScript == "Infinit" then
		loadstring(game:HttpGet(('https://raw.githubusercontent.com/hoh8rza35894/rblx-Script/refs/heads/main/infinit_source.lua'),true))()
	elseif selectedScript == "Build Island" then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Bac0nHck/Scripts/refs/heads/main/buildanisland.lua"))()
	elseif selectedScript == "Ink Game by AlexScriptX" then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexScriptX/Ink-Game-Script/refs/heads/main/Ink%20Game%20by%20AlexScriptX.lua"))()
	else
		warn("Script ไม่รองรับ: " .. selectedScript)
	end
end)

if universeId == 7541395924 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Bac0nHck/Scripts/refs/heads/main/buildanisland.lua"))()
elseif universeId == 7008097940 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexScriptX/Ink-Game-Script/refs/heads/main/Ink%20Game%20by%20AlexScriptX.lua"))()
end
-- แสดงแท็บแรก
switchTab("User")
