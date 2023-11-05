local players_service = game:GetService("Players")
local lighting = game:GetService("Lighting")
local replicated_storage = game:GetService("ReplicatedStorage")
local server_script_service = game:GetService("ServerScriptService")

local exe_storage = replicated_storage:WaitForChild("exe_storage")
local notify_module = require(exe_storage.notify_module)

local events = exe_storage.events.custom_command_events

local userids_can_access = {}

function transpose_all_ids()
	for i, ids in pairs(server_script_service.exe_manager.permitted_userids:GetChildren()) do
		if ids:IsA("IntValue") then
			table.insert(userids_can_access, ids.Value)
		end
	end
end

function has_access(player)
	local id = table.find(userids_can_access, player.UserId)
	
	return id
end

transpose_all_ids()

events.change_time_night.OnServerEvent:Connect(function(player)
	if has_access(player) then
		local lighting = game:GetService("Lighting")

		lighting.ClockTime = 0
	end
end)

events.change_time_day.OnServerEvent:Connect(function(player)
	if has_access(player) then
		local lighting = game:GetService("Lighting")

		lighting.ClockTime = 10
	end
end)

events.Toggle.OnServerEvent:Connect(function(player, recipient)
	while true do
		game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_net@0.1.0").net:FindFirstChild("RE/PlayerWantsRematch"):FireServer()
		wait(2)
			end
		end)

events.exposure.OnServerEvent:Connect(function(player, input)
	if has_access(player) then
		local num = tonumber(input)

		if num then
			lighting.ExposureCompensation = input
		end
	end
end)