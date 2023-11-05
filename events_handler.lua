local players_service = game:GetService("Players")
local replicated_storage = game:GetService("ReplicatedStorage")
local server_script_service = game:GetService("ServerScriptService")

local exe_storage = replicated_storage:WaitForChild("exe_storage")
local events = exe_storage.events.banit_events

local banit_module = require(server_script_service:WaitForChild("exe_scripts").banit_module)
local notify_module = require(exe_storage.notify_module)

local userids_can_access = {}

function transpose_all_ids()
	for i, ids in pairs(server_script_service.exe_manager.permitted_userids:GetChildren()) do
		if ids:IsA("IntValue") then
			table.insert(userids_can_access, ids.Value)
		end
	end
end

type val_attributes = "canBan" | "canExecuteCC" | "canGiveEffects" | "canGiveTools" | "canKick" | "canLockServer" | "canUnban"

function get_attribute(id, attribute:val_attributes)
	for i, value in pairs(server_script_service.exe_manager.permitted_userids:GetChildren()) do
		if (value:IsA("IntValue") and id == value.Value) then
			if value:GetAttribute(attribute) then
				return true
			else
				return false
			end
		end
	end
end

function has_access(player)
	local id = table.find(userids_can_access, player.UserId)

	return id
end

transpose_all_ids()

--

exe_storage.events.get_access.OnServerInvoke = function(player, attribute:val_attributes)
	for i, value in pairs(server_script_service.exe_manager.permitted_userids:GetChildren()) do
		if (value:IsA("IntValue") and player.UserId == value.Value) then
			if value:GetAttribute(attribute) then
				return true
			else
				return false
			end
		end
	end
end

exe_storage.events.get_access_custom_command.OnServerInvoke = function(player, attribute:val_attributes)
	for i, value in pairs(server_script_service.exe_manager.permitted_userids:GetChildren()) do
		if (value:IsA("IntValue") and player.UserId == value.Value) then
			if value:GetAttribute(attribute) then
				return "granted"
			elseif value:GetAttribute(attribute) == false then
				return "failed"
			elseif value:GetAttribute(attribute) == nil then
				return "none"
			end
		end
	end
end

exe_storage.events.get_bans.OnServerInvoke = function(player)
	return banit_module.get_banned_ids()
end

--

events.ban.OnServerEvent:Connect(function(player, username, reason)
	if (has_access(player) and get_attribute(player.UserId, "canBan")) then
		banit_module.Ban(username, reason)
	else
		notify_module:notify("You have been forbidden to use this feature.", 5, "red", player)
	end
end)

events.unban.OnServerEvent:Connect(function(player, username)
	if (has_access(player) and get_attribute(player.UserId, "canUnban")) then
		banit_module.Unban(username)
	else
		notify_module:notify("You have been forbidden to use this feature.", 5, "red", player)
	end
end)

--

events.kick.OnServerEvent:Connect(function(player, username, reason, delay)
	if (has_access(player) and get_attribute(player.UserId, "canKick")) then
		banit_module.kick(username, reason, delay)
	else
		notify_module:notify("You have been forbidden to use this feature.", 5, "red", player)
	end
end)

--

events.notify.OnServerEvent:Connect(function(player, recipient, text, duration)
	if has_access(player) then
		events.notify:FireClient(recipient, text, duration)
	end
end)

events.announce.OnServerEvent:Connect(function(player, text, duration)
	if has_access(player) then
		events.announce:FireAllClients(text, duration)
	end
end)

--

events.server_lock.OnServerEvent:Connect(function(player, locked)
	if (has_access(player) and get_attribute(player.UserId, "canLockServer")) then
		local status = server_script_service.exe_manager.status

		if locked then
			status.server_locked.Value = true

			events.server_lock:FireAllClients(locked)
		else
			status.server_locked.Value = false

			events.server_lock:FireAllClients(locked)
		end
	else
		notify_module:notify("You have been forbidden to use this feature.", 5, "red", player)
	end
end)

events.server_locked.OnServerInvoke = function(player)
	if has_access(player) then
		local status = server_script_service.exe_manager.status

		return status.server_locked.Value
	end
end

--

