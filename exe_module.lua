local tween_service = game:GetService("TweenService")
local player_service = game:GetService("Players")
local lighting = game:GetService("Lighting")
local replicated_storage = game:GetService("ReplicatedStorage")

local info = TweenInfo.new(.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

local local_player = player_service.LocalPlayer

local exe = local_player.PlayerGui:WaitForChild("exe")

local notification = exe.notification
local frame = exe.frame

local ban = frame.ban_frame
local profile = frame.profile_frame
local kick = frame.kick_frame
local notify = frame.notify_frame
local announcement = frame.announcement_frame
local tool_manager = frame.tool_manager_frame
local config_menu = frame.configure_frame
local credits = frame.credits_frame
local jail = frame.jail_frame
local effects = frame.effects_frame
local custom_commands = frame.custom_command_frame
local commands_list = frame.command_list_frame

local glow = frame.glows

local links = frame.credits_page
local dashboard = frame.dashboard_frame
local main = frame.main_frame
local menu = frame.menu_frame

local exe_storage = replicated_storage.exe_storage
local notify_module = require(exe_storage:WaitForChild("notify_module"))

type accents = "red" | "green" | "blue" | "gray"
type pages = "main_menu" | "dashboard" | "credits"
type configs = "health" | "jump" | "walk" | "none"

local blur = Instance.new("BlurEffect")

blur.Size = 0
blur.Name = "exe_additional_blur"
blur.Parent = lighting

local module = {}

function module:notify(text, duration, accent: accents)
	notify_module:notify(text, duration, accent)
end

function module:announce(text, duration)
	notify_module:announce(text, duration)
end

function module:main(state)
	if state then
		dashboard.idle_layer.Visible = false
		links.idle_layer.Visible = false
		main.idle_layer.Visible = false

		tween_service:Create(main, info, {GroupTransparency = 0}):Play()
		tween_service:Create(main.scale, info, {Scale = 1}):Play()

		tween_service:Create(dashboard, info, {GroupTransparency = 0}):Play()
		tween_service:Create(dashboard.scale, info, {Scale = 1}):Play()

		tween_service:Create(links, info, {GroupTransparency = 0}):Play()
		tween_service:Create(links.scale, info, {Scale = 1}):Play()

	else
		dashboard.idle_layer.Visible = true
		links.idle_layer.Visible = true
		main.idle_layer.Visible = true

		tween_service:Create(main, info, {GroupTransparency = .95}):Play()
		tween_service:Create(main.scale, info, {Scale = .9}):Play()

		tween_service:Create(dashboard, info, {GroupTransparency = .95}):Play()
		tween_service:Create(dashboard.scale, info, {Scale = .9}):Play()

		tween_service:Create(links, info, {GroupTransparency = .95}):Play()
		tween_service:Create(links.scale, info, {Scale = .9}):Play()

	end
end

function module:topage(page:pages, menu)
	if page == "dashboard" then

		main.Visible = false
		links.Visible = false

		dashboard.Visible = true

		if not menu then
			dashboard.Position = UDim2.fromScale(.5, .8)
		end

		--

		tween_service:Create(dashboard, info, {Position = UDim2.fromScale(.5, .5)}):Play()

	elseif page == "main_menu" then

		dashboard.Visible = false
		links.Visible = false

		main.Visible = true

		if not menu then
			main.Position = UDim2.fromScale(.5, .8)
		end

		--

		tween_service:Create(main, info, {Position = UDim2.fromScale(.5, .5)}):Play()


	elseif page == "credits" then

		dashboard.Visible = false
		main.Visible = false

		links.Visible = true

		if not menu then
			links.Position = UDim2.fromScale(.5, .8)
		end

		--

		tween_service:Create(links, info, {Position = UDim2.fromScale(.5, .5)}):Play()

	end
end

local menu_db = false

function module:menu(state)
	if (state and not menu_db) then

		menu_db = true

		if not menu.Visible then

			menu.Visible = true

			menu.GroupTransparency = 1
			menu.Position = UDim2.new(-.5, 0, .5, 0)
			menu.scale.Scale = .8

			--

			main.menu_button.button_icon.Image = "rbxassetid://11422143469"
			dashboard.menu_button.button_icon.Image = "rbxassetid://11422143469"
			links.menu_button.button_icon.Image = "rbxassetid://11422143469"

			main.close_button.Visible = false
			dashboard.close_button.Visible = false
			links.close_button.Visible = false

			--

			dashboard.idle_layer.Visible = true
			links.idle_layer.Visible = true
			main.idle_layer.Visible = true

			--

			tween_service:Create(menu, info, {GroupTransparency = 0}):Play()
			tween_service:Create(menu, info, {Position = UDim2.new(0, 10, .5, 0)}):Play()
			tween_service:Create(menu.scale, info, {Scale = 1}):Play()

			tween_service:Create(main, info, {Position = UDim2.new(.5, 260, .5, 0)}):Play()
			tween_service:Create(dashboard, info, {Position = UDim2.new(.5, 260, .5, 0)}):Play()
			tween_service:Create(links, info, {Position = UDim2.new(.5, 260, .5, 0)}):Play()

			tween_service:Create(glow.prism_glow, info, {Rotation = 15, ImageTransparency = .85}):Play()
			tween_service:Create(glow.prism_glow.scale, info, {Scale = 1}):Play()

			--

			task.wait(1)

			--

			menu_db = false

		end
	else

		main.menu_button.button_icon.Image = "rbxassetid://11295285432"
		dashboard.menu_button.button_icon.Image = "rbxassetid://11295285432"
		links.menu_button.button_icon.Image = "rbxassetid://11295285432"

		main.close_button.Visible = true
		dashboard.close_button.Visible = true
		links.close_button.Visible = true

		--

		dashboard.idle_layer.Visible = false
		links.idle_layer.Visible = false
		main.idle_layer.Visible = false

		--

		tween_service:Create(menu, info, {GroupTransparency = 1}):Play()
		tween_service:Create(menu, info, {Position = UDim2.new(-.5, 0, .5, 0)}):Play()
		tween_service:Create(menu.scale, info, {Scale = .8}):Play()

		tween_service:Create(main, info, {Position = UDim2.new(.5, 0, .5, 0)}):Play()
		tween_service:Create(dashboard, info, {Position = UDim2.new(.5, 0, .5, 0)}):Play()
		tween_service:Create(links, info, {Position = UDim2.new(.5, 0, .5, 0)}):Play()

		tween_service:Create(glow.prism_glow, info, {Rotation = 0, ImageTransparency =	1}):Play()
		tween_service:Create(glow.prism_glow.scale, info, {Scale = .8}):Play()

		task.wait(.2)

		menu.Visible = false
	end
end

function module:kick_menu(state, player)
	if state then
		if not kick.Visible then

			kick.Visible = true

			--

			kick.properties.id.Value = player.UserId
			kick.properties.username.Value = player.Name

			kick.GroupTransparency = 1
			kick.Position = UDim2.fromScale(.5, 1.5)
			kick.scale.Scale = .8

			--

			dashboard.idle_layer.Visible = true
			links.idle_layer.Visible = true
			main.idle_layer.Visible = true

			--

			tween_service:Create(kick, info, {GroupTransparency = 0}):Play()
			tween_service:Create(kick, info, {Position = UDim2.new(.5, 0, .5, 0)}):Play()
			tween_service:Create(kick.scale, info, {Scale = 1}):Play()

			tween_service:Create(glow.prism_glow, info, {Rotation = 15, ImageTransparency = .85}):Play()
			tween_service:Create(glow.prism_glow.scale, info, {Scale = 1}):Play()

			tween_service:Create(blur, info, {Size = 30}):Play()

			module:main(false)

		end
	else

		dashboard.idle_layer.Visible = false
		links.idle_layer.Visible = false
		main.idle_layer.Visible = false

		--

		tween_service:Create(kick, info, {GroupTransparency = 1}):Play()
		tween_service:Create(kick, info, {Position = UDim2.new(.5, 0, 1.5, 0)}):Play()
		tween_service:Create(kick.scale, info, {Scale = .8}):Play()

		tween_service:Create(glow.prism_glow, info, {Rotation = 0, ImageTransparency =	1}):Play()
		tween_service:Create(glow.prism_glow.scale, info, {Scale = .8}):Play()

		tween_service:Create(blur, info, {Size = 0}):Play()

		module:main(true)

		task.wait(info.Time)

		kick.Visible = false

	end
end

function module:profile_menu(state, player, crossfade)
	if state then
		if not profile.Visible then

			profile.Visible = true

			--
			local thumbnail = player_service:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot,
				Enum.ThumbnailSize.Size420x420)

			profile.container.ScrollBarImageTransparency = 1

			profile.container.list.Padding = UDim.new(1, 0)

			profile.container.player_thumbnail.Image = thumbnail
			profile.container.display.Text = player.DisplayName
			profile.container.username.Text = "@" .. player.Name
			profile.container.id.Text = player.UserId

			profile.properties.id.Value = player.UserId
			profile.properties.username.Value = player.Name

			profile.GroupTransparency = 1
			profile.Position = UDim2.fromScale(.5, 1.5)
			profile.scale.Scale = .8

			--

			dashboard.idle_layer.Visible = true
			links.idle_layer.Visible = true
			main.idle_layer.Visible = true

			--
			tween_service:Create(profile.container, info, {ScrollBarImageTransparency = .8}):Play()

			tween_service:Create(profile.container.list, info, {Padding = UDim.new(0, 15)}):Play()

			tween_service:Create(profile, info, {GroupTransparency = 0}):Play()
			tween_service:Create(profile, info, {Position = UDim2.new(.5, 0, .5, 0)}):Play()
			tween_service:Create(profile.scale, info, {Scale = 1}):Play()

			tween_service:Create(glow.prism_glow, info, {Rotation = 15, ImageTransparency = .85}):Play()
			tween_service:Create(glow.prism_glow.scale, info, {Scale = 1}):Play()			

			tween_service:Create(blur, info, {Size = 30}):Play()

			module:main(false)


		end
	else

		dashboard.idle_layer.Visible = false
		links.idle_layer.Visible = false
		main.idle_layer.Visible = false

		--

		tween_service:Create(profile, info, {GroupTransparency = 1}):Play()
		tween_service:Create(profile, info, {Position = UDim2.new(.5, 0, 1.5, 0)}):Play()
		tween_service:Create(profile.scale, info, {Scale = .8}):Play()

		tween_service:Create(glow.prism_glow, info, {Rotation = 0, ImageTransparency =	1}):Play()
		tween_service:Create(glow.prism_glow.scale, info, {Scale = .8}):Play()

		tween_service:Create(blur, info, {Size = 0}):Play()

		module:main(true)

		if not crossfade then
			task.wait(info.Time)
		end

		profile.Visible = false

	end
