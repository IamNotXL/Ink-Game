local Fluent = loadstring(Game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua", true))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "🦑 Ink Game",
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 430),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home"}),
    Player = Window:AddTab({ Title = "Player", Icon = "users"}),
    Lobby = Window:AddTab({ Title = "Lobby", Icon = "building"}),
    RLGL = Window:AddTab({ Title = "Red Light Green Light", Icon = "siren"}),
    LightsOut = Window:AddTab({ Title = "Lights Out", Icon = "lightbulb-off"}),
    GlassBridge = Window:AddTab({ Title = "Glass Bridge", Icon = "grid"}),
    Rebel = Window:AddTab({ Title = "Rebel", Icon = "axe"}),
    Misc = Window:AddTab({ Title = "Misc", Icon = "align-justify"}),
    MoreScripts = Window:AddTab({ Title = "MoreScripts", Icon = "app-window-mac"}),
}

local Options = Fluent.Options

do

    Tabs.Main:AddParagraph({
        Title = "Hello, " .. game.Players.LocalPlayer.Name .. "!"
    })

    local executor = identifyexecutor()
    
    Tabs.Main:AddParagraph({
        Title = string.format("Executor: %s", executor)
    })

    local placeversion = game.PlaceVersion

    Tabs.Main:AddParagraph({
        Title = "Game Version: " .. placeversion
    })

    local jobid = game.JobId
    
    Tabs.Main:AddButton({
        Title = "Copy Job Id",
        Callback = function()
            setclipboard(jobid)
        end
    })

    local teleportService = game:GetService("TeleportService")
    
    local Input = Tabs.Main:AddInput("Input", {
        Title = "Join By Job Id",
        Placeholder = "Enter Job Id",
        Numeric = false, -- Only allows numbers
        Finished = true, -- Only calls callback when you press enter
        Callback = function(Value)
            teleportService:TeleportToPlaceInstance(game.PlaceId, Value)
        end
    })

    local placeId = game.PlaceId
    
    Tabs.Main:AddButton({
        Title = "Rejoin",
        Callback = function()
            teleportService:Teleport(placeId, game.Players.LocalPlayer)
        end
    })

    local Join = loadstring(game:HttpGet("https://raw.githubusercontent.com/EpicPug/Stuff/main/hop.lua"))()
    
    Tabs.Main:AddButton({
        Title = "Server Hop",
        Callback = function()
            Join()
        end
    })

