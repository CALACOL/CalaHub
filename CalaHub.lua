local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "CalaHub"
gui.Parent = game.CoreGui

-- OPEN BUTTON
local open = Instance.new("ImageButton")
open.Parent = gui
open.Size = UDim2.new(0,60,0,60)
open.Position = UDim2.new(0,20,0.5,-30)
open.BackgroundTransparency = 1
open.Image = "rbxassetid://0"
open.Draggable = true

-- MAIN FRAME
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,650,0,400)
main.Position = UDim2.new(0.5,-325,0.5,-200)
main.BackgroundColor3 = Color3.fromRGB(0,0,0)
main.BorderSizePixel = 0
main.Visible = false

local corner = Instance.new("UICorner",main)
corner.CornerRadius = UDim.new(0,20)

local stroke = Instance.new("UIStroke",main)
stroke.Color = Color3.fromRGB(0,170,255)
stroke.Thickness = 2

-- TITLE
local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,60)
title.BackgroundTransparency = 1
title.Text = "CALA HUB"
title.Font = Enum.Font.GothamBlack
title.TextSize = 40
title.TextColor3 = Color3.fromRGB(0,170,255)

-- BLUR
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

-- MUSIC
local music = Instance.new("Sound")
music.Parent = gui
music.SoundId = "rbxassetid://1843529634"
music.Volume = 2
music.Looped = true

-- OPEN SOUND
local opensound = Instance.new("Sound")
opensound.Parent = gui
opensound.SoundId = "rbxassetid://9118823108"
opensound.Volume = 2

-- CLOSE SOUND
local closesound = Instance.new("Sound")
closesound.Parent = gui
closesound.SoundId = "rbxassetid://9118823108"
closesound.Volume = 2

-- ANIMATION
open.MouseButton1Click:Connect(function()
	if main.Visible == false then
		main.Visible = true
		main.BackgroundTransparency = 1
		
		TweenService:Create(main,TweenInfo.new(0.4),{
			BackgroundTransparency = 0
		}):Play()

		TweenService:Create(blur,TweenInfo.new(0.4),{
			Size = 20
		}):Play()

		opensound:Play()
		music:Play()
	else
		local tween = TweenService:Create(main,TweenInfo.new(0.4),{
			BackgroundTransparency = 1
		})

		tween:Play()

		TweenService:Create(blur,TweenInfo.new(0.4),{
			Size = 0
		}):Play()

		closesound:Play()
		music:Stop()

		tween.Completed:Wait()
		main.Visible = false
	end
end)

-- DRAG GUI
local dragging
local dragInput
local dragStart
local startPos

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- BUTTONS
local functions = {
	"Velocidad",
	"Infinite Jump",
	"Noclip",
	"FullBright",
	"Reset Character",
	"Low Gravity",
	"ESP",
	"Fly",
	"TP Tool",
	"AutoFarm",
	"Recolectar Monedas"
}

for i,v in pairs(functions) do
	local b = Instance.new("TextButton")
	b.Parent = main
	b.Size = UDim2.new(0,300,0,50)
	b.Position = UDim2.new(0,20,0,70 + (i*55))
	b.BackgroundColor3 = Color3.fromRGB(15,15,15)
	b.Text = v
	b.TextColor3 = Color3.fromRGB(0,170,255)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 24
	
	local bc = Instance.new("UICorner",b)
	bc.CornerRadius = UDim.new(0,15)
end

-- STATUS
local stats = Instance.new("TextLabel")
stats.Parent = main
stats.Size = UDim2.new(0,220,0,120)
stats.Position = UDim2.new(1,-240,0,80)
stats.BackgroundTransparency = 1
stats.TextColor3 = Color3.fromRGB(0,170,255)
stats.Font = Enum.Font.Gotham
stats.TextSize = 22
stats.TextXAlignment = Enum.TextXAlignment.Left
stats.TextYAlignment = Enum.TextYAlignment.Top

RunService.RenderStepped:Connect(function()
	stats.Text =
	"FPS: 60\n"..
	"Players: "..#Players:GetPlayers().."\n"..
	"Time Played: "..math.floor(tick()).."s\n"..
	"Clock: "..os.date("%X")
end)
