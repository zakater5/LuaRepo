Library = {}

local playIntro = true
local configFileName = "UITestLibConfig.json"
local saveData = true

local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local players = game:GetService("Players")

local player = players.LocalPlayer
local mouse = player:GetMouse()

local uiAccentColors = {
    ["Blue"] = Color3.fromRGB(44, 115, 216),
    ["Purple"] = Color3.fromRGB(173, 17, 216),
    ["Pink"] = Color3.fromRGB(255, 37, 186),
    ["Red"] = Color3.fromRGB(255, 0, 4),
    ["Orange"] = Color3.fromRGB(255, 102, 0),
    ["Yellow"] = Color3.fromRGB(217, 210, 0),
    ["Lime"] = Color3.fromRGB(0, 255, 81),
    ["Cyan"] = Color3.fromRGB(0, 230, 255),
}

local lightTheme_Shades = {
    ["Primary"] = Color3.fromRGB(156, 156, 158),
    ["Secondary"] = Color3.fromRGB(163, 162, 165),
    ["Tertiary"] = Color3.fromRGB(176, 176, 176),
}

local darkTheme_Shades = {
    ["Primary"] = Color3.fromRGB(50, 50, 50),
    ["Secondary"] = Color3.fromRGB(63, 63, 63),
    ["Tertiary"] = Color3.fromRGB(38, 38, 38),
}

function Library:SaveData(boolean)
    saveData = boolean
end

function Library:PlayIntro(boolean)
    playIntro = boolean
end

-- [[ SAVING/LOADING SETTINGS ]] --
_G.settings = {}
function loadSettings()
    local HttpService = game:GetService("HttpService")
    if (readfile and isfile and isfile(configFileName)) then
        _G.settings = HttpService:JSONDecode(readfile(configFileName))
    end
end
loadSettings()
if _G.settings.AccentColor == nil then _G.settings.AccentColor = "Blue" end
if _G.settings.Theme == nil then _G.settings.Theme = "Dark" end

function saveSettings()
    if not saveData then return end
    local json
    local HttpService = game:GetService("HttpService")
    if (writefile) then
        json = HttpService:JSONEncode(_G.settings)
        writefile(configFileName, json)
    else
        print("Could not save settings, your executor does not support the 'writefile' function.")
    end
end

function updateUI_accents(mainFrame)
    for i, v in pairs(mainFrame:GetDescendants()) do
        if v:IsA("ImageLabel") or v:IsA("ImageButton") then
            for i, color in pairs(uiAccentColors) do
                if v.ImageColor3 == color and v.Name ~= i then
                    v.ImageColor3 = uiAccentColors[_G.settings.AccentColor]
                end
            end
        end
    end
end

function updateUI_theme(mainFrame, theme)
    if theme == "Dark" then
        for i, v in pairs(mainFrame:GetDescendants()) do
            if v:IsA("ImageLabel") or v:IsA("ImageButton") then
                for i, shade in pairs(lightTheme_Shades) do
                    if v.ImageColor3 == shade then
                        v.ImageColor3 = darkTheme_Shades[i]
                    end
                end
            end
        end
        for i, v in pairs(mainFrame:GetDescendants()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") then
                v.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end

    elseif theme == "Light" then
        for i, v in pairs(mainFrame:GetDescendants()) do
            if v:IsA("ImageLabel") or v:IsA("ImageButton") then
                for i, shade in pairs(darkTheme_Shades) do
                    if v.ImageColor3 == shade then
                        v.ImageColor3 = lightTheme_Shades[i]
                    end
                end
            end
        end
        for i, v in pairs(mainFrame:GetDescendants()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") then
                v.TextColor3 = Color3.fromRGB(1, 1, 1)
            end
        end
    end
end

-- The break line:
local Line = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")

Line.Name = "Line"
Line.AnchorPoint = Vector2.new(0.5, 0.5)
Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line.BackgroundTransparency = 0.900
Line.Position = UDim2.new(0.5, 0, 1, 0)
Line.Size = UDim2.new(0.95, 0, 0.2, 0)

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
UIGradient.Rotation = 90
UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.25, 1.00), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(0.74, 1.00), NumberSequenceKeypoint.new(1.00, 1.00)}
UIGradient.Parent = Line

function runIntro(mainBG, sideBar, uiName)
    local mainBG_OrigSize = mainBG.Size
    local sideBar_OrigSize = sideBar.Size
    mainBG.Size = UDim2.new(0, 0, mainBG_OrigSize.Y.Scale, 0)
    sideBar.Size = UDim2.new(0, 0, sideBar_OrigSize.Y.Scale, 0)

    local introTitle = Instance.new("TextLabel")
    introTitle.Size = UDim2.new(1, 0, 1, 0)
    introTitle.BackgroundTransparency = 1
    introTitle.Text = uiName
    introTitle.TextTransparency = 1
    introTitle.Parent = mainBG
    introTitle.ZIndex = 3
    introTitle.Font = Enum.Font.GothamBold
    introTitle.TextColor3 = Color3.fromRGB(234, 234, 234)
    introTitle.TextSize = 20
    introTitle.TextWrapped = true

    local UIMainLogo = Instance.new("ImageLabel")
    UIMainLogo.Name = "UIMainLogo"
    UIMainLogo.Parent = mainBG
    UIMainLogo.AnchorPoint = Vector2.new(0.5, 0.5)
    UIMainLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UIMainLogo.BackgroundTransparency = 1.000
    UIMainLogo.Position = UDim2.new(0.5, 0, 0.25, 0)
    UIMainLogo.Size = UDim2.new(0, 0, 0, 0)
    UIMainLogo.Image = "rbxassetid://10700710572"
    UIMainLogo.ImageTransparency = 1

    TS:Create(
        mainBG,
        TweenInfo.new(.5, Enum.EasingStyle.Sine),
        {Size = mainBG_OrigSize}
    ):Play()
    wait(.3)

    TS:Create(
        UIMainLogo,
        TweenInfo.new(.5, Enum.EasingStyle.Sine),
        {Size = UDim2.new(0.3, 0, 0.42, 0), ImageTransparency = 0}
    ):Play()
    wait(.2)

    TS:Create(
        introTitle,
        TweenInfo.new(.3, Enum.EasingStyle.Sine),
        {TextTransparency = 0}
    ):Play()
    wait(1)

    TS:Create(
        introTitle,
        TweenInfo.new(.3, Enum.EasingStyle.Sine),
        {TextTransparency = 1}
    ):Play()
    TS:Create(
        UIMainLogo,
        TweenInfo.new(.5, Enum.EasingStyle.Sine),
        {ImageTransparency = 1}
    ):Play()
    wait(.3)
    UIMainLogo:Destroy()

    TS:Create(
        sideBar,
        TweenInfo.new(.3, Enum.EasingStyle.Sine),
        {Size = sideBar_OrigSize}
    ):Play()
end

-- [[ CREATING CUSTOM NOTIFICATION GUI ]] --
-- NOTIFICATION LIST:
-- Instances:
local notifExists = game.CoreGui:FindFirstChild("NotificationGui")
if notifExists then notifExists:Destroy() end
local NotificationGui = Instance.new("ScreenGui")
local NotificationsList = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")

--Properties:
NotificationGui.Name = "NotificationGui"
NotificationGui.Parent = game.CoreGui

NotificationsList.Name = "NotificationsList"
NotificationsList.Parent = NotificationGui
NotificationsList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NotificationsList.BackgroundTransparency = 1
NotificationsList.Position = UDim2.new(0.846829891, 0, 0.191411048, 0)
NotificationsList.Size = UDim2.new(0, 236, 0, 553)

UIListLayout.Parent = NotificationsList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
UIListLayout.Padding = UDim.new(0.01, 0)

-- NOTIFICATION TEMPLATE:
-- Instances:
local NotificationFrame = Instance.new("ImageLabel")
local Button1 = Instance.new("TextButton")
local Roundify = Instance.new("ImageLabel")
local Title = Instance.new("TextLabel")
local Roundify_2 = Instance.new("ImageLabel")
local Text = Instance.new("TextLabel")
local Roundify_3 = Instance.new("ImageLabel")
local Button2 = Instance.new("TextButton")
local Roundify_4 = Instance.new("ImageLabel")

--Properties:
NotificationFrame.Name = "NotificationFrame"
NotificationFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NotificationFrame.BackgroundTransparency = 1
NotificationFrame.Size = UDim2.new(1, 0, 0.149782985, 0)
NotificationFrame.Image = "rbxassetid://3570695787"
NotificationFrame.ImageColor3 = Color3.fromRGB(67, 67, 67)
NotificationFrame.ImageTransparency = 0.200
NotificationFrame.ScaleType = Enum.ScaleType.Slice
NotificationFrame.SliceCenter = Rect.new(100, 100, 100, 100)
NotificationFrame.SliceScale = 0.120

Button1.Name = "Button1"
Button1.Parent = NotificationFrame
Button1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Button1.BackgroundTransparency = 1
Button1.BorderSizePixel = 0
Button1.Position = UDim2.new(0.015, 0, 0.6875, 0)
Button1.Size = UDim2.new(0.48, 0, 0.28, 0)
Button1.ZIndex = 2
Button1.Font = Enum.Font.GothamBold
Button1.TextColor3 = Color3.fromRGB(235, 235, 235)
Button1.TextSize = 14

