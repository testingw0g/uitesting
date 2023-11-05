-- Gui to Lua
-- Version: 3.2

-- Instances:

local exe = Instance.new("ScreenGui")
local storage = Instance.new("Folder")
local notification = Instance.new("TextLabel")
local padding = Instance.new("UIPadding")
local accent = Instance.new("Frame")
local button_frame = Instance.new("Frame")
local button = Instance.new("ImageButton")
local scale = Instance.new("UIScale")
local padding_2 = Instance.new("UIPadding")
local frame = Instance.new("ImageButton")
local padding_3 = Instance.new("UIPadding")
local scale_2 = Instance.new("UIScale")
local glows = Instance.new("Frame")
local prism_glow = Instance.new("ImageLabel")
local scale_3 = Instance.new("UIScale")

--Properties:

exe.Name = "exe"
exe.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
exe.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
exe.DisplayOrder = 1000
exe.ResetOnSpawn = false

storage.Name = "storage"
storage.Parent = exe

notification.Name = "notification"
notification.Parent = exe
notification.AnchorPoint = Vector2.new(0.5, 0)
notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
notification.BorderSizePixel = 0
notification.Position = UDim2.new(0.5, 0, 0, 30)
notification.Size = UDim2.new(0, 200, 0, 40)
notification.Visible = false
notification.ZIndex = 10
notification.Font = Enum.Font.Gotham
notification.Text = "Notification goes here..."
notification.TextColor3 = Color3.fromRGB(255, 255, 255)
notification.TextSize = 15.000
notification.TextTransparency = 0.200
notification.TextXAlignment = Enum.TextXAlignment.Left

padding.Name = "padding"
padding.Parent = notification
padding.PaddingBottom = UDim.new(0, 5)
padding.PaddingLeft = UDim.new(0, 20)
padding.PaddingRight = UDim.new(0, 20)
padding.PaddingTop = UDim.new(0, 5)

accent.Name = "accent"
accent.Parent = notification
accent.AnchorPoint = Vector2.new(0, 0.5)
accent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
accent.BorderSizePixel = 0
accent.Position = UDim2.new(0, -20, 0.5, 0)
accent.Size = UDim2.new(0, 3, 1, 10)

button_frame.Name = "button_frame"
button_frame.Parent = exe
button_frame.AnchorPoint = Vector2.new(0.5, 0.5)
button_frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
button_frame.BackgroundTransparency = 1.000
button_frame.BorderSizePixel = 0
button_frame.Position = UDim2.new(0.5, 0, 0.5, 0)
button_frame.Size = UDim2.new(1, 0, 1, 0)

button.Name = "button"
button.Parent = button_frame
button.AnchorPoint = Vector2.new(0.5, 0.5)
button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundTransparency = 1.000
button.BorderSizePixel = 0
button.Position = UDim2.new(1, 0, 0, 0)
button.Size = UDim2.new(0, 80, 0, 50)
button.AutoButtonColor = false
button.Image = "rbxassetid://14592348670"
button.ImageTransparency = 0.800
button.ScaleType = Enum.ScaleType.Fit

scale.Name = "scale"
scale.Parent = button
scale.Scale = 0.900

padding_2.Name = "padding"
padding_2.Parent = button_frame
padding_2.PaddingBottom = UDim.new(0, 80)
padding_2.PaddingLeft = UDim.new(0, 80)
padding_2.PaddingRight = UDim.new(0, 80)
padding_2.PaddingTop = UDim.new(0, 80)

frame.Name = "frame"
frame.Parent = exe
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.800
frame.BorderSizePixel = 0
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.Size = UDim2.new(1, 0, 1, 0)
frame.Visible = false
frame.AutoButtonColor = false
frame.Modal = true
frame.Image = "rbxassetid://13685684156"

padding_3.Name = "padding"
padding_3.Parent = frame
padding_3.PaddingBottom = UDim.new(0, 20)
padding_3.PaddingLeft = UDim.new(0, 20)
padding_3.PaddingRight = UDim.new(0, 20)
padding_3.PaddingTop = UDim.new(0, 20)

scale_2.Name = "scale"
scale_2.Parent = frame

glows.Name = "glows"
glows.Parent = frame
glows.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
glows.BackgroundTransparency = 1.000
glows.BorderSizePixel = 0
glows.Size = UDim2.new(1, 0, 1, 0)
glows.ZIndex = -5

prism_glow.Name = "prism_glow"
prism_glow.Parent = glows
prism_glow.AnchorPoint = Vector2.new(0.5, 0.5)
prism_glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
prism_glow.BackgroundTransparency = 1.000
prism_glow.BorderSizePixel = 0
prism_glow.Position = UDim2.new(0.5, 0, 0.5, 0)
prism_glow.Rotation = 15.000
prism_glow.Size = UDim2.new(0, 1000, 0, 1000)
prism_glow.Image = "rbxassetid://13736983594"
prism_glow.ImageTransparency = 0.850
prism_glow.ScaleType = Enum.ScaleType.Fit

