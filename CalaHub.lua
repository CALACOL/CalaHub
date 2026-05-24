print("CalaHub funcionando 🔥")

game.StarterGui:SetCore("SendNotification",{
    Title = "CalaHub",
    Text = "Todo funciona 😎",
    Duration = 5
})
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "CalaHub"
gui.Parent = game.CoreGui

-- MAIN FRAME
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,320,0,220)
main.Position = UDim2.new(0.5,-160,0.5,-110)
main.BackgroundColor3 = Color3.fromRGB(10,10,10)
main.BorderSizePixel = 0

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0,12)

-- TITLE
local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "CALA HUB"
title.TextColor3 = Color3.fromRGB(0,170,255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 28

-- SIDE MENU
local menu = Instance.new("Frame")
menu.Parent = main
menu.Size = UDim2.new(0,90,1,-40)
menu.Position = UDim2.new(0,0,0,40)
menu.BackgroundColor3 = Color3.fromRGB(15,15,15)
menu.BorderSizePixel = 0

local menuCorner = Instance.new("UICorner", menu)
menuCorner.CornerRadius = UDim.new(0,10)

-- CONTENT
local content = Instance.new("Frame")
content.Parent = main
content.Size = UDim2.new(1,-100,1,-50)
content.Position = UDim2.new(0,95,0,45)
content.BackgroundTransparency = 1

-- FUNCTION TO CLEAR
local function clear()
	for _,v in pairs(content:GetChildren()) do
		v:Destroy()
	end
end

-- BUTTON CREATOR
local function createMenuButton(text,ypos,callback)
	local b = Instance.new("TextButton")
	b.Parent = menu
	b.Size = UDim2.new(1,-10,0,35)
	b.Position = UDim2.new(0,5,0,ypos)
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.Text = text
	b.TextColor3 = Color3.fromRGB(0,170,255)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16
	
	local c = Instance.new("UICorner", b)
	c.CornerRadius = UDim.new(0,8)
	
	b.MouseButton1Click:Connect(callback)
end

-- MAIN TAB
local function MainTab()
	clear()
	
	local info = Instance.new("TextLabel")
	info.Parent = content
	info.Size = UDim2.new(1,0,0,100)
	info.BackgroundTransparency = 1
	info.Text = "Bienvenido a CalaHub 🔥\nGUI Mobile Compacta"
	info.TextColor3 = Color3.fromRGB(255,255,255)
	info.Font = Enum.Font.GothamBold
	info.TextSize = 18
end

-- PLAYER TAB
local function PlayerTab()
	clear()

	local speed = Instance.new("TextButton")
	speed.Parent = content
	speed.Size = UDim2.new(0,180,0,40)
	speed.Position = UDim2.new(0,0,0,0)
	speed.BackgroundColor3 = Color3.fromRGB(20,20,20)
	speed.Text = "Velocidad"
	speed.TextColor3 = Color3.fromRGB(0,170,255)
	speed.Font = Enum.Font.GothamBold
	speed.TextSize = 18
	
	local c1 = Instance.new("UICorner", speed)
	c1.CornerRadius = UDim.new(0,8)

	speed.MouseButton1Click:Connect(function()
		player.Character.Humanoid.WalkSpeed = 50
	end)

	local jump = speed:Clone()
	jump.Parent = content
	jump.Position = UDim2.new(0,0,0,50)
	jump.Text = "Infinite Jump"
	
	jump.MouseButton1Click:Connect(function()
		player.Character.Humanoid.JumpPower = 120
	end)
end

-- COMBAT TAB
local function CombatTab()
	clear()

	local combat = Instance.new("TextLabel")
	combat.Parent = content
	combat.Size = UDim2.new(1,0,0,50)
	combat.BackgroundTransparency = 1
	combat.Text = "Combat Functions ⚔️"
	combat.TextColor3 = Color3.fromRGB(255,255,255)
	combat.Font = Enum.Font.GothamBold
	combat.TextSize = 20
end

-- VISUAL TAB
local function VisualTab()
	clear()

	local visual = Instance.new("TextLabel")
	visual.Parent = content
	visual.Size = UDim2.new(1,0,0,50)
	visual.BackgroundTransparency = 1
	visual.Text = "ESP / FullBright 👁️"
	visual.TextColor3 = Color3.fromRGB(255,255,255)
	visual.Font = Enum.Font.GothamBold
	visual.TextSize = 20
end

-- MENU BUTTONS
createMenuButton("Main",10,MainTab)
createMenuButton("Player",55,PlayerTab)
createMenuButton("Combat",100,CombatTab)
createMenuButton("Visual",145,VisualTab)

-- OPEN MAIN TAB
MainTab()