end

function module:ban_menu(state, player)
	if state then
		if not ban.Visible then

			ban.Visible = true

			--

			ban.page:JumpTo(ban.normal_ban)

			ban.properties.id.Value = player.UserId
			ban.properties.username.Value = player.Name

			ban.GroupTransparency = 1
			ban.Position = UDim2.fromScale(.5, 1.5)
			ban.scale.Scale = .8

			--

			dashboard.idle_layer.Visible = true
			links.idle_layer.Visible = true
			main.idle_layer.Visible = true

			--

			tween_service:Create(ban, info, {GroupTransparency = 0}):Play()
			tween_service:Create(ban, info, {Position = UDim2.new(.5, 0, .5, 0)}):Play()
			tween_service:Create(ban.scale, info, {Scale = 1}):Play()

			tween_service:Create(glow.prism_glow, info, {Rotation = 15, ImageTransparency = .85}):Play()
			tween_service:Create(glow.prism_glow.scale, info, {Scale = 1}):Play()

			tween_service:Create(blur, info, {Size = 30}):Play()

			--

			module:main(false)
		end
	else

		dashboard.idle_layer.Visible = false
		links.idle_layer.Visible = false
		main.idle_layer.Visible = false

		--

		tween_service:Create(ban, info, {GroupTransparency = 1}):Play()
		tween_service:Create(ban, info, {Position = UDim2.new(.5, 0, 1.5, 0)}):Play()
		tween_service:Create(ban.scale, info, {Scale = .8}):Play()

		tween_service:Create(glow.prism_glow, info, {Rotation = 0, ImageTransparency =	1}):Play()
		tween_service:Create(glow.prism_glow.scale, info, {Scale = .8}):Play()

		tween_service:Create(blur, info, {Size = 0}):Play()

		module:main(true)

		task.wait(info.Time)

		ban.Visible = false

	end
