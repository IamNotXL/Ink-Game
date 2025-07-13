local Fluent = loadstring(Game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua", true))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "🦑 Ink Game" .. Fluent.Version,
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main"}),
    Player = Window:AddTab({ Title = "Player"}),
    Lobby = Window:AddTab({ Title = "Lobby"}),
    RLGL = Window:AddTab({ Title = "Red Light Green Light"}),
    Main1 = Window:AddTab({ Title = "Main"}),
    Main2 = Window:AddTab({ Title = "Main"}),
    Main3 = Window:AddTab({ Title = "Main"}),
}

local Options = Fluent.Options

do

    Tabs.Main:AddParagraph({
        Title = "Hello, " .. game.Players.LocalPlayer.Name .. "!"
    })

    local executor = detectExecutor()
    
    Tabs.Main:AddParagraph({
        Title = string.format("Executor: `%s`", executor)
    })
    
    Tabs.Main:AddButton({
        Title = "Button",
        Description = "Very important button",
        Callback = function()
            print("Button clicked.")
        end
    })

-------------------------------

    Tabs.Player:AddButton({
        Title = "Button",
        Description = "Very important button",
        Callback = function()
            print("Button clicked.")
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