Roundify.Name = "Roundify"
Roundify.Parent = Button1
Roundify.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify.BackgroundTransparency = 1
Roundify.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify.Size = UDim2.new(1, 0, 1, 0)
Roundify.Image = "rbxassetid://3570695787"
Roundify.ImageColor3 = Color3.fromRGB(102, 102, 102)
Roundify.ImageTransparency = 0.500
Roundify.ScaleType = Enum.ScaleType.Slice
Roundify.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify.SliceScale = 0.120

Title.Name = "Title"
Title.Parent = NotificationFrame
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.192139745, 0, 0.05, 0)
Title.Size = UDim2.new(0.6, 0, 0.25, 0)
Title.ZIndex = 2
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(232, 232, 232)
Title.TextScaled = true
Title.TextSize = 14
Title.TextWrapped = true

Roundify_2.Name = "Roundify"
Roundify_2.Parent = Title
Roundify_2.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_2.BackgroundTransparency = 1
Roundify_2.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_2.Size = UDim2.new(1, 0, 1, 0)
Roundify_2.Image = "rbxassetid://3570695787"
Roundify_2.ImageColor3 = Color3.fromRGB(121, 121, 121)
Roundify_2.ImageTransparency = 0.500
Roundify_2.ScaleType = Enum.ScaleType.Slice
Roundify_2.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_2.SliceScale = 0.12

Text.Name = "Text"
Text.Parent = NotificationFrame
Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text.BackgroundTransparency = 1
Text.BorderSizePixel = 0
Text.Position = UDim2.new(0.113537118, 0, 0.35, 0)
Text.Size = UDim2.new(0.78, 0, 0.3, 0)
Text.ZIndex = 2
Text.Font = Enum.Font.GothamBold
Text.TextColor3 = Color3.fromRGB(232, 232, 232)
Text.TextScaled = true
Text.TextSize = 14
Text.TextWrapped = true

Roundify_3.Name = "Roundify"
Roundify_3.Parent = Text
Roundify_3.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_3.BackgroundTransparency = 1
Roundify_3.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_3.Size = UDim2.new(1, 0, 1, 0)
Roundify_3.Image = "rbxassetid://3570695787"
Roundify_3.ImageColor3 = Color3.fromRGB(121, 121, 121)
Roundify_3.ImageTransparency = 0.5
Roundify_3.ScaleType = Enum.ScaleType.Slice
Roundify_3.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_3.SliceScale = 0.12

Button2.Name = "Button2"
Button2.Parent = NotificationFrame
Button2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Button2.BackgroundTransparency = 1
Button2.BorderSizePixel = 0
Button2.Position = UDim2.new(0.509, 0, 0.6875, 0)
Button2.Size = UDim2.new(0.48, 0, 0.28, 0)
Button2.ZIndex = 2
Button2.Font = Enum.Font.GothamBold
Button2.TextColor3 = Color3.fromRGB(235, 235, 235)
Button2.TextSize = 14

Roundify_4.Name = "Roundify"
Roundify_4.Parent = Button2
Roundify_4.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_4.BackgroundTransparency = 1
Roundify_4.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_4.Size = UDim2.new(1, 0, 1, 0)
Roundify_4.Image = "rbxassetid://3570695787"
Roundify_4.ImageColor3 = Color3.fromRGB(102, 102, 102)
Roundify_4.ImageTransparency = 0.500
Roundify_4.ScaleType = Enum.ScaleType.Slice
Roundify_4.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_4.SliceScale = 0.12

-- CONSTRUCTORS / FUNCTION FOR NOTIFICATION:
function Library:sendNotification(settings)
    local newNotification = NotificationFrame:Clone()
    newNotification.Parent = NotificationsList
    newNotification.Title.Text = settings.Title
    newNotification["Text"].Text = settings.Text
    newNotification["Text"].TextColor3 = itemColors[settings.Text]
    newNotification.Button1.Text = settings.button1Text
    newNotification.Button2.Text = settings.button2Text
    newNotification.Button1.MouseButton1Click:Connect(settings.onButton1Click)
    newNotification.Button2.MouseButton1Click:Connect(settings.onButton2Click)
    
    if settings.Color then
        newNotification.PopupEffect.UIGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, settings.Color),
            ColorSequenceKeypoint.new(0.5, settings.Color),
            ColorSequenceKeypoint.new(1.00, settings.Color)
        }
        
        TS:Create(
            newNotification.PopupEffect,
            TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true, 0),
            {Size = UDim2.new(1.5, 0, 4, 0), BackgroundTransparency = 0}
        ):Play()
    end
    
    Debris:AddItem(newNotification, settings.Duration)
    return newNotification
end



function Library:DraggingEnabled(MainFrame, DragRegObj)
    frame = DragRegObj
    parent = MainFrame
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