end

function module:unban_menu(state)
	if state then

		ban.Visible = true

		--

		ban.page:JumpTo(ban.unban_panel)

		ban.GroupTransparency = 1
		ban.Position = UDim2.fromScale(.5, 1.5)
		ban.scale.Scale = .8

		--

		dashboard.idle_layer.Visible = true
		links.idle_layer.Visible = true
		main.idle_layer.Visible = true

		--

		tween_service:Create(ban, info, {GroupTransparency = 0}):Play()
		tween_service:Create(ban, info, {Position = UDim2.new(.5, 0, .5, 0)}):Play()
		tween_service:Create(ban.scale, info, {Scale = 1}):Play()

		tween_service:Create(glow.prism_glow, info, {Rotation = 15, ImageTransparency = .8}):Play()
		tween_service:Create(glow.prism_glow.scale, info, {Scale = 1}):Play()

		tween_service:Create(blur, info, {Size = 30}):Play()

		--

		module:main(false)
	else

		dashboard.idle_layer.Visible = false
		links.idle_layer.Visible = false
		main.idle_layer.Visible = false

		--

		tween_service:Create(ban, info, {GroupTransparency = 1}):Play()
		tween_service:Create(ban, info, {Position = UDim2.new(.5, 0, 1.5, 0)}):Play()
		tween_service:Create(ban.scale, info, {Scale = .8}):Play()

		tween_service:Create(glow.prism_glow, info, {Rotation = 0, ImageTransparency =	1}):Play()
		tween_service:Create(glow.prism_glow.scale, info, {Scale = .8}):Play()

		tween_service:Create(blur, info, {Size = 0}):Play()

		module:main(true)

		task.wait(info.Time)

		ban.Visible = false

	end