scale_3.Name = "scale"
scale_3.Parent = prism_glow

-- Module Scripts:

local fake_module_scripts = {}

do -- exe.exe_main_module
	local script = Instance.new('ModuleScript', exe)
	script.Name = "exe_main_module"
	local function module_script()
		local tween_service = game:GetService("TweenService")
		local player_service = game:GetService("Players")
		local lighting = game:GetService("Lighting")
		local replicated_storage = game:GetService("ReplicatedStorage")
		
		local exe_storage = replicated_storage:WaitForChild("exe_storage")
		
		local info = TweenInfo.new(.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
		
		local local_player = player_service.LocalPlayer
		
		local exe = script.Parent
		local frame = exe.frame
		
		local module = {}
		
		function module:exe_admin_panel(state)
			if state then
				if not frame.Visible then
					local blur = Instance.new("BlurEffect")
					--
					
					blur.Size = 0
					blur.Name = "exe_admin_panel_blur"
					blur.Parent = lighting
					
					--
					
					frame.Visible = true
					exe.button_frame.Visible = false
					
					frame.ImageTransparency = 1
					frame.scale.Scale = 1.2
					frame.main_frame.GroupTransparency = 1
					
					--
					
					tween_service:Create(frame, info, {ImageTransparency = 0}):Play()
					tween_service:Create(frame.scale, info, {Scale = 1}):Play()
					tween_service:Create(frame.main_frame, info, {GroupTransparency = 0}):Play()
					
					tween_service:Create(blur, info, {Size = 16}):Play()
					
					--
					
					exe_storage.events.admin_panel_opened:Fire()
				end
			else
				local blur = lighting:FindFirstChild("exe_admin_panel_blur")
				local addition_blur = lighting:FindFirstChild("exe_additional_blur")
				
				tween_service:Create(frame, info, {ImageTransparency = 1}):Play()
				tween_service:Create(frame.scale, info, {Scale = 1.2}):Play()
				tween_service:Create(frame.main_frame, info, {GroupTransparency = 1}):Play()
		
				tween_service:Create(blur, info, {Size = 0}):Play()
				tween_service:Create(addition_blur, info, {Size = 0}):Play()
				
				--
				
				exe_storage.events.admin_panel_closed:Fire()
				
				--
				
				task.wait(.1)
				
				--
				
				frame.Visible = false
				exe.button_frame.Visible = true
				
				blur:Destroy()
			end
		end
		
		return module
	end
	fake_module_scripts[script] = module_script
end


-- Scripts:

local function LAVO_fake_script() -- storage.handler 
	local script = Instance.new('LocalScript', storage)
	local req = require
	local require = function(obj)
		local fake = fake_module_scripts[obj]
		if fake then
			return fake()
		end
		return req(obj)
	end

	local replicated_storage = game:GetService("ReplicatedStorage")
	
	local exe_storage = replicated_storage.exe_storage
	local events = exe_storage.events.banit_events
	
	local module = require(exe_storage:WaitForChild("notify_module"))
	
	events.notify.OnClientEvent:Connect(function(text, duration)
		module:notify(text, duration, "gray")
	end)
	
	events.announce.OnClientEvent:Connect(function(text, duration)
		module:announce(text, duration)
	end)
end
coroutine.wrap(LAVO_fake_script)()
local function EVVTRA_fake_script() -- storage.notify_receiver 
	local script = Instance.new('LocalScript', storage)
	local req = require
	local require = function(obj)
		local fake = fake_module_scripts[obj]
		if fake then
			return fake()
		end
		return req(obj)
	end

	local run_service = game:GetService("RunService")
	local tween_service = game:GetService("TweenService")
	local player_service = game:GetService("Players")
	local replicated_storage = game:GetService("ReplicatedStorage")
	
	local info = TweenInfo.new(.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
	
	local local_player = player_service.LocalPlayer
	
	local exe = local_player.PlayerGui:WaitForChild("exe")
	local notification = exe.notification
	local announcement = exe.announcement
	
	local storage = replicated_storage:WaitForChild("exe_storage")
	
	storage.notify_module.notify.OnClientEvent:Connect(function(text, duration, accent)
		local item = notification:Clone()
		item.Position = UDim2.fromScale(.5, -.5)
		item.Visible = true
		item.Text = text
	
		--
	
		if accent == "red" then
			item.accent.BackgroundColor3 = Color3.fromRGB(255, 53, 53)
		elseif accent == "green" then
			item.accent.BackgroundColor3 = Color3.fromRGB(35, 255, 86)
		elseif accent == "blue" then
			item.accent.BackgroundColor3 = Color3.fromRGB(83, 83, 255)
		elseif accent == "gray" then
			item.accent.BackgroundColor3 = Color3.fromRGB(139, 139, 139)
		end
	
		--
	
		item.Parent = exe.storage
	
		--
	
		tween_service:Create(item, info, {Position = UDim2.new(.5, 0, 0, 30)}):Play()
	
		task.wait(duration)
	
		tween_service:Create(item, info, {Position = UDim2.fromScale(.5, -.5)}):Play()
	
		--
	
		task.wait(.5)
	
		item:Destroy()
	end)
end
coroutine.wrap(EVVTRA_fake_script)()
local function OYYHY_fake_script() -- button_frame.handler 
	local script = Instance.new('LocalScript', button_frame)
	local req = require
	local require = function(obj)
		local fake = fake_module_scripts[obj]
		if fake then
			return fake()
		end
		return req(obj)
	end

	local input_service = game:GetService("UserInputService")
	local tween_service = game:GetService("TweenService")
	local players = game:GetService("Players")
	
	local info = TweenInfo.new(.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
	local info_2 = TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
	
	local local_player = players.LocalPlayer
	local exe = local_player.PlayerGui:WaitForChild("exe")
	local module = require(exe.exe_main_module)
	local mouse = local_player:GetMouse()
	
	local cam = workspace.CurrentCamera
	local viewport = cam.ViewportSize
	
	local frame = script.Parent
	local button = frame.button
	
	local drag_toggle = nil
	local drag_speed = .1
	local drag_start = nil
	local start_pos = nil
	local intended_to_drag = false
	local in_button = false
	
	function update(input)
		local delta = input.Position - drag_start
		local position = UDim2.new(start_pos.X.Scale, start_pos.X.Offset + delta.X, start_pos.Y.Scale, start_pos.Y.Offset + delta.Y)
		local info = TweenInfo.new(drag_speed, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
	
		tween_service:Create(button, info, {Position = position}):Play()
	end
	
	function initialize()
		button.scale.Scale = 0 
		
		repeat task.wait()
		until workspace.DistributedGameTime > 5
		
		--
		
		tween_service:Create(button.scale, info, {Scale = 1}):Play()
	end
	
	initialize()
	
	--
	
	button.MouseEnter:Connect(function() 
		in_button = true 
		
		tween_service:Create(button, info, {ImageTransparency = 0}):Play()
		tween_service:Create(button.scale, info, {Scale = 1}):Play()
	end)
	
	button.MouseLeave:Connect(function() in_button = false end)
	
	button.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
			drag_toggle = true
			intended_to_drag = false
	
			drag_start = input.Position
			start_pos = button.Position
	
			input.Changed:Connect(function()
				if drag_toggle then
					if input.UserInputState == Enum.UserInputState.End then
						local half_v = viewport.X / 2
	
						drag_toggle = false
	
						tween_service:Create(button, info, {ImageTransparency = 0}):Play()
						tween_service:Create(button.scale, info, {Scale = 1}):Play()
	
						if mouse.X > half_v then
							tween_service:Create(button, info, {Position = UDim2.new(1, 0, 0, button.Position.Y.Offset)}):Play()
						else
							tween_service:Create(button, info, {Position = UDim2.new(0, 0, 0, button.Position.Y.Offset)}):Play()
						end
					end
				end
			end)
		end
	end)
	
	input_service.InputBegan:Connect(function(input)
		if in_button then
			tween_service:Create(button, info, {ImageTransparency = 0}):Play()
			tween_service:Create(button.scale, info, {Scale = 1}):Play()
	
		else
			tween_service:Create(button, info, {ImageTransparency = .8}):Play()
			tween_service:Create(button.scale, info, {Scale = .9}):Play()
	
		end
	end)
	
	input_service.InputChanged:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			if drag_toggle and intended_to_drag then
	
				intended_to_drag = true
	
				update(input)
	
			end
		end
	end)
	
	button.MouseLeave:Connect(function()
		if drag_toggle then
			tween_service:Create(button, info_2, {ImageTransparency = .5}):Play()
			tween_service:Create(button.scale, info_2, {Scale = 1.2}):Play()
	
			task.wait(.3)
	
			if drag_toggle then
				intended_to_drag = true
	
			else
				tween_service:Create(button, info_2, {ImageTransparency = 0}):Play()
				tween_service:Create(button.scale, info_2, {Scale = 1}):Play()
			end
		end
	end)
	
	button.MouseButton1Click:Connect(function()
		if not intended_to_drag then
			module:exe_admin_panel(true)
		end
	end)
end
coroutine.wrap(OYYHY_fake_script)()
local function TVSZRT_fake_script() -- frame.input_handler 
	local script = Instance.new('LocalScript', frame)
	local req = require
	local require = function(obj)
		local fake = fake_module_scripts[obj]
		if fake then
			return fake()
		end
		return req(obj)
	end

	local input_service = game:GetService("UserInputService")
	local replicated_storage = game:GetService("ReplicatedStorage")
	
	local frame = script.Parent
	local ui = frame.Parent
	
	local main_module = require(ui.exe_main_module)
	local exe_module = require(replicated_storage:WaitForChild("exe_storage").exe_module)
	
	local debounce = false
	
	input_service.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.F2 then		
			if not debounce then
				if not frame.Visible then
					debounce = true
	
					main_module:exe_admin_panel(true)
	
					task.wait(1)
	
					debounce = false
				end
			end
		end
	end)
end
coroutine.wrap(TVSZRT_fake_script)()
