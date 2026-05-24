print("CalaHub funcionando 🔥")

game.StarterGui:SetCore("SendNotification",{
    Title = "CalaHub",
    Text = "Todo funciona 😎",
    Duration = 5
})
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "CalaHub"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

-- BLUR
local blur = Instance.new("BlurEffect")
blur.Parent = Lighting
blur.Size = 0

-- OPEN BUTTON
local open = Instance.new("ImageButton")
open.Parent = gui
open.Size = UDim2.new(0,60,0,60)
open.Position = UDim2.new(0.05,0,0.45,0)
open.BackgroundColor3 = Color3.fromRGB(15,15,15)
open.Image = "rbxassetid://0"
open.AutoButtonColor = false

local opencorner = Instance.new("UICorner",open)
opencorner.CornerRadius = UDim.new(1,0)

local openstroke = Instance.new("UIStroke",open)
openstroke.Color = Color3.fromRGB(0,170,255)
openstroke.Thickness = 2

-- MAIN
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,370,0,250)
main.Position = UDim2.new(0.5,-185,0.5,-125)
main.BackgroundColor3 = Color3.fromRGB(10,10,10)
main.Visible = false
main.BorderSizePixel = 0

local maincorner = Instance.new("UICorner",main)
maincorner.CornerRadius = UDim.new(0,15)

local mainstroke = Instance.new("UIStroke",main)
mainstroke.Color = Color3.fromRGB(0,170,255)

-- TITLE
local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "☠ CalaHub"
title.TextColor3 = Color3.fromRGB(0,170,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 24

-- CLOSE BUTTON
local close = Instance.new("TextButton")
close.Parent = main
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,5)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 20
close.BackgroundColor3 = Color3.fromRGB(25,25,25)
close.TextColor3 = Color3.fromRGB(255,255,255)

local closecorner = Instance.new("UICorner",close)
closecorner.CornerRadius = UDim.new(1,0)

-- MENU
local menu = Instance.new("Frame")
menu.Parent = main
menu.Size = UDim2.new(0,90,1,-50)
menu.Position = UDim2.new(0,5,0,45)
menu.BackgroundColor3 = Color3.fromRGB(15,15,15)

local menucorner = Instance.new("UICorner",menu)
menucorner.CornerRadius = UDim.new(0,10)

-- CONTENT
local content = Instance.new("ScrollingFrame")
content.Parent = main
content.Size = UDim2.new(1,-105,1,-55)
content.Position = UDim2.new(0,100,0,45)
content.CanvasSize = UDim2.new(0,0,2,0)
content.ScrollBarThickness = 3
content.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout",content)
layout.Padding = UDim.new(0,5)

-- CLEAR
local function clear()
	for _,v in pairs(content:GetChildren()) do
		if not v:IsA("UIListLayout") then
			v:Destroy()
		end
	end
end

-- CREATE TOGGLE
local function Toggle(text)
	local b = Instance.new("TextButton")
	b.Parent = content
	b.Size = UDim2.new(1,-5,0,40)
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.Text = text.." : OFF"
	b.Font = Enum.Font.GothamBold
	b.TextSize = 18
	b.TextColor3 = Color3.fromRGB(255,255,255)

	local bc = Instance.new("UICorner",b)
	bc.CornerRadius = UDim.new(0,10)

	local enabled = false

	b.MouseButton1Click:Connect(function()
		enabled = not enabled

		if enabled then
			b.Text = text.." : ON"
			b.BackgroundColor3 = Color3.fromRGB(0,170,255)
		else
			b.Text = text.." : OFF"
			b.BackgroundColor3 = Color3.fromRGB(20,20,20)
		end
	end)
end