end

function module:notify_menu(state, player)
	if state then
		if not notify.Visible then

			notify.Visible = true

			--

			notify.properties.id.Value = player.UserId
			notify.properties.username.Value = player.Name

			notify.GroupTransparency = 1
			notify.Position = UDim2.fromScale(.5, 1.5)
			notify.scale.Scale = .8

			--

			dashboard.idle_layer.Visible = true
			links.idle_layer.Visible = true
			main.idle_layer.Visible = true

			--

			tween_service:Create(notify, info, {GroupTransparency = 0}):Play()
			tween_service:Create(notify, info, {Position = UDim2.new(.5, 0, .5, 0)}):Play()
			tween_service:Create(notify.scale, info, {Scale = 1}):Play()

			tween_service:Create(glow.prism_glow, info, {Rotation = 15, ImageTransparency = .85}):Play()
			tween_service:Create(glow.prism_glow.scale, info, {Scale = 1}):Play()

			tween_service:Create(blur, info, {Size = 30}):Play()

			module:main(false)

		end
	else

		dashboard.idle_layer.Visible = false
		links.idle_layer.Visible = false
		main.idle_layer.Visible = false

		--

		tween_service:Create(notify, info, {GroupTransparency = 1}):Play()
		tween_service:Create(notify, info, {Position = UDim2.new(.5, 0, 1.5, 0)}):Play()
		tween_service:Create(notify.scale, info, {Scale = .8}):Play()

		tween_service:Create(glow.prism_glow, info, {Rotation = 0, ImageTransparency =	1}):Play()
		tween_service:Create(glow.prism_glow.scale, info, {Scale = .8}):Play()

		tween_service:Create(blur, info, {Size = 0}):Play()

		module:main(true)

		task.wait(info.Time)

		notify.Visible = false

	end