-------------------------------

    local Input = Tabs.Player:AddInput("Input", {
        Title = "Walk Speed",
        Placeholder = "Value",
        Numeric = true, -- Only allows numbers
        Finished = true, -- Only calls callback when you press enter
        Callback = function(Value)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    })

    local Input = Tabs.Player:AddInput("Input", {
        Title = "Walk Speed V2",
        Description = "Default = 1",
        Placeholder = "Value",
        Numeric = true, -- Only allows numbers
        Finished = true, -- Only calls callback when you press enter
        Callback = function(Value)
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()

            local ssfold = character:FindFirstChild("SwingSpeed")
            if ssfold then
                ssfold.Value = Value
            end
        end
    })

    local Input = Tabs.Player:AddInput("Input", {
        Title = "Jump Power",
        Placeholder = "Value",
        Numeric = true, -- Only allows numbers
        Finished = true, -- Only calls callback when you press enter
        Callback = function(Value)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    })

    local Input = Tabs.Player:AddInput("Input", {
        Title = "XP Level (Non-FE)",
        Placeholder = "Value",
        Numeric = true, -- Only allows numbers
        Finished = true, -- Only calls callback when you press enter
        Callback = function(Value)
            game.Players.LocalPlayer:SetAttribute("_CurrentLevel", Value)
        end
    })

    local Input = Tabs.Player:AddInput("Input", {
        Title = "Current XP (Non-FE)",
        Placeholder = "Value",
        Numeric = true, -- Only allows numbers
        Finished = true, -- Only calls callback when you press enter
        Callback = function(Value)
            game.Players.LocalPlayer:SetAttribute("_Experience", Value)
        end
    })

    local Input = Tabs.Player:AddInput("Input", {
        Title = "Wins (Non-FE)",
        Placeholder = "Value",
        Numeric = true, -- Only allows numbers
        Finished = true, -- Only calls callback when you press enter
        Callback = function(Value)
            game.Players.LocalPlayer:SetAttribute("_GameWins", Value)
        end
    })
    
    local Toggle = Tabs.Player:AddToggle("MyToggle", {Title = "Auto Run", Default = false })

    Toggle:OnChanged(function(v)
        game:GetService("Players").LocalPlayer.AutoRun.Value = v
    end)

    local Toggle = Tabs.Player:AddToggle("MyToggle", {Title = "Infinite Jump", Default = false })

    Toggle:OnChanged(function(v)
        _G.infinjump = v

        if _G.infinJumpStarted == nil then
    	--Ensures this only runs once to save resources
    	_G.infinJumpStarted = true
	
    	--Notifies readiness
    	game.StarterGui:SetCore("SendNotification", {Title="WeAreDevs.net"; Text="The WeAreDevs Infinite Jump exploit is ready!"; Duration=5;})

    	--The actual infinite jump
    	local plr = game:GetService('Players').LocalPlayer
    	local m = plr:GetMouse()
    	m.KeyDown:connect(function(k)
		if _G.infinjump then
			if k:byte() == 32 then
    			humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
    			humanoid:ChangeState('Jumping')
    			wait()
    			humanoid:ChangeState('Seated')
        			end
        		end
        	end)
        end
    end)

    local Toggle = Tabs.Player:AddToggle("MyToggle", {Title = "Noclip", Default = false })

    Toggle:OnChanged(function(v)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function onTouched(part)
    if not part:IsA("BasePart") then return end
    if not part.Anchored then return end
    if not part.CanCollide then return end

    local character = LocalPlayer.Character
    if not character then return end

    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- Prevent disabling floors
    if part.Position.Y < (hrp.Position.Y - hrp.Size.Y) then return end

    -- Passed all checks
    part.CanCollide = v
end

-- Wait for character and hook HRP
local function setup()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    hrp.Touched:Connect(onTouched)
end

if LocalPlayer.Character then
    setup()
end

LocalPlayer.CharacterAdded:Connect(setup)
    end)

    Tabs.Player:AddButton({
        Title = "Teleport To Random Player",
        Callback = function()
            local players = game:GetService("Players")
            local localPlayer = players.LocalPlayer
            -- Get all players except the local player
            local otherPlayers = {}
            for _, player in pairs(players:GetPlayers()) do
                if player ~= localPlayer then
                    table.insert(otherPlayers, player)
                end
            end

            -- Check if there are any other players to teleport to
            if #otherPlayers > 0 then
                -- Choose a random player from the list
                local targetPlayer = otherPlayers[math.random(1, #otherPlayers)]

                -- Teleport the local player to the target player's position
                if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
                    if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
                    end
                end
            else
                -- No other players available
                print("No other players to teleport to.")
            end
        end
    })

    local Dropdown = Tabs.Player:AddDropdown("TitleDropdown", {
        Title = "Select Title",
        Values = {"None", "Squidder", "Frontman", "Him", "Rich Millionaire", "The Chosen One", "The Glass Maker", "Tanos", "Manipulator", "Honeycomb Artist", "The Recruiter", "Game VIP", "Game Developer", "Game Moderator", "Game Contributor", "Game Builder", "Game Animator", "Game Artist", "Game Modeller", "Sackboy", "Content Creator", "SFX Designer", "The Perfect Lifeform", "The Strongest"},
        Multi = false,
        Default = 1,
    })

    Tabs.Player:AddButton({
        Title = "Enable Selected Title",
        Callback = function()
        	Dropdown:OnChanged(function(Value)
                if Dropdown.Value == "Squidder" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[Squidder]"
                        title.TextColor3 = Color3.fromRGB(255, 116, 116)
                    end
                elseif Dropdown.Value == "Frontman" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[Fontman]"
                        title.TextColor3 = Color3.fromRGB(22, 22, 22)
                    end
                elseif Dropdown.Value == "Him" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[Him]"
                        title.TextColor3 = Color3.fromRGB(0, 0, 0)
                    end
                elseif Dropdown.Value == "Rich Millionaire" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()
                    
                    local title = character.Torso.Player_Nametag.TitleText
                    local gradient = Instance.new("UIGradient")
                    gradient.Parent = title
                    if title then
                        title.Text = "[Rich Millionaire]"
                        title.TextColor3 = Color3.fromRGB(226, 184, 58)
                        gradient.Color = "0 1 1 0.745098 0 0.3 1 1 0 0 0.6 1 1 0.588235 0 1 1 0.862745 0 0"
                        gradient.Rotation = 45
                    end
                elseif Dropdown.Value == "The Chosen One" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[The Chosen One]"
                        title.TextColor3 = Color3.fromRGB(136, 4, 4)
                    end
                elseif Dropdown.Value == "The Glass Maker" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[The Glass Maker]"
                        title.TextColor3 = Color3.fromRGB(0, 79, 238)
                    end
                elseif Dropdown.Value == "Tanos" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[Tanos]"
                        title.TextColor3 = Color3.fromRGB(85, 0, 127)
                    end
                elseif Dropdown.Value == "Manipulator" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[Manipulator]"
                        title.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                elseif Dropdown.Value == "Honeycomb Artist" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[Honeycomb Artist]"
                        title.TextColor3 = Color3.fromRGB(204, 153, 0)
                    end
                elseif Dropdown.Value == "The Recruiter" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[The Recruiter]"
                        title.TextColor3 = Color3.fromRGB(80, 80, 80)
                    end
                elseif Dropdown.Value == "Game VIP" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[Game VIP]"
                        title.TextColor3 = Color3.fromRGB(120, 0, 180)
                    end
                elseif Dropdown.Value == "Game Developer" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[Game Developer]"
                        title.TextColor3 = Color3.fromRGB(255, 0, 0)
                    end
                elseif Dropdown.Value == "Game Moderator" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[Game Moderator]"
                        title.TextColor3 = Color3.fromRGB(82, 171, 255)
                    end
                elseif Dropdown.Value == "Game Contributor" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[Game Contributor]"
                        title.TextColor3 = Color3.fromRGB(255, 169, 82)
                    end
                elseif Dropdown.Value == "Game Builder" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[Game Builder]"
                        title.TextColor3 = Color3.fromRGB(255, 116, 116)
                    end
                elseif Dropdown.Value == "Game Animator" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[Game Animator]"
                        title.TextColor3 = Color3.fromRGB(46, 255, 105)
                    end
                elseif Dropdown.Value == "Game Artist" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[Game Artist]"
                        title.TextColor3 = Color3.fromRGB(32, 255, 125)
                    end
                elseif Dropdown.Value == "Game Modeller" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[Game Modeller]"
                        title.TextColor3 = Color3.fromRGB(255, 171, 102)
                    end
                elseif Dropdown.Value == "Sackboy" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[Sackboy]"
                        title.TextColor3 = Color3.fromRGB(121, 80, 1)
                    end
                elseif Dropdown.Value == "Content Creator" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[Content Creator]"
                        title.TextColor3 = Color3.fromRGB(255, 61, 61)
                    end
                elseif Dropdown.Value == "SFX Designer" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[SFX Designer]"
                        title.TextColor3 = Color3.fromRGB(255, 140, 51)
                    end
                elseif Dropdown.Value == "The Perfect Lifeform" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[The Perfect Lifeform]"
                        title.TextColor3 = Color3.fromRGB(41, 255, 59)
                    end
                elseif Dropdown.Value == "The Strongest" then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()

                    local title = character.Torso.Player_Nametag.TitleText
                    if title then
                        title.Text = "[The Strongest]"
                        title.TextColor3 = Color3.fromRGB(161, 242, 255)
                    end

                end
            end)
        end
    })

    Tabs.Player:AddButton({
        Title = "Disable Title",
        Callback = function()
        	Dropdown:OnChanged(function(Value)
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()

                local title = character.Torso.Player_Nametag.TitleText
                if title then
                    title.Text = ""
                    title.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end)
        end
    })

    local anima = game:GetService("ReplicatedStorage").Animations.Emotes
    local emoteNames = {"None"} -- Optional default choice
    for _, emote in ipairs(anima:GetChildren()) do
        if emote:IsA("Animation") then
            table.insert(emoteNames, emote.Name)
        end
    end
    
    local DropdownEmote = Tabs.Player:AddDropdown("EmoteDropdown", {
        Title = "Select Emote",
        Values = emoteNames,
        Multi = false,
        Default = 1,
    })

    Tabs.Player:AddButton({
        Title = "Play Selected Emote",
        Callback = function()
        	local selected = DropdownEmote.Value
            if selected and selected ~= "None" then
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local humanoid = character:FindFirstChildOfClass("Humanoid")

                local anim = anima:FindFirstChild(selected)
                if anim and humanoid then
                    local animTrack = humanoid:LoadAnimation(anim)
                    animTrack:Play()
                else
                    warn("Animation or humanoid not found!")
                end
            end
        end
    })

        Tabs.Player:AddButton({
        Title = "Stop Playing Emote",
        Callback = function()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character.Humanoid

            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end
    })
    
-------------------------------
    
    Tabs.Lobby:AddButton({
        Title = "Join Next Game",
        Callback = function()
        	local humanoidrootpart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        	if humanoidrootpart then
        		humanoidrootpart.CFrame = CFrame.new(game.Workspace.Effects.QueuePart.CFrame.p) + Vector3.new(0,5,0)
        	end

        end
    })

-------------------------------

    Tabs.RLGL:AddButton({
        Title = "Tp To Start Line",
        Callback = function()
        	local humanoidrootpart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        	if humanoidrootpart then
        		humanoidrootpart.CFrame = CFrame.new(game.Workspace.RedLightGreenLight.sand.startingcrossedover.CFrame.p) + Vector3.new(0,5,0)
        	end

        end
    })

    Tabs.RLGL:AddButton({
        Title = "Tp To Finish Line",
        Callback = function()
        	local humanoidrootpart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        	if humanoidrootpart then
        		humanoidrootpart.CFrame = CFrame.new(game.Workspace.RedLightGreenLight.sand.crossedover.CFrame.p) + Vector3.new(0,5,0)
        	end

        end
    })

    Tabs.RLGL:AddButton({
        Title = "Remove Injury",
        Callback = function()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()

            local stuntFold = character:FindFirstChild("Stun")
            if stuntFold then
                stuntFold:Destroy()
            end
        end
    })

-------------------------------

    Tabs.LightsOut:AddButton({
        Title = "Tp To Safe Place",
        Callback = function()
            local humanoidrootpart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        	if humanoidrootpart then
        		humanoidrootpart.CFrame = CFrame.new(workspace.Map:GetChildren()[38]:GetChildren()[67].CFrame.p) + Vector3.new(0,5,0)
        	end
        end
    })

    Tabs.LightsOut:AddButton({
        Title = "Tp All Players To Me",
        Callback = function()
            local localPlayer = game.Players.LocalPlayer
        	local char = localPlayer.Character
        	if not char then return end

            	local root = char:FindFirstChild("HumanoidRootPart")
                	if not root then return end

                    	for _, player in pairs(game.Players:GetPlayers()) do
                    		if player ~= localPlayer then
                    			local otherChar = player.Character
                    			if otherChar and otherChar:FindFirstChild("HumanoidRootPart") then
                    				-- WARNING: this will only move the character visually for the local player
                    				otherChar:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame.p) + game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame.LookVector * 20
                    			end
                    		end
                    	end
        end
    })

    local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "Kill Aura", Default = false })
    
    Toggle:OnChanged(function(v)
        killAuraEnabled = v
    end)
    