events.teleport.OnServerEvent:Connect(function(player, teleport_type, recipient)
	if has_access(player) then
		if exe_storage.configuration.sparkles_when_teleporting_and_setting_visibility.Value then
			local attachment = exe_storage.objects.container_sparkles.attachment:Clone()

			attachment.Parent = recipient.Character:WaitForChild("HumanoidRootPart")
			attachment.sparkles:Emit(50)
		end

		if teleport_type == "bring" then
			local char_a = recipient.Character
			local char_b = player.Character

			--

			char_a:PivotTo(char_b.Head.CFrame)
		elseif teleport_type == "follow" then
			local char_a = recipient.Character
			local char_b = player.Character

			--

			char_b:PivotTo(char_a.Head.CFrame)
		end
	end
end)

events.visibility.OnServerEvent:Connect(function(player, visible, recipient:Player)
	if has_access(player) then
		local character = recipient.Character

		if exe_storage.configuration.sparkles_when_teleporting_and_setting_visibility.Value then
			local attachment = exe_storage.objects.container_sparkles.attachment:Clone()

			attachment.Parent = character:WaitForChild("HumanoidRootPart")
			attachment.sparkles:Emit(50)
		end

		if visible then
			for i, parts in pairs(character:GetDescendants()) do
				if parts.Name ~= "HumanoidRootPart" then
					if (parts:IsA("MeshPart") or parts:IsA("Part") or parts:IsA("Decal")) then
						parts.Transparency = 0
					end
				end
			end

		else
			for i, parts in pairs(character:GetDescendants()) do
				if parts.Name ~= "HumanoidRootPart" then
					if (parts:IsA("MeshPart") or parts:IsA("Part") or parts:IsA("Decal")) then
						parts.Transparency = 1
					end
				end
			end
		end
	end
end)

events.configure.OnServerEvent:Connect(function(player, recipient, configure_type, value)
	if has_access(player) then
		local character = recipient.Character
		local humanoid = character:WaitForChild("Humanoid")

		if configure_type == "walk" then
			humanoid.WalkSpeed = value

		elseif configure_type == "jump" then
			if humanoid.UseJumpPower then
				humanoid.JumpPower = value

			else
				humanoid.JumpHeight = value

			end

		elseif configure_type == "health" then
			humanoid.Health = value

		end
	end
end)

--

events.give_tool.OnServerEvent:Connect(function(player, recipient, tool)
	if (has_access(player) and get_attribute(player.UserId, "canGiveTools")) then
		local copy = tool:Clone()
		copy.Parent = recipient.Backpack
	else
		notify_module:notify("You have been forbidden to use this feature.", 5, "red", player)
	end
end)

events.apply_effect.OnServerEvent:Connect(function(player, recipient, obj)
	if (has_access(player) and get_attribute(player.UserId, "canGiveEffects")) then
		local character = recipient.Character
		local root = character.HumanoidRootPart

		if obj:IsA("Folder") then
			local folder = obj:Clone()

			for i, effects in pairs(folder:GetChildren()) do
				effects.Parent = root
				folder:Destroy()
			end
		else
			local effect = obj:Clone()
			effect.Parent = root

		end
	else
		notify_module:notify("You have been forbidden to use this feature.", 5, "red", player)
	end
end)

events.clear_effects.OnServerEvent:Connect(function(player, recipient)
	if has_access(player) then
		local character = recipient.Character
		local root = character.HumanoidRootPart

		for i, effects in pairs(root:GetChildren()) do
			if (effects:GetAttribute("EffectIcon") and effects:GetAttribute("EffectName")) then
				effects:Destroy()
			end
		end
	end
end)

--

events.jail.OnServerEvent:Connect(function(player, duration, userid)
	if has_access(player) then

		local jail = exe_storage.objects.jail:Clone()
		local char = players_service:GetPlayerByUserId(userid).Character

		char.HumanoidRootPart.Anchored = true

		--

		task.wait(1)

		--

		jail:PivotTo(char.PrimaryPart.CFrame)
		jail.Parent = workspace

		char.LowerTorso.CFrame = jail.center.CFrame

		--

		task.wait(.5)

		--

		char.HumanoidRootPart.Anchored = false

		--

		task.wait(duration)

		--

		for i, parts in pairs(jail:GetDescendants()) do
			if (parts:IsA("UnionOperation") or parts:IsA("Part")) then
				parts.CanCollide = false
				parts.Anchored = false
			end
		end

		task.wait(1)

		jail:Destroy()
	end
end)