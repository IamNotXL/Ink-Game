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
    Main = Window:AddTab({ Title = "Main"}),
    Player = Window:AddTab({ Title = "Player"}),
    Lobby = Window:AddTab({ Title = "Lobby"}),
    RLGL = Window:AddTab({ Title = "Red Light Green Light"}),
    Rebel = Window:AddTab({ Title = "Rebel"}),
    Main2 = Window:AddTab({ Title = "Main"}),
    Main3 = Window:AddTab({ Title = "Main"}),
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
    
end

-------------------------------

    Tabs.Rebel:AddButton({
        Title = "Guard Hitbox",
        Callback = function()
            for _, guard in pairs(Workspace.Live:GetChildren()) do
                if guard.Name == "squid guylobby" and guard:FindFirstChild("Head") then
                    guard.Head.Size = Vector3.new(10, 9, 9)
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = guard.Head
                end
            end
        end
    })








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
