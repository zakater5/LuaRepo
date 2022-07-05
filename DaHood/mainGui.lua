-- [[ Author : zakater#8888 ]]--

-- [[ Config ]] --
local MenuName = "Violence UI"
local MenuVersion = "1.0.0"


-- [[ Variables ]] --
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local char = plr.Character
local humanoid = char:FindFirstChildWhichIsA("Humanoid")
local rootPart = char.HumanoidRootPart
local Camera = workspace.CurrentCamera
local mouse = plr:GetMouse()
local UserInputService = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- Exploit vars --
local speedOn = false
local humanDefault_ws = humanoid.WalkSpeed
local jumpOn = false
local humanDefault_jp = humanoid.JumpPower

local toggles = {
    noSlowdown = false,
    superSpeed = false,
    superJump = false
}

-- Teleport Locations --
local tpLocations = {
    ["Rev"] = CFrame.new(-664, 48, -134),
    ["Bank"] = CFrame.new(-433, 38, -284),
    ["DownHill"] = CFrame.new(-579, 67, -683),
    ["UpHill"] = CFrame.new(435, 107, -627),
    ["Flame"] = CFrame.new(-153, 55, -98),
    ["Casino"] = CFrame.new(-864, 65, -115),
    ["DB"] = CFrame.new(-1030, 80, -231),
    ["Gym"] = CFrame.new(-75, 57, -636),
    ["Theme Park"] = CFrame.new(113, 45, -917),
    ["VIP Area"] = CFrame.new(-798, -40, -886)
}


-- [[ Main Event-Listeners 1 (On-Start) ]] --
plr.CharacterAdded:Connect(function(chr)
    char = chr
    humanoid = chr:WaitForChild("Humanoid")
    rootPart = char.HumanoidRootPart
end)


-- [[ UI ]] --
local AlreadyExistingUI = game.CoreGui:FindFirstChild(MenuName) -- Checks if THIS UI already exists
if AlreadyExistingUI then
    AlreadyExistingUI:Destroy()
end

local BaseGui = Instance.new("ScreenGui", game.CoreGui) --Changed from ("ScreenGui", plr.PlayerGui)
BaseGui.ResetOnSpawn = false
BaseGui.Name = MenuName
BaseGui.Enabled = false

local MainFrame = Instance.new("Frame", BaseGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.25, 0, 0.3, 0)
MainFrame.Position = UDim2.new(.5, 0, .5, 0)
MainFrame.AnchorPoint = Vector2.new(.5, .5)
MainFrame.BackgroundTransparency = 1

local UI_Background = Instance.new("ImageLabel", MainFrame)
UI_Background.Name = "UI_Background"
UI_Background.Size = UDim2.new(1, 0, 1, 0)
UI_Background.BackgroundTransparency = 1
UI_Background.Image = "rbxassetid://3570695787"
UI_Background.SliceCenter = Rect.new(100, 100, 100, 100)
UI_Background.SliceScale = 0.08
UI_Background.ScaleType = Enum.ScaleType.Slice
UI_Background.ImageColor3 = Color3.new(0.25, 0.25, 0.25)

local TopBar_Frame = Instance.new("Frame", MainFrame)
TopBar_Frame.Name = "TopBar_Frame"
TopBar_Frame.Size = UDim2.new(1, 0, 0.1, 0)
TopBar_Frame.BackgroundTransparency = 1

local TopBar = Instance.new("ImageLabel", TopBar_Frame)
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 1, 0)
TopBar.BackgroundTransparency = 1
TopBar.Image = "rbxassetid://3570695787"
TopBar.SliceCenter = Rect.new(100, 100, 100, 100)
TopBar.SliceScale = 0.08
TopBar.ScaleType = Enum.ScaleType.Slice
TopBar.ImageColor3 = Color3.new(0.3, 0.3, 0.3)
TopBar.ZIndex = 3

TopBar_BG = Instance.new("ImageLabel", TopBar)
TopBar_BG.Name = "TopBar_BG"
TopBar_BG.Size = UDim2.new(1, 0, .2, 0)
TopBar_BG.Position = UDim2.new(0, 0, .8, 0)
TopBar_BG.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TopBar_BG.BorderSizePixel = 0
TopBar_BG.ZIndex = 2

local TopBarGradient = Instance.new("UIGradient", TopBar)
TopBarGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(199, 199, 199)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(230, 230, 230)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(199, 199, 199)),
}

local TopBarBorderLine = Instance.new("Frame", TopBar)
TopBarBorderLine.Name = "TopBarBorderLine"
TopBarBorderLine.Position = UDim2.new(0, 0, 1, 0)
TopBarBorderLine.Size = UDim2.new(1, 0, 0.05, 0)
TopBarBorderLine.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TopBarBorderLine.BorderSizePixel = 0
TopBarBorderLine.ZIndex = 2

-- [[ TopBar Controls ]] --
local X_Button = Instance.new("ImageButton", TopBar_Frame)
X_Button.Name = "X_Button"
X_Button.Size = UDim2.new(.03, 0, .45, 0)
X_Button.Position = UDim2.new(.03, 0, .3, 0)
X_Button.BackgroundTransparency = 1
X_Button.Image = "rbxassetid://3570695787"
X_Button.SliceCenter = Rect.new(100, 100, 100, 100)
X_Button.SliceScale = 0.12
X_Button.ScaleType = Enum.ScaleType.Slice
X_Button.ImageColor3 = Color3.fromRGB(249, 77, 78)
X_Button.ZIndex = 3

local Max_Button = Instance.new("ImageButton", TopBar_Frame)
Max_Button.Name = "Max_Button"
Max_Button.Size = UDim2.new(.03, 0, .45, 0)
Max_Button.Position = UDim2.new(.08, 0, .3, 0)
Max_Button.BackgroundTransparency = 1
Max_Button.Image = "rbxassetid://3570695787"
Max_Button.SliceCenter = Rect.new(100, 100, 100, 100)
Max_Button.SliceScale = 0.12
Max_Button.ScaleType = Enum.ScaleType.Slice
Max_Button.ImageColor3 = Color3.fromRGB(254, 191, 45)
Max_Button.ZIndex = 3

local Min_Button = Instance.new("ImageButton", TopBar_Frame)
Min_Button.Name = "Min_Button"
Min_Button.Size = UDim2.new(.03, 0, .45, 0)
Min_Button.Position = UDim2.new(.13, 0, .3, 0)
Min_Button.BackgroundTransparency = 1
Min_Button.Image = "rbxassetid://3570695787"
Min_Button.SliceCenter = Rect.new(100, 100, 100, 100)
Min_Button.SliceScale = 0.12
Min_Button.ScaleType = Enum.ScaleType.Slice
Min_Button.ImageColor3 = Color3.fromRGB(50, 209, 64)
Min_Button.ZIndex = 3