-- CREATE BOX
local function Box(text,default)
	local frame = Instance.new("Frame")
	frame.Parent = content
	frame.Size = UDim2.new(1,-5,0,45)
	frame.BackgroundColor3 = Color3.fromRGB(20,20,20)

	local fc = Instance.new("UICorner",frame)
	fc.CornerRadius = UDim.new(0,10)

	local label = Instance.new("TextLabel")
	label.Parent = frame
	label.Size = UDim2.new(0.5,0,1,0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.Font = Enum.Font.GothamBold
	label.TextSize = 16
	label.TextColor3 = Color3.fromRGB(255,255,255)

	local box = Instance.new("TextBox")
	box.Parent = frame
	box.Size = UDim2.new(0,70,0,30)
	box.Position = UDim2.new(1,-80,0.5,-15)
	box.Text = tostring(default)
	box.BackgroundColor3 = Color3.fromRGB(30,30,30)
	box.TextColor3 = Color3.fromRGB(0,170,255)
	box.Font = Enum.Font.GothamBold
	box.TextSize = 16

	local bc = Instance.new("UICorner",box)
	bc.CornerRadius = UDim.new(0,8)

	return box
end

-- MAIN TAB
local function MainTab()
	clear()

	local speed = Box("WalkSpeed",50)

	speed.FocusLost:Connect(function()
		pcall(function()
			player.Character.Humanoid.WalkSpeed = tonumber(speed.Text)
		end)
	end)

	local jump = Box("JumpPower",100)

	jump.FocusLost:Connect(function()
		pcall(function()
			player.Character.Humanoid.JumpPower = tonumber(jump.Text)
		end)
	end)

	Toggle("Infinite Jump")
	Toggle("Fly")
	Toggle("Noclip")
end

-- PLAYER TAB
local function PlayerTab()
	clear()

	Toggle("Anti AFK")

	local gravity = Box("Gravity",196)

	gravity.FocusLost:Connect(function()
		pcall(function()
			workspace.Gravity = tonumber(gravity.Text)
		end)
	end)
end

-- COMBAT TAB
local function CombatTab()
	clear()

	Toggle("Kill Aura")
	Toggle("Auto Farm")

	Box("Reach",15)
	Box("Attack Speed",1)
end

-- VISUAL TAB
local function VisualTab()
	clear()

	Toggle("ESP")
	Toggle("FullBright")
	Toggle("Hitbox")
	Toggle("Tracers")
	Toggle("FPS Boost")
end

-- SETTINGS TAB
local function SettingsTab()
	clear()

	Toggle("Blue Theme")
	Toggle("Dark Theme")

	local color = Box("Blue Amount",170)

	color.FocusLost:Connect(function()
		local num = tonumber(color.Text)

		if num then
			mainstroke.Color = Color3.fromRGB(0,num,255)
			openstroke.Color = Color3.fromRGB(0,num,255)
			title.TextColor3 = Color3.fromRGB(0,num,255)
		end
	end)
end

-- MENU BUTTON
local function MenuButton(text,y,callback)
	local b = Instance.new("TextButton")
	b.Parent = menu
	b.Size = UDim2.new(1,-10,0,35)
	b.Position = UDim2.new(0,5,0,y)
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.Text = text
	b.TextColor3 = Color3.fromRGB(255,255,255)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16

	local bc = Instance.new("UICorner",b)
	bc.CornerRadius = UDim.new(0,8)

	b.MouseButton1Click:Connect(callback)
end

MenuButton("Main",10,MainTab)
MenuButton("Player",50,PlayerTab)
MenuButton("Combat",90,CombatTab)
MenuButton("Visual",130,VisualTab)
MenuButton("Settings",170,SettingsTab)

MainTab()

-- OPEN/CLOSE
open.MouseButton1Click:Connect(function()

	if main.Visible == false then

		main.Visible = true
		main.BackgroundTransparency = 1

		TweenService:Create(main,TweenInfo.new(0.3),{
			BackgroundTransparency = 0
		}):Play()

		TweenService:Create(blur,TweenInfo.new(0.3),{
			Size = 15
		}):Play()

	else

		local tween = TweenService:Create(main,TweenInfo.new(0.3),{
			BackgroundTransparency = 1
		})

		tween:Play()

		TweenService:Create(blur,TweenInfo.new(0.3),{
			Size = 0
		}):Play()

		tween.Completed:Wait()

		main.Visible = false
	end
end)

close.MouseButton1Click:Connect(function()
	main.Visible = false
	blur.Size = 0
end)

-- DRAG BUTTON
local dragging = false
local dragInput
local dragStart
local startPos

open.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = open.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

open.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart

		open.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- FPS + PING
local stats = Instance.new("TextLabel")
stats.Parent = main
stats.Size = UDim2.new(0,120,0,45)
stats.Position = UDim2.new(1,-125,1,-50)
stats.BackgroundTransparency = 1
stats.TextColor3 = Color3.fromRGB(255,255,255)
stats.Font = Enum.Font.Gotham
stats.TextSize = 13
stats.TextXAlignment = Enum.TextXAlignment.Right

RunService.RenderStepped:Connect(function()
	local fps = math.floor(1 / RunService.RenderStepped:Wait())

	stats.Text =
	"FPS: "..fps..
	"\nPlayers: "..#Players:GetPlayers()
end)
