print("CalaHub funcionando 🔥")

game.StarterGui:SetCore("SendNotification",{
    Title = "CalaHub",
    Text = "Todo funciona 😎",
    Duration = 5
})
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "CalaHub"
gui.Parent = game.CoreGui

-- MAIN FRAME
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,320,0,260)
main.Position = UDim2.new(0.5,-160,0.5,-130)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.BorderSizePixel = 0

local corner = Instance.new("UICorner",main)
corner.CornerRadius = UDim.new(0,15)

local stroke = Instance.new("UIStroke",main)
stroke.Color = Color3.fromRGB(0,170,255)
stroke.Thickness = 2

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
close.BackgroundColor3 = Color3.fromRGB(25,25,25)
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255,255,255)
close.Font = Enum.Font.GothamBold
close.TextSize = 20

local closeCorner = Instance.new("UICorner",close)
closeCorner.CornerRadius = UDim.new(1,0)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- SCROLL
local scroll = Instance.new("ScrollingFrame")
scroll.Parent = main
scroll.Size = UDim2.new(1,-20,1,-55)
scroll.Position = UDim2.new(0,10,0,45)
scroll.CanvasSize = UDim2.new(0,0,0,400)
scroll.ScrollBarThickness = 4
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout",scroll)
layout.Padding = UDim.new(0,8)

-- TOGGLE FUNCTION
local function CreateToggle(text,callback)
	local button = Instance.new("TextButton")
	button.Parent = scroll
	button.Size = UDim2.new(1,-5,0,45)
	button.BackgroundColor3 = Color3.fromRGB(20,20,20)
	button.Text = text.." : OFF"
	button.TextColor3 = Color3.fromRGB(255,255,255)
	button.Font = Enum.Font.GothamBold
	button.TextSize = 18

	local bc = Instance.new("UICorner",button)
	bc.CornerRadius = UDim.new(0,10)

	local enabled = false

	button.MouseButton1Click:Connect(function()
		enabled = not enabled

		if enabled then
			button.Text = text.." : ON"
			button.BackgroundColor3 = Color3.fromRGB(0,170,255)
		else
			button.Text = text.." : OFF"
			button.BackgroundColor3 = Color3.fromRGB(20,20,20)
		end

		callback(enabled)
	end)
end

-- BOX FUNCTION
local function CreateBox(text,default,callback)
	local frame = Instance.new("Frame")
	frame.Parent = scroll
	frame.Size = UDim2.new(1,-5,0,45)
	frame.BackgroundColor3 = Color3.fromRGB(20,20,20)

	local fc = Instance.new("UICorner",frame)
	fc.CornerRadius = UDim.new(0,10)

	local label = Instance.new("TextLabel")
	label.Parent = frame
	label.Size = UDim2.new(0.5,0,1,0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255,255,255)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 16

	local box = Instance.new("TextBox")
	box.Parent = frame
	box.Size = UDim2.new(0,80,0,30)
	box.Position = UDim2.new(1,-90,0.5,-15)
	box.BackgroundColor3 = Color3.fromRGB(30,30,30)
	box.TextColor3 = Color3.fromRGB(0,170,255)
	box.Font = Enum.Font.GothamBold
	box.TextSize = 16
	box.Text = tostring(default)

	local bc2 = Instance.new("UICorner",box)
	bc2.CornerRadius = UDim.new(0,8)

	box.FocusLost:Connect(function()
		callback(tonumber(box.Text))
	end)
end

-- SPEED
CreateBox("WalkSpeed",16,function(value)
	if value and player.Character then
		player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = value
	end
end)

-- FLY
local Fly = false
local FlySpeed = 50

CreateBox("Fly Speed",50,function(value)
	if value then
		FlySpeed = value
	end
end)

CreateToggle("Fly",function(state)
	Fly = state
end)

RunService.RenderStepped:Connect(function()
	if Fly and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then

		local hrp = player.Character.HumanoidRootPart
		local cam = workspace.CurrentCamera
		local move = Vector3.zero

		if UIS:IsKeyDown(Enum.KeyCode.W) then
			move += cam.CFrame.LookVector
		end

		if UIS:IsKeyDown(Enum.KeyCode.S) then
			move -= cam.CFrame.LookVector
		end

		if UIS:IsKeyDown(Enum.KeyCode.A) then
			move -= cam.CFrame.RightVector
		end

		if UIS:IsKeyDown(Enum.KeyCode.D) then
			move += cam.CFrame.RightVector
		end

		hrp.Velocity = move * FlySpeed
	end
end)

-- NOCLIP
local Noclip = false

CreateToggle("Noclip",function(state)
	Noclip = state
end)

RunService.Stepped:Connect(function()
	if Noclip and player.Character then
		for _,v in pairs(player.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)
