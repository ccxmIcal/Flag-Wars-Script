--[[
    Made by sync!#1337

    If you plan to skid from this / whatever just pass me some credits idrc :sunglasses:
    If the wallbang is not working properly / silent aimbot overall then just lower the fov because it means that it is targetting random people behind walls / ff people.
    Don't dm unless it's very important I wont be working on this script.
    Script made in like 30 minutes because why not
    Do not DM unless the script completely broke / your dm is script related.
    
    Game Link: https://www.roblox.com/games/3214114884/Flag-Wars-TONIGHT
    
    Credits to Kiriot for the ESP Library.

    Uhm Features:
      Silent Aim
      WallBang

      ESP

      WalkSpeed
      Jump Power
      Gravity
      Inf Jump
]]


local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()


local Window = Library:CreateWindow({
    Title = 'I hate jews, mexicans || Made by yours sync!#1337',
    Center = true, 
    AutoShow = true,
})

local Tabs = {
    Main = Window:AddTab('Main'),
    VisualsTab = Window:AddTab("ESP"),
    MiscTab = Window:AddTab("Misc"),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}




--[[
                  VARS
]]

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Mouse = LocalPlayer:GetMouse()




local MainLeft = Tabs.Main:AddLeftGroupbox('Silent Aim')
local MainRight = Tabs.Main:AddRightGroupbox('Silent Aim Configuration')

MainLeft:AddToggle('silentTgl', {Text = 'Silent Aimbot', Default = false, Tooltip = 'Toggle the Silent Aimbot'})
MainLeft:AddToggle('rageTeamCheck', {Text = 'Team Check', Default = true, Tooltip = 'Will decide if you want to aim at teammates or not!'})
MainLeft:AddToggle('silentFovCircleTgl', {Text = 'Show FOV Circle', Default = false, Tooltip = 'Decide if you want to show the FOV Circle or not!'})
MainLeft:AddToggle('wallbangTgl', {Text = 'WallBang', Default = false, Tooltip = 'Shoot through walls.'})

MainRight:AddSlider('silentFovRadius', {Text = 'Fov Size', Min = 5, Max = 500, Default = 90, Rounding = 0, Suffix = 'π'})
MainRight:AddSlider('silentFovSides', {Text = 'Fov Sides', Min = 5, Max = 64, Default = 64, Rounding = 0, Suffix = 'sides'})
MainRight:AddSlider('silentFovThickness', {Text = 'Fov Circle Thickness', Min = 0, Max = 9, Default = 5, Rounding = 0})
MainRight:AddLabel('Fov Circle Color'):AddColorPicker('Silent_Fov_Color', {Default = Color3.new(1, 1, 0)})
MainRight:AddDropdown('silentHitbox', {Values = {'Head', 'UpperTorso', 'LowerTorso'}, Default = 1, Multi = false, Text = 'Silent Hitbox', Tooltip = 'Choose what part you want to aim at!'})
MainRight:AddSlider('silentPrediction',{Text = 'Aimbot Prediction', Min = 0, Max = 100, Default = 50, Rounding = 0})


local silentFovRad = Options.silentFovRadius.Value
local silentFovColor = Options.Silent_Fov_Color.Value
local silentFovVisible = Toggles.silentFovCircleTgl.Value
local silentNumSides = Options.silentFovSides.Value
local silentThickness = Options.silentFovThickness.Value
local silentAimPart = Options.silentHitbox.Value


local SilentFovCircle = Drawing.new('Circle')
SilentFovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
SilentFovCircle.Radius = silentFovRad
SilentFovCircle.Color = silentFovColor
SilentFovCircle.Filled = false
SilentFovCircle.Visible = silentFovVisible
SilentFovCircle.Transparency = 0.5
SilentFovCircle.NumSides = silentNumSides
SilentFovCircle.Thickness = silentThickness

getgenv().Target = nil

local function silentClosetPlayer()
    local MaximumDistance = Options.silentFovRadius.Value

    for _, v in next, Players:GetPlayers() do
        if v.Name ~= LocalPlayer.Name then
            if Toggles.rageTeamCheck.Value == true then
                if v.Team ~= LocalPlayer.Team then
                    if v.Character ~= nil then
                        if v.Character:FindFirstChild("HumanoidRootPart") then
                            if v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                    
                                if VectorDistance < MaximumDistance then
                                    getgenv().Target = v
                                end
                            end
                        end
                    end
                end
            else
                if v.Character ~= nil then
                    if v.Character:FindFirstChild("HumanoidRootPart") then
                        if v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                            local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                            local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                            
                            if VectorDistance < MaximumDistance then
                                getgenv().Target = v
                            end
                        end
                    end
                end
            end
        end
    end
end


RunService.RenderStepped:Connect(function()
    SilentFovCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    SilentFovCircle.Radius = Options.silentFovRadius.Value
    SilentFovCircle.Filled = false
    SilentFovCircle.Color = Options.Silent_Fov_Color.Value
    SilentFovCircle.Visible = true
    SilentFovCircle.Transparency = 0.5
    SilentFovCircle.NumSides = Options.silentFovSides.Value
    SilentFovCircle.Thickness = Options.silentFovThickness.Value
    silentClosetPlayer()
    if Toggles.silentFovCircleTgl.Value == false or Toggles.silentTgl.Value == false then
        SilentFovCircle.Visible = false
    end
end)


--[[
    ######### ESP
]]



local ESPContainer = Tabs.VisualsTab:AddLeftGroupbox('Enemy ESP')
local ESPConfiguration = Tabs.VisualsTab:AddRightGroupbox('ESP Config')

