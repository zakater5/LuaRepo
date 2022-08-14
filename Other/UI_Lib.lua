Library = {}

local playIntro = false
local configFileName = "UITestLibConfig.json"

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
Line.Position = UDim2.new(0.5, 0, 0.95, 0)
Line.Size = UDim2.new(0.95, 0, 0.2, 0)
UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
UIGradient.Rotation = 90
UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.25, 1.00), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(0.74, 1.00), NumberSequenceKeypoint.new(1.00, 1.00)}
UIGradient.Parent = Line

function runIntro(mainBG, sideBar, uiName)
    local mainBG_OrigSize = mainBG.Size
    local sideBar_OrigSize = sideBar.Size
    mainBG.Size = UDim2.new(0,0,0,0)
    sideBar.Size = UDim2.new(0,0,sideBar.Size.Y.Scale,0)

    TS:Create(
        mainBG,
        TweenInfo.new(.5, Enum.EasingStyle.Sine),
        {Size = mainBG_OrigSize}
    ):Play()
    wait(1)
    TS:Create(
        sideBar,
        TweenInfo.new(.5, Enum.EasingStyle.Sine),
        {Size = mainBG_OrigSize}
    ):Play()
end

-- [[ CREATING CUSTOM NOTIFICATION GUI ]] --
-- NOTIFICATION LIST:
-- Instances:
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
Roundify_4.SliceScale = 0.120

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
    optionsTab.OptionsTab.CanvasSize = UDim2.new(0, 0, 1.5, 0)
    optionsTab.OptionsTab.ScrollBarThickness = 6
    optionsTab.OptionsTab.Visible = false

    optionsTab.Frame.Parent = optionsTab.OptionsTab
    optionsTab.Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    optionsTab.Frame.BackgroundTransparency = 1
    optionsTab.Frame.Size = UDim2.new(0.972, 0, 0.12, 0)

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
    optionsTab.Frame_3.Size = UDim2.new(0.972, 0, 0.058, 0)

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
    end)

    optionsTab.DarkMode.MouseButton1Click:Connect(function()
        _G.settings.Theme = "Dark"
        updateUI_theme(mainFrame, "Dark")
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

    -- Properties:
    UI_Lib.Name = UI_Name
    UI_Lib.Parent = game:GetService("CoreGui")
    UI_Lib.ResetOnSpawn = false

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = UI_Lib
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundTransparency = 1
    MainFrame.Position = UDim2.new(0.5, 0, 0.4, 0)
    MainFrame.Size = UDim2.new(0.318675667, 0, 0.427295029, 0)

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
    Min_Button.Position = UDim2.new(0.2, 0, 0.221589461, 0)
    Min_Button.Size = UDim2.new(0.11929135, 0, 0.539204836, 0)
    Min_Button.ZIndex = 5
    Min_Button.Image = "rbxassetid://3570695787"
    Min_Button.ImageColor3 = Color3.fromRGB(50, 209, 64)
    Min_Button.ScaleType = Enum.ScaleType.Slice
    Min_Button.SliceCenter = Rect.new(100, 100, 100, 100)
    Min_Button.SliceScale = 0.12

    X_Button.Name = "X_Button"
    X_Button.Parent = TopBar_Frame
    X_Button.BackgroundTransparency = 1
    X_Button.Position = UDim2.new(0.05, 0, 0.221589461, 0)
    X_Button.Size = UDim2.new(0.11929135, 0, 0.539204836, 0)
    X_Button.ZIndex = 5
    X_Button.Image = "rbxassetid://3570695787"
    X_Button.ImageColor3 = Color3.fromRGB(249, 77, 78)
    X_Button.ScaleType = Enum.ScaleType.Slice
    X_Button.SliceCenter = Rect.new(100, 100, 100, 100)
    X_Button.SliceScale = 0.120

    Opt_Button.Name = "Opt_Button"
    Opt_Button.Parent = TopBar_Frame
    Opt_Button.BackgroundTransparency = 1
    Opt_Button.Position = UDim2.new(0.804176092, 0, 0.222, 0)
    Opt_Button.Size = UDim2.new(0.15, 0, 0.7, 0)
    Opt_Button.ZIndex = 5
    Opt_Button.Image = "rbxassetid://10565603595"
    Opt_Button.ImageColor3 = Color3.fromRGB(200, 200, 200)
    Opt_Button.SliceCenter = Rect.new(100, 100, 100, 100)
    Opt_Button.SliceScale = 0.12

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

    X_Button.MouseButton1Click:Connect(function()
        MainFrame:TweenSize(UDim2.new(0,0,0,0), "In", "Sine", .2)
        wait(.2)
        MainFrame:Destroy()
    end)

    Min_Button.MouseButton1Click:Connect(function()
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
        NewTab.Size = UDim2.new(0.740969956, 0, 0.962810099, 0)
        NewTab.CanvasSize = UDim2.new(0, 0, 1.5, 0)
        NewTab.ScrollBarThickness = 6
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
        function Controls:AddLabel(LabelText)
            LabelText = LabelText or "Label"

            -- Instances:
            local Frame = Instance.new("Frame")
            local TextLabel = Instance.new("TextLabel")

            --Properties:
            Frame.Parent = NewTab
            Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame.BackgroundTransparency = 1
            Frame.Size = UDim2.new(0.972, 0, 0.058, 0)

            TextLabel.Name = "TextLabel"
            TextLabel.Parent = Frame
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1
            TextLabel.Position = UDim2.new(0.0489281043, 0, 0, 0)
            TextLabel.Size = UDim2.new(0.416493893, 0, 1, 0)
            TextLabel.ZIndex = 3
            TextLabel.Font = Enum.Font.GothamBold
            TextLabel.Text = "Flight"
            TextLabel.TextColor3 = Color3.fromRGB(234, 234, 234)
            TextLabel.TextSize = 12
            TextLabel.TextWrapped = true
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left

            local line = Line:Clone()
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
            Frame.Size = UDim2.new(0.972, 0, 0.058, 0)

            Frame_2.Parent = Frame
            Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame_2.BackgroundTransparency = 1
            Frame_2.Position = UDim2.new(0.377439648, 0, 0, 0)
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
            Button_TL.Text = ButtonText
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
            Frame.Size = UDim2.new(0.972, 0, 0.058, 0)

            Frame_2.Parent = Frame
            Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame_2.BackgroundTransparency = 1
            Frame_2.Position = UDim2.new(0.377439648, 0, 0, 0)
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
            newToggle.Size = UDim2.new(0.972, 0, 0.058, 0)

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
            newToggle_TL.Text = "Flight"
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
                    newToggle_BG.ImageColor3 = Color3.fromRGB(38, 38, 38)
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
            newSlider.Size = UDim2.new(0.972, 0, 0.058, 0)

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

        function Controls:AddDropdown(Title, Options, callback)
            local Dropdown = {}
            local OptionsTable = {}
            Title = Title or "Untitled"
            Options = Options or {}
            callback = callback or function() end

            -- Instances:
            local newDropdown = Instance.new("ImageLabel")
            local newDropdown_TL = Instance.new("TextLabel")
            local ScrollingFrame = Instance.new("ScrollingFrame")
            local Dropdown_Items = Instance.new("Folder")
            local UIListLayout = Instance.new("UIListLayout")
            local SelectedOption_Btn = Instance.new("TextButton")
            local SelectedOption_Btn_BG = Instance.new("ImageLabel")
            local Arrow = Instance.new("ImageLabel")
            local DropDownBG = Instance.new("ImageLabel")
            local DropDownBG_BG = Instance.new("ImageLabel")

            -- Properties:
            newDropdown.Name = "newDropdown"
            newDropdown.Parent = NewTab
            newDropdown.BackgroundTransparency = 1
            newDropdown.Position = UDim2.new(0, 0, 0.52, 0)
            newDropdown.Size = UDim2.new(0.972, 0, 0.075, 0)
            newDropdown.Image = "rbxassetid://3570695787"
            newDropdown.ImageColor3 = Color3.fromRGB(44, 44, 44)
            newDropdown.ScaleType = Enum.ScaleType.Slice
            newDropdown.SliceCenter = Rect.new(100, 100, 100, 100)
            newDropdown.SliceScale = 0.06

            newDropdown_TL.Name = "newDropdown_TL"
            newDropdown_TL.Parent = newDropdown
            newDropdown_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            newDropdown_TL.BackgroundTransparency = 1
            newDropdown_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
            newDropdown_TL.Size = UDim2.new(0.16822055, 0, 1, 0)
            newDropdown_TL.ZIndex = 6
            newDropdown_TL.Font = Enum.Font.GothamBold
            newDropdown_TL.Text = "Quest"
            newDropdown_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
            newDropdown_TL.TextSize = 12
            newDropdown_TL.TextWrapped = true
            newDropdown_TL.TextXAlignment = Enum.TextXAlignment.Left

            ScrollingFrame.Name = "ScrollingFrame"
            ScrollingFrame.Parent = newDropdown
            ScrollingFrame.Active = true
            ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ScrollingFrame.BackgroundTransparency = 1
            ScrollingFrame.BorderSizePixel = 0
            ScrollingFrame.Position = UDim2.new(0.294, 0, 0.829, 0)
            ScrollingFrame.Size = UDim2.new(0.692, 0, 2.268, 0)
            ScrollingFrame.Visible = false
            ScrollingFrame.ZIndex = 8
            ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)
            ScrollingFrame.ScrollBarThickness = 10
            ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

            Dropdown_Items.Name = "Dropdown_Items"
            Dropdown_Items.Parent = ScrollingFrame

            UIListLayout.Parent = Dropdown_Items
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

            SelectedOption_Btn.Name = "SelectedOption_Btn"
            SelectedOption_Btn.Parent = newDropdown
            SelectedOption_Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SelectedOption_Btn.BackgroundTransparency = 1
            SelectedOption_Btn.BorderSizePixel = 0
            SelectedOption_Btn.Position = UDim2.new(0.293, 0, 0.206, 0)
            SelectedOption_Btn.Size = UDim2.new(0.692, 0, 0.642, 0)
            SelectedOption_Btn.ZIndex = 6
            SelectedOption_Btn.Font = Enum.Font.GothamBold
            SelectedOption_Btn.Text = "Officer Sam [Lvl. 1+]"
            SelectedOption_Btn.TextColor3 = Color3.fromRGB(209, 209, 209)
            SelectedOption_Btn.TextSize = 12

            SelectedOption_Btn_BG.Name = "SelectedOption_Btn_BG"
            SelectedOption_Btn_BG.Parent = SelectedOption_Btn
            SelectedOption_Btn_BG.AnchorPoint = Vector2.new(0.5, 0.5)
            SelectedOption_Btn_BG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SelectedOption_Btn_BG.BackgroundTransparency = 1
            SelectedOption_Btn_BG.Position = UDim2.new(0.5, 0, 0.5, 0)
            SelectedOption_Btn_BG.Size = UDim2.new(1, 0, 1, 0)
            SelectedOption_Btn_BG.ZIndex = 2
            SelectedOption_Btn_BG.Image = "rbxassetid://3570695787"
            SelectedOption_Btn_BG.ImageColor3 = Color3.fromRGB(62, 62, 62)
            SelectedOption_Btn_BG.ScaleType = Enum.ScaleType.Slice
            SelectedOption_Btn_BG.SliceCenter = Rect.new(100, 100, 100, 100)
            SelectedOption_Btn_BG.SliceScale = 0.12

            Arrow.Name = "Arrow"
            Arrow.Parent = SelectedOption_Btn
            Arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Arrow.BackgroundTransparency = 1
            Arrow.Position = UDim2.new(0.05, 0, 0.15, 0)
            Arrow.Rotation = 90
            Arrow.Size = UDim2.new(0.07, 0, 0.7, 0)
            Arrow.ZIndex = 2
            Arrow.Image = "rbxassetid://71659683"
            Arrow.ImageColor3 = Color3.fromRGB(230, 230, 230)

            DropDownBG.Name = "DropDownBG"
            DropDownBG.Parent = newDropdown
            DropDownBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropDownBG.BackgroundTransparency = 1
            DropDownBG.Position = UDim2.new(0.294, 0, 0.206, 0)
            DropDownBG.Size = UDim2.new(0.692, 0, 3.072, 0)
            DropDownBG.ZIndex = 2
            DropDownBG.Visible = false
            DropDownBG.Image = "rbxassetid://3570695787"
            DropDownBG.ImageColor3 = Color3.fromRGB(62, 62, 62)
            DropDownBG.ScaleType = Enum.ScaleType.Slice
            DropDownBG.SliceCenter = Rect.new(100, 100, 100, 100)
            DropDownBG.SliceScale = 0.12

            --DropDownBG_BG.Name = "DropDownBG_BG"
            --DropDownBG_BG.Parent = DropDownBG
            --DropDownBG_BG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            --DropDownBG_BG.BackgroundTransparency = 1
            --DropDownBG_BG.Position = UDim2.new(-0.01, 0, -0.01, 0)
            --DropDownBG_BG.Size = UDim2.new(1.02, 0, 1.02, 0)
            --DropDownBG_BG.Image = "rbxassetid://3570695787"
            --DropDownBG_BG.ImageColor3 = Color3.fromRGB(216, 34, 128)
            --DropDownBG_BG.ScaleType = Enum.ScaleType.Slice
            --DropDownBG_BG.SliceCenter = Rect.new(100, 100, 100, 100)
            --DropDownBG_BG.SliceScale = 0.12

                for _, v in pairs(Options) do
                    local newOption = Instance.new("TextButton")
                    newOption.Name = v
                    newOption.Parent = Dropdown_Items
                    newOption.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
                    newOption.BorderSizePixel = 0
                    newOption.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
                    newOption.Size = UDim2.new(1, 0, 0.3, 0)
                    newOption.ZIndex = 4
                    newOption.Font = Enum.Font.GothamBold
                    newOption.Text = v
                    newOption.TextColor3 = Color3.fromRGB(209, 209, 209)
                    newOption.TextSize = 12
                    newOption.TextWrapped = true
                    table.insert(OptionsTable, newOption)

                    newOption.MouseButton1Click:Connect(function()
                        SelectedOption_Btn.Text = v
                        ScrollingFrame.Visible = false
                        DropDownBG.Visible = false
                        callback(v)
                    end)
                end

                SelectedOption_Btn.MouseButton1Click:Connect(function()
                    if ScrollingFrame.Visible == true then
                        ScrollingFrame.Visible = false
                        DropDownBG.Visible = false
                    else
                        ScrollingFrame.Visible = true
                        DropDownBG.Visible = true
                    end
                end)

                function Dropdown:RefreshDropdown(newOptions, newCallback)
                    newOptions = newOptions or {}
                    newCallback = newCallback or function() end

                    for i, v in pairs(newOptions) do
                        local newOption = Instance.new("TextButton")
                        newOption.Name = v
                        newOption.Parent = Dropdown_Items
                        newOption.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
                        newOption.BorderSizePixel = 0
                        newOption.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
                        newOption.Size = UDim2.new(1, 0, 0.3, 0)
                        newOption.ZIndex = 4
                        newOption.Font = Enum.Font.GothamBold
                        newOption.Text = v
                        newOption.TextColor3 = Color3.fromRGB(209, 209, 209)
                        newOption.TextSize = 12
                        newOption.TextWrapped = true

                        newOption.MouseButton1Click:Connect(function()
                            SelectedOption_Btn.Text = v
                            ScrollingFrame.Visible = false
                            DropDownBG.Visible = false
                            newCallback(v)
                        end)
                    end
                end

                return Dropdown
            end

            function Controls:AddSelection(Title, Options, itemSelected_callback, itemUnselected_callback)
                Title = Title or "Untitled"
                Options = Options or {}
                itemSelected_callback = itemSelected_callback or function() end
                itemUnselected_callback = itemUnselected_callback or function() end

                local selectedOptions = {}

                -- Instances:
                local newSelection = Instance.new("ImageLabel")
                local newSelection_TL = Instance.new("TextLabel")
                local SelectionFrame = Instance.new("Frame")
                local SelectionItems = Instance.new("Folder")
                local UIGridLayout = Instance.new("UIGridLayout")

                -- Properties:
                newSelection.Name = "newSelection"
                newSelection.Parent = NewTab
                newSelection.BackgroundTransparency = 1
                newSelection.Position = UDim2.new(0, 0, 0.21, 0)
                newSelection.Size = UDim2.new(0.971999943, 0, 0.25, 0)
                newSelection.Image = "rbxassetid://3570695787"
                newSelection.ImageColor3 = Color3.fromRGB(44, 44, 44)
                newSelection.ScaleType = Enum.ScaleType.Slice
                newSelection.SliceCenter = Rect.new(100, 100, 100, 100)
                newSelection.SliceScale = 0.06

                newSelection_TL.Name = "newSelection_TL"
                newSelection_TL.Parent = newSelection
                newSelection_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                newSelection_TL.BackgroundTransparency = 1
                newSelection_TL.Position = UDim2.new(0.0489280932, 0, 0, 0)
                newSelection_TL.Size = UDim2.new(0.663618565, 0, 0.225675911, 0)
                newSelection_TL.ZIndex = 6
                newSelection_TL.Font = Enum.Font.GothamBold
                newSelection_TL.Text = "Look for"
                newSelection_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
                newSelection_TL.TextSize = 12
                newSelection_TL.TextWrapped = true
                newSelection_TL.TextXAlignment = Enum.TextXAlignment.Left

                SelectionFrame.Name = "SelectionFrame"
                SelectionFrame.Parent = newSelection
                SelectionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SelectionFrame.BackgroundTransparency = 1
                SelectionFrame.Position = UDim2.new(0.0314923562, 0, 0.235058755, 0)
                SelectionFrame.Size = UDim2.new(0.934548557, 0, 0.74648416, 0)

                SelectionItems.Name = "SelectionItems"
                SelectionItems.Parent = SelectionFrame

                UIGridLayout.Parent = SelectionItems
                UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIGridLayout.CellPadding = UDim2.new(0.3, 0, 0.05, 0)
                UIGridLayout.CellSize = UDim2.new(0.05, 0, 0.18, 0)

                for i, v in pairs(Options) do
                    -- Instances:
                    local newOption = Instance.new("ImageButton")
                    local option_BG = Instance.new("ImageLabel")
                    local option_TL = Instance.new("TextLabel")

                    -- Properties:
                    newOption.Name = v
                    newOption.Parent = SelectionItems
                    newOption.AnchorPoint = Vector2.new(0, 0.5)
                    newOption.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    newOption.BackgroundTransparency = 1
                    newOption.Position = UDim2.new(0.04, 0, 0.301115066, 0)
                    newOption.Size = UDim2.new(0.045, 0, 0.116359457, 0)
                    newOption.ZIndex = 2
                    newOption.Image = "rbxassetid://3570695787"
                    newOption.ScaleType = Enum.ScaleType.Slice
                    newOption.SliceCenter = Rect.new(100, 100, 100, 100)

                    option_BG.Name = "option_BG"
                    option_BG.Parent = newOption
                    option_BG.AnchorPoint = Vector2.new(0.5, 0.5)
                    option_BG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    option_BG.BackgroundTransparency = 1
                    option_BG.Position = UDim2.new(0.5, 0, 0.5, 0)
                    option_BG.Size = UDim2.new(1.5, 0, 1.5, 0)
                    option_BG.Image = "rbxassetid://3570695787"
                    option_BG.ImageColor3 = Color3.fromRGB(62, 62, 62)
                    option_BG.ScaleType = Enum.ScaleType.Slice
                    option_BG.SliceCenter = Rect.new(100, 100, 100, 100)

                    option_TL.Name = "option_TL"
                    option_TL.Parent = newOption
                    option_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    option_TL.BackgroundTransparency = 1
                    option_TL.Position = UDim2.new(1.5, 0, 0, 0)
                    option_TL.Size = UDim2.new(5, 0, 1, 0)
                    option_TL.ZIndex = 6
                    option_TL.Font = Enum.Font.GothamBold
                    option_TL.Text = v
                    option_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
                    option_TL.TextSize = 11
                    option_TL.TextWrapped = true
                    option_TL.TextXAlignment = Enum.TextXAlignment.Left

                    newOption.MouseButton1Click:Connect(function()
                        if newOption.ImageTransparency == 1 then
                            newOption.ImageTransparency = 0
                            table.insert(selectedOptions, newOption.Name)
                            itemSelected_callback(newOption.Name, selectedOptions)
                        else
                            newOption.ImageTransparency = 1
                            local findOption = table.find(selectedOptions, newOption.Name)
                            if findOption then
                                table.remove(selectedOptions, findOption)
                                itemUnselected_callback(newOption.Name, selectedOptions)
                            end
                        end
                    end)
                end
            end

            function Controls:AddKeybind(Title, keyString, onKey_Callback)
                Title = Title or "Untitled"
                keyString = keyString:upper() or "F"
                onKey_Callback = onKey_Callback or function() end

                -- Instances:
                local newKeybind = Instance.new("ImageLabel")
                local newKeybind_TL = Instance.new("TextLabel")
                local newKeybind_Btn = Instance.new("TextButton")
                local Btn_BG = Instance.new("ImageLabel")

                -- Properties:
                newKeybind.Name = "newKeybind"
                newKeybind.Parent = NewTab
                newKeybind.BackgroundTransparency = 1
                newKeybind.Position = UDim2.new(4.6708, 0, -0.5, 0)
                newKeybind.Size = UDim2.new(0.972, 0, 0.08, 0)
                newKeybind.Image = "rbxassetid://3570695787"
                newKeybind.ImageColor3 = Color3.fromRGB(38, 38, 38)
                newKeybind.ScaleType = Enum.ScaleType.Slice
                newKeybind.SliceCenter = Rect.new(100, 100, 100, 100)
                newKeybind.SliceScale = 0.06

                newKeybind_TL.Name = "newKeybind_TL"
                newKeybind_TL.Parent = newKeybind
                newKeybind_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                newKeybind_TL.BackgroundTransparency = 1
                newKeybind_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
                newKeybind_TL.Size = UDim2.new(0.663618565, 0, 1, 0)
                newKeybind_TL.ZIndex = 6
                newKeybind_TL.Font = Enum.Font.GothamBold
                newKeybind_TL.Text = Title
                newKeybind_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
                newKeybind_TL.TextSize = 12
                newKeybind_TL.TextWrapped = true
                newKeybind_TL.TextXAlignment = Enum.TextXAlignment.Left

                newKeybind_Btn.Name = "newKeybind_Btn"
                newKeybind_Btn.Parent = newKeybind
                newKeybind_Btn.AnchorPoint = Vector2.new(0, 0.5)
                newKeybind_Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                newKeybind_Btn.BackgroundTransparency = 1
                newKeybind_Btn.BorderSizePixel = 0
                newKeybind_Btn.Position = UDim2.new(0.749213159, 0, 0.5, 0)
                newKeybind_Btn.Size = UDim2.new(0.23855485, 0, 0.8, 0)
                newKeybind_Btn.ZIndex = 2
                newKeybind_Btn.Font = Enum.Font.GothamBold
                newKeybind_Btn.Text = keyString
                newKeybind_Btn.TextColor3 = Color3.fromRGB(211, 211, 211)
                newKeybind_Btn.TextSize = 12
                newKeybind_Btn.TextWrapped = true

                Btn_BG.Name = "Btn_BG"
                Btn_BG.Parent = newKeybind_Btn
                Btn_BG.AnchorPoint = Vector2.new(0.5, 0.5)
                Btn_BG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Btn_BG.BackgroundTransparency = 1
                Btn_BG.Position = UDim2.new(0.5, 0, 0.5, 0)
                Btn_BG.Size = UDim2.new(1, 0, 1, 0)
                Btn_BG.Image = "rbxassetid://3570695787"
                Btn_BG.ImageColor3 = Color3.fromRGB(62, 62, 62)
                Btn_BG.ScaleType = Enum.ScaleType.Slice
                Btn_BG.SliceCenter = Rect.new(100, 100, 100, 100)
                Btn_BG.SliceScale = 0.06

                local logKey = false
                mouse.KeyDown:Connect(function(key)
                    local pressedKey = key:upper()

                    if pressedKey == keyString and not logKey then
                        onKey_Callback()
                    end

                    if logKey then
                        _G.settings.flight_KeyBind = pressedKey
                        newKeybind_Btn.Text = pressedKey:upper()
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

-- test code here:

local newUI = Library.new("e", "e", nil)
local newTab = newUI:AddTab("Tab 1")
local newTab2 = newUI:AddTab("Tab 2")
newTab:AddLabel("Label")
newTab:AddButton("Button")
newTab:AddTextBox("TextBox")
newTab:AddToggle("Toggle")
newTab:AddSlider("Slider")

-- end of test code

return Library



--local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zakater5/LuaRepo/main/Other/UI_Lib.lua"))()
--local newUI = Library.new("e", "e", nil)
--local newTab = newUI:NewTab("tabname")
--newTab:AddSlider("Label", 100, 0, 30)