-- [[ TopBar Info ]] --
local Title_Label = Instance.new("TextLabel", TopBar)
Title_Label.Name = "Title_Label"
Title_Label.Text = MenuName
Title_Label.Font = Enum.Font.GothamBold
Title_Label.TextScaled = true
Title_Label.Size = UDim2.new(0.6, 0, .6, 0)
Title_Label.Position = UDim2.new(.2, 0, .25, 0)
Title_Label.BackgroundTransparency = 1
Title_Label.TextColor3 = Color3.fromRGB(220, 220, 220)
Title_Label.ZIndex = 3

local Version_Label = Instance.new("TextLabel", TopBar)
Version_Label.Name = "Version_Label"
Version_Label.Text = MenuVersion
Version_Label.Font = Enum.Font.GothamBold
Version_Label.TextScaled = true
Version_Label.Size = UDim2.new(0.6, 0, .6, 0)
Version_Label.Position = UDim2.new(.63, 0, .25, 0)
Version_Label.BackgroundTransparency = 1
Version_Label.TextColor3 = Color3.fromRGB(220, 220, 220)
Version_Label.ZIndex = 3

-- [[ SideBar ]] --
local SideBar = Instance.new("ImageLabel", MainFrame)
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(.25, 0, 1, 0)
SideBar.BackgroundTransparency = 1
SideBar.Image = "rbxassetid://3570695787"
SideBar.SliceCenter = Rect.new(100, 100, 100, 100)
SideBar.SliceScale = 0.08
SideBar.ScaleType = Enum.ScaleType.Slice
SideBar.ImageColor3 = Color3.new(0.3, 0.3, 0.3)

-- [[ SideBar Constrols ]] --
local SideBar_ButtonsTable = {}
local SideBar_ButtonBackgroundTable = {}

local HomePage_Button = Instance.new("TextButton", MainFrame)
HomePage_Button.Name = "HomePage_Button"
HomePage_Button.Text = "Home"
HomePage_Button.Font = Enum.Font.GothamBold
HomePage_Button.FontSize = Enum.FontSize.Size18
HomePage_Button.TextColor3 = Color3.fromRGB(220, 220, 220)
HomePage_Button.TextTransparency = 1
HomePage_Button.Size = UDim2.new(.2, 0, .075, 0)
HomePage_Button.Position = UDim2.new(.025, 0, .12, 0)
HomePage_Button.BackgroundTransparency = 1
HomePage_Button.ZIndex = 5

local PlayersList_Button = Instance.new("TextButton", MainFrame)
PlayersList_Button.Name = "PlayersList_Button"
PlayersList_Button.Text = "Players"
PlayersList_Button.Font = Enum.Font.GothamBold
PlayersList_Button.FontSize = Enum.FontSize.Size18
PlayersList_Button.TextColor3 = Color3.fromRGB(220, 220, 220)
PlayersList_Button.TextTransparency = 1
PlayersList_Button.Size = UDim2.new(.2, 0, .075, 0)
PlayersList_Button.Position = UDim2.new(.025, 0, .22, 0)
PlayersList_Button.BackgroundTransparency = 1
PlayersList_Button.ZIndex = 5

local CombatPage_Button = Instance.new("TextButton", MainFrame)
CombatPage_Button.Name = "CombatPage_Button"
CombatPage_Button.Text = "Combat"
CombatPage_Button.Font = Enum.Font.GothamBold
CombatPage_Button.FontSize = Enum.FontSize.Size18
CombatPage_Button.TextColor3 = Color3.fromRGB(220, 220, 220)
CombatPage_Button.TextTransparency = 1
CombatPage_Button.Size = UDim2.new(.2, 0, .075, 0)
CombatPage_Button.Position = UDim2.new(.025, 0, .32, 0)
CombatPage_Button.BackgroundTransparency = 1
CombatPage_Button.ZIndex = 5

local LocationsList_Button = Instance.new("TextButton", MainFrame)
LocationsList_Button.Name = "LocationsList_Button"
LocationsList_Button.Text = "Locations"
LocationsList_Button.Font = Enum.Font.GothamBold
LocationsList_Button.FontSize = Enum.FontSize.Size18
LocationsList_Button.TextColor3 = Color3.fromRGB(220, 220, 220)
LocationsList_Button.TextTransparency = 1
LocationsList_Button.Size = UDim2.new(.2, 0, .075, 0)
LocationsList_Button.Position = UDim2.new(.025, 0, .42, 0)
LocationsList_Button.BackgroundTransparency = 1
LocationsList_Button.ZIndex = 5

local ExtrasPage_Button = Instance.new("TextButton", MainFrame)
ExtrasPage_Button.Name = "ExtrasPage_Button"
ExtrasPage_Button.Text = "Extras"
ExtrasPage_Button.Font = Enum.Font.GothamBold
ExtrasPage_Button.FontSize = Enum.FontSize.Size18
ExtrasPage_Button.TextColor3 = Color3.fromRGB(220, 220, 220)
ExtrasPage_Button.TextTransparency = 1
ExtrasPage_Button.Size = UDim2.new(.2, 0, .075, 0)
ExtrasPage_Button.Position = UDim2.new(.025, 0, .52, 0)
ExtrasPage_Button.BackgroundTransparency = 1
ExtrasPage_Button.ZIndex = 5

SideBar_ButtonsTable = {HomePage_Button, PlayersList_Button, CombatPage_Button, LocationsList_Button, ExtrasPage_Button}

for _, v in pairs(SideBar_ButtonsTable) do
    local newButtonBackground = Instance.new("ImageLabel", v)
    newButtonBackground.Name = v.Name .. "_background"
    newButtonBackground.Image = "rbxassetid://3570695787"
    newButtonBackground.SliceCenter = Rect.new(100, 100, 100, 100)
    newButtonBackground.SliceScale = 0.08
    newButtonBackground.ScaleType = Enum.ScaleType.Slice
    newButtonBackground.ImageColor3 = Color3.new(0.25, 0.25, 0.25)
    newButtonBackground.Position = UDim2.new(.5, 0, .5, 0)
    newButtonBackground.AnchorPoint = Vector2.new(.5, .5)
    newButtonBackground.BackgroundTransparency = 1
    newButtonBackground.ZIndex = 4
    
    -- SideBar Controls - OnMouseEnter listeners --
    v.MouseEnter:Connect(function()
        local opening_tween = TS:Create(
            newButtonBackground,
            TweenInfo.new(.2, Enum.EasingStyle.Sine),
            {Size = UDim2.new(1.2, 0, 1.2, 0)}
        )
        opening_tween:Play()
    end)
    
    v.MouseLeave:Connect(function()
        local closing_tween = TS:Create(
            newButtonBackground,
            TweenInfo.new(.2, Enum.EasingStyle.Sine),
            {Size = UDim2.new(0, 0, 0, 0)}
        )
        closing_tween:Play()
    end)
    
    table.insert(SideBar_ButtonBackgroundTable, newButtonBackground)