end

function module:announcement_menu(state)
	if state then
		if not announcement.Visible then

			announcement.Visible = true

			announcement.GroupTransparency = 1
			announcement.Position = UDim2.fromScale(.5, 1.5)
			announcement.scale.Scale = .8

			--

			dashboard.idle_layer.Visible = true
			links.idle_layer.Visible = true
			main.idle_layer.Visible = true

			--

			tween_service:Create(announcement, info, {GroupTransparency = 0}):Play()
			tween_service:Create(announcement, info, {Position = UDim2.new(.5, 0, .5, 0)}):Play()
			tween_service:Create(announcement.scale, info, {Scale = 1}):Play()

			tween_service:Create(glow.prism_glow, info, {Rotation = 15, ImageTransparency = .85}):Play()
			tween_service:Create(glow.prism_glow.scale, info, {Scale = 1}):Play()

			tween_service:Create(blur, info, {Size = 30}):Play()

			module:main(false)

		end
	else

		dashboard.idle_layer.Visible = false
		links.idle_layer.Visible = false
		main.idle_layer.Visible = false

		--

		tween_service:Create(announcement, info, {GroupTransparency = 1}):Play()
		tween_service:Create(announcement, info, {Position = UDim2.new(.5, 0, 1.5, 0)}):Play()
		tween_service:Create(announcement.scale, info, {Scale = .8}):Play()

		tween_service:Create(glow.prism_glow, info, {Rotation = 0, ImageTransparency =	1}):Play()
		tween_service:Create(glow.prism_glow.scale, info, {Scale = .8}):Play()

		tween_service:Create(blur, info, {Size = 0}):Play()

		module:main(true)

		task.wait(info.Time)

		announcement.Visible = false
	end
end

function module:jail_menu(state, player)
	if state then
		if not jail.Visible then

			jail.Visible = true

			jail.properties.id.Value = player.UserId

			jail.GroupTransparency = 1
			jail.Position = UDim2.fromScale(.5, 1.5)
			jail.scale.Scale = .8

			--

			dashboard.idle_layer.Visible = true
			links.idle_layer.Visible = true
			main.idle_layer.Visible = true

			--

			tween_service:Create(jail, info, {GroupTransparency = 0}):Play()
			tween_service:Create(jail, info, {Position = UDim2.new(.5, 0, .5, 0)}):Play()
			tween_service:Create(jail.scale, info, {Scale = 1}):Play()

			tween_service:Create(glow.prism_glow, info, {Rotation = 15, ImageTransparency = .85}):Play()
			tween_service:Create(glow.prism_glow.scale, info, {Scale = 1}):Play()

			tween_service:Create(blur, info, {Size = 30}):Play()

			module:main(false)

		end
	else

		dashboard.idle_layer.Visible = false
		links.idle_layer.Visible = false
		main.idle_layer.Visible = false

		--

		tween_service:Create(jail, info, {GroupTransparency = 1}):Play()
		tween_service:Create(jail, info, {Position = UDim2.new(.5, 0, 1.5, 0)}):Play()
		tween_service:Create(jail.scale, info, {Scale = .8}):Play()

		tween_service:Create(glow.prism_glow, info, {Rotation = 0, ImageTransparency =	1}):Play()
		tween_service:Create(glow.prism_glow.scale, info, {Scale = .8}):Play()

		tween_service:Create(blur, info, {Size = 0}):Play()

		module:main(true)

		task.wait(info.Time)

		jail.Visible = false
	end