-------------------------------

    Tabs.GlassBridge:AddButton({
        Title = "Tp To Start Platform",
        Callback = function()
            local humanoidrootpart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        	if humanoidrootpart then
        		humanoidrootpart.CFrame = CFrame.new(workspace.GlassBridge["Plane.012"].CFrame.p) + Vector3.new(0,5,0)
        	end
        end
    })

    Tabs.GlassBridge:AddButton({
        Title = "Tp To End Platform",
        Callback = function()
            local humanoidrootpart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        	if humanoidrootpart then
        		humanoidrootpart.CFrame = CFrame.new(workspace.GlassBridge.End.Model["Plane.012"].CFrame.p) + Vector3.new(0,5,0)
        	end
        end
    })
    
------------------------------- 

    local Toggle = Tabs.Rebel:AddToggle("HitboxToggle", {Title = "Guards Hitbox", Default = false })

    Toggle:OnChanged(function(v)
        if v then
            for _, guard in pairs(Workspace.Live:GetChildren()) do
                if guard.Name == "squid guylobby" and guard:FindFirstChild("Head") then
                    guard.Head.Size = Vector3.new(10, 9, 9)
                end
            end
        else
            for _, guard in pairs(Workspace.Live:GetChildren()) do
                if guard.Name == "squid guylobby" and guard:FindFirstChild("Head") then
                    guard.Head.Size = Vector3.new(2, 1, 1)
                end
            end
        end
    end)

    local Toggle = Tabs.Rebel:AddToggle("EspToggle", {Title = "ESP Guards", Default = false })
    
    Toggle:OnChanged(function(v)
        local highlight = Instance.new("Highlight")
        if v then
            for _, guard in pairs(Workspace.Live:GetChildren()) do
                if guard.Name == "squid guylobby" and guard:FindFirstChild("Head") then
                    highlight.Parent = guard.Head
                end
            end
        else
            for _, guard in pairs(Workspace.Live:GetChildren()) do
                if guard.Name == "squid guylobby" and guard:FindFirstChild("Head") then
                    for _, hl in ipairs(guard.Head:GetChildren()) do
                        if hl:IsA("Highlight") then
                            hl:Destroy()
                        end
                    end
                end
            end
        end
    end)

    Tabs.Rebel:AddButton({
        Title = "Bring Guards (W.I.P)",
        Callback = function()
            for _, guard in pairs(Workspace.Live:GetChildren()) do
                if guard.Name == "squid guylobby" and guard:FindFirstChild("HumanoidRootPart") then
                    if guard then
                        while true do
                            guard:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame.p) + game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame.LookVector * 20
                            task.wait(0.01)
                        end
                    end
                end
            end
        end
    })