end


-- [[ EXPLOIT-FUNCTIONS ]] --
local inputBegan_SuperJump = nil
local inputBegan_NoSlowdown = nil
local inputEnded_NoSlowdown = nil
local inputBegan_SuperSpeed = nil
local inputEnded_SuperSpeed = nil

local function toggle_noSlowdown()
    if not toggles.noSlowdown then
        inputBegan_NoSlowdown = UIS.InputBegan:Connect(function(input, processed)
            if input.KeyCode == Enum.KeyCode.LeftShift and not processed then
                humanoid.WalkSpeed = 22
            end
        end)

        inputEnded_NoSlowdown = UIS.InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.LeftShift then
                humanoid.WalkSpeed = humanDefault_ws
            end
        end)
        toggles.noSlowdown = true
        
    else
        inputBegan_NoSlowdown:Disconnect()
        inputEnded_NoSlowdown:Disconnect()
        humanoid.WalkSpeed = humanDefault_ws
        toggles.noSlowdown = false
    end
end

local function toggle_SuperSpeed()
    if not toggles.superSpeed then
        inputBegan_SuperSpeed = UIS.InputBegan:Connect(function(input, processed)
            if input.KeyCode == Enum.KeyCode.Q and not processed and not speedOn then
                humanoid.WalkSpeed = 150
                speedOn = true
        
            elseif input.KeyCode == Enum.KeyCode.Q and not processed and speedOn then
                humanoid.WalkSpeed = humanDefault_ws
                speedOn = false
            end
        
            if input.KeyCode == Enum.KeyCode.LeftShift and not processed then
                humanoid.WalkSpeed = 22
            end
        end)

        inputEnded_SuperSpeed = UIS.InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.LeftShift then
                humanoid.WalkSpeed = humanDefault_ws
            end
        end)
        
    else
        inputBegan_SuperSpeed:Disconnect()
        inputEnded_SuperSpeed:Disconnect()
        humanoid.WalkSpeed = humanDefault_ws
        speedOn = false
        toggles.superSpeed = false
    end
    
    
end

local function toggle_SuperJump()
    if not toggles.superJump then
        inputBegan_SuperJump = UIS.InputBegan:Connect(function(input, processed)
            if input.KeyCode == Enum.KeyCode.J and not processed and not jumpOn then
                humanoid.JumpPower = 250
                jumpOn = true
        
            elseif input.KeyCode == Enum.KeyCode.J and not processed and jumpOn then
                humanoid.JumpPower = humanDefault_jp
                jumpOn = false
            end
        end)
        toggles.superJump = true
        
    else
        inputBegan_SuperJump:Disconnect()
        humanoid.JumpPower = humanDefault_jp
        jumpOn = false
        toggles.superJump = false
    end
end

local function teleportTo(locationCFrame)
    rootPart.CFrame = locationCFrame
end

local function setupPlayersList()
    for _, v in pairs(game.Players:GetChildren()) do
        local newPlayerButton = Instance.new("TextButton", PlayerListFrame)
        newPlayerButton.Name = "HomePage_Button"
        newPlayerButton.Text = v.DisplayName
        newPlayerButton.Font = Enum.Font.GothamBold
        newPlayerButton.FontSize = Enum.FontSize.Size24
        newPlayerButton.TextColor3 = Color3.fromRGB(220, 220, 220)
        newPlayerButton.Text = v.Name
        newPlayerButton.Size = UDim2.new(.8, 0, .05, 0)
        newPlayerButton.BackgroundTransparency = 1
        newPlayerButton.ZIndex = 5
    
        local newPlayerButton_BG = Instance.new("ImageLabel", newPlayerButton)
        newPlayerButton_BG.Name = "PlayerButton_BG"
        newPlayerButton_BG.Image = "rbxassetid://3570695787"
        newPlayerButton_BG.Size = UDim2.new(1, 0, 1, 0)
        newPlayerButton_BG.SliceCenter = Rect.new(100, 100, 100, 100)
        newPlayerButton_BG.SliceScale = 0.08
        newPlayerButton_BG.ScaleType = Enum.ScaleType.Slice
        newPlayerButton_BG.ImageColor3 = Color3.new(0.3, 0.3, 0.3)
        newPlayerButton_BG.Position = UDim2.new(.5, 0, .5, 0)
        newPlayerButton_BG.AnchorPoint = Vector2.new(.5, .5)
        newPlayerButton_BG.BackgroundTransparency = 1
        newPlayerButton_BG.ZIndex = 4
    
        newPlayerButton.MouseButton1Click:Connect(function() openPlayerPage(v) end)
    end
end


-- [[ Pages ]] --
local Pages_Table = {}

local Home_Page = Instance.new("Frame", UI_Background)
Home_Page.Size = UDim2.new(.75, 0, .9, 0)
Home_Page.Position = UDim2.new(.25, 0, .1, 0)
Home_Page.BackgroundTransparency = 1
Home_Page.Visible = true -- The first page to show on startup

local PlayersList_Page = Instance.new("Frame", UI_Background)
PlayersList_Page.Size = UDim2.new(.75, 0, .9, 0)
PlayersList_Page.Position = UDim2.new(.25, 0, .1, 0)
PlayersList_Page.BackgroundTransparency = 1
PlayersList_Page.Visible = false

local Combat_Page = Instance.new("Frame", UI_Background)
Combat_Page.Size = UDim2.new(.65, 0, .85, 0)
Combat_Page.Position = UDim2.new(.3, 0, .15, 0)
Combat_Page.BackgroundTransparency = 1
Combat_Page.Visible = false

local LocationsList_Page = Instance.new("Frame", UI_Background)
LocationsList_Page.Size = UDim2.new(.65, 0, .85, 0)
LocationsList_Page.Position = UDim2.new(.3, 0, .15, 0)
LocationsList_Page.BackgroundTransparency = 1
LocationsList_Page.Visible = false