end

function module:tool_manager_menu(state)
	if state then
		if not tool_manager.Visible then

			tool_manager.Visible = true

			tool_manager.GroupTransparency = 1
			tool_manager.Position = UDim2.fromScale(.5, 1.5)
			tool_manager.scale.Scale = .8

			--

			dashboard.idle_layer.Visible = true
			links.idle_layer.Visible = true
			main.idle_layer.Visible = true

			--

			tween_service:Create(tool_manager, info, {GroupTransparency = 0}):Play()
			tween_service:Create(tool_manager, info, {Position = UDim2.new(.5, 0, .5, 0)}):Play()
			tween_service:Create(tool_manager.scale, info, {Scale = 1}):Play()

			tween_service:Create(glow.prism_glow, info, {Rotation = 15, ImageTransparency = .85}):Play()
			tween_service:Create(glow.prism_glow.scale, info, {Scale = 1}):Play()

			tween_service:Create(blur, info, {Size = 30}):Play()

			module:main(false)

		end
	else

		dashboard.idle_layer.Visible = false
		links.idle_layer.Visible = false
		main.idle_layer.Visible = false

		--

		tween_service:Create(tool_manager, info, {GroupTransparency = 1}):Play()
		tween_service:Create(tool_manager, info, {Position = UDim2.new(.5, 0, 1.5, 0)}):Play()
		tween_service:Create(tool_manager.scale, info, {Scale = .8}):Play()

		tween_service:Create(glow.prism_glow, info, {Rotation = 0, ImageTransparency =	1}):Play()
		tween_service:Create(glow.prism_glow.scale, info, {Scale = .8}):Play()

		tween_service:Create(blur, info, {Size = 0}):Play()

		module:main(true)

		task.wait(info.Time)

		tool_manager.Visible = false
	end
end

function module:effects_menu(state)
	if state then
		if not effects.Visible then

			effects.Visible = true

			effects.GroupTransparency = 1
			effects.Position = UDim2.fromScale(.5, 1.5)
			effects.scale.Scale = .8

			--

			dashboard.idle_layer.Visible = true
			links.idle_layer.Visible = true
			main.idle_layer.Visible = true

			--

			tween_service:Create(effects, info, {GroupTransparency = 0}):Play()
			tween_service:Create(effects, info, {Position = UDim2.new(.5, 0, .5, 0)}):Play()
			tween_service:Create(effects.scale, info, {Scale = 1}):Play()

			tween_service:Create(glow.prism_glow, info, {Rotation = 15, ImageTransparency = .85}):Play()
			tween_service:Create(glow.prism_glow.scale, info, {Scale = 1}):Play()

			tween_service:Create(blur, info, {Size = 30}):Play()

			module:main(false)

		end
	else

		dashboard.idle_layer.Visible = false
		links.idle_layer.Visible = false
		main.idle_layer.Visible = false

		--

		tween_service:Create(effects, info, {GroupTransparency = 1}):Play()
		tween_service:Create(effects, info, {Position = UDim2.new(.5, 0, 1.5, 0)}):Play()
		tween_service:Create(effects.scale, info, {Scale = .8}):Play()

		tween_service:Create(glow.prism_glow, info, {Rotation = 0, ImageTransparency =	1}):Play()
		tween_service:Create(glow.prism_glow.scale, info, {Scale = .8}):Play()

		tween_service:Create(blur, info, {Size = 0}):Play()

		module:main(true)

		task.wait(info.Time)

		effects.Visible = false
	end
end