-------------------------------

    Tabs.Misc:AddButton({
        Title = "Infinite Yield",
        Callback = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        end
    })

    local Toggle = Tabs.Misc:AddToggle("MyToggle", {Title = "Mute Emote Volume", Default = false })

    Toggle:OnChanged(function(v)
        local em = game:GetService("SoundService").EmoteMusic
            
        if v then
            em.Volume = 0
        else
            em.Volume = 1
        end
    end)

    local Toggle = Tabs.Misc:AddToggle("MyToggle", {Title = "Mute Global Volume", Default = false })

    Toggle:OnChanged(function(v)
        local em = game:GetService("SoundService").GlobalMusic
            
        if v then
            em.Volume = 0
        else
            em.Volume = 1
        end
    end)

    local Toggle = Tabs.Misc:AddToggle("MyToggle", {Title = "Mute Volume Control", Default = false })

    Toggle:OnChanged(function(v)
        local em = game:GetService("SoundService").VolumeControl
            
        if v then
            em.Volume = 0
        else
            em.Volume = 1
        end
    end)

-------------------------------
    
    Tabs.MoreScripts:AddParagraph({
        Title = "The scripts here are from other users, you can directly execute it."
    })

    Tabs.MoreScripts:AddButton({
        Title = "RINGTA Hub (by Ringta)",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/wefwef127382/inkgames.github.io/refs/heads/main/ringta.lua"))()
        end
    })

    Tabs.MoreScripts:AddButton({
        Title = "Ink Game (By Tora IsMe",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/InkGame"))()
        end
    })

    Tabs.MoreScripts:AddButton({
        Title = "AX-SCRIPTS (by AlexScriptX",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexScriptX/Ink-Game-Script/refs/heads/main/Ink%20Game%20by%20AlexScriptX.lua"))()
        end
    })

    Tabs.MoreScripts:AddButton({
        Title = "",
        Callback = function()
            
        end
    })

    Tabs.MoreScripts:AddButton({
        Title = "",
        Callback = function()
            
        end
    })

    Tabs.MoreScripts:AddButton({
        Title = "",
        Callback = function()
            
        end
    })

    Tabs.MoreScripts:AddButton({
        Title = "",
        Callback = function()
            
        end
    })

    
end





-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