local optionsTab = {}
function setupSettings(TabsFolder, mainFrame)

    -- Instances:
    optionsTab = {
        OptionsTab = Instance.new("ScrollingFrame"),
        Frame = Instance.new("Frame"),
        Frame_2 = Instance.new("Frame"),
        LightMode = Instance.new("ImageButton"),
        BG = Instance.new("ImageButton"),
        DarkMode = Instance.new("ImageButton"),
        BG_2 = Instance.new("ImageButton"),
        TextLabel = Instance.new("TextLabel"),
        Line = Instance.new("Frame"),
        UIGradient = Instance.new("UIGradient"),
        Frame_3 = Instance.new("Frame"),
        Frame_4 = Instance.new("Frame"),
        Blue = Instance.new("ImageButton"),
        Toggle_Flight = Instance.new("ImageButton"),
        UIListLayout = Instance.new("UIListLayout"),
        Pruple = Instance.new("ImageButton"),
        Toggle_Flight_2 = Instance.new("ImageButton"),
        Pink = Instance.new("ImageButton"),
        Toggle_Flight_3 = Instance.new("ImageButton"),
        Red = Instance.new("ImageButton"),
        Toggle_Flight_4 = Instance.new("ImageButton"),
        Orange = Instance.new("ImageButton"),
        Toggle_Flight_5 = Instance.new("ImageButton"),
        Yellow = Instance.new("ImageButton"),
        Toggle_Flight_6 = Instance.new("ImageButton"),
        Lime = Instance.new("ImageButton"),
        Toggle_Flight_7 = Instance.new("ImageButton"),
        Cyan = Instance.new("ImageButton"),
        Toggle_Flight_8 = Instance.new("ImageButton"),
        TextLabel_2 = Instance.new("TextLabel"),
        Line_2 = Instance.new("Frame"),
        UIGradient_2 = Instance.new("UIGradient"),
        UIListLayout_2 = Instance.new("UIListLayout"),
    }

    -- Properties:
    optionsTab.OptionsTab.Name = "OptionsTab"
    optionsTab.OptionsTab.Parent = TabsFolder
    optionsTab.OptionsTab.Active = true
    optionsTab.OptionsTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    optionsTab.OptionsTab.BackgroundTransparency = 1
    optionsTab.OptionsTab.BorderSizePixel = 0
    optionsTab.OptionsTab.Position = UDim2.new(0.246, 0, 0.016190093, 0)
    optionsTab.OptionsTab.Size = UDim2.new(0.740969956, 0, 0.96281, 0)
    optionsTab.OptionsTab.CanvasSize = UDim2.new(0, 0, 1, 0)
    optionsTab.OptionsTab.ScrollBarThickness = 6
    optionsTab.OptionsTab.AutomaticCanvasSize = Enum.AutomaticSize.Y
    optionsTab.OptionsTab.Visible = false

    optionsTab.Frame.Parent = optionsTab.OptionsTab
    optionsTab.Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    optionsTab.Frame.BackgroundTransparency = 1
    optionsTab.Frame.Size = UDim2.new(0.972, 0, 0.16, 0)

    optionsTab.Frame_2.Parent = optionsTab.Frame
    optionsTab.Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    optionsTab.Frame_2.BackgroundTransparency = 1
    optionsTab.Frame_2.Position = UDim2.new(0.377439648, 0, 0, 0)
    optionsTab.Frame_2.Size = UDim2.new(0.597560465, 0, 1, 0)

    optionsTab.LightMode.Name = "LightMode"
    optionsTab.LightMode.Parent = optionsTab.Frame_2
    optionsTab.LightMode.AnchorPoint = Vector2.new(0, 0.5)
    optionsTab.LightMode.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    optionsTab.LightMode.BackgroundTransparency = 1
    optionsTab.LightMode.Position = UDim2.new(0.02, 0, 0.45, 0)
    optionsTab.LightMode.Size = UDim2.new(0.37, 0, 0.8, 0)
    optionsTab.LightMode.ZIndex = 4
    optionsTab.LightMode.Image = "rbxassetid://10584551721"
    optionsTab.LightMode.ScaleType = Enum.ScaleType.Stretch
    optionsTab.LightMode.SliceCenter = Rect.new(100, 100, 100, 100)
    optionsTab.LightMode.SliceScale = 0.06

    optionsTab.BG.Name = "BG"
    optionsTab.BG.Parent = optionsTab.LightMode
    optionsTab.BG.AnchorPoint = Vector2.new(0.5, 0.5)
    optionsTab.BG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    optionsTab.BG.BackgroundTransparency = 1
    optionsTab.BG.Position = UDim2.new(0.5, 0, 0.5, 0)
    optionsTab.BG.Size = UDim2.new(1.05, 0, 1.1, 0)
    optionsTab.BG.ZIndex = 3
    optionsTab.BG.Image = "rbxassetid://3570695787"
    optionsTab.BG.ImageColor3 = uiAccentColors[_G.settings.AccentColor]
    optionsTab.BG.ScaleType = Enum.ScaleType.Slice
    optionsTab.BG.SliceCenter = Rect.new(100, 100, 100, 100)
    optionsTab.BG.SliceScale = 0.06
    if _G.settings.Theme == "Light" then
        optionsTab.BG.Visible = true
    else
        optionsTab.BG.Visible = false
    end

    optionsTab.DarkMode.Name = "DarkMode"
    optionsTab.DarkMode.Parent = optionsTab.Frame_2
    optionsTab.DarkMode.AnchorPoint = Vector2.new(0, 0.5)
    optionsTab.DarkMode.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    optionsTab.DarkMode.BackgroundTransparency = 1
    optionsTab.DarkMode.Position = UDim2.new(0.5, 0, 0.45, 0)
    optionsTab.DarkMode.Size = UDim2.new(0.37, 0, 0.8, 0)
    optionsTab.DarkMode.ZIndex = 4
    optionsTab.DarkMode.Image = "rbxassetid://10584336759"
    optionsTab.DarkMode.ScaleType = Enum.ScaleType.Stretch
    optionsTab.DarkMode.SliceCenter = Rect.new(100, 100, 100, 100)
    optionsTab.DarkMode.SliceScale = 0.06

    optionsTab.BG_2.Name = "BG"
    optionsTab.BG_2.Parent = optionsTab.DarkMode
    optionsTab.BG_2.AnchorPoint = Vector2.new(0.5, 0.5)
    optionsTab.BG_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    optionsTab.BG_2.BackgroundTransparency = 1
    optionsTab.BG_2.Position = UDim2.new(0.5, 0, 0.5, 0)
    optionsTab.BG_2.Size = UDim2.new(1.05, 0, 1.1, 0)
    optionsTab.BG_2.ZIndex = 3
    optionsTab.BG_2.Image = "rbxassetid://3570695787"
    optionsTab.BG_2.ImageColor3 = uiAccentColors[_G.settings.AccentColor]
    optionsTab.BG_2.ScaleType = Enum.ScaleType.Slice
    optionsTab.BG_2.SliceCenter = Rect.new(100, 100, 100, 100)
    optionsTab.BG_2.SliceScale = 0.06
    if _G.settings.Theme == "Dark" then
        optionsTab.BG_2.Visible = true
    else
        optionsTab.BG_2.Visible = false
    end

    optionsTab.TextLabel.Parent = optionsTab.Frame
    optionsTab.TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    optionsTab.TextLabel.BackgroundTransparency = 1
    optionsTab.TextLabel.Position = UDim2.new(0.0489281043, 0, 0, 0)
    optionsTab.TextLabel.Size = UDim2.new(0.416493893, 0, 1, 0)
    optionsTab.TextLabel.ZIndex = 3
    optionsTab.TextLabel.Font = Enum.Font.GothamBold
    optionsTab.TextLabel.Text = "Appearance"
    optionsTab.TextLabel.TextColor3 = Color3.fromRGB(234, 234, 234)
    optionsTab.TextLabel.TextSize = 12
    optionsTab.TextLabel.TextWrapped = true
    optionsTab.TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    local line = Line:Clone()
    line.Size = UDim2.new(0.95, 0, 0.1, 0)
    line.Parent = optionsTab.Frame

    optionsTab.Frame_3.Parent = optionsTab.OptionsTab
    optionsTab.Frame_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    optionsTab.Frame_3.BackgroundTransparency = 1
    optionsTab.Frame_3.Size = UDim2.new(0.972, 0, 0.09, 0)

    optionsTab.Frame_4.Parent = optionsTab.Frame_3
    optionsTab.Frame_4.AnchorPoint = Vector2.new(0, 0.5)
    optionsTab.Frame_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    optionsTab.Frame_4.BackgroundTransparency = 1
    optionsTab.Frame_4.Position = UDim2.new(0.377439648, 0, 0.5, 0)
    optionsTab.Frame_4.Size = UDim2.new(0.48306039, 0, 0.7, 0)

    optionsTab.UIListLayout.Parent = optionsTab.Frame_4
    optionsTab.UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    optionsTab.UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    optionsTab.UIListLayout.Padding = UDim.new(0.02, 0)

    for i, v in pairs(uiAccentColors) do
        local newColorBtn = Instance.new("ImageButton")
        newColorBtn.Name = i
        newColorBtn.Parent = optionsTab.Frame_4
        newColorBtn.AnchorPoint = Vector2.new(0, 0.5)
        newColorBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        newColorBtn.BackgroundTransparency = 1
        newColorBtn.Position = UDim2.new(0.05, 0, 1, 0)
        newColorBtn.Size = UDim2.new(0.125, 0, 1, 0)
        newColorBtn.ZIndex = 3
        newColorBtn.Image = "rbxassetid://3570695787"
        newColorBtn.ImageColor3 = v
        newColorBtn.ScaleType = Enum.ScaleType.Slice
        newColorBtn.SliceCenter = Rect.new(100, 100, 100, 100)

        local innerButton = newColorBtn:Clone()
        innerButton.Parent = newColorBtn
        innerButton.Name = "Inner"
        innerButton.Size = UDim2.new(0.5, 0, 0.5, 0)
        innerButton.Position = UDim2.new(0.5, 0, 0.5, 0)
        innerButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
        innerButton.AnchorPoint = Vector2.new(0.5, 0.5)
        if _G.settings.AccentColor == i then
            innerButton.Visible = true
        else
            innerButton.Visible = false
        end

        newColorBtn.MouseButton1Click:Connect(function()
            for _, innerBtn in pairs(optionsTab.Frame_4:GetChildren()) do
                if innerBtn:IsA("ImageButton") and innerBtn ~= newColorBtn then
                    innerBtn.Inner.Visible = false
                end
            end
            innerButton.Visible = true
            _G.settings.AccentColor = i
            saveSettings()
            updateUI_accents(mainFrame)
        end)
    end

    optionsTab.TextLabel_2.Parent = optionsTab.Frame_3
    optionsTab.TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    optionsTab.TextLabel_2.BackgroundTransparency = 1
    optionsTab.TextLabel_2.Position = UDim2.new(0.0489281043, 0, 0, 0)
    optionsTab.TextLabel_2.Size = UDim2.new(0.416493893, 0, 1, 0)
    optionsTab.TextLabel_2.ZIndex = 3
    optionsTab.TextLabel_2.Font = Enum.Font.GothamBold
    optionsTab.TextLabel_2.Text = "Accent color"
    optionsTab.TextLabel_2.TextColor3 = Color3.fromRGB(234, 234, 234)
    optionsTab.TextLabel_2.TextSize = 12
    optionsTab.TextLabel_2.TextWrapped = true
    optionsTab.TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

    local line = Line:Clone()
    line.Parent = optionsTab.Frame_3

    optionsTab.UIListLayout_2.Parent = optionsTab.OptionsTab
    optionsTab.UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder


    optionsTab.LightMode.MouseButton1Click:Connect(function()
        _G.settings.Theme = "Light"
        updateUI_theme(mainFrame, "Light")
        optionsTab.BG.Visible = true
        optionsTab.BG_2.Visible = false
    end)

    optionsTab.DarkMode.MouseButton1Click:Connect(function()
        _G.settings.Theme = "Dark"
        updateUI_theme(mainFrame, "Dark")
        optionsTab.BG.Visible = false
        optionsTab.BG_2.Visible = true
    end)

    updateUI_theme(mainFrame, _G.settings.Theme)
end




