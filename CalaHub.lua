print("CalaHub funcionando 🔥")

game.StarterGui:SetCore("SendNotification",{
    Title = "CalaHub",
    Text = "Todo funciona 😎",
    Duration = 5
})
-- FUNCIONES UNIVERSALES FUNCIONALES PARA CALAHUB

-- INFINITE JUMP
local InfiniteJump = false

game:GetService("UserInputService").JumpRequest:Connect(function()
	if InfiniteJump then
		game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
	end
end)

-- NOCLIP
local Noclip = false

game:GetService("RunService").Stepped:Connect(function()
	if Noclip and game.Players.LocalPlayer.Character then
		for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

-- FULLBRIGHT
local FullBright = false

spawn(function()
	while wait() do
		if FullBright then
			game:GetService("Lighting").Brightness = 5
			game:GetService("Lighting").ClockTime = 12
			game:GetService("Lighting").FogEnd = 100000
			game:GetService("Lighting").GlobalShadows = false
		end
	end
end)

-- FLY
local Fly = false
local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local speed = 50

spawn(function()
	while wait() do
		if Fly and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then

			local hrp = player.Character.HumanoidRootPart

			local bv = hrp:FindFirstChild("CalaFly")

			if not bv then
				bv = Instance.new("BodyVelocity")
				bv.Name = "CalaFly"
				bv.MaxForce = Vector3.new(999999,999999,999999)
				bv.Parent = hrp
			end

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

			bv.Velocity = move * speed

		else
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local old = player.Character.HumanoidRootPart:FindFirstChild("CalaFly")

				if old then
					old:Destroy()
				end
			end
		end
	end
end)

-- ESP
local ESP = false

spawn(function()
	while wait(1) do
		if ESP then
			for _,v in pairs(game.Players:GetPlayers()) do
				if v ~= player and v.Character and not v.Character:FindFirstChild("CalaESP") then

					local h = Instance.new("Highlight")
					h.Name = "CalaESP"
					h.FillColor = Color3.fromRGB(0,170,255)
					h.OutlineColor = Color3.fromRGB(255,255,255)
					h.Parent = v.Character

				end
			end
		else
			for _,v in pairs(game.Players:GetPlayers()) do
				if v.Character and v.Character:FindFirstChild("CalaESP") then
					v.Character.CalaESP:Destroy()
				end
			end
		end
	end
end)

-- HITBOX
local Hitbox = false

spawn(function()
	while wait(1) do
		if Hitbox then
			for _,v in pairs(game.Players:GetPlayers()) do
				if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then

					v.Character.HumanoidRootPart.Size = Vector3.new(8,8,8)
					v.Character.HumanoidRootPart.Transparency = 0.5
					v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Bright blue")
					v.Character.HumanoidRootPart.Material = Enum.Material.Neon
					v.Character.HumanoidRootPart.CanCollide = false

				end
			end
		end
	end
end)

-- TRACERS
local Tracers = false

spawn(function()
	while wait(1) do
		if Tracers then
			for _,v in pairs(game.Players:GetPlayers()) do
				if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then

					if not v.Character:FindFirstChild("Tracer") then

						local beam = Instance.new("Beam")
						beam.Name = "Tracer"

						local a0 = Instance.new("Attachment")
						local a1 = Instance.new("Attachment")

						a0.Parent = player.Character.HumanoidRootPart
						a1.Parent = v.Character.HumanoidRootPart

						beam.Attachment0 = a0
						beam.Attachment1 = a1
						beam.Width0 = 0.1
						beam.Width1 = 0.1
						beam.Color = ColorSequence.new(Color3.fromRGB(0,170,255))
						beam.Parent = v.Character

					end
				end
			end
		end
	end
end)

-- FPS BOOST
local FPSBoost = false

spawn(function()
	while wait(2) do
		if FPSBoost then
			for _,v in pairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") then
					v.Material = Enum.Material.SmoothPlastic
					v.Reflectance = 0
				end

				if v:IsA("Texture") then
					v:Destroy()
				end
			end
		end
	end
end)

-- FOV
local camera = workspace.CurrentCamera

local function SetFOV(num)
	camera.FieldOfView = num
end

print("Funciones universales cargadas 🔥")