local Extras_Page = Instance.new("Frame", UI_Background)
Extras_Page.Size = UDim2.new(.65, 0, .85, 0)
Extras_Page.Position = UDim2.new(.3, 0, .15, 0)
Extras_Page.BackgroundTransparency = 1
Extras_Page.Visible = false

Pages_Table = {Home_Page, PlayersList_Page, Combat_Page, LocationsList_Page, Extras_Page}


-- [[ Page Button Listeners ]] --
local function OpenPage(Page)
    for _, v in pairs(Pages_Table) do --Close all other pages
        if v ~= Page then
            v.Visible = false
        end
    end
    Page.Visible = true
end

HomePage_Button.MouseButton1Click:Connect(function() OpenPage(Home_Page) end)
PlayersList_Button.MouseButton1Click:Connect(function() OpenPage(PlayersList_Page) setupPlayersList() end)
CombatPage_Button.MouseButton1Click:Connect(function() OpenPage(Combat_Page) end)
LocationsList_Button.MouseButton1Click:Connect(function() OpenPage(LocationsList_Page) end)
ExtrasPage_Button.MouseButton1Click:Connect(function() OpenPage(Extras_Page) end)


-- [[ HOME PAGE ]] --
local Welcome_Label = Instance.new("TextLabel", Home_Page)
Welcome_Label.AnchorPoint = Vector2.new(.5, .5)
Welcome_Label.Position = UDim2.new(.5, 0, .15, 0)
Welcome_Label.Size = UDim2.new(.5, 0, .1, 0)
Welcome_Label.BackgroundTransparency = 1
Welcome_Label.Font = Enum.Font.GothamBold
Welcome_Label.FontSize = Enum.FontSize.Size18
Welcome_Label.TextColor3 = Color3.fromRGB(220, 220, 220)
Welcome_Label.TextScaled = true
Welcome_Label.Text = "Welcome, " .. plr.DisplayName .. "!"

local WelcomeAvi_Image = Instance.new("ImageLabel", Home_Page)
WelcomeAvi_Image.AnchorPoint = Vector2.new(.5, .5)
WelcomeAvi_Image.Position = UDim2.new(.5, 0, .5, 0)
WelcomeAvi_Image.Size = UDim2.new(.4, 0, .5, 0)
WelcomeAvi_Image.BorderSizePixel = 5
local aviImg, ready = Players:GetUserThumbnailAsync(
        plr.UserId,
        Enum.ThumbnailType.HeadShot,
        Enum.ThumbnailSize.Size420x420
    )
WelcomeAvi_Image.Image = aviImg


-- [[ COMBAT PAGE ]] --
local uiListLayout_CombatPage = Instance.new("UIGridLayout", Combat_Page)
uiListLayout_CombatPage.CellSize = UDim2.new(1, 0, .15, 0)
uiListLayout_CombatPage.CellPadding = UDim2.new(.5, 0, .02, 0)

local enableSpeedGlitch_Button = Instance.new("TextButton", Combat_Page)
enableSpeedGlitch_Button.Name = "enableSpeedGlitch_Button"
enableSpeedGlitch_Button.Text = "Super Human [Q]"
enableSpeedGlitch_Button.TextScaled = true
enableSpeedGlitch_Button.BackgroundTransparency = 1
enableSpeedGlitch_Button.Font = Enum.Font.GothamBold
enableSpeedGlitch_Button.FontSize = Enum.FontSize.Size18
enableSpeedGlitch_Button.TextColor3 = Color3.fromRGB(220, 220, 220)
enableSpeedGlitch_Button.Size = UDim2.new(.35, 0, .15, 0)
enableSpeedGlitch_Button.ZIndex = 2
    
local enableSpeedGlitchButton_BG = Instance.new("ImageLabel", enableSpeedGlitch_Button)
enableSpeedGlitchButton_BG.Size = UDim2.new(1, 0, 1, 0)
enableSpeedGlitchButton_BG.Name = "enableSpeedGlitchButton_BG"
enableSpeedGlitchButton_BG.Image = "rbxassetid://3570695787"
enableSpeedGlitchButton_BG.SliceCenter = Rect.new(100, 100, 100, 100)
enableSpeedGlitchButton_BG.SliceScale = 0.08
enableSpeedGlitchButton_BG.ScaleType = Enum.ScaleType.Slice
enableSpeedGlitchButton_BG.ImageColor3 = Color3.new(0.3, 0.3, 0.3)
enableSpeedGlitchButton_BG.BackgroundTransparency = 1

local enableSuperJump_Button = Instance.new("TextButton", Combat_Page)
enableSuperJump_Button.Name = "enableSuperJump_Button"
enableSuperJump_Button.Text = "Super Jump [J]"
enableSuperJump_Button.TextScaled = true
enableSuperJump_Button.BackgroundTransparency = 1
enableSuperJump_Button.Font = Enum.Font.GothamBold
enableSuperJump_Button.FontSize = Enum.FontSize.Size18
enableSuperJump_Button.TextColor3 = Color3.fromRGB(220, 220, 220)
enableSuperJump_Button.Size = UDim2.new(.35, 0, .15, 0)
enableSuperJump_Button.ZIndex = 2
    
local enableSuperJumpButton_BG = Instance.new("ImageLabel", enableSuperJump_Button)
enableSuperJumpButton_BG.Size = UDim2.new(1, 0, 1, 0)
enableSuperJumpButton_BG.Name = "enableSuperJumpButton_BG"
enableSuperJumpButton_BG.Image = "rbxassetid://3570695787"
enableSuperJumpButton_BG.SliceCenter = Rect.new(100, 100, 100, 100)
enableSuperJumpButton_BG.SliceScale = 0.08
enableSuperJumpButton_BG.ScaleType = Enum.ScaleType.Slice
enableSuperJumpButton_BG.ImageColor3 = Color3.new(0.3, 0.3, 0.3)
enableSuperJumpButton_BG.BackgroundTransparency = 1

local enableNoSlowdown_Button = Instance.new("TextButton", Combat_Page)
enableNoSlowdown_Button.Name = "enableNoSlowdown_Button"
enableNoSlowdown_Button.Text = "No Slowdown"
enableNoSlowdown_Button.TextScaled = true
enableNoSlowdown_Button.BackgroundTransparency = 1
enableNoSlowdown_Button.Font = Enum.Font.GothamBold
enableNoSlowdown_Button.FontSize = Enum.FontSize.Size18
enableNoSlowdown_Button.TextColor3 = Color3.fromRGB(220, 220, 220)
enableNoSlowdown_Button.Size = UDim2.new(.35, 0, .15, 0)
enableNoSlowdown_Button.ZIndex = 2
    