function Library.new(UI_Name)
    UI_Name = UI_Name or "Untitled UI"
    local UI_Exists = game.CoreGui:FindFirstChild(UI_Name)
    if UI_Exists then UI_Exists:Destroy() end

    -- Instances:
    local UI_Lib = Instance.new("ScreenGui")
    pcall(function()
        syn.protect_gui(UI_Lib)
    end)

    local MainFrame = Instance.new("Frame")
    local UI_Background = Instance.new("ImageLabel")
    local TopBar_Frame = Instance.new("Frame")
    local Min_Button = Instance.new("ImageButton")
    local X_Button = Instance.new("ImageButton")
    local Opt_Button = Instance.new("ImageButton")
    local Tabs_Folder = Instance.new("Folder")
    local SideBar = Instance.new("ImageLabel")
    local TabButtons = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local _Image = Instance.new("ImageButton")
    local xImage = Instance.new("ImageButton")

    -- Properties:
    UI_Lib.Name = UI_Name
    UI_Lib.Parent = game:GetService("CoreGui")
    UI_Lib.ResetOnSpawn = false

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = UI_Lib
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundTransparency = 1
    MainFrame.Position = UDim2.new(0.5, 0, 0.4, 0)
    MainFrame.Size = UDim2.new(0.281, 0, 0.377, 0)

    UI_Background.Name = "UI_Background"
    UI_Background.Parent = MainFrame
    UI_Background.BackgroundTransparency = 1
    UI_Background.Size = UDim2.new(1, 0, 1, 0)
    UI_Background.Image = "rbxassetid://3570695787"
    UI_Background.ImageColor3 = Color3.fromRGB(63, 63, 63)
    UI_Background.ScaleType = Enum.ScaleType.Slice
    UI_Background.SliceCenter = Rect.new(100, 100, 100, 100)
    UI_Background.SliceScale = 0.08

    TopBar_Frame.Name = "TopBar_Frame"
    TopBar_Frame.Parent = MainFrame
    TopBar_Frame.BackgroundTransparency = 1
    TopBar_Frame.Size = UDim2.new(0.228033975, 0, 0.073063463, 0)

    Min_Button.Name = "Min_Button"
    Min_Button.Parent = TopBar_Frame
    Min_Button.BackgroundTransparency = 1
    Min_Button.Position = UDim2.new(0.23, 0, 0.222, 0)
    Min_Button.Size = UDim2.new(0.11929135, 0, 0.539204836, 0)
    Min_Button.ZIndex = 5
    Min_Button.Image = "rbxassetid://3570695787"
    Min_Button.ImageColor3 = Color3.fromRGB(113, 113, 113)
    Min_Button.ScaleType = Enum.ScaleType.Slice
    Min_Button.SliceCenter = Rect.new(100, 100, 100, 100)
    Min_Button.SliceScale = 0.120

    _Image.Name = "_Image"
    _Image.Parent = Min_Button
    _Image.AnchorPoint = Vector2.new(0.5, 0.5)
    _Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    _Image.BackgroundTransparency = 1
    _Image.Position = UDim2.new(0.5, 0, 0.5, 0)
    _Image.Size = UDim2.new(0.8, 0, 0.8, 0)
    _Image.ZIndex = 6
    _Image.Image = "rbxassetid://10597869630"
    _Image.ImageColor3 = Color3.fromRGB(254, 254, 254)

    X_Button.Name = "X_Button"
    X_Button.Parent = TopBar_Frame
    X_Button.BackgroundTransparency = 1
    X_Button.Position = UDim2.new(0.05, 0, 0.221589461, 0)
    X_Button.Size = UDim2.new(0.11929135, 0, 0.539204836, 0)
    X_Button.ZIndex = 5
    X_Button.Image = "rbxassetid://3570695787"
    X_Button.ImageColor3 = Color3.fromRGB(113, 113, 113)
    X_Button.ScaleType = Enum.ScaleType.Slice
    X_Button.SliceCenter = Rect.new(100, 100, 100, 100)
    X_Button.SliceScale = 0.120

    xImage.Name = "xImage"
    xImage.Parent = X_Button
    xImage.AnchorPoint = Vector2.new(0.5, 0.5)
    xImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    xImage.BackgroundTransparency = 1
    xImage.Position = UDim2.new(0.5, 0, 0.5, 0)
    xImage.Size = UDim2.new(0.8, 0, 0.8, 0)
    xImage.ZIndex = 6
    xImage.Image = "rbxassetid://10597813580"
    xImage.ImageColor3 = Color3.fromRGB(254, 254, 254)

    Opt_Button.Name = "Opt_Button"
    Opt_Button.Parent = TopBar_Frame
    Opt_Button.BackgroundTransparency = 1
    Opt_Button.Position = UDim2.new(0.4, 0, 0.222, 0)
    Opt_Button.Size = UDim2.new(0.119, 0, 0.538999975, 0)
    Opt_Button.ZIndex = 5
    Opt_Button.Image = "rbxassetid://10565603595"
    Opt_Button.ImageColor3 = Color3.fromRGB(254, 254, 254)
    Opt_Button.SliceCenter = Rect.new(100, 100, 100, 100)
    Opt_Button.SliceScale = 0.120

    Tabs_Folder.Name = "Tabs"
    Tabs_Folder.Parent = MainFrame

    SideBar.Name = "SideBar"
    SideBar.Parent = MainFrame
    SideBar.BackgroundTransparency = 1
    SideBar.Size = UDim2.new(0.228034049, 0, 1, 0)
    SideBar.Image = "rbxassetid://3570695787"
    SideBar.ImageColor3 = Color3.fromRGB(50, 50, 50)
    SideBar.ScaleType = Enum.ScaleType.Slice
    SideBar.SliceCenter = Rect.new(100, 100, 100, 100)
    SideBar.SliceScale = 0.080

    TabButtons.Name = "TabButtons"
    TabButtons.Parent = MainFrame
    TabButtons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabButtons.BackgroundTransparency = 1
    TabButtons.Position = UDim2.new(0.009, 0, 0.0924424604, 0)
    TabButtons.Size = UDim2.new(0.21, 0, 0.884641469, 0)
    TabButtons.ZIndex = 4

    UIListLayout.Parent = TabButtons
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    setupSettings(Tabs_Folder, MainFrame)
    if playIntro then runIntro(MainFrame, SideBar, UI_Name) end

    xImage.MouseButton1Click:Connect(function() -- XButton
        MainFrame:TweenSize(UDim2.new(0,0,0,0), "In", "Sine", .2)
        wait(.2)
        MainFrame:Destroy()
    end)

    _Image.MouseButton1Click:Connect(function() -- MinButton
        MainFrame:TweenSize(UDim2.new(0,0,0,0), "In", "Sine", .2)
    end)

    Opt_Button.MouseButton1Click:Connect(function()
        for _, v in pairs(Tabs_Folder:GetChildren()) do
            if v:IsA("Frame") or v:IsA("ScrollingFrame") then
                v.Visible = false
            end
        end
        optionsTab.OptionsTab.Visible = true
    end)

    Library:DraggingEnabled(MainFrame, UI_Background)

    local Tabs = {}
    function Tabs:AddTab(tabName)
        tabName = tabName or "Tab"

        -- Instances:
        local newTabButton_Frame = Instance.new("Frame")
        local New_TabButton = Instance.new("TextButton")
        local TabButtonLogo = Instance.new("ImageButton")
        local NewTab = Instance.new("ScrollingFrame")
        local UIListLayout = Instance.new("UIListLayout")
        local background = Instance.new("ImageLabel")

        -- Properties:
        newTabButton_Frame.Name = "newTabButton_Frame"
        newTabButton_Frame.Parent = TabButtons
        newTabButton_Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        newTabButton_Frame.BackgroundTransparency = 1
        newTabButton_Frame.Size = UDim2.new(1, 0, 0.0893225521, 0)
        newTabButton_Frame.ZIndex = 4

        New_TabButton.Name = "newTabButton"
        New_TabButton.Parent = newTabButton_Frame
        New_TabButton.BackgroundTransparency = 1
        New_TabButton.Position = UDim2.new(0.259088218, 0, 0, 0)
        New_TabButton.Size = UDim2.new(0.812778711, 0, 1, 0)
        New_TabButton.ZIndex = 5
        New_TabButton.Font = Enum.Font.GothamBold
        New_TabButton.Text = tabName
        New_TabButton.TextColor3 = Color3.fromRGB(217, 217, 217)
        New_TabButton.TextSize = 14
        New_TabButton.TextWrapped = true
        New_TabButton.TextXAlignment = Enum.TextXAlignment.Left

        TabButtonLogo.Name = "TabButtonLogo"
        TabButtonLogo.Parent = newTabButton_Frame
        TabButtonLogo.AnchorPoint = Vector2.new(0, 0.5)
        TabButtonLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButtonLogo.BackgroundTransparency = 1
        TabButtonLogo.Position = UDim2.new(0.05, 0, 0.5, 0)
        TabButtonLogo.Size = UDim2.new(0.18, 0, 0.6, 0)
        TabButtonLogo.ZIndex = 5
        TabButtonLogo.Image = "rbxassetid://10560634600"
        TabButtonLogo.ImageColor3 = uiAccentColors[_G.settings.AccentColor]

        NewTab.Name = tabName
        NewTab.Parent = Tabs_Folder
        NewTab.Active = true
        NewTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NewTab.BackgroundTransparency = 1
        NewTab.BorderSizePixel = 0
        NewTab.Position = UDim2.new(0.246, 0, 0.01619, 0)
        NewTab.Size = UDim2.new(0.740969956, 0, 0.96281, 0)
        NewTab.CanvasSize = UDim2.new(0, 0, 1, 0)
        NewTab.ScrollBarThickness = 6
        NewTab.AutomaticCanvasSize = Enum.AutomaticSize.Y
        NewTab.Visible = false

        UIListLayout.Parent = NewTab
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

        background.Name = "background"
        background.Parent = newTabButton_Frame
        background.AnchorPoint = Vector2.new(.5, .5)
        background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        background.BackgroundTransparency = 1
        background.Position = UDim2.new(.5, 0, .5, 0)
        background.Size = UDim2.new(0, 0, 0, 0)
        background.ZIndex = 4
        background.Image = "rbxassetid://3570695787"
        background.ImageColor3 = uiAccentColors[_G.settings.AccentColor]
        background.ScaleType = Enum.ScaleType.Slice
        background.SliceCenter = Rect.new(100, 100, 100, 100)
        background.SliceScale = 0.06

        --Tab Button Event/s:
        newTabButton_Frame.MouseEnter:Connect(function()
            local opening_tween = TS:Create(
                background,
                TweenInfo.new(.2, Enum.EasingStyle.Sine),
                {Size = UDim2.new(1, 0, 1, 0)}
            )
            opening_tween:Play()
            TabButtonLogo.ImageColor3 = Color3.fromRGB(255, 255, 255)
        end)
        
        newTabButton_Frame.MouseLeave:Connect(function()
            local closing_tween = TS:Create(
                background,
                TweenInfo.new(.2, Enum.EasingStyle.Sine),
                {Size = UDim2.new(0, 0, 0, 0)}
            )
            closing_tween:Play()
            TabButtonLogo.ImageColor3 = uiAccentColors[_G.settings.AccentColor]
        end)

        New_TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(Tabs_Folder:GetChildren()) do
                if v:IsA("Frame") or v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            NewTab.Visible = true
        end)

        TabButtonLogo.MouseButton1Click:Connect(function()
            for _, v in pairs(Tabs_Folder:GetChildren()) do
                if v:IsA("Frame") or v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            NewTab.Visible = true
        end)

        Controls = {}
        function Controls:MakeMainTab()
            NewTab.Visible = true
        end

        function Controls:AddLabel(LabelText)
            LabelText = LabelText or "Label"

            -- Instances:
            local Frame = Instance.new("Frame")
            local TextLabel = Instance.new("TextLabel")

            --Properties:
            Frame.Parent = NewTab
            Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame.BackgroundTransparency = 1
            Frame.Size = UDim2.new(0.972, 0, 0.09, 0)

            TextLabel.Name = "TextLabel"
            TextLabel.Parent = Frame
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1
            TextLabel.Position = UDim2.new(0.0489281043, 0, 0, 0)
            TextLabel.Size = UDim2.new(0.416493893, 0, 1, 0)
            TextLabel.ZIndex = 3
            TextLabel.Font = Enum.Font.GothamBold
            TextLabel.Text = LabelText
            TextLabel.TextColor3 = Color3.fromRGB(234, 234, 234)
            TextLabel.TextSize = 12
            TextLabel.TextWrapped = true
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left

            local line = Line:Clone()
            line.Parent = Frame
        end

        function Controls:AddParagraph(ParaText)
            ParaText = ParaText or "Label"
            local _, count = ParaText:gsub('\n', '\n')

            -- Instances:
            local Frame = Instance.new("Frame")
            local TextLabel = Instance.new("TextLabel")

            --Properties:
            Frame.Parent = NewTab
            Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame.BackgroundTransparency = 1
            Frame.Size = UDim2.new(0.972, 0, (0.09 * count) / 2, 0)

            TextLabel.Name = "TextLabel"
            TextLabel.Parent = Frame
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1
            TextLabel.Position = UDim2.new(0.0489281043, 0, 0, 0)
            TextLabel.Size = UDim2.new(1, 0, 1, 0)
            TextLabel.ZIndex = 3
            TextLabel.Font = Enum.Font.GothamBold
            TextLabel.Text = ParaText
            TextLabel.TextColor3 = Color3.fromRGB(234, 234, 234)
            TextLabel.TextSize = 12
            TextLabel.TextWrapped = true
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left

            local line = Line:Clone()
            line.Size = UDim2.new(line.Size.X.Scale, 0, line.Size.Y.Scale / count, 0)
            line.Parent = Frame
        end

        function Controls:AddButton(Title, ButtonText, callback)
            Title = Title or "Untitled"
            ButtonText = ButtonText or "Text"
            callback = callback or function() end

            -- Instances:
            local Frame = Instance.new("Frame")
            local Frame_2 = Instance.new("Frame")
            local TextButton = Instance.new("TextButton")
            local buttonBG = Instance.new("ImageLabel")
            local Button_TL = Instance.new("TextLabel")

            --Properties:
            Frame.Parent = NewTab
            Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame.BackgroundTransparency = 1
            Frame.Size = UDim2.new(0.972, 0, 0.09, 0)

            Frame_2.Parent = Frame
            Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame_2.BackgroundTransparency = 1
            Frame_2.Position = UDim2.new(0.5, 0, 0, 0)
            Frame_2.Size = UDim2.new(0.48306039, 0, 1, 0)

            TextButton.Parent = Frame_2
            TextButton.AnchorPoint = Vector2.new(0, 0.5)
            TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextButton.BackgroundTransparency = 1
            TextButton.Position = UDim2.new(0.05, 0, 0.5, 0)
            TextButton.Size = UDim2.new(0.795529723, 0, 0.7, 0)
            TextButton.ZIndex = 4
            TextButton.Font = Enum.Font.GothamBold
            TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextButton.TextSize = 14
            TextButton.Text = ButtonText

            buttonBG.Name = "buttonBG"
            buttonBG.Parent = TextButton
            buttonBG.AnchorPoint = Vector2.new(0.5, 0)
            buttonBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            buttonBG.BackgroundTransparency = 1
            buttonBG.Position = UDim2.new(0.5, 0, 0, 0)
            buttonBG.Size = UDim2.new(1.1, 0, 1, 0)
            buttonBG.ZIndex = 3
            buttonBG.Image = "rbxassetid://3570695787"
            buttonBG.ImageColor3 = uiAccentColors[_G.settings.AccentColor]
            buttonBG.ScaleType = Enum.ScaleType.Slice
            buttonBG.SliceCenter = Rect.new(100, 100, 100, 100)
            buttonBG.SliceScale = 0.06

            Button_TL.Name = "Button_TL"
            Button_TL.Parent = Frame
            Button_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Button_TL.BackgroundTransparency = 1
            Button_TL.Position = UDim2.new(0.0489281043, 0, 0, 0)
            Button_TL.Size = UDim2.new(0.416493893, 0, 1, 0)
            Button_TL.ZIndex = 3
            Button_TL.Font = Enum.Font.GothamBold
            Button_TL.Text = Title
            Button_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
            Button_TL.TextSize = 12
            Button_TL.TextWrapped = true
            Button_TL.TextXAlignment = Enum.TextXAlignment.Left

            local line = Line:Clone()
            line.Parent = Frame

            TextButton.MouseButton1Click:Connect(function()
                callback()
            end)

            return TextButton
        end

        function Controls:AddTextBox(Title, placeholderText, callback)
            Title = Title or "Untitled"
            placeholderText = placeholderText or ""
            callback = callback or function() end

            -- Instances:
            local Frame = Instance.new("Frame")
            local Frame_2 = Instance.new("Frame")
            local TextBox = Instance.new("TextBox")
            local TextBox_BG = Instance.new("ImageLabel")
            local TextBox_TL = Instance.new("TextLabel")

            -- Properties:
            Frame.Parent = NewTab
            Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame.BackgroundTransparency = 1
            Frame.Size = UDim2.new(0.972, 0, 0.09, 0)

            Frame_2.Parent = Frame
            Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame_2.BackgroundTransparency = 1
            Frame_2.Position = UDim2.new(0.5, 0, 0, 0)
            Frame_2.Size = UDim2.new(0.48306039, 0, 1, 0)

            TextBox.Parent = Frame_2
            TextBox.AnchorPoint = Vector2.new(0, 0.5)
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1
            TextBox.Position = UDim2.new(0.05, 0, 0.5, 0)
            TextBox.Size = UDim2.new(0.796, 0, 0.7, 0)
            TextBox.ZIndex = 4
            TextBox.Font = Enum.Font.GothamBold
            TextBox.PlaceholderText = placeholderText
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 14
            TextBox.Text = ""

            TextBox_BG.Name = "TextBox_BG"
            TextBox_BG.Parent = TextBox
            TextBox_BG.AnchorPoint = Vector2.new(0.5, 0)
            TextBox_BG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox_BG.BackgroundTransparency = 1
            TextBox_BG.Position = UDim2.new(0.5, 0, 0, 0)
            TextBox_BG.Size = UDim2.new(1.1, 0, 1, 0)
            TextBox_BG.ZIndex = 3
            TextBox_BG.Image = "rbxassetid://3570695787"
            TextBox_BG.ImageColor3 = Color3.fromRGB(113, 113, 113)
            TextBox_BG.ScaleType = Enum.ScaleType.Slice
            TextBox_BG.SliceCenter = Rect.new(100, 100, 100, 100)
            TextBox_BG.SliceScale = 0.06

            TextBox_TL.Name = "TextBox_TL"
            TextBox_TL.Parent = Frame
            TextBox_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox_TL.BackgroundTransparency = 1
            TextBox_TL.Position = UDim2.new(0.0489281043, 0, 0, 0)
            TextBox_TL.Size = UDim2.new(0.416493893, 0, 1, 0)
            TextBox_TL.ZIndex = 3
            TextBox_TL.Font = Enum.Font.GothamBold
            TextBox_TL.Text = Title
            TextBox_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
            TextBox_TL.TextSize = 12
            TextBox_TL.TextWrapped = true
            TextBox_TL.TextXAlignment = Enum.TextXAlignment.Left

            local line = Line:Clone()
            line.Parent = Frame

            TextBox.FocusLost:Connect(function(EnterPressed)
                if EnterPressed then
                    callback(TextBox.Text)
                    wait(0.2)
                    TextBox.Text = ""
                else
                    return
                end
            end)

            return TextBox
        end

        function Controls:AddToggle(Title, callback)
            Title = Title or "Untitled"
            callback = callback or function() end

            -- Instances:
            local newToggle = Instance.new("Frame")
            local newToggle_BG = Instance.new("ImageButton")
            local newToggle_Btn = Instance.new("ImageButton")
            local newToggle_TL = Instance.new("TextLabel")

            -- Properties:
            newToggle.Name = "newToggle"
            newToggle.Parent = NewTab
            newToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            newToggle.BackgroundTransparency = 1
            newToggle.Size = UDim2.new(0.972, 0, 0.09, 0)

            newToggle_BG.Name = "newToggle_BG"
            newToggle_BG.Parent = newToggle
            newToggle_BG.AnchorPoint = Vector2.new(0, 0.5)
            newToggle_BG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            newToggle_BG.BackgroundTransparency = 1
            newToggle_BG.Position = UDim2.new(0.85, 0, 0.5, 0)
            newToggle_BG.Size = UDim2.new(0.105, 0, 0.5, 0)
            newToggle_BG.ZIndex = 2
            newToggle_BG.Image = "rbxassetid://3570695787"
            newToggle_BG.ImageColor3 = Color3.fromRGB(38, 38, 38)
            newToggle_BG.ScaleType = Enum.ScaleType.Slice
            newToggle_BG.SliceCenter = Rect.new(100, 100, 100, 100)

            newToggle_Btn.Name = "newToggle_Btn"
            newToggle_Btn.Parent = newToggle_BG
            newToggle_Btn.AnchorPoint = Vector2.new(0, 0.5)
            newToggle_Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            newToggle_Btn.BackgroundTransparency = 1
            newToggle_Btn.Position = UDim2.new(0.1, 0, 0.5, 0)
            newToggle_Btn.Size = UDim2.new(0.32, 0, 0.7, 0)
            newToggle_Btn.ZIndex = 3
            newToggle_Btn.Image = "rbxassetid://3570695787"
            newToggle_Btn.ScaleType = Enum.ScaleType.Slice
            newToggle_Btn.SliceCenter = Rect.new(100, 100, 100, 100)

            newToggle_TL.Name = "newToggle_TL"
            newToggle_TL.Parent = newToggle
            newToggle_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            newToggle_TL.BackgroundTransparency = 1
            newToggle_TL.Position = UDim2.new(0.0489281081, 0, 0, 0)
            newToggle_TL.Size = UDim2.new(0.759346068, 0, 1, 0)
            newToggle_TL.ZIndex = 3
            newToggle_TL.Font = Enum.Font.GothamBold
            newToggle_TL.Text = Title
            newToggle_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
            newToggle_TL.TextSize = 12
            newToggle_TL.TextWrapped = true
            newToggle_TL.TextXAlignment = Enum.TextXAlignment.Left

            local line = Line:Clone()
            line.Parent = newToggle

            local isToggled = false

            local function toggle()
                if not isToggled then
                    isToggled = true
                    newToggle_Btn:TweenPosition(newToggle_Btn.Position + UDim2.new(.5,0,0,0),"In","Sine",.1)
                    newToggle_BG.ImageColor3 = uiAccentColors[_G.settings.AccentColor]
                    callback(isToggled)
                else
                    isToggled = false
                    newToggle_Btn:TweenPosition(newToggle_Btn.Position + UDim2.new(-.5,0,0,0),"In","Sine",.1)
                    if _G.settings.Theme == "Dark" then
                        newToggle_BG.ImageColor3 = Color3.fromRGB(38, 38, 38)
                    elseif _G.settings.Theme == "Light" then
                        newToggle_BG.ImageColor3 = Color3.fromRGB(176, 176, 176)
                    end
                    callback(isToggled)
                end
            end

            newToggle_Btn.MouseButton1Click:Connect(function()
                toggle()
            end)

            newToggle_BG.MouseButton1Click:Connect(function()
                toggle()
            end)
        end

        function Controls:AddSlider(Title, maxValue, minValue, defaultValue, callback)
            Title = Title or "Untitled"
            maxValue = maxValue or 100
            minValue = minValue or 0
            defaultValue = defaultValue or minValue
            callback = callback or function() end

            -- Instances:
            local newSlider = Instance.new("Frame")
            local newSlider_TL = Instance.new("TextLabel")
            local newSliderFrame = Instance.new("ImageButton")
            local newSliderBar = Instance.new("ImageButton")
            local newSliderKnob = Instance.new("ImageButton")
            local newSliderValue_TL = Instance.new("TextLabel")

            -- Properties (background):
            newSlider.Name = Title
            newSlider.Parent = NewTab
            newSlider.BackgroundTransparency = 1
            newSlider.Position = UDim2.new(0, 0, 0.381, 0)
            newSlider.Size = UDim2.new(0.972, 0, 0.09, 0)

            newSlider_TL.Name = Title .."_TL"
            newSlider_TL.Parent = newSlider
            newSlider_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            newSlider_TL.BackgroundTransparency = 1
            newSlider_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
            newSlider_TL.Size = UDim2.new(0.16822055, 0, 1, 0)
            newSlider_TL.ZIndex = 6
            newSlider_TL.Font = Enum.Font.GothamBold
            newSlider_TL.Text = Title
            newSlider_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
            newSlider_TL.TextSize = 12
            newSlider_TL.TextWrapped = true
            newSlider_TL.TextXAlignment = Enum.TextXAlignment.Left

            -- Properties (slider):
            newSliderFrame.Name = Title.."_SliderFrame"
            newSliderFrame.Parent = newSlider
            newSliderFrame.AnchorPoint = Vector2.new(0, 0.5)
            newSliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            newSliderFrame.BackgroundTransparency = 1
            newSliderFrame.Position = UDim2.new(0.24038364, 0, 0.5, 0)
            newSliderFrame.Size = UDim2.new(0.596787989, 0, 0.25, 0)
            newSliderFrame.Image = "rbxassetid://3570695787"
            newSliderFrame.ImageColor3 = Color3.fromRGB(38, 38, 38)
            newSliderFrame.ScaleType = Enum.ScaleType.Slice
            newSliderFrame.SliceCenter = Rect.new(100, 100, 100, 100)

            newSliderBar.Name = Title.."_SliderBar"
            newSliderBar.Parent = newSliderFrame
            newSliderBar.AnchorPoint = Vector2.new(0, 0.5)
            newSliderBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            newSliderBar.BackgroundTransparency = 1
            newSliderBar.Position = UDim2.new(0, 0, 0.5, 0)
            newSliderBar.Size = UDim2.new(1, 0, 1, 0)
            newSliderBar.ZIndex = 2
            newSliderBar.Image = "rbxassetid://3570695787"
            newSliderBar.ImageColor3 = uiAccentColors[_G.settings.AccentColor]
            newSliderBar.ScaleType = Enum.ScaleType.Slice
            newSliderBar.SliceCenter = Rect.new(100, 100, 100, 100)

            newSliderKnob.Name = Title.."_Slider"
            newSliderKnob.Parent = newSliderFrame
            newSliderKnob.AnchorPoint = Vector2.new(0, 0.5)
            newSliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            newSliderKnob.BackgroundTransparency = 1
            newSliderKnob.Position = UDim2.new(0.8, 0, 0.5, 0)
            newSliderKnob.Size = UDim2.new(0.05, 0, 1.3, 0)
            newSliderKnob.ZIndex = 2
            newSliderKnob.Image = "rbxassetid://3570695787"
            newSliderKnob.ScaleType = Enum.ScaleType.Slice
            newSliderKnob.SliceCenter = Rect.new(100, 100, 100, 100)

            newSliderValue_TL.Name = Title.."Value_TL"
            newSliderValue_TL.Parent = newSlider
            newSliderValue_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            newSliderValue_TL.BackgroundTransparency = 1
            newSliderValue_TL.Position = UDim2.new(0.867276311, 0, 0, 0)
            newSliderValue_TL.Size = UDim2.new(0.104002289, 0, 1, 0)
            newSliderValue_TL.ZIndex = 6
            newSliderValue_TL.Font = Enum.Font.GothamBold
            newSliderValue_TL.Text = defaultValue
            newSliderValue_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
            newSliderValue_TL.TextSize = 12
            newSliderValue_TL.TextXAlignment = Enum.TextXAlignment.Left

            local line = Line:Clone()
            line.Parent = newSlider

            local isSliding = false
            local reverse_percentage = (defaultValue * newSliderFrame.Size.X.Scale) / maxValue * 2
            newSliderKnob.Position = UDim2.new(reverse_percentage - newSliderKnob.Size.X.Scale / 2, 0, .5, 0)
            newSliderBar.Size = UDim2.new(reverse_percentage, 0, newSliderBar.Size.Y.Scale, 0)
            newSliderValue_TL.Text = defaultValue

            newSliderKnob.MouseButton1Down:Connect(function()
                isSliding = true
            end)
                
            UIS.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isSliding = false
                end
            end)
                
            UIS.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    if isSliding then
                        local mouseLoc = UIS:GetMouseLocation()
                        local relativePos = mouseLoc - newSliderFrame.AbsolutePosition
                        local percentage = math.clamp(relativePos.X / newSliderFrame.AbsoluteSize.X, 0, 1)
                        newSliderKnob.Position = UDim2.new(percentage - newSliderKnob.Size.X.Scale / 2, 0, .5, 0)
                        newSliderBar.Size = UDim2.new(percentage, 0, newSliderBar.Size.Y.Scale, 0)
                        local value = math.floor(math.clamp((percentage * maxValue), minValue, maxValue))
                        newSliderValue_TL.Text = value
                        defaultValue = value
                        pcall(function() callback(value) end)
                    end
                end
            end)
                
            newSliderFrame.MouseButton1Click:Connect(function()
                if not isSliding then
                    local mouseLoc = UIS:GetMouseLocation()
                    local relativePos = mouseLoc - newSliderFrame.AbsolutePosition
                    local percentage = math.clamp(relativePos.X / newSliderFrame.AbsoluteSize.X, 0, 1)
                    newSliderKnob:TweenPosition(UDim2.new(percentage - newSliderKnob.Size.X.Scale / 2, 0, .5, 0),"In","Sine",.1)
                    newSliderBar:TweenSize(UDim2.new(percentage, 0, newSliderBar.Size.Y.Scale, 0),"In","Sine",.1)
                    local value = math.floor(math.clamp((percentage * maxValue), minValue, maxValue))
                    newSliderValue_TL.Text = value
                    defaultValue = value
                    pcall(function() callback(value) end)
                end
            end)
                
            newSliderBar.MouseButton1Click:Connect(function()
                if not isSliding then
                    local mouseLoc = UIS:GetMouseLocation()
                    local relativePos = mouseLoc - newSliderFrame.AbsolutePosition
                    local percentage = math.clamp(relativePos.X / newSliderFrame.AbsoluteSize.X, 0, 1)
                    newSliderKnob:TweenPosition(UDim2.new(percentage - newSliderKnob.Size.X.Scale / 2, 0, .5, 0),"In","Sine",.1)
                    newSliderBar:TweenSize(UDim2.new(percentage, 0, newSliderBar.Size.Y.Scale, 0),"In","Sine",.1)
                    local value = math.floor(math.clamp((percentage * maxValue), minValue, maxValue))
                    newSliderValue_TL.Text = value
                    defaultValue = value
                    pcall(function() callback(value) end)
                end
            end)
        end

        function Controls:AddDropdown(Title, Options, defaultOption, callback)
            local dropdown = {}
            local OptionsTable = {}
            Title = Title or "Untitled"
            Options = Options or {}
            defaultOption = defaultOption or ""
            callback = callback or function() end

            -- Instances:
            local Dropdown = Instance.new("Frame")
            local Frame = Instance.new("Frame")
            local DropdownIcon_BG = Instance.new("ImageButton")
            local DropdownIcon = Instance.new("ImageButton")
            local DropdownBtn = Instance.new("TextButton")
            local DropdownBtn_BG = Instance.new("ImageButton")
            local ScrollingFrame = Instance.new("ScrollingFrame")
            local Dropdown_Items = Instance.new("Folder")
            local UIListLayout = Instance.new("UIListLayout")
            local DropDownBG = Instance.new("ImageLabel")
            local dropdownLabel = Instance.new("TextLabel")

            -- Properties:
            Dropdown.Name = "Dropdown"
            Dropdown.Parent = NewTab
            Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dropdown.BackgroundTransparency = 1
            Dropdown.Size = UDim2.new(0.972, 0, 0.09, 0)

            Frame.Parent = Dropdown
            Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame.BackgroundTransparency = 1
            Frame.Position = UDim2.new(0.5, 0, 0, 0)
            Frame.Size = UDim2.new(0.48306039, 0, 1, 0)

            DropdownIcon_BG.Name = "DropdownIcon_BG"
            DropdownIcon_BG.Parent = Frame
            DropdownIcon_BG.AnchorPoint = Vector2.new(0, 0.5)
            DropdownIcon_BG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownIcon_BG.BackgroundTransparency = 1
            DropdownIcon_BG.Position = UDim2.new(0.87830627, 0, 0.5, 0)
            DropdownIcon_BG.Size = UDim2.new(0.121942624, 0, 0.7, 0)
            DropdownIcon_BG.ZIndex = 8
            DropdownIcon_BG.Image = "rbxassetid://3570695787"
            DropdownIcon_BG.ImageColor3 = uiAccentColors[_G.settings.AccentColor]
            DropdownIcon_BG.ScaleType = Enum.ScaleType.Slice
            DropdownIcon_BG.SliceCenter = Rect.new(100, 100, 100, 100)
            DropdownIcon_BG.SliceScale = 0.060

            DropdownIcon.Name = "DropdownIcon"
            DropdownIcon.Parent = DropdownIcon_BG
            DropdownIcon.AnchorPoint = Vector2.new(0.5, 0.5)
            DropdownIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownIcon.BackgroundTransparency = 1
            DropdownIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
            DropdownIcon.Size = UDim2.new(1, 0, 1, 0)
            DropdownIcon.ZIndex = 9
            DropdownIcon.Image = "rbxassetid://10104292792"
            DropdownIcon.SliceCenter = Rect.new(100, 100, 100, 100)
            DropdownIcon.SliceScale = 0

            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = Frame
            DropdownBtn.AnchorPoint = Vector2.new(0, 0.5)
            DropdownBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownBtn.BackgroundTransparency = 1
            DropdownBtn.Position = UDim2.new(0.050000228, 0, 0.5, 0)
            DropdownBtn.Size = UDim2.new(0.904998064, 0, 0.7, 0)
            DropdownBtn.ZIndex = 8
            DropdownBtn.Font = Enum.Font.GothamBold
            DropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownBtn.TextSize = 14
            DropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
            DropdownBtn.Text = defaultOption
            DropdownBtn.TextWrapped = true

            DropdownBtn_BG.Name = "DropdownBtn_BG"
            DropdownBtn_BG.Parent = DropdownBtn
            DropdownBtn_BG.AnchorPoint = Vector2.new(0.5, 0)
            DropdownBtn_BG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownBtn_BG.BackgroundTransparency = 1
            DropdownBtn_BG.Position = UDim2.new(0.5, 0, 0, 0)
            DropdownBtn_BG.Size = UDim2.new(1.1, 0, 1, 0)
            DropdownBtn_BG.ZIndex = 3
            DropdownBtn_BG.Image = "rbxassetid://3570695787"
            DropdownBtn_BG.ImageColor3 = Color3.fromRGB(113, 113, 113)
            DropdownBtn_BG.ScaleType = Enum.ScaleType.Slice
            DropdownBtn_BG.SliceCenter = Rect.new(100, 100, 100, 100)
            DropdownBtn_BG.SliceScale = 0.06

            ScrollingFrame.Parent = Frame
            ScrollingFrame.Active = true
            ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ScrollingFrame.BackgroundTransparency = 1
            ScrollingFrame.BorderSizePixel = 0
            ScrollingFrame.Position = UDim2.new(0.0102236029, 0, 0.85, 0)
            ScrollingFrame.ZIndex = 8
            ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, 0)
            ScrollingFrame.ScrollBarThickness = 10
            ScrollingFrame.Visible = false

            Dropdown_Items.Name = "Dropdown_Items"
            Dropdown_Items.Parent = ScrollingFrame

            UIListLayout.Parent = Dropdown_Items
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

            DropDownBG.Name = "DropDownBG"
            DropDownBG.Parent = Frame
            DropDownBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropDownBG.BackgroundTransparency = 1
            DropDownBG.Position = UDim2.new(0.00475058611, 0, 0.15, 0)
            DropDownBG.ZIndex = 7
            DropDownBG.Image = "rbxassetid://3570695787"
            DropDownBG.ImageColor3 = Color3.fromRGB(113, 113, 113)
            DropDownBG.ScaleType = Enum.ScaleType.Slice
            DropDownBG.SliceCenter = Rect.new(100, 100, 100, 100)
            DropDownBG.SliceScale = 0.12
            DropDownBG.Visible = false

            ScrollingFrame.Size = UDim2.new(1, 0, .8 * #Options, 0)
            DropDownBG.Size = UDim2.new(1, 0, (.8 * #Options) + 1, 0)

            dropdownLabel.Name = "dropdownLabel"
            dropdownLabel.Parent = Dropdown
            dropdownLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            dropdownLabel.BackgroundTransparency = 1
            dropdownLabel.Position = UDim2.new(0.0489281043, 0, 0, 0)
            dropdownLabel.Size = UDim2.new(0.416493893, 0, 1, 0)
            dropdownLabel.ZIndex = 3
            dropdownLabel.Font = Enum.Font.GothamBold
            dropdownLabel.Text = Title
            dropdownLabel.TextColor3 = Color3.fromRGB(234, 234, 234)
            dropdownLabel.TextSize = 12
            dropdownLabel.TextWrapped = true
            dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left

            local line = Line:Clone()
            line.Parent = Dropdown

            local function onClick()
                if ScrollingFrame.Visible == true then
                    local tween1 = TS:Create(DropDownBG, TweenInfo.new(.3, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 0, 0)})
                    local tween2 = TS:Create(ScrollingFrame, TweenInfo.new(.3, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 0, 0)})
                    tween1:Play()
                    tween2:Play()
                    tween1.Completed:Wait()
                    ScrollingFrame.Visible = false
                    DropDownBG.Visible = false
                else
                    ScrollingFrame.Visible = true
                    DropDownBG.Visible = true
                    ScrollingFrame.Size = UDim2.new(1, 0, 0, 0)
                    DropDownBG.Size = UDim2.new(1, 0, 0, 0)
                    TS:Create(DropDownBG, TweenInfo.new(.3, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, (.8 * #Options) + 1, 0)}):Play()
                    TS:Create(ScrollingFrame, TweenInfo.new(.3, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, .8 * #Options, 0)}):Play()
                end
            end

            DropdownBtn.MouseButton1Click:Connect(onClick)
            DropdownIcon.MouseButton1Click:Connect(onClick)
            DropdownIcon_BG.MouseButton1Click:Connect(onClick)

            for _, v in pairs(Options) do
                local newOption = Instance.new("TextButton")
                newOption.Name = v
                newOption.Parent = Dropdown_Items
                newOption.BackgroundColor3 = Color3.fromRGB(113, 113, 113)
                newOption.BorderSizePixel = 0
                newOption.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
                newOption.Size = UDim2.new(1, 0, 1 / #Options, 0)
                newOption.ZIndex = 9
                newOption.Font = Enum.Font.GothamBold
                newOption.Text = v
                newOption.TextColor3 = Color3.fromRGB(209, 209, 209)
                newOption.TextSize = 12
                table.insert(OptionsTable, newOption)

                newOption.MouseButton1Click:Connect(function()
                    DropdownBtn.Text = v
                    callback(v)
                    onClick()
                end)
            end


            function dropdown:RefreshDropdown(newOptions, newCallback)
                newOptions = newOptions or {}
                newCallback = newCallback or function() end

                for i, v in pairs(newOptions) do
                    local newOption = Instance.new("TextButton")
                    newOption.Name = v
                    newOption.Parent = Dropdown_Items
                    newOption.BackgroundColor3 = Color3.fromRGB(113, 113, 113)
                    newOption.BorderSizePixel = 0
                    newOption.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
                    newOption.Size = UDim2.new(1, 0, 0.13, 0)
                    newOption.ZIndex = 9
                    newOption.Font = Enum.Font.GothamBold
                    newOption.Text = v
                    newOption.TextColor3 = Color3.fromRGB(209, 209, 209)
                    newOption.TextSize = 12

                    newOption.MouseButton1Click:Connect(function()
                        DropdownBtn.Text = v
                        ScrollingFrame.Visible = false
                        DropDownBG.Visible = false
                        newCallback(v)
                    end)
                end
            end

            return dropdown
        end

        function Controls:AddSelection(Title, Options, itemSelected_callback, itemUnselected_callback)
            Title = Title or "Untitled"
            Options = Options or {}
            itemSelected_callback = itemSelected_callback or function() end
            itemUnselected_callback = itemUnselected_callback or function() end

            local selectedOptions = {}

            local dictCount = 0 --instead of #Options because its a disctionary not a table..
            for i, v in pairs(Options) do
                dictCount = dictCount + 1
            end

            -- Instances:
            local Selection = Instance.new("Frame")
            local selectionLabel = Instance.new("TextLabel")
            local List = Instance.new("Frame")
            local UIListLayout = Instance.new("UIListLayout")

            -- Properties:
            Selection.Name = "Selection"
            Selection.Parent = NewTab
            Selection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Selection.BackgroundTransparency = 1
            Selection.Size = UDim2.new(0.972, 0, dictCount * 0.09, 0)

            selectionLabel.Name = "selectionLabel"
            selectionLabel.Parent = Selection
            selectionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            selectionLabel.BackgroundTransparency = 1
            selectionLabel.Position = UDim2.new(0.0489281043, 0, 0, 0)
            selectionLabel.Size = UDim2.new(0.416493893, 0, 1 / dictCount, 0)
            selectionLabel.ZIndex = 3
            selectionLabel.Font = Enum.Font.GothamBold
            selectionLabel.Text = Title
            selectionLabel.TextColor3 = Color3.fromRGB(234, 234, 234)
            selectionLabel.TextSize = 12
            selectionLabel.TextWrapped = true
            selectionLabel.TextXAlignment = Enum.TextXAlignment.Left

            local line = Line:Clone()
            line.Size = UDim2.new(line.Size.X.Scale, 0, line.Size.Y.Scale / dictCount, 0)
            line.Parent = Selection

            List.Name = "List"
            List.Parent = Selection
            List.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            List.BackgroundTransparency = 1
            List.Position = UDim2.new(0.475, 0, 0, 0)
            List.Size = UDim2.new(0.51172173, 0, 1, 0)

            UIListLayout.Parent = List
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

            for i, v in pairs(Options) do
                local newOption = Instance.new("Frame")
                local optionLabel = Instance.new("TextLabel")
                local optionButton = Instance.new("ImageButton")
                local checkMarkBtn = Instance.new("ImageButton")

                newOption.Name = "newOption"
                newOption.Parent = List
                newOption.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                newOption.BackgroundTransparency = 1
                newOption.Size = UDim2.new(1, 0, 1 / dictCount, 0)

                optionLabel.Name = "selectionLabel"
                optionLabel.Parent = newOption
                optionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                optionLabel.BackgroundTransparency = 1
                optionLabel.Position = UDim2.new(0.207002029, 0, 0, 0)
                optionLabel.Size = UDim2.new(0.747997642, 0, 1, 0)
                optionLabel.ZIndex = 3
                optionLabel.Font = Enum.Font.GothamBold
                optionLabel.Text = i
                optionLabel.TextColor3 = Color3.fromRGB(234, 234, 234)
                optionLabel.TextSize = 12
                optionLabel.TextWrapped = true
                optionLabel.TextXAlignment = Enum.TextXAlignment.Left

                optionButton.Name = "optionButton"
                optionButton.Parent = newOption
                optionButton.AnchorPoint = Vector2.new(0, 0.5)
                optionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                optionButton.BackgroundTransparency = 1
                optionButton.Position = UDim2.new(0.05, 0, 0.5, 0)
                optionButton.Size = UDim2.new(0.119658366, 0, 0.7, 0)
                optionButton.ZIndex = 3
                optionButton.Image = "rbxassetid://3570695787"
                optionButton.ImageColor3 = uiAccentColors[_G.settings.AccentColor]
                optionButton.ScaleType = Enum.ScaleType.Slice
                optionButton.SliceCenter = Rect.new(100, 100, 100, 100)
                optionButton.SliceScale = 0.06

                checkMarkBtn.Name = i
                checkMarkBtn.Parent = optionButton
                checkMarkBtn.AnchorPoint = Vector2.new(0.5, 0.5)
                checkMarkBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                checkMarkBtn.BackgroundTransparency = 1
                checkMarkBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
                checkMarkBtn.Size = UDim2.new(0.5, 0, 0.5, 0)
                checkMarkBtn.ZIndex = 3
                checkMarkBtn.Image = "rbxassetid://10560437392"
                checkMarkBtn.ScaleType = Enum.ScaleType.Slice
                checkMarkBtn.SliceCenter = Rect.new(100, 100, 100, 100)

                if v == false then
                    checkMarkBtn.ImageTransparency = 1
                    optionButton.ImageColor3 = Color3.fromRGB(38, 38, 38)
                else
                    table.insert(selectedOptions, i)
                end

                local function onClick()
                    if checkMarkBtn.ImageTransparency == 1 then
                        table.insert(selectedOptions, i)
                        itemSelected_callback(i, selectedOptions)
                        checkMarkBtn.ImageTransparency = 0
                        optionButton.ImageColor3 = uiAccentColors[_G.settings.AccentColor]
                    else                      
                        local findOption = table.find(selectedOptions, i)
                        if findOption then
                            table.remove(selectedOptions, findOption)
                            itemUnselected_callback(i, selectedOptions)
                        end
                        checkMarkBtn.ImageTransparency = 1
                        optionButton.ImageColor3 = Color3.fromRGB(38, 38, 38)
                    end
                end

                checkMarkBtn.MouseButton1Click:Connect(onClick)
                optionButton.MouseButton1Click:Connect(onClick)
            end
        end

        function Controls:AddKeybind_Setting(Title, keyString, onKey_Callback)
            Title = Title or "Untitled"
            keyString = keyString:upper() or "F"
            onKey_Callback = onKey_Callback or function() end
            if _G.settings.keybinds then
                if _G.settings.keybinds[Title] then keyString = _G.settings.keybinds[Title] end
            end

            -- Instances:
            local newKeybind = Instance.new("Frame")
            local newKeybind_Btn = Instance.new("TextButton")
            local Btn_BG = Instance.new("ImageButton")
            local newKeybind_TL = Instance.new("TextLabel")

            -- Properties:
            newKeybind.Name = "newKeybind"
            newKeybind.Parent = NewTab
            newKeybind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            newKeybind.BackgroundTransparency = 1
            newKeybind.Size = UDim2.new(0.972, 0, 0.09, 0)

            newKeybind_Btn.Name = "newKeybind_Btn"
            newKeybind_Btn.Parent = newKeybind
            newKeybind_Btn.AnchorPoint = Vector2.new(0, 0.5)
            newKeybind_Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            newKeybind_Btn.BackgroundTransparency = 1
            newKeybind_Btn.Position = UDim2.new(0.05, 0, 0.5, 0)
            newKeybind_Btn.Size = UDim2.new(0.904998064, 0, 0.7, 0)
            newKeybind_Btn.ZIndex = 8
            newKeybind_Btn.Font = Enum.Font.GothamBold
            newKeybind_Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            newKeybind_Btn.TextSize = 14
            newKeybind_Btn.Text = "[" .. keyString .. "]"
            newKeybind_Btn.TextWrapped = true

            Btn_BG.Name = "Btn_BG"
            Btn_BG.Parent = newKeybind_Btn
            Btn_BG.AnchorPoint = Vector2.new(0.5, 0)
            Btn_BG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Btn_BG.BackgroundTransparency = 1
            Btn_BG.Position = UDim2.new(0.5, 0, 0, 0)
            Btn_BG.Size = UDim2.new(1.1, 0, 1, 0)
            Btn_BG.ZIndex = 3
            Btn_BG.Image = "rbxassetid://3570695787"
            Btn_BG.ImageColor3 = Color3.fromRGB(113, 113, 113)
            Btn_BG.ScaleType = Enum.ScaleType.Slice
            Btn_BG.SliceCenter = Rect.new(100, 100, 100, 100)
            Btn_BG.SliceScale = 0.06

            local line = Line:Clone()
            line.Parent = Dropdown

            local logKey = false
            mouse.KeyDown:Connect(function(key)
                local pressedKey = key:upper()

                if pressedKey == keyString and not logKey then
                    onKey_Callback()
                end

                if logKey then
                    _G.settings.keybinds[Title] = pressedKey
                    keyString = pressedKey
                    newKeybind_Btn.Text = "[" .. pressedKey:upper() .. "]"
                    logKey = false
                    saveSettings()
                end
            end)

            newKeybind_Btn.MouseButton1Click:Connect(function()
                newKeybind_Btn.Text = "Press Key"
                logKey = true
            end)
        end

        return Controls
    end

    return Tabs
end

function Library:AddKeybind(key, callback, description)
    key = key:lower() or ""
    callback = callback or function() end
    description = description or ""

    mouse.KeyDown:Connect(function(keyString)
        if keyString == key then
            callback()
        end
    end)
end

-- test code here:

-- end of test code

return Library



--local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zakater5/LuaRepo/main/Other/UI_Lib.lua"))()
--local newUI = Library.new("e", "e", nil)
--local newTab = newUI:NewTab("tabname")
--newTab:AddSlider("Label", 100, 0, 30)