function module:configure_menu(state, page: configs, recipient)
	if state then
		if not config_menu.Visible then

			config_menu.Visible = true

			--

			if page == "health" then
				config_menu.page:JumpTo(config_menu.health_page)
			elseif page == "jump" then
				config_menu.page:JumpTo(config_menu.jump_power)
			elseif page == "walk" then
				config_menu.page:JumpTo(config_menu.walk_page)
			end

			--

			config_menu.properties.username.Value = recipient.Name
			config_menu.properties.id.Value = recipient.UserId

			config_menu.GroupTransparency = 1
			config_menu.Position = UDim2.fromScale(.5, 1.5)
			config_menu.scale.Scale = .8

			--

			dashboard.idle_layer.Visible = true
			links.idle_layer.Visible = true
			main.idle_layer.Visible = true

			--

			tween_service:Create(config_menu, info, {GroupTransparency = 0}):Play()
			tween_service:Create(config_menu, info, {Position = UDim2.new(.5, 0, .5, 0)}):Play()
			tween_service:Create(config_menu.scale, info, {Scale = 1}):Play()

			tween_service:Create(glow.prism_glow, info, {Rotation = 15, ImageTransparency = .85}):Play()
			tween_service:Create(glow.prism_glow.scale, info, {Scale = 1}):Play()

			tween_service:Create(blur, info, {Size = 30}):Play()

			module:main(false)

		end
	else

		dashboard.idle_layer.Visible = false
		links.idle_layer.Visible = false
		main.idle_layer.Visible = false

		--

		tween_service:Create(config_menu, info, {GroupTransparency = 1}):Play()
		tween_service:Create(config_menu, info, {Position = UDim2.new(.5, 0, 1.5, 0)}):Play()
		tween_service:Create(config_menu.scale, info, {Scale = .8}):Play()

		tween_service:Create(glow.prism_glow, info, {Rotation = 0, ImageTransparency =	1}):Play()
		tween_service:Create(glow.prism_glow.scale, info, {Scale = .8}):Play()

		tween_service:Create(blur, info, {Size = 0}):Play()

		module:main(true)

		task.wait(info.Time)

		config_menu.Visible = false
	end
end

function module:credits_menu(state, link, description)
	if state then
		if not credits.Visible then

			credits.Visible = true

			credits.properties.link.Value = link

			credits.subtext.Text = description
			credits.devforum_link.Text = link

			credits.GroupTransparency = 1
			credits.Position = UDim2.fromScale(.5, 1.5)
			credits.scale.Scale = .8

			--

			dashboard.idle_layer.Visible = true
			links.idle_layer.Visible = true
			main.idle_layer.Visible = true

			--

			tween_service:Create(credits, info, {GroupTransparency = 0}):Play()
			tween_service:Create(credits, info, {Position = UDim2.new(.5, 0, .5, 0)}):Play()
			tween_service:Create(credits.scale, info, {Scale = 1}):Play()

			tween_service:Create(glow.prism_glow, info, {Rotation = 15, ImageTransparency = .85}):Play()
			tween_service:Create(glow.prism_glow.scale, info, {Scale = 1}):Play()

			tween_service:Create(blur, info, {Size = 30}):Play()

			module:main(false)

		end
	else

		dashboard.idle_layer.Visible = false
		links.idle_layer.Visible = false
		main.idle_layer.Visible = false

		--

		tween_service:Create(credits, info, {GroupTransparency = 1}):Play()
		tween_service:Create(credits, info, {Position = UDim2.new(.5, 0, 1.5, 0)}):Play()
		tween_service:Create(credits.scale, info, {Scale = .8}):Play()

		tween_service:Create(glow.prism_glow, info, {Rotation = 0, ImageTransparency =	1}):Play()
		tween_service:Create(glow.prism_glow.scale, info, {Scale = .8}):Play()

		tween_service:Create(blur, info, {Size = 0}):Play()

		module:main(true)

		task.wait(info.Time)

		credits.Visible = false
	end
end