local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
ESP:Toggle(true)
ESP.Color = Color3.new(1,1,1)

ESPContainer:AddToggle('boxesTGL', {Text = 'Boxes', Default = false, Tooltip = 'Toggle the Boxes ESP'})
ESPContainer:AddToggle('tracersTGL', {Text = 'Tracers', Default = false, Tooltip = 'Toggle the Tracers ESP'})
ESPContainer:AddToggle('namesTGL', {Text = 'Names', Default = false, Tooltip = 'Toggle the Names ESP'})

ESPConfiguration:AddToggle('teamESPTgl', {Text = 'Team ESP', Default = false, Tooltip = 'Choose if you want ESP on your teammates aswell!'})
ESPConfiguration:AddToggle('teamcolorTgl', {Text = 'Use team color', Default = true, Tooltip = 'Choose if you want to use the team color or not.'})
ESPConfiguration:AddToggle('boxesCameraTgl', {Text = 'Boxes Face Camera', Default = true, Tooltip = 'Choose if you want the boxes to face the camera or not.'})
ESPConfiguration:AddLabel('ESP Color'):AddColorPicker('ESP_Color', {Default = Color3.new(1, 1, 0)})


Toggles.boxesTGL:OnChanged(function()
    ESP.Boxes = Toggles.boxesTGL.Value
end)

Toggles.tracersTGL:OnChanged(function()
    ESP.Tracers = Toggles.tracersTGL.Value
end)

Toggles.namesTGL:OnChanged(function()
    ESP.Names = Toggles.namesTGL.Value
end)


Toggles.teamcolorTgl:OnChanged(function()
    ESP.TeamColor = Toggles.teamcolorTgl.Value
end)

Toggles.boxesCameraTgl:OnChanged(function()
    ESP.FaceCamera = Toggles.boxesCameraTgl.Value
end)

Options.ESP_Color:OnChanged(function()
    ESP.Color = Options.ESP_Color.Value
end)

Toggles.teamESPTgl:OnChanged(function()
    ESP.TeamMates = Toggles.teamESPTgl.Value
end)


--[[
    ########## MISC ###########
]]



local MiscLeftGroupBox = Tabs.MiscTab:AddLeftGroupbox("Misc Toggles")
local MiscRightGroupBox = Tabs.MiscTab:AddRightGroupbox("Misc Configuration")

MiscLeftGroupBox:AddToggle('WSToggle', {Text = "Walkspeed", Default = false, Tooltip = 'Modify your walkspeed.'})
MiscLeftGroupBox:AddToggle('JPToggle', {Text = "Jump Power", Default = false, Tooltip = 'Modify your jump power!' })
MiscLeftGroupBox:AddToggle('GravityToggle', {Text = 'Gravity Changer', Default = false, Tooltip = 'Changes the game gravity',})
MiscLeftGroupBox:AddToggle('infJump', {Text = 'Infinite Jump', Default = false})


MiscRightGroupBox:AddSlider('WSlider', {Text = 'WalkSpeed', Default = 24, Min = 5, Max = 1000, Rounding = 0, Compact = false,})
MiscRightGroupBox:AddSlider('JPSlider', {Text = 'JumpPower', Default = 24, Min = 5, Max = 1000, Rounding = 0, Compact = false})
MiscRightGroupBox:AddSlider('GravSlider', {Text = 'Gravity', Default = 196, Min = 5, Max = 1000, Rounding = 0, Compact = false})



Toggles.WSToggle:OnChanged(function()
    if Toggles.WSToggle.Value == false then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

Options.WSlider:OnChanged(function()
    if Toggles.WSToggle.Value == false then return end
    LocalPlayer.Character.Humanoid.WalkSpeed = Options.WSlider.Value
end)

Toggles.JPToggle:OnChanged(function()
    if Toggles.JPToggle.Value == false then
        LocalPlayer.Character.Humanoid.JumpPower = 55
    end
end)

Options.JPSlider:OnChanged(function()
    if Toggles.JPToggle.Value == false then return end
    LocalPlayer.Character.Humanoid.JumpPower = Options.JPSlider.Value
end)


Toggles.GravityToggle:OnChanged(function()
    if Toggles.GravityToggle.Value == false then
        game.Workspace.Gravity = 196.2
    end
end)

Options.GravSlider:OnChanged(function()
    if Toggles.GravityToggle.Value == false then return end
    if Toggles.GravityToggle.Value == true then
        game.Workspace.Gravity = Options.GravSlider.Value
    end
end)

UserInputService.JumpRequest:connect(function()
	if Toggles.infJump.Value then
		LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
	end
end)


local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' }) 

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder('MyScriptHub')
ThemeManager:ApplyToTab(Tabs['UI Settings'])


--[[
    ###### Hooks
]]

local old
old = hookmetamethod(game, "__namecall", function(Self, ...)
    local Args = {...}
    if Self.Name == "Shoot" and getgenv().Target ~= nil and Toggles.silentTgl.Value == true then
        local base = getgenv().Target.Character[Options.silentHitbox.Value]
        local velocity = base.AssemblyLinearVelocity
        local aimpos = base.Position + (velocity * Vector3.new(Options.silentPrediction.Value / 200, 0, Options.silentPrediction.Value / 200))
        Args[3] = aimpos
        if Toggles.wallbangTgl.Value == true then
            Args[2] = getgenv().Target.Character[Options.silentHitbox.Value].Position
        end
        return old(Self, unpack(Args))
    end
    return old(Self, unpack(Args))
end)