local enableNoSlowdownButton_BG = Instance.new("ImageLabel", enableNoSlowdown_Button)
enableNoSlowdownButton_BG.Size = UDim2.new(1, 0, 1, 0)
enableNoSlowdownButton_BG.Name = "enableNoSlowdownButton_BG"
enableNoSlowdownButton_BG.Image = "rbxassetid://3570695787"
enableNoSlowdownButton_BG.SliceCenter = Rect.new(100, 100, 100, 100)
enableNoSlowdownButton_BG.SliceScale = 0.08
enableNoSlowdownButton_BG.ScaleType = Enum.ScaleType.Slice
enableNoSlowdownButton_BG.ImageColor3 = Color3.new(0.3, 0.3, 0.3)
enableNoSlowdownButton_BG.BackgroundTransparency = 1

enableSpeedGlitch_Button.MouseButton1Click:Connect(toggle_SuperSpeed)
enableSuperJump_Button.MouseButton1Click:Connect(toggle_SuperJump)
enableNoSlowdown_Button.MouseButton1Click:Connect(toggle_noSlowdown)


-- [[ LOCATIONS LIST PAGE ]] --
local uiGridLayour_TPLocations = Instance.new("UIGridLayout", LocationsList_Page)
uiGridLayour_TPLocations.CellSize = UDim2.new(.35, 0, .15, 0)

for i, v in pairs(tpLocations) do
    local newTpButton = Instance.new("TextButton", LocationsList_Page)
    newTpButton.Name = i
    newTpButton.Text = i
    newTpButton.BackgroundTransparency = 1
    newTpButton.Font = Enum.Font.GothamBold
    newTpButton.FontSize = Enum.FontSize.Size18
    newTpButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    newTpButton.ZIndex = 2
    
    local newTpButton_BG = Instance.new("ImageLabel", newTpButton)
    newTpButton_BG.Size = UDim2.new(1, 0, 1, 0)
    newTpButton_BG.Name = i .. "_background"
    newTpButton_BG.Image = "rbxassetid://3570695787"
    newTpButton_BG.SliceCenter = Rect.new(100, 100, 100, 100)
    newTpButton_BG.SliceScale = 0.08
    newTpButton_BG.ScaleType = Enum.ScaleType.Slice
    newTpButton_BG.ImageColor3 = Color3.new(0.3, 0.3, 0.3)
    newTpButton_BG.BackgroundTransparency = 1
    
    newTpButton.MouseButton1Click:Connect(function() teleportTo(v) end)
end


-- [[ PLAYER LIST PAGE ]] --
local PlayerListFrame = Instance.new("ScrollingFrame", PlayersList_Page)
PlayerListFrame.Size = UDim2.new(1, 0, .8, 0)
PlayerListFrame.Position = UDim2.new(0, 0, .2, 0)
PlayerListFrame.BackgroundTransparency = 1

local UI_ListLayout = Instance.new("UIListLayout", PlayerListFrame)
UI_ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Specific player page --
local PlayerPage = Instance.new("Frame", UI_Background)
PlayerPage.Size = UDim2.new(.75, 0, .9, 0)
PlayerPage.Position = UDim2.new(.25, 0, .1, 0)
PlayerPage.BackgroundTransparency = 1
PlayerPage.Visible = false
table.insert(Pages_Table, PlayerPage)

local PlayerPage_DisplayName = Instance.new("TextLabel", PlayerPage)
PlayerPage_DisplayName.Position = UDim2.new(.4, 0, .05, 0)
PlayerPage_DisplayName.Size = UDim2.new(.5, 0, .08, 0)

local PlayerPage_Username = Instance.new("TextLabel", PlayerPage)
PlayerPage_Username.Position = UDim2.new(.4, 0, .15, 0)
PlayerPage_Username.Size = UDim2.new(.5, 0, .08, 0)

local PlayerPage_Avatar = Instance.new("ImageLabel", PlayerPage)
PlayerPage_Avatar.Position = UDim2.new(.05, 0, .05, 0)
PlayerPage_Avatar.Size = UDim2.new(.3, 0, .4, 0)

local PlayerPage_MoneyAmount = Instance.new("TextLabel", PlayerPage)
PlayerPage_MoneyAmount.Position = UDim2.new(-.05, 0, .5, 0)
PlayerPage_MoneyAmount.Size = UDim2.new(.5, 0, .08, 0)
PlayerPage_MoneyAmount.Font = Enum.Font.GothamBold
PlayerPage_MoneyAmount.FontSize = Enum.FontSize.Size18
PlayerPage_MoneyAmount.TextColor3 = Color3.fromRGB(0, 255, 85)
PlayerPage_MoneyAmount.TextScaled = true
PlayerPage_MoneyAmount.BackgroundTransparency = 1

local PlayerPage_ArmorAmount = Instance.new("TextLabel", PlayerPage)
PlayerPage_ArmorAmount.Position = UDim2.new(-.05, 0, .6, 0)
PlayerPage_ArmorAmount.Size = UDim2.new(.5, 0, .08, 0)
PlayerPage_ArmorAmount.Font = Enum.Font.GothamBold
PlayerPage_ArmorAmount.FontSize = Enum.FontSize.Size18
PlayerPage_ArmorAmount.TextColor3 = Color3.fromRGB(0, 106, 255)
PlayerPage_ArmorAmount.TextScaled = true
PlayerPage_ArmorAmount.BackgroundTransparency = 1

local PlayerPage_Items = Instance.new("TextLabel", PlayerPage)
PlayerPage_Items.Position = UDim2.new(.4, 0, .30, 0)
PlayerPage_Items.Size = UDim2.new(.5, 0, .6, 0)
PlayerPage_Items.TextScaled = true
PlayerPage_Items.Text = ""


local function openPlayerPage(player)
    for _, v in pairs(Pages_Table) do --Close all other pages
        if v ~= Page then
            v.Visible = false
        end
    end
    PlayerPage.Visible = true
    PlayerPage_DisplayName.Text = player.DisplayName
    PlayerPage_Username.Text = player.Name
    local content, isReady = Players:GetUserThumbnailAsync(
        player.UserId,
        Enum.ThumbnailType.HeadShot,
        Enum.ThumbnailSize.Size420x420
    )
    PlayerPage_Avatar.Image = content
    PlayerPage_MoneyAmount.Text = "$ " .. tostring(player:WaitForChild("DataFolder"):WaitForChild("Currency").Value)
    local informationFolder = player:WaitForChild("DataFolder"):WaitForChild("Information")
    local armor = informationFolder:FindFirstChild("ArmorSave")
    if armor then
        PlayerPage_ArmorAmount.Text = "Armor: " .. tostring(armor.Value / 2) .. "%"
    else
        PlayerPage_ArmorAmount.Text = "Armor: 0%"
    end
    
    local playerBackpackFolder = player:WaitForChild("Backpack"):GetChildren()
    PlayerPage_Items.Text = ""
    
    for _, v in pairs(playerBackpackFolder) do
        if v:IsA("Tool") then
            if v.Name ~= "Wallet" or v.Name ~= "[Phone]" or v.Name ~= "Combat" or v.Name ~= "[SprayCan]" then
                PlayerPage_Items.Text = PlayerPage_Items.Text .. " " .. v.Name
            end
        end
    end
end


-- [[ Intro setup ]] --
local AlreadyExistingUI_Intro = game.CoreGui:FindFirstChild(MenuName .. "_intro") -- Checks if THIS UI already exists
if AlreadyExistingUI_Intro then
    AlreadyExistingUI_Intro:Destroy()
end

local BaseIntroGui = Instance.new("ScreenGui", game.CoreGui) --Changed from ("ScreenGui", plr.PlayerGui)
BaseIntroGui.ResetOnSpawn = false
BaseIntroGui.Name = MenuName .. "_intro"

local intro_Background = Instance.new("ImageLabel", BaseIntroGui)
intro_Background.Name = "intro_Background"
intro_Background.Position = UDim2.new(.5, 0, .5, 0)
intro_Background.AnchorPoint = Vector2.new(.5, .5)
intro_Background.Size = UDim2.new(0, 0, 0, 0)
intro_Background.BackgroundTransparency = 1
intro_Background.Image = "rbxassetid://3570695787"
intro_Background.SliceCenter = Rect.new(100, 100, 100, 100)
intro_Background.SliceScale = 0.08
intro_Background.ScaleType = Enum.ScaleType.Slice
intro_Background.ImageColor3 = Color3.new(0.25, 0.25, 0.25)

local intro_Logo = Instance.new("ImageLabel", intro_Background)
intro_Logo.Name = "intro_Logo"
intro_Logo.Size = UDim2.new(.8, 0, .8, 0)
intro_Logo.AnchorPoint = Vector2.new(0, 0)
intro_Logo.Position = UDim2.new(.1, 0, 0, 0)
intro_Logo.BackgroundTransparency = 1
intro_Logo.BorderSizePixel = 0
intro_Logo.Image = "rbxassetid://8103048875" --oni image
intro_Logo.ImageColor3 = Color3.new(0.25, 0.25, 0.25)
intro_Logo.ZIndex = 3

local gradientFrame = Instance.new("Frame", intro_Background)
gradientFrame.Name = "gradientFrame"
gradientFrame.Size = intro_Logo.Size
gradientFrame.AnchorPoint = Vector2.new(0, 0)
gradientFrame.Position = UDim2.new(.1, 0, 0, 0)
gradientFrame.BorderSizePixel = 0
gradientFrame.ZIndex = 2

local UI_Gradient_ = Instance.new("UIGradient", gradientFrame)
UI_Gradient_.Rotation = 45

local intro_Title = Instance.new("TextLabel", intro_Background)
intro_Title.BackgroundTransparency = 1
intro_Title.BorderSizePixel = 0
intro_Title.Size = UDim2.new(.5, 0, .2, 0)
intro_Title.AnchorPoint = Vector2.new(0, 0)
intro_Title.Position = UDim2.new(.25, 0, .75, 0)
intro_Title.TextColor3 = Color3.fromRGB(200, 200, 200)
intro_Title.TextScaled = true
intro_Title.Font = Enum.Font.GothamBold
intro_Title.Text = MenuName
intro_Title.ZIndex = 3


-- [[ Gradient thread ]] --
local gradientThread = coroutine.create(function()
    local speed = .3
    local purple
    local purple2
    local purple3
    local pink
    local pink2
    local pink3
    local fullColorCycle
    
    while wait() do --200, 200, 200 / 1, 1, 1
        purple = ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 200, 200))
        purple2 = ColorSequenceKeypoint.new(.2, Color3.fromRGB(1, 1, 1))
        purple3 = ColorSequenceKeypoint.new(.4, Color3.fromRGB(200, 200, 200))
        pink = ColorSequenceKeypoint.new(.6, Color3.fromRGB(1, 1, 1))
        pink2 = ColorSequenceKeypoint.new(.8, Color3.fromRGB(200, 200, 200))
        pink3 = ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 1, 1))
        fullColorCycle = ColorSequence.new({purple, purple2, purple3, pink, pink2, pink3})
        UI_Gradient_.Color = fullColorCycle
        wait(speed)
        
        purple = ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 200, 200))
        purple2 = ColorSequenceKeypoint.new(.1, Color3.fromRGB(1, 1, 1))
        purple3 = ColorSequenceKeypoint.new(.3, Color3.fromRGB(200, 200, 200))
        pink = ColorSequenceKeypoint.new(.5, Color3.fromRGB(1, 1, 1))
        pink2 = ColorSequenceKeypoint.new(.7, Color3.fromRGB(200, 200, 200))
        pink3 = ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 1, 1))
        fullColorCycle = ColorSequence.new({purple, purple2, purple3, pink, pink2, pink3})
        UI_Gradient_.Color = fullColorCycle
        wait(speed)

        purple = ColorSequenceKeypoint.new(0, Color3.fromRGB(1, 1, 1))
        purple2 = ColorSequenceKeypoint.new(.2, Color3.fromRGB(200, 200, 200))
        purple3 = ColorSequenceKeypoint.new(.4, Color3.fromRGB(1, 1, 1))
        pink = ColorSequenceKeypoint.new(.6, Color3.fromRGB(200, 200, 200))
        pink2 = ColorSequenceKeypoint.new(.8, Color3.fromRGB(1, 1, 1))
        pink3 = ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
        fullColorCycle = ColorSequence.new({purple, purple2, purple3, pink, pink2, pink3})
        UI_Gradient_.Color = fullColorCycle
        wait(speed)
        
        purple = ColorSequenceKeypoint.new(0, Color3.fromRGB(1, 1, 1))
        purple2 = ColorSequenceKeypoint.new(.1, Color3.fromRGB(200, 200, 200))
        purple3 = ColorSequenceKeypoint.new(.3, Color3.fromRGB(1, 1, 1))
        pink = ColorSequenceKeypoint.new(.5, Color3.fromRGB(200, 200, 200))
        pink2 = ColorSequenceKeypoint.new(.7, Color3.fromRGB(1, 1, 1))
        pink3 = ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
        fullColorCycle = ColorSequence.new({purple, purple2, purple3, pink, pink2, pink3})
        UI_Gradient_.Color = fullColorCycle
        wait(speed)
    end
end)
coroutine.resume(gradientThread)


-- [[ UI-Button listeners ]] --
X_Button.MouseButton1Click:Connect(function()
    game.CoreGui:FindFirstChild(MenuName):Destroy()
end)

Max_Button.MouseButton1Click:Connect(function()
    local windowSize = BaseGui.AbsoluteSize
    UI_Background.Size = UI_Background.Size + UDim2.new(0, windowSize.X - 1000, 0, windowSize.Y - 500)
    TopBar.Size = TopBar.Size + UDim2.new(0, windowSize.X - 1000, 0, 0)
    SideBar.Size = SideBar.Size + UDim2.new(0, 0, 0, windowSize.Y - 500)
    MainFrame.Position = UDim2.new(UI_Background.Position.X.Scale, 0, UI_Background.Position.Y.Scale, 0)
end)

local UI_Minimized = false
local UI_Background_OriginalSize = nil
local TopBarBG_OriginalSize = nil
local SideBar_OriginalSize = nil
local lastOpenPage = nil
local min_button_debounce = false
Min_Button.MouseButton1Click:Connect(function()
    if UI_Minimized == false and  min_button_debounce == false then
        min_button_debounce = true
        
        for _, v in pairs(Pages_Table) do --Close all other pages
            if v.Visible == true then
                lastOpenPage = v
            end
            v.Visible = false
        end
        
        -- Disabling button backgrounds --
        for _, v in pairs(SideBar_ButtonBackgroundTable) do
            v.Visible = false
        end
        
        UI_Background_OriginalSize = UI_Background.Size
        TopBarBG_OriginalSize = TopBar.Size
        SideBar_OriginalSize = SideBar.Size
        local closing_tween_Background = TS:Create(
            UI_Background,
            TweenInfo.new(.5, Enum.EasingStyle.Sine),
            {Size = UDim2.new(UI_Background.Size.X.Scale, 0, 0, 0)}
        )
        local closing_tween_TopBar = TS:Create(
            TopBar,
            TweenInfo.new(.5, Enum.EasingStyle.Sine),
            {Size = UDim2.new(.3, 0, TopBar.Size.Y.Scale, 0)}
        )
        local closing_tween_SideBar = TS:Create(
            SideBar,
            TweenInfo.new(.5, Enum.EasingStyle.Sine),
            {Size = UDim2.new(SideBar.Size.X.Scale, 0, 0, 0)}
        )
        local closing_tween_TitleLabel = TS:Create(
            Title_Label,
            TweenInfo.new(.5, Enum.EasingStyle.Sine),
            {TextTransparency = 1}
        )
        local closing_tween_VersionLabel = TS:Create(
            Version_Label,
            TweenInfo.new(.5, Enum.EasingStyle.Sine),
            {TextTransparency = 1}
        )
        
        -- Reversing the order of the table --
        for i = 1, math.floor(#SideBar_ButtonsTable / 2) do
            local j = #SideBar_ButtonsTable - i + 1
            SideBar_ButtonsTable[i], SideBar_ButtonsTable[j] = SideBar_ButtonsTable[j], SideBar_ButtonsTable[i]
        end
        
        for _, v in pairs(SideBar_ButtonsTable) do
            TS:Create(
                v,
                TweenInfo.new(.3, Enum.EasingStyle.Sine),
                {TextTransparency = 1}
            ):Play()
            wait(.03)
        end
        
        closing_tween_Background:Play()
        closing_tween_SideBar:Play()
        
        wait(.5)
        closing_tween_TitleLabel:Play()
        closing_tween_VersionLabel:Play()
        closing_tween_TopBar:Play()
        wait(.5)
        UI_Minimized = true
        min_button_debounce = false
        
    elseif UI_Minimized == true and min_button_debounce == false then
        min_button_debounce = true
        local opening_tween_Background = TS:Create(
            UI_Background,
            TweenInfo.new(.5, Enum.EasingStyle.Sine),
            {Size = UI_Background_OriginalSize}
        )
        local opening_tween_TopBar = TS:Create(
            TopBar,
            TweenInfo.new(.5, Enum.EasingStyle.Sine),
            {Size = TopBarBG_OriginalSize}
        )
        local opening_tween_SideBar = TS:Create(
            SideBar,
            TweenInfo.new(.5, Enum.EasingStyle.Sine),
            {Size = SideBar_OriginalSize}
        )
        local opening_tween_TitleLabel = TS:Create(
            Title_Label,
            TweenInfo.new(.5, Enum.EasingStyle.Sine),
            {TextTransparency = 0}
        )
        local opening_tween_VersionLabel = TS:Create(
            Version_Label,
            TweenInfo.new(.5, Enum.EasingStyle.Sine),
            {TextTransparency = 0}
        )
        opening_tween_TitleLabel:Play()
        opening_tween_VersionLabel:Play()
        opening_tween_TopBar:Play()
        wait(.5)
        
        opening_tween_Background:Play()
        opening_tween_SideBar:Play()
        wait(.1)
        
        -- Reversing the order of the table --
        for i = 1, math.floor(#SideBar_ButtonsTable / 2) do
            local j = #SideBar_ButtonsTable - i + 1
            SideBar_ButtonsTable[i], SideBar_ButtonsTable[j] = SideBar_ButtonsTable[j], SideBar_ButtonsTable[i]
        end
        
        for _, v in pairs(SideBar_ButtonsTable) do
            TS:Create(
                v,
                TweenInfo.new(.3, Enum.EasingStyle.Sine),
                {TextTransparency = 0}
            ):Play()
            wait(.03)
        end
        
        -- Enabling button backgrounds --
        for _, v in pairs(SideBar_ButtonBackgroundTable) do
            v.Visible = true
        end
        
        if lastOpenPage ~= nil then
            lastOpenPage.Visible = true
        end
        
        wait(.5)
        UI_Minimized = false
        min_button_debounce = false
    end
end)


-- [[ Intro sequence ]] --
TS:Create(
    intro_Background,
    TweenInfo.new(.5, Enum.EasingStyle.Sine),
    {Size = UDim2.new(.13, 0, .25, 0)}
):Play()

wait(3)

TS:Create(
    intro_Background,
    TweenInfo.new(.5, Enum.EasingStyle.Sine),
    {Size = UDim2.new(0, 0, 0, 0)}
):Play()

wait(.3)

MainFrame.Size = UDim2.new(0, 0, 0, 0)
BaseGui.Enabled = true
TS:Create(
    MainFrame,
    TweenInfo.new(.5, Enum.EasingStyle.Sine),
    {Size = UDim2.new(0.25, 0, 0.3, 0)}
):Play()

wait(.5)

for _, v in pairs(SideBar_ButtonsTable) do
    TS:Create(
       v,
       TweenInfo.new(.3, Enum.EasingStyle.Sine),
       {TextTransparency = 0}
    ):Play()
    wait(.1)
end


--------------------------------------------------------------------------------------------------------------------------------------

-- Draggable UI functionality [ Made by : Spynaz ] --
local UDim2_new = UDim2.new
--local UserInputService = game:GetService("UserInputService")
local DraggableObject 		= {}
DraggableObject.__index 	= DraggableObject
-- Sets up a new draggable object
function DraggableObject.new(Object)
	local self 			= {}
	self.Object			= Object
	self.DragStarted	= nil
	self.DragEnded		= nil
	self.Dragged		= nil
	self.Dragging		= false

	setmetatable(self, DraggableObject)

	return self
end
-- Enables dragging
function DraggableObject:Enable()
	local object			= self.Object
	local dragInput			= nil
	local dragStart			= nil
	local startPos			= nil
	local preparingToDrag	= false

	-- Updates the element
	local function update(input)
		local delta 		= input.Position - dragStart
		local newPosition	= UDim2_new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		object.Position 	= newPosition

		return newPosition
	end

	self.InputBegan = object.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			preparingToDrag = true
			local connection 
			connection = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End and (self.Dragging or preparingToDrag) then
					self.Dragging = false
					connection:Disconnect()

					if self.DragEnded and not preparingToDrag then
						self.DragEnded()
					end

					preparingToDrag = false
				end
			end)
		end
	end)
	self.InputChanged = object.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	self.InputChanged2 = UserInputService.InputChanged:Connect(function(input)
		if object.Parent == nil then
			self:Disable()
			return
		end
		if preparingToDrag then
			preparingToDrag = false

			if self.DragStarted then
				self.DragStarted()
			end

			self.Dragging	= true
			dragStart 		= input.Position
			startPos 		= object.Position
		end
		if input == dragInput and self.Dragging then
			local newPosition = update(input)

			if self.Dragged then
				self.Dragged(newPosition)
			end
		end
	end)
end
-- Disables dragging
function DraggableObject:Disable()
	self.InputBegan:Disconnect()
	self.InputChanged:Disconnect()
	self.InputChanged2:Disconnect()
	if self.Dragging then
		self.Dragging = false
		if self.DragEnded then
			self.DragEnded()
		end
	end
end

-- Setup Draggable UI --
local FrameDrag = DraggableObject.new(MainFrame)
FrameDrag:Enable() --Enable the dragging

--------------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------------

-- // This script is needed to bypass dahood's anti-cheat

-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Vars
local tablefind = table.find
local MainEvent = ReplicatedStorage.MainEvent
local SpoofTable = {
    WalkSpeed = 16,
    JumpPower = 50
}

-- // Configuration
local Flags = {
    "CHECKER_1",
    "TeleportDetect",
    "OneMoreTime"
}

-- // __namecall hook
local __namecall
__namecall = hookmetamethod(game, "__namecall", function(...)
    -- // Vars
    local args = {...}
    local self = args[1]
    local method = getnamecallmethod()
    local caller = getcallingscript()

    -- // See if the game is trying to alert the server
    if (method == "FireServer" and self == MainEvent and tablefind(Flags, args[2])) then
        return
    end

    -- // Anti Crash
    if (not checkcaller() and getfenv(2).crash) then
        -- // Hook the crash function to make it not work
        hookfunction(getfenv(2).crash, function()
            warn("Crash Attempt") 
        end)
    end
    
    -- //
    return __namecall(...)
end)

-- // __index hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Make sure it's trying to get our humanoid's ws/jp
    if (not checkcaller() and t:IsA("Humanoid") and (k == "WalkSpeed" or k == "JumpPower")) then
        -- // Return spoof values
        return SpoofTable[k]
    end

    -- //
    return __index(t, k)
end)

-- // __newindex hook
local __newindex
__newindex = hookmetamethod(game, "__newindex", function(t, k, v)
    -- // Make sure it's trying to set our humanoid's ws/jp
    if (not checkcaller() and t:IsA("Humanoid") and (k == "WalkSpeed" or k == "JumpPower")) then
        -- // Add values to spoof table
        SpoofTable[k] = v

        -- // Disallow the set
        return
    end
    
    -- //
    return __newindex(t, k, v)
end)

-- I added these next listeners because the matamathod hook basically forces them to be a specific value
UIS.InputBegan:Connect(function(input, processed)
    if input.KeyCode == Enum.KeyCode.LeftShift and not processed and not speedOn then
        humanoid.WalkSpeed = 22
    end
end)

UIS.InputEnded:Connect(function(input, processed)
    if input.KeyCode == Enum.KeyCode.LeftShift and not processed and not speedOn then
        humanoid.WalkSpeed = humanDefault_ws -- or 16
    end
end)

humanoid:GetPropertyChangedSignal("Health"):Connect(function()
    if humanoid <= 50 then
        
    end
end)


--------------------------------------------------------------------------------------------------------------------------------------


-- [[ ON "LOADED" ]] --
local function callback(Text)
    if Text == "Get Link" then
        setclipboard ("https://discord.gg/QyYsqZ6")
        wait(.3)
        game:GetService("StarterGui"):SetCore("SendNotification", {
	        Title = "Discord link copied !";
	        Text = "The discord link has been copied to your clipboard , Paste it in your browser to join. ";
        })

    elseif Text == ("Close") then
        print ("")
    end
end

local NotificationBindable = Instance.new("BindableFunction")
NotificationBindable.OnInvoke = callback

game.StarterGui:SetCore("SendNotification",  {
    Title = MenuName .. " Service";
    Text = "Thanks for using " .. MenuName .. ", consider joining our discord community!";
    Icon = "";
    Duration = 5;
    Button1 = "Get Link";
    Button2 = "Close";
    Callback = NotificationBindable;
})

print("Loaded " .. MenuName .. " / Version " .. MenuVersion)

coroutine.yield(gradientThread)