function module:custom_command_menu(state, event, procedure, cmd_name, cmd_description)
	if state then
		if not custom_commands.Visible then

			custom_commands.Visible = true

			--
			if procedure == "plain_menu" then
				custom_commands.page:JumpTo(custom_commands.non_player_command)

				custom_commands.non_player_command.command_description.Text = cmd_description
				custom_commands.non_player_command.command_name.Text = cmd_name
			elseif procedure == "input_menu" then
				custom_commands.page:JumpTo(custom_commands.input_command)

				custom_commands.input_command.command_description.Text = cmd_description
				custom_commands.input_command.command_name.Text = cmd_name
			elseif procedure == "player_menu" then
				custom_commands.page:JumpTo(custom_commands.player_command)

				custom_commands.player_command.command_description.Text = cmd_description
				custom_commands.player_command.command_name.Text = cmd_name
			end

			custom_commands.properties.event.Value = event

			custom_commands.GroupTransparency = 1
			custom_commands.Position = UDim2.fromScale(.5, 1.5)
			custom_commands.scale.Scale = .8

			--

			dashboard.idle_layer.Visible = true
			links.idle_layer.Visible = true
			main.idle_layer.Visible = true

			--

			tween_service:Create(custom_commands, info, {GroupTransparency = 0}):Play()
			tween_service:Create(custom_commands, info, {Position = UDim2.new(.5, 0, .5, 0)}):Play()
			tween_service:Create(custom_commands.scale, info, {Scale = 1}):Play()

			tween_service:Create(glow.prism_glow, info, {Rotation = 15, ImageTransparency = .85}):Play()
			tween_service:Create(glow.prism_glow.scale, info, {Scale = 1}):Play()

			tween_service:Create(blur, info, {Size = 30}):Play()

			--

			module:main(false)
		end
	else

		dashboard.idle_layer.Visible = false
		links.idle_layer.Visible = false
		main.idle_layer.Visible = false

		--

		tween_service:Create(custom_commands, info, {GroupTransparency = 1}):Play()
		tween_service:Create(custom_commands, info, {Position = UDim2.new(.5, 0, 1.5, 0)}):Play()
		tween_service:Create(custom_commands.scale, info, {Scale = .8}):Play()

		tween_service:Create(glow.prism_glow, info, {Rotation = 0, ImageTransparency =	1}):Play()
		tween_service:Create(glow.prism_glow.scale, info, {Scale = .8}):Play()

		tween_service:Create(blur, info, {Size = 0}):Play()

		module:main(true)

		task.wait(info.Time)

		custom_commands.Visible = false

	end
end

function module:commands_list_frame(state, crossfade)
	if state then
		if not commands_list.Visible then

			commands_list.Visible = true

			commands_list.GroupTransparency = 1
			commands_list.Position = UDim2.fromScale(.5, 1.5)
			commands_list.scale.Scale = .8

			--

			dashboard.idle_layer.Visible = true
			links.idle_layer.Visible = true
			main.idle_layer.Visible = true

			--

			tween_service:Create(commands_list, info, {GroupTransparency = 0}):Play()
			tween_service:Create(commands_list, info, {Position = UDim2.new(.5, 0, .5, 0)}):Play()
			tween_service:Create(commands_list.scale, info, {Scale = 1}):Play()

			tween_service:Create(glow.prism_glow, info, {Rotation = 15, ImageTransparency = .85}):Play()
			tween_service:Create(glow.prism_glow.scale, info, {Scale = 1}):Play()

			tween_service:Create(blur, info, {Size = 30}):Play()

			module:main(false)

		end
	else

		dashboard.idle_layer.Visible = false
		links.idle_layer.Visible = false
		main.idle_layer.Visible = false

		--

		if crossfade then
			tween_service:Create(commands_list, info, {GroupTransparency = 1}):Play()
			tween_service:Create(commands_list, info, {Position = UDim2.new(.5, 0, 1.5, 0)}):Play()
			tween_service:Create(commands_list.scale, info, {Scale = .8}):Play()

			tween_service:Create(glow.prism_glow, info, {Rotation = 0, ImageTransparency =	1}):Play()
			tween_service:Create(glow.prism_glow.scale, info, {Scale = .8}):Play()

			tween_service:Create(blur, info, {Size = 0}):Play()

			module:main(true)

			task.wait(info.Time)
		end

		commands_list.Visible = false
	end
end

return module