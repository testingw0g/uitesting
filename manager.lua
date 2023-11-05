local player_service = game:GetService("Players")
local replicated_storage = game:GetService("ReplicatedStorage")
local server_script_service = game:GetService("ServerScriptService")

local folder = script.Parent

local userids_can_access = {}

function set_states()
	folder.exe_scripts.events_handler.Enabled = true
	folder.exe_scripts.filter_string_invoke.Enabled = true
	
	folder.exe_storage.Parent = replicated_storage
	folder.exe_scripts.Parent = server_script_service
end

function transpose_all_ids()
	for i, ids in pairs(folder.permitted_userids:GetChildren()) do
		if ids:IsA("IntValue") then
			table.insert(userids_can_access, ids.Value)
		end
	end
end

set_states()
transpose_all_ids()

local exe_storage = replicated_storage:WaitForChild("exe_storage")

local server_locked_message = "This server is currently locked. You may join this game by manually selecting server in the Server Page."

player_service.PlayerAdded:Connect(function(plr)
	local id = table.find(userids_can_access, plr.UserId)
	
	if folder.status.server_locked.Value then
		if id then
			if exe_storage.configuration.player_have_access_to_exe_panel_allowed_to_join_locked_servers.Value then
				local exe = folder.exe:Clone()

				for i, handlers in pairs(exe:GetDescendants()) do
					if handlers:IsA("LocalScript") then
						handlers.Enabled = true
					end
				end

				exe.Parent = plr.PlayerGui
			else
				plr:Kick(server_locked_message)
				
			end
		else
			plr:Kick(server_locked_message)
			
		end
		
	else
		if id then
			local exe = folder.exe:Clone()

			for i, handlers in pairs(exe:GetDescendants()) do
				if handlers:IsA("LocalScript") then
					handlers.Enabled = true
				end
			end

			exe.Parent = plr.PlayerGui
			
		else
			local exe = folder.exe:Clone()

			exe.frame:Destroy()
			exe.exe_main_module:Destroy()
			exe.button_frame:Destroy()
			exe.Parent = plr.PlayerGui
		end
	end
end)