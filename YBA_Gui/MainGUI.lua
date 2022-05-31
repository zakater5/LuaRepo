
-- YBA item ESP --


-- config
local UI_Name = "ShitStain Lite"
local superSpeed_speedValue = 150 --temporary
local superSpeed_KeyBind = "v" --temporary
local fly_KeyBind = "e" --temporary
local max_flightSpeed = 50
local flightSpeed = 25

-- services
local players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TS = game:GetService("TweenService")

-- vars
local player = players.LocalPlayer
local itemsFolder = game.Workspace.Item_Spawns.Items
local mouse = player:GetMouse()
local Debris = game:GetService("Debris")

local speedOn = false

local toggles = {
    --items
    ItemESP = false,
    ItemAutoFarm = false,
    ItemNotifs = false,
    
    --combat
    superSpeed = false,
    jump = false,
    isFlying = false,
    ClickTP = false,
    targetPlayer = false,
    
    --extras
    playerHealthBars = false,
}

local isPickingUpItem = false
local searchForAllItems = true
local FilterItems = {} -- if user is looking for specific items instead of all
local itemColors = {
    ["Gold Coin"] = Color3.fromRGB(245, 239, 66),
    ["Rokakaka"] = Color3.fromRGB(255, 82, 85),
    ["Pure Roka."] = Color3.fromRGB(255, 1, 5),
    ["Myst. Arrow"] = Color3.fromRGB(253, 255, 96),
    ["Lucky Arrow"] = Color3.fromRGB(255, 217, 0),
    ["Rib Cage"] = Color3.fromRGB(206, 206, 206),
    ["Diamond"] = Color3.fromRGB(103, 194, 255),
    ["Anc. Scroll"] = Color3.fromRGB(255, 189, 74),
    ["Quin. Gloves"] = Color3.fromRGB(255, 107, 88),
    ["Steel Ball"] = Color3.fromRGB(80, 255, 115),
    ["Headband"] = Color3.fromRGB(255, 130, 41),
    ["Stone Mask"] = Color3.fromRGB(109, 109, 109),
    ["Unknown"] = Color3.fromRGB(255, 255, 255),
}

local autoFarmPositionCFrames = {
    CFrame.new(-481, 803, 496),
    CFrame.new(-422, 803, 341),
    CFrame.new(-419, 803, 193),
    CFrame.new(-472, 803, 4),
    CFrame.new(-443, 803, -208),
    CFrame.new(-269, 803, -225),
    CFrame.new(-56, 803, -164),
    CFrame.new(171, 803, -223),
    CFrame.new(316, 805, -137),
    CFrame.new(533, 803, -255),
    CFrame.new(710, 803, -209),
    CFrame.new(984, 803, -257),
    CFrame.new(744, 806, 24),
    CFrame.new(1091, 814, -7),
    CFrame.new(1963, 820, -6),
    CFrame.new(2052, 819, -251),
    CFrame.new(115, 803, 518),
    CFrame.new(299, 803, 495),
    CFrame.new(496, 803, 497),
    CFrame.new(112, 803, 814),
    CFrame.new(-57, 826, 343),
    CFrame.new(-176, 828, 282),
    CFrame.new(-300, 826, 259),
    CFrame.new(-322, 826, 36),
    CFrame.new(-224, 826, -134),
    CFrame.new(-151, 826, 36),
    CFrame.new(67, 826, 34),
    CFrame.new(134, 826, -112),
    CFrame.new(352, 826, -44),
    CFrame.new(280, 826, 193),
    CFrame.new(54, 826, 190),
    CFrame.new(127, 826, 374),
    CFrame.new(514, 826, 336),
}


-- [[ CREATING MAIN UI ]] --

-- Checking for existing UI --
local UI_Exists = game.CoreGui:FindFirstChild(UI_Name)
if UI_Exists then UI_Exists:Destroy() end

-- Instances:

local YBA = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TabButtons = Instance.new("Folder")
local Extras = Instance.new("TextButton")
local Roundify = Instance.new("ImageLabel")
local Combat = Instance.new("TextButton")
local Roundify_2 = Instance.new("ImageLabel")
local Items = Instance.new("TextButton")
local Roundify_3 = Instance.new("ImageLabel")
local Tabs = Instance.new("Folder")
local ItemsTab = Instance.new("ImageLabel")
local Toggles = Instance.new("Folder")
local Toggle_ItemESP = Instance.new("TextButton")
local Roundify_4 = Instance.new("ImageLabel")
local Toggle_ItemNotifs = Instance.new("TextButton")
local Roundify_5 = Instance.new("ImageLabel")
local Toggle_ItemAutoFarm = Instance.new("TextButton")
local Roundify_6 = Instance.new("ImageLabel")
local TextLabels = Instance.new("Folder")
local Text = Instance.new("TextLabel")
local Text_2 = Instance.new("TextLabel")
local Text_3 = Instance.new("TextLabel")
local CheckBoxes = Instance.new("Folder")
local Toggle_Rokakaka = Instance.new("TextButton")
local BG = Instance.new("ImageLabel")
local Toggle_Arrows = Instance.new("TextButton")
local BG_2 = Instance.new("ImageLabel")
local Toggle_Coins = Instance.new("TextButton")
local BG_3 = Instance.new("ImageLabel")
local Toggle_Diamond = Instance.new("TextButton")
local BG_4 = Instance.new("ImageLabel")
local Toggle_RibCage = Instance.new("TextButton")
local BG_5 = Instance.new("ImageLabel")
local Toggle_All = Instance.new("TextButton")
local BG_6 = Instance.new("ImageLabel")
local Toggle_DEOsDiary = Instance.new("TextButton")
local BG_7 = Instance.new("ImageLabel")
local Toggle_StoneMask = Instance.new("TextButton")
local BG_8 = Instance.new("ImageLabel")
local Toggle_SteelBall = Instance.new("TextButton")
local BG_9 = Instance.new("ImageLabel")
local Toggle_Headband = Instance.new("TextButton")
local BG_10 = Instance.new("ImageLabel")
local Toggle_LuckyArrow = Instance.new("TextButton")
local BG_11 = Instance.new("ImageLabel")
local Toggle_PureRokakaka = Instance.new("TextButton")
local BG_12 = Instance.new("ImageLabel")
local CheckBoxes_Text = Instance.new("Folder")
local Text_4 = Instance.new("TextLabel")
local Text_5 = Instance.new("TextLabel")
local Text_6 = Instance.new("TextLabel")
local Text_7 = Instance.new("TextLabel")
local Text_8 = Instance.new("TextLabel")
local Text_9 = Instance.new("TextLabel")
local Text_10 = Instance.new("TextLabel")
local Text_11 = Instance.new("TextLabel")
local Text_12 = Instance.new("TextLabel")
local Text_13 = Instance.new("TextLabel")
local Text_14 = Instance.new("TextLabel")
local Text_15 = Instance.new("TextLabel")
local Other = Instance.new("Folder")
local Roundify_7 = Instance.new("ImageLabel")
local Roundify_8 = Instance.new("ImageLabel")
local CombatTab = Instance.new("ImageLabel")
local TextLabels_2 = Instance.new("Folder")
local Text_16 = Instance.new("TextLabel")
local Text_17 = Instance.new("TextLabel")
local Text_18 = Instance.new("TextLabel")
local Text_19 = Instance.new("TextLabel")
local Text_20 = Instance.new("TextLabel")
local Text_21 = Instance.new("TextLabel")
local Toggles_2 = Instance.new("Folder")
local Toggle_Speed = Instance.new("TextButton")
local Roundify_9 = Instance.new("ImageLabel")
local Toggle_Jump = Instance.new("TextButton")
local Roundify_10 = Instance.new("ImageLabel")
local Toggle_Flight = Instance.new("TextButton")
local Roundify_11 = Instance.new("ImageLabel")
local Toggle_TargetPlayer = Instance.new("TextButton")
local Roundify_12 = Instance.new("ImageLabel")
local Toggle_ClickTP = Instance.new("TextButton")
local Roundify_13 = Instance.new("ImageLabel")
local ValueInputs = Instance.new("Folder")
local Input_TargetPlayer = Instance.new("TextBox")
local Roundify_14 = Instance.new("ImageLabel")
local Other_2 = Instance.new("Folder")
local Roundify_15 = Instance.new("ImageLabel")
local Roundify_16 = Instance.new("ImageLabel")
local ExtrasTab = Instance.new("ImageLabel")
local TextLabels_3 = Instance.new("Folder")
local Text_22 = Instance.new("TextLabel")
local Toggles_3 = Instance.new("Folder")
local Toggle_PlayerHealthBars = Instance.new("TextButton")
local Roundify_17 = Instance.new("ImageLabel")
local Other_3 = Instance.new("Folder")
local Roundify_18 = Instance.new("ImageLabel")
local TopBar = Instance.new("Folder")
local Frame_2 = Instance.new("Frame")
local Frame_3 = Instance.new("Frame")
local Frame_4 = Instance.new("ImageLabel")
local Title = Instance.new("TextLabel")
local Frame_5 = Instance.new("ImageLabel")
local BorderBG = Instance.new("ImageLabel")

--Properties:

YBA.Name = UI_Name
YBA.Parent = game.CoreGui
YBA.ResetOnSpawn = false

Frame.Parent = YBA
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.Position = UDim2.new(0.307000011, 0, 0.207000017, 0)
Frame.Size = UDim2.new(0.215000004, 0, 0.476662546, 0)
Frame.ZIndex = 8

TabButtons.Name = "TabButtons"
TabButtons.Parent = Frame

Extras.Name = "Extras"
Extras.Parent = TabButtons
Extras.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Extras.BackgroundTransparency = 1.000
Extras.BorderSizePixel = 0
Extras.Position = UDim2.new(0.674452603, 0, 0.0900000036, 0)
Extras.Size = UDim2.new(0.305109471, 0, 0.0649230033, 0)
Extras.ZIndex = 3
Extras.Font = Enum.Font.GothamBold
Extras.Text = "Extras"
Extras.TextColor3 = Color3.fromRGB(206, 206, 206)
Extras.TextSize = 17.000

Roundify.Name = "Roundify"
Roundify.Parent = Extras
Roundify.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify.BackgroundTransparency = 1.000
Roundify.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify.Size = UDim2.new(1, 0, 1, 0)
Roundify.ZIndex = 2
Roundify.Image = "rbxassetid://3570695787"
Roundify.ImageColor3 = Color3.fromRGB(79, 79, 79)
Roundify.ScaleType = Enum.ScaleType.Slice
Roundify.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify.SliceScale = 0.120

Combat.Name = "Combat"
Combat.Parent = TabButtons
Combat.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Combat.BackgroundTransparency = 1.000
Combat.BorderSizePixel = 0
Combat.Position = UDim2.new(0.019999953, 0, 0.0900000036, 0)
Combat.Size = UDim2.new(0.305109471, 0, 0.0649230033, 0)
Combat.ZIndex = 3
Combat.Font = Enum.Font.GothamBold
Combat.Text = "Combat"
Combat.TextColor3 = Color3.fromRGB(206, 206, 206)
Combat.TextSize = 17.000

Roundify_2.Name = "Roundify"
Roundify_2.Parent = Combat
Roundify_2.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_2.BackgroundTransparency = 1.000
Roundify_2.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_2.Size = UDim2.new(1, 0, 1, 0)
Roundify_2.ZIndex = 2
Roundify_2.Image = "rbxassetid://3570695787"
Roundify_2.ImageColor3 = Color3.fromRGB(79, 79, 79)
Roundify_2.ScaleType = Enum.ScaleType.Slice
Roundify_2.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_2.SliceScale = 0.120

Items.Name = "Items"
Items.Parent = TabButtons
Items.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Items.BackgroundTransparency = 1.000
Items.BorderSizePixel = 0
Items.Position = UDim2.new(0.349999934, 0, 0.0900000036, 0)
Items.Size = UDim2.new(0.305109471, 0, 0.0649230033, 0)
Items.ZIndex = 3
Items.Font = Enum.Font.GothamBold
Items.Text = "Items"
Items.TextColor3 = Color3.fromRGB(206, 206, 206)
Items.TextSize = 17.000

Roundify_3.Name = "Roundify"
Roundify_3.Parent = Items
Roundify_3.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_3.BackgroundTransparency = 1.000
Roundify_3.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_3.Size = UDim2.new(1, 0, 1, 0)
Roundify_3.ZIndex = 2
Roundify_3.Image = "rbxassetid://3570695787"
Roundify_3.ImageColor3 = Color3.fromRGB(79, 79, 79)
Roundify_3.ScaleType = Enum.ScaleType.Slice
Roundify_3.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_3.SliceScale = 0.120

Tabs.Name = "Tabs"
Tabs.Parent = Frame

ItemsTab.Name = "ItemsTab"
ItemsTab.Parent = Tabs
ItemsTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ItemsTab.BackgroundTransparency = 1.000
ItemsTab.Position = UDim2.new(0, 0, 0.174980864, 0)
ItemsTab.Size = UDim2.new(1, 0, 0.825019062, 0)
ItemsTab.Visible = false
ItemsTab.Image = "rbxassetid://3570695787"
ItemsTab.ImageColor3 = Color3.fromRGB(77, 77, 77)
ItemsTab.ScaleType = Enum.ScaleType.Slice
ItemsTab.SliceCenter = Rect.new(100, 100, 100, 100)
ItemsTab.SliceScale = 0.120

Toggles.Name = "Toggles"
Toggles.Parent = ItemsTab

Toggle_ItemESP.Name = "Toggle_ItemESP"
Toggle_ItemESP.Parent = Toggles
Toggle_ItemESP.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_ItemESP.BackgroundTransparency = 1.000
Toggle_ItemESP.BorderSizePixel = 0
Toggle_ItemESP.Position = UDim2.new(0.0404379405, 0, 0.054999996, 0)
Toggle_ItemESP.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
Toggle_ItemESP.ZIndex = 3
Toggle_ItemESP.Font = Enum.Font.GothamBold
Toggle_ItemESP.Text = "OFF"
Toggle_ItemESP.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_ItemESP.TextSize = 17.000

Roundify_4.Name = "Roundify"
Roundify_4.Parent = Toggle_ItemESP
Roundify_4.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_4.BackgroundTransparency = 1.000
Roundify_4.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_4.Size = UDim2.new(1, 0, 1, 0)
Roundify_4.ZIndex = 2
Roundify_4.Image = "rbxassetid://3570695787"
Roundify_4.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_4.ScaleType = Enum.ScaleType.Slice
Roundify_4.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_4.SliceScale = 0.120

Toggle_ItemNotifs.Name = "Toggle_ItemNotifs"
Toggle_ItemNotifs.Parent = Toggles
Toggle_ItemNotifs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_ItemNotifs.BackgroundTransparency = 1.000
Toggle_ItemNotifs.BorderSizePixel = 0
Toggle_ItemNotifs.Position = UDim2.new(0.0404379405, 0, 0.168972045, 0)
Toggle_ItemNotifs.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
Toggle_ItemNotifs.ZIndex = 3
Toggle_ItemNotifs.Font = Enum.Font.GothamBold
Toggle_ItemNotifs.Text = "OFF"
Toggle_ItemNotifs.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_ItemNotifs.TextSize = 17.000

Roundify_5.Name = "Roundify"
Roundify_5.Parent = Toggle_ItemNotifs
Roundify_5.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_5.BackgroundTransparency = 1.000
Roundify_5.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_5.Size = UDim2.new(1, 0, 1, 0)
Roundify_5.ZIndex = 2
Roundify_5.Image = "rbxassetid://3570695787"
Roundify_5.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_5.ScaleType = Enum.ScaleType.Slice
Roundify_5.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_5.SliceScale = 0.120

Toggle_ItemAutoFarm.Name = "Toggle_ItemAutoFarm"
Toggle_ItemAutoFarm.Parent = Toggles
Toggle_ItemAutoFarm.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_ItemAutoFarm.BackgroundTransparency = 1.000
Toggle_ItemAutoFarm.BorderSizePixel = 0
Toggle_ItemAutoFarm.Position = UDim2.new(0.0404379405, 0, 0.282944143, 0)
Toggle_ItemAutoFarm.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
Toggle_ItemAutoFarm.ZIndex = 3
Toggle_ItemAutoFarm.Font = Enum.Font.GothamBold
Toggle_ItemAutoFarm.Text = "OFF"
Toggle_ItemAutoFarm.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_ItemAutoFarm.TextSize = 17.000

Roundify_6.Name = "Roundify"
Roundify_6.Parent = Toggle_ItemAutoFarm
Roundify_6.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_6.BackgroundTransparency = 1.000
Roundify_6.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_6.Size = UDim2.new(1, 0, 1, 0)
Roundify_6.ZIndex = 2
Roundify_6.Image = "rbxassetid://3570695787"
Roundify_6.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_6.ScaleType = Enum.ScaleType.Slice
Roundify_6.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_6.SliceScale = 0.120

TextLabels.Name = "TextLabels"
TextLabels.Parent = ItemsTab

Text.Name = "Text"
Text.Parent = TextLabels
Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text.BackgroundTransparency = 1.000
Text.Position = UDim2.new(0.300000101, 0, 0.282944143, 0)
Text.Size = UDim2.new(0.649999976, 0, 0.085651733, 0)
Text.ZIndex = 3
Text.Font = Enum.Font.GothamBold
Text.Text = "Item Auto-Farm"
Text.TextColor3 = Color3.fromRGB(209, 209, 209)
Text.TextSize = 18.000
Text.TextXAlignment = Enum.TextXAlignment.Left

Text_2.Name = "Text"
Text_2.Parent = TextLabels
Text_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_2.BackgroundTransparency = 1.000
Text_2.Position = UDim2.new(0.300000101, 0, 0.168972045, 0)
Text_2.Size = UDim2.new(0.649999976, 0, 0.085651733, 0)
Text_2.ZIndex = 3
Text_2.Font = Enum.Font.GothamBold
Text_2.Text = "Item Notifications"
Text_2.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_2.TextSize = 18.000
Text_2.TextXAlignment = Enum.TextXAlignment.Left

Text_3.Name = "Text"
Text_3.Parent = TextLabels
Text_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_3.BackgroundTransparency = 1.000
Text_3.Position = UDim2.new(0.300000101, 0, 0.0549999513, 0)
Text_3.Size = UDim2.new(0.649999976, 0, 0.085651733, 0)
Text_3.ZIndex = 3
Text_3.Font = Enum.Font.GothamBold
Text_3.Text = "Item ESP"
Text_3.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_3.TextSize = 18.000
Text_3.TextXAlignment = Enum.TextXAlignment.Left

CheckBoxes.Name = "CheckBoxes"
CheckBoxes.Parent = ItemsTab

Toggle_Rokakaka.Name = "Toggle_Rokakaka"
Toggle_Rokakaka.Parent = CheckBoxes
Toggle_Rokakaka.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Rokakaka.BackgroundTransparency = 1.000
Toggle_Rokakaka.BorderSizePixel = 0
Toggle_Rokakaka.Position = UDim2.new(0.349999934, 0, 0.449921429, 0)
Toggle_Rokakaka.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
Toggle_Rokakaka.ZIndex = 3
Toggle_Rokakaka.Font = Enum.Font.GothamBold
Toggle_Rokakaka.Text = ""
Toggle_Rokakaka.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_Rokakaka.TextSize = 17.000

BG.Name = "BG"
BG.Parent = Toggle_Rokakaka
BG.Active = true
BG.AnchorPoint = Vector2.new(0.5, 0.5)
BG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BG.BackgroundTransparency = 1.000
BG.Position = UDim2.new(0.5, 0, 0.5, 0)
BG.Selectable = true
BG.Size = UDim2.new(1, 0, 1, 0)
BG.ZIndex = 2
BG.Image = "rbxassetid://3570695787"
BG.ImageColor3 = Color3.fromRGB(62, 62, 62)
BG.ScaleType = Enum.ScaleType.Slice
BG.SliceCenter = Rect.new(100, 100, 100, 100)
BG.SliceScale = 0.060

Toggle_Arrows.Name = "Toggle_Arrows"
Toggle_Arrows.Parent = CheckBoxes
Toggle_Arrows.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Arrows.BackgroundTransparency = 1.000
Toggle_Arrows.BorderSizePixel = 0
Toggle_Arrows.Position = UDim2.new(0.0500000194, 0, 0.549768269, 0)
Toggle_Arrows.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
Toggle_Arrows.ZIndex = 3
Toggle_Arrows.Font = Enum.Font.GothamBold
Toggle_Arrows.Text = ""
Toggle_Arrows.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_Arrows.TextSize = 17.000

BG_2.Name = "BG"
BG_2.Parent = Toggle_Arrows
BG_2.Active = true
BG_2.AnchorPoint = Vector2.new(0.5, 0.5)
BG_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BG_2.BackgroundTransparency = 1.000
BG_2.Position = UDim2.new(0.5, 0, 0.5, 0)
BG_2.Selectable = true
BG_2.Size = UDim2.new(1, 0, 1, 0)
BG_2.ZIndex = 2
BG_2.Image = "rbxassetid://3570695787"
BG_2.ImageColor3 = Color3.fromRGB(62, 62, 62)
BG_2.ScaleType = Enum.ScaleType.Slice
BG_2.SliceCenter = Rect.new(100, 100, 100, 100)
BG_2.SliceScale = 0.060

Toggle_Coins.Name = "Toggle_Coins"
Toggle_Coins.Parent = CheckBoxes
Toggle_Coins.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Coins.BackgroundTransparency = 1.000
Toggle_Coins.BorderSizePixel = 0
Toggle_Coins.Position = UDim2.new(0.0500000194, 0, 0.64961499, 0)
Toggle_Coins.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
Toggle_Coins.ZIndex = 3
Toggle_Coins.Font = Enum.Font.GothamBold
Toggle_Coins.Text = ""
Toggle_Coins.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_Coins.TextSize = 17.000

BG_3.Name = "BG"
BG_3.Parent = Toggle_Coins
BG_3.Active = true
BG_3.AnchorPoint = Vector2.new(0.5, 0.5)
BG_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BG_3.BackgroundTransparency = 1.000
BG_3.Position = UDim2.new(0.5, 0, 0.5, 0)
BG_3.Selectable = true
BG_3.Size = UDim2.new(1, 0, 1, 0)
BG_3.ZIndex = 2
BG_3.Image = "rbxassetid://3570695787"
BG_3.ImageColor3 = Color3.fromRGB(62, 62, 62)
BG_3.ScaleType = Enum.ScaleType.Slice
BG_3.SliceCenter = Rect.new(100, 100, 100, 100)
BG_3.SliceScale = 0.060

Toggle_Diamond.Name = "Toggle_Diamond"
Toggle_Diamond.Parent = CheckBoxes
Toggle_Diamond.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Diamond.BackgroundTransparency = 1.000
Toggle_Diamond.BorderSizePixel = 0
Toggle_Diamond.Position = UDim2.new(0.349999934, 0, 0.549768269, 0)
Toggle_Diamond.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
Toggle_Diamond.ZIndex = 3
Toggle_Diamond.Font = Enum.Font.GothamBold
Toggle_Diamond.Text = ""
Toggle_Diamond.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_Diamond.TextSize = 17.000

BG_4.Name = "BG"
BG_4.Parent = Toggle_Diamond
BG_4.Active = true
BG_4.AnchorPoint = Vector2.new(0.5, 0.5)
BG_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BG_4.BackgroundTransparency = 1.000
BG_4.Position = UDim2.new(0.5, 0, 0.5, 0)
BG_4.Selectable = true
BG_4.Size = UDim2.new(1, 0, 1, 0)
BG_4.ZIndex = 2
BG_4.Image = "rbxassetid://3570695787"
BG_4.ImageColor3 = Color3.fromRGB(62, 62, 62)
BG_4.ScaleType = Enum.ScaleType.Slice
BG_4.SliceCenter = Rect.new(100, 100, 100, 100)
BG_4.SliceScale = 0.060

Toggle_RibCage.Name = "Toggle_RibCage"
Toggle_RibCage.Parent = CheckBoxes
Toggle_RibCage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_RibCage.BackgroundTransparency = 1.000
Toggle_RibCage.BorderSizePixel = 0
Toggle_RibCage.Position = UDim2.new(0.349999934, 0, 0.64961499, 0)
Toggle_RibCage.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
Toggle_RibCage.ZIndex = 3
Toggle_RibCage.Font = Enum.Font.GothamBold
Toggle_RibCage.Text = ""
Toggle_RibCage.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_RibCage.TextSize = 17.000

BG_5.Name = "BG"
BG_5.Parent = Toggle_RibCage
BG_5.Active = true
BG_5.AnchorPoint = Vector2.new(0.5, 0.5)
BG_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BG_5.BackgroundTransparency = 1.000
BG_5.Position = UDim2.new(0.5, 0, 0.5, 0)
BG_5.Selectable = true
BG_5.Size = UDim2.new(1, 0, 1, 0)
BG_5.ZIndex = 2
BG_5.Image = "rbxassetid://3570695787"
BG_5.ImageColor3 = Color3.fromRGB(62, 62, 62)
BG_5.ScaleType = Enum.ScaleType.Slice
BG_5.SliceCenter = Rect.new(100, 100, 100, 100)
BG_5.SliceScale = 0.060

Toggle_All.Name = "Toggle_All"
Toggle_All.Parent = CheckBoxes
Toggle_All.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_All.BackgroundTransparency = 1.000
Toggle_All.BorderSizePixel = 0
Toggle_All.Position = UDim2.new(0.0500000194, 0, 0.449921429, 0)
Toggle_All.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
Toggle_All.ZIndex = 3
Toggle_All.Font = Enum.Font.GothamBold
Toggle_All.Text = "X"
Toggle_All.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_All.TextSize = 17.000

BG_6.Name = "BG"
BG_6.Parent = Toggle_All
BG_6.Active = true
BG_6.AnchorPoint = Vector2.new(0.5, 0.5)
BG_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BG_6.BackgroundTransparency = 1.000
BG_6.Position = UDim2.new(0.5, 0, 0.5, 0)
BG_6.Selectable = true
BG_6.Size = UDim2.new(1, 0, 1, 0)
BG_6.ZIndex = 2
BG_6.Image = "rbxassetid://3570695787"
BG_6.ImageColor3 = Color3.fromRGB(62, 62, 62)
BG_6.ScaleType = Enum.ScaleType.Slice
BG_6.SliceCenter = Rect.new(100, 100, 100, 100)
BG_6.SliceScale = 0.060

Toggle_DEOsDiary.Name = "Toggle_DEOsDiary"
Toggle_DEOsDiary.Parent = CheckBoxes
Toggle_DEOsDiary.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_DEOsDiary.BackgroundTransparency = 1.000
Toggle_DEOsDiary.BorderSizePixel = 0
Toggle_DEOsDiary.Position = UDim2.new(0.649999857, 0, 0.64961499, 0)
Toggle_DEOsDiary.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
Toggle_DEOsDiary.ZIndex = 3
Toggle_DEOsDiary.Font = Enum.Font.GothamBold
Toggle_DEOsDiary.Text = ""
Toggle_DEOsDiary.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_DEOsDiary.TextSize = 17.000

BG_7.Name = "BG"
BG_7.Parent = Toggle_DEOsDiary
BG_7.Active = true
BG_7.AnchorPoint = Vector2.new(0.5, 0.5)
BG_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BG_7.BackgroundTransparency = 1.000
BG_7.Position = UDim2.new(0.5, 0, 0.5, 0)
BG_7.Selectable = true
BG_7.Size = UDim2.new(1, 0, 1, 0)
BG_7.ZIndex = 2
BG_7.Image = "rbxassetid://3570695787"
BG_7.ImageColor3 = Color3.fromRGB(62, 62, 62)
BG_7.ScaleType = Enum.ScaleType.Slice
BG_7.SliceCenter = Rect.new(100, 100, 100, 100)
BG_7.SliceScale = 0.060

Toggle_StoneMask.Name = "Toggle_StoneMask"
Toggle_StoneMask.Parent = CheckBoxes
Toggle_StoneMask.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_StoneMask.BackgroundTransparency = 1.000
Toggle_StoneMask.BorderSizePixel = 0
Toggle_StoneMask.Position = UDim2.new(0.649999857, 0, 0.549768269, 0)
Toggle_StoneMask.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
Toggle_StoneMask.ZIndex = 3
Toggle_StoneMask.Font = Enum.Font.GothamBold
Toggle_StoneMask.Text = ""
Toggle_StoneMask.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_StoneMask.TextSize = 17.000

BG_8.Name = "BG"
BG_8.Parent = Toggle_StoneMask
BG_8.Active = true
BG_8.AnchorPoint = Vector2.new(0.5, 0.5)
BG_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BG_8.BackgroundTransparency = 1.000
BG_8.Position = UDim2.new(0.5, 0, 0.5, 0)
BG_8.Selectable = true
BG_8.Size = UDim2.new(1, 0, 1, 0)
BG_8.ZIndex = 2
BG_8.Image = "rbxassetid://3570695787"
BG_8.ImageColor3 = Color3.fromRGB(62, 62, 62)
BG_8.ScaleType = Enum.ScaleType.Slice
BG_8.SliceCenter = Rect.new(100, 100, 100, 100)
BG_8.SliceScale = 0.060

Toggle_SteelBall.Name = "Toggle_SteelBall"
Toggle_SteelBall.Parent = CheckBoxes
Toggle_SteelBall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_SteelBall.BackgroundTransparency = 1.000
Toggle_SteelBall.BorderSizePixel = 0
Toggle_SteelBall.Position = UDim2.new(0.649999857, 0, 0.449921429, 0)
Toggle_SteelBall.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
Toggle_SteelBall.ZIndex = 3
Toggle_SteelBall.Font = Enum.Font.GothamBold
Toggle_SteelBall.Text = ""
Toggle_SteelBall.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_SteelBall.TextSize = 17.000

BG_9.Name = "BG"
BG_9.Parent = Toggle_SteelBall
BG_9.Active = true
BG_9.AnchorPoint = Vector2.new(0.5, 0.5)
BG_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BG_9.BackgroundTransparency = 1.000
BG_9.Position = UDim2.new(0.5, 0, 0.5, 0)
BG_9.Selectable = true
BG_9.Size = UDim2.new(1, 0, 1, 0)
BG_9.ZIndex = 2
BG_9.Image = "rbxassetid://3570695787"
BG_9.ImageColor3 = Color3.fromRGB(62, 62, 62)
BG_9.ScaleType = Enum.ScaleType.Slice
BG_9.SliceCenter = Rect.new(100, 100, 100, 100)
BG_9.SliceScale = 0.060

Toggle_Headband.Name = "Toggle_Headband"
Toggle_Headband.Parent = CheckBoxes
Toggle_Headband.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Headband.BackgroundTransparency = 1.000
Toggle_Headband.BorderSizePixel = 0
Toggle_Headband.Position = UDim2.new(0.349999934, 0, 0.74946177, 0)
Toggle_Headband.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
Toggle_Headband.ZIndex = 3
Toggle_Headband.Font = Enum.Font.GothamBold
Toggle_Headband.Text = ""
Toggle_Headband.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_Headband.TextSize = 17.000

BG_10.Name = "BG"
BG_10.Parent = Toggle_Headband
BG_10.Active = true
BG_10.AnchorPoint = Vector2.new(0.5, 0.5)
BG_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BG_10.BackgroundTransparency = 1.000
BG_10.Position = UDim2.new(0.5, 0, 0.5, 0)
BG_10.Selectable = true
BG_10.Size = UDim2.new(1, 0, 1, 0)
BG_10.ZIndex = 2
BG_10.Image = "rbxassetid://3570695787"
BG_10.ImageColor3 = Color3.fromRGB(62, 62, 62)
BG_10.ScaleType = Enum.ScaleType.Slice
BG_10.SliceCenter = Rect.new(100, 100, 100, 100)
BG_10.SliceScale = 0.060

Toggle_LuckyArrow.Name = "Toggle_LuckyArrow"
Toggle_LuckyArrow.Parent = CheckBoxes
Toggle_LuckyArrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_LuckyArrow.BackgroundTransparency = 1.000
Toggle_LuckyArrow.BorderSizePixel = 0
Toggle_LuckyArrow.Position = UDim2.new(0.649999857, 0, 0.74946177, 0)
Toggle_LuckyArrow.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
Toggle_LuckyArrow.ZIndex = 3
Toggle_LuckyArrow.Font = Enum.Font.GothamBold
Toggle_LuckyArrow.Text = ""
Toggle_LuckyArrow.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_LuckyArrow.TextSize = 17.000

BG_11.Name = "BG"
BG_11.Parent = Toggle_LuckyArrow
BG_11.Active = true
BG_11.AnchorPoint = Vector2.new(0.5, 0.5)
BG_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BG_11.BackgroundTransparency = 1.000
BG_11.Position = UDim2.new(0.5, 0, 0.5, 0)
BG_11.Selectable = true
BG_11.Size = UDim2.new(1, 0, 1, 0)
BG_11.ZIndex = 2
BG_11.Image = "rbxassetid://3570695787"
BG_11.ImageColor3 = Color3.fromRGB(62, 62, 62)
BG_11.ScaleType = Enum.ScaleType.Slice
BG_11.SliceCenter = Rect.new(100, 100, 100, 100)
BG_11.SliceScale = 0.060

Toggle_PureRokakaka.Name = "Toggle_PureRokakaka"
Toggle_PureRokakaka.Parent = CheckBoxes
Toggle_PureRokakaka.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_PureRokakaka.BackgroundTransparency = 1.000
Toggle_PureRokakaka.BorderSizePixel = 0
Toggle_PureRokakaka.Position = UDim2.new(0.0500000194, 0, 0.74946177, 0)
Toggle_PureRokakaka.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
Toggle_PureRokakaka.ZIndex = 3
Toggle_PureRokakaka.Font = Enum.Font.GothamBold
Toggle_PureRokakaka.Text = ""
Toggle_PureRokakaka.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_PureRokakaka.TextSize = 17.000

BG_12.Name = "BG"
BG_12.Parent = Toggle_PureRokakaka
BG_12.Active = true
BG_12.AnchorPoint = Vector2.new(0.5, 0.5)
BG_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BG_12.BackgroundTransparency = 1.000
BG_12.Position = UDim2.new(0.5, 0, 0.5, 0)
BG_12.Selectable = true
BG_12.Size = UDim2.new(1, 0, 1, 0)
BG_12.ZIndex = 2
BG_12.Image = "rbxassetid://3570695787"
BG_12.ImageColor3 = Color3.fromRGB(62, 62, 62)
BG_12.ScaleType = Enum.ScaleType.Slice
BG_12.SliceCenter = Rect.new(100, 100, 100, 100)
BG_12.SliceScale = 0.060

CheckBoxes_Text.Name = "CheckBoxes_Text"
CheckBoxes_Text.Parent = ItemsTab

Text_4.Name = "Text"
Text_4.Parent = CheckBoxes_Text
Text_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_4.BackgroundTransparency = 1.000
Text_4.Position = UDim2.new(0.128832042, 0, 0.449921429, 0)
Text_4.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
Text_4.ZIndex = 3
Text_4.Font = Enum.Font.GothamBold
Text_4.Text = "All Items"
Text_4.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_4.TextScaled = true
Text_4.TextSize = 18.000
Text_4.TextWrapped = true
Text_4.TextXAlignment = Enum.TextXAlignment.Left

Text_5.Name = "Text"
Text_5.Parent = CheckBoxes_Text
Text_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_5.BackgroundTransparency = 1.000
Text_5.Position = UDim2.new(0.128832042, 0, 0.549768388, 0)
Text_5.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
Text_5.ZIndex = 3
Text_5.Font = Enum.Font.GothamBold
Text_5.Text = "Arrows"
Text_5.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_5.TextScaled = true
Text_5.TextSize = 18.000
Text_5.TextWrapped = true
Text_5.TextXAlignment = Enum.TextXAlignment.Left

Text_6.Name = "Text"
Text_6.Parent = CheckBoxes_Text
Text_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_6.BackgroundTransparency = 1.000
Text_6.Position = UDim2.new(0.128832042, 0, 0.64961499, 0)
Text_6.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
Text_6.ZIndex = 3
Text_6.Font = Enum.Font.GothamBold
Text_6.Text = "Coins"
Text_6.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_6.TextScaled = true
Text_6.TextSize = 18.000
Text_6.TextWrapped = true
Text_6.TextXAlignment = Enum.TextXAlignment.Left

Text_7.Name = "Text"
Text_7.Parent = CheckBoxes_Text
Text_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_7.BackgroundTransparency = 1.000
Text_7.Position = UDim2.new(0.424999982, 0, 0.449921429, 0)
Text_7.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
Text_7.ZIndex = 3
Text_7.Font = Enum.Font.GothamBold
Text_7.Text = "Rokakaka"
Text_7.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_7.TextScaled = true
Text_7.TextSize = 18.000
Text_7.TextWrapped = true
Text_7.TextXAlignment = Enum.TextXAlignment.Left

Text_8.Name = "Text"
Text_8.Parent = CheckBoxes_Text
Text_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_8.BackgroundTransparency = 1.000
Text_8.Position = UDim2.new(0.424999982, 0, 0.549768388, 0)
Text_8.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
Text_8.ZIndex = 3
Text_8.Font = Enum.Font.GothamBold
Text_8.Text = "Diamond"
Text_8.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_8.TextScaled = true
Text_8.TextSize = 18.000
Text_8.TextWrapped = true
Text_8.TextXAlignment = Enum.TextXAlignment.Left

Text_9.Name = "Text"
Text_9.Parent = CheckBoxes_Text
Text_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_9.BackgroundTransparency = 1.000
Text_9.Position = UDim2.new(0.424999982, 0, 0.64961499, 0)
Text_9.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
Text_9.ZIndex = 3
Text_9.Font = Enum.Font.GothamBold
Text_9.Text = "Rib Cage"
Text_9.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_9.TextScaled = true
Text_9.TextSize = 18.000
Text_9.TextWrapped = true
Text_9.TextXAlignment = Enum.TextXAlignment.Left

Text_10.Name = "Text"
Text_10.Parent = CheckBoxes_Text
Text_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_10.BackgroundTransparency = 1.000
Text_10.Position = UDim2.new(0.725000083, 0, 0.449921429, 0)
Text_10.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
Text_10.ZIndex = 3
Text_10.Font = Enum.Font.GothamBold
Text_10.Text = "Steel Ball"
Text_10.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_10.TextScaled = true
Text_10.TextSize = 18.000
Text_10.TextWrapped = true
Text_10.TextXAlignment = Enum.TextXAlignment.Left

Text_11.Name = "Text"
Text_11.Parent = CheckBoxes_Text
Text_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_11.BackgroundTransparency = 1.000
Text_11.Position = UDim2.new(0.725000083, 0, 0.549768388, 0)
Text_11.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
Text_11.ZIndex = 3
Text_11.Font = Enum.Font.GothamBold
Text_11.Text = "Stone Mask"
Text_11.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_11.TextScaled = true
Text_11.TextSize = 18.000
Text_11.TextWrapped = true
Text_11.TextXAlignment = Enum.TextXAlignment.Left

Text_12.Name = "Text"
Text_12.Parent = CheckBoxes_Text
Text_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_12.BackgroundTransparency = 1.000
Text_12.Position = UDim2.new(0.725000083, 0, 0.64961499, 0)
Text_12.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
Text_12.ZIndex = 3
Text_12.Font = Enum.Font.GothamBold
Text_12.Text = "DEO's Diary"
Text_12.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_12.TextScaled = true
Text_12.TextSize = 18.000
Text_12.TextWrapped = true
Text_12.TextXAlignment = Enum.TextXAlignment.Left

Text_13.Name = "Text"
Text_13.Parent = CheckBoxes_Text
Text_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_13.BackgroundTransparency = 1.000
Text_13.Position = UDim2.new(0.725000083, 0, 0.74946177, 0)
Text_13.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
Text_13.ZIndex = 3
Text_13.Font = Enum.Font.GothamBold
Text_13.Text = "Lucky_Arrow"
Text_13.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_13.TextScaled = true
Text_13.TextSize = 18.000
Text_13.TextWrapped = true
Text_13.TextXAlignment = Enum.TextXAlignment.Left

Text_14.Name = "Text"
Text_14.Parent = CheckBoxes_Text
Text_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_14.BackgroundTransparency = 1.000
Text_14.Position = UDim2.new(0.424999982, 0, 0.74946177, 0)
Text_14.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
Text_14.ZIndex = 3
Text_14.Font = Enum.Font.GothamBold
Text_14.Text = "Headband"
Text_14.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_14.TextScaled = true
Text_14.TextSize = 18.000
Text_14.TextWrapped = true
Text_14.TextXAlignment = Enum.TextXAlignment.Left

Text_15.Name = "Text"
Text_15.Parent = CheckBoxes_Text
Text_15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_15.BackgroundTransparency = 1.000
Text_15.Position = UDim2.new(0.128832042, 0, 0.74946177, 0)
Text_15.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
Text_15.ZIndex = 3
Text_15.Font = Enum.Font.GothamBold
Text_15.Text = "Pure Roka."
Text_15.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_15.TextScaled = true
Text_15.TextSize = 18.000
Text_15.TextWrapped = true
Text_15.TextXAlignment = Enum.TextXAlignment.Left

Other.Name = "Other"
Other.Parent = ItemsTab

Roundify_7.Name = "Roundify"
Roundify_7.Parent = Other
Roundify_7.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_7.BackgroundTransparency = 1.000
Roundify_7.Position = UDim2.new(0.5, 0, 0.214511603, 0)
Roundify_7.Size = UDim2.new(0.941604972, 0, 0.354140997, 0)
Roundify_7.Image = "rbxassetid://3570695787"
Roundify_7.ImageColor3 = Color3.fromRGB(43, 43, 43)
Roundify_7.ScaleType = Enum.ScaleType.Slice
Roundify_7.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_7.SliceScale = 0.120

Roundify_8.Name = "Roundify"
Roundify_8.Parent = Other
Roundify_8.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_8.BackgroundTransparency = 1.000
Roundify_8.Position = UDim2.new(0.5, 0, 0.637441158, 0)
Roundify_8.Size = UDim2.new(0.941604972, 0, 0.429023296, 0)
Roundify_8.Image = "rbxassetid://3570695787"
Roundify_8.ImageColor3 = Color3.fromRGB(43, 43, 43)
Roundify_8.ScaleType = Enum.ScaleType.Slice
Roundify_8.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_8.SliceScale = 0.120

CombatTab.Name = "CombatTab"
CombatTab.Parent = Tabs
CombatTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CombatTab.BackgroundTransparency = 1.000
CombatTab.Position = UDim2.new(0, 0, 0.174980864, 0)
CombatTab.Size = UDim2.new(1, 0, 0.825019062, 0)
CombatTab.Image = "rbxassetid://3570695787"
CombatTab.ImageColor3 = Color3.fromRGB(77, 77, 77)
CombatTab.ScaleType = Enum.ScaleType.Slice
CombatTab.SliceCenter = Rect.new(100, 100, 100, 100)
CombatTab.SliceScale = 0.120

TextLabels_2.Name = "TextLabels"
TextLabels_2.Parent = CombatTab

Text_16.Name = "Text"
Text_16.Parent = TextLabels_2
Text_16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_16.BackgroundTransparency = 1.000
Text_16.Position = UDim2.new(0.244524837, 0, 0.282944143, 0)
Text_16.Size = UDim2.new(0.442697614, 0, 0.085651733, 0)
Text_16.ZIndex = 3
Text_16.Font = Enum.Font.GothamBold
Text_16.Text = "Flight"
Text_16.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_16.TextSize = 18.000
Text_16.TextXAlignment = Enum.TextXAlignment.Left

Text_17.Name = "Text"
Text_17.Parent = TextLabels_2
Text_17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_17.BackgroundTransparency = 1.000
Text_17.Position = UDim2.new(0.244524837, 0, 0.168972045, 0)
Text_17.Size = UDim2.new(0.442697614, 0, 0.085651733, 0)
Text_17.ZIndex = 3
Text_17.Font = Enum.Font.GothamBold
Text_17.Text = "Super Jump"
Text_17.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_17.TextSize = 18.000
Text_17.TextXAlignment = Enum.TextXAlignment.Left

Text_18.Name = "Text"
Text_18.Parent = TextLabels_2
Text_18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_18.BackgroundTransparency = 1.000
Text_18.Position = UDim2.new(0.244524837, 0, 0.0549999513, 0)
Text_18.Size = UDim2.new(0.442697614, 0, 0.085651733, 0)
Text_18.ZIndex = 3
Text_18.Font = Enum.Font.GothamBold
Text_18.Text = "Super Speed"
Text_18.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_18.TextSize = 18.000
Text_18.TextXAlignment = Enum.TextXAlignment.Left

Text_19.Name = "Text"
Text_19.Parent = TextLabels_2
Text_19.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_19.BackgroundTransparency = 1.000
Text_19.Position = UDim2.new(0.244524837, 0, 0.545850933, 0)
Text_19.Size = UDim2.new(0.442697614, 0, 0.0844864547, 0)
Text_19.ZIndex = 3
Text_19.Font = Enum.Font.GothamBold
Text_19.Text = "Target Player"
Text_19.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_19.TextSize = 18.000
Text_19.TextXAlignment = Enum.TextXAlignment.Left

Text_20.Name = "Text"
Text_20.Parent = TextLabels_2
Text_20.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_20.BackgroundTransparency = 1.000
Text_20.Position = UDim2.new(0.089635849, 0, 0.648199141, 0)
Text_20.Size = UDim2.new(0.133204013, 0, 0.0906417593, 0)
Text_20.ZIndex = 3
Text_20.Font = Enum.Font.GothamBold
Text_20.Text = "User:"
Text_20.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_20.TextSize = 18.000
Text_20.TextXAlignment = Enum.TextXAlignment.Left

Text_21.Name = "Text"
Text_21.Parent = TextLabels_2
Text_21.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_21.BackgroundTransparency = 1.000
Text_21.Position = UDim2.new(0.244524837, 0, 0.395000011, 0)
Text_21.Size = UDim2.new(0.442697614, 0, 0.085651733, 0)
Text_21.ZIndex = 3
Text_21.Font = Enum.Font.GothamBold
Text_21.Text = "Ctrl + Click = TP"
Text_21.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_21.TextSize = 18.000
Text_21.TextXAlignment = Enum.TextXAlignment.Left

Toggles_2.Name = "Toggles"
Toggles_2.Parent = CombatTab

Toggle_Speed.Name = "Toggle_Speed"
Toggle_Speed.Parent = Toggles_2
Toggle_Speed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Speed.BackgroundTransparency = 1.000
Toggle_Speed.BorderSizePixel = 0
Toggle_Speed.Position = UDim2.new(0.0404379405, 0, 0.054999996, 0)
Toggle_Speed.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
Toggle_Speed.ZIndex = 3
Toggle_Speed.Font = Enum.Font.GothamBold
Toggle_Speed.Text = "OFF"
Toggle_Speed.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_Speed.TextSize = 17.000

Roundify_9.Name = "Roundify"
Roundify_9.Parent = Toggle_Speed
Roundify_9.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_9.BackgroundTransparency = 1.000
Roundify_9.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_9.Size = UDim2.new(1, 0, 1, 0)
Roundify_9.ZIndex = 2
Roundify_9.Image = "rbxassetid://3570695787"
Roundify_9.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_9.ScaleType = Enum.ScaleType.Slice
Roundify_9.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_9.SliceScale = 0.120

Toggle_Jump.Name = "Toggle_Jump"
Toggle_Jump.Parent = Toggles_2
Toggle_Jump.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Jump.BackgroundTransparency = 1.000
Toggle_Jump.BorderSizePixel = 0
Toggle_Jump.Position = UDim2.new(0.0404379405, 0, 0.168972045, 0)
Toggle_Jump.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
Toggle_Jump.ZIndex = 3
Toggle_Jump.Font = Enum.Font.GothamBold
Toggle_Jump.Text = "OFF"
Toggle_Jump.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_Jump.TextSize = 17.000

Roundify_10.Name = "Roundify"
Roundify_10.Parent = Toggle_Jump
Roundify_10.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_10.BackgroundTransparency = 1.000
Roundify_10.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_10.Size = UDim2.new(1, 0, 1, 0)
Roundify_10.ZIndex = 2
Roundify_10.Image = "rbxassetid://3570695787"
Roundify_10.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_10.ScaleType = Enum.ScaleType.Slice
Roundify_10.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_10.SliceScale = 0.120

Toggle_Flight.Name = "Toggle_Flight"
Toggle_Flight.Parent = Toggles_2
Toggle_Flight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Flight.BackgroundTransparency = 1.000
Toggle_Flight.BorderSizePixel = 0
Toggle_Flight.Position = UDim2.new(0.0404379405, 0, 0.282944143, 0)
Toggle_Flight.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
Toggle_Flight.ZIndex = 3
Toggle_Flight.Font = Enum.Font.GothamBold
Toggle_Flight.Text = "OFF"
Toggle_Flight.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_Flight.TextSize = 17.000

Roundify_11.Name = "Roundify"
Roundify_11.Parent = Toggle_Flight
Roundify_11.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_11.BackgroundTransparency = 1.000
Roundify_11.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_11.Size = UDim2.new(1, 0, 1, 0)
Roundify_11.ZIndex = 2
Roundify_11.Image = "rbxassetid://3570695787"
Roundify_11.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_11.ScaleType = Enum.ScaleType.Slice
Roundify_11.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_11.SliceScale = 0.120

Toggle_TargetPlayer.Name = "Toggle_TargetPlayer"
Toggle_TargetPlayer.Parent = Toggles_2
Toggle_TargetPlayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_TargetPlayer.BackgroundTransparency = 1.000
Toggle_TargetPlayer.BorderSizePixel = 0
Toggle_TargetPlayer.Position = UDim2.new(0.0400000848, 0, 0.545850754, 0)
Toggle_TargetPlayer.Size = UDim2.new(0.164963469, 0, 0.0842651352, 0)
Toggle_TargetPlayer.ZIndex = 3
Toggle_TargetPlayer.Font = Enum.Font.GothamBold
Toggle_TargetPlayer.Text = "OFF"
Toggle_TargetPlayer.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_TargetPlayer.TextSize = 17.000

Roundify_12.Name = "Roundify"
Roundify_12.Parent = Toggle_TargetPlayer
Roundify_12.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_12.BackgroundTransparency = 1.000
Roundify_12.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_12.Size = UDim2.new(1, 0, 1, 0)
Roundify_12.ZIndex = 2
Roundify_12.Image = "rbxassetid://3570695787"
Roundify_12.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_12.ScaleType = Enum.ScaleType.Slice
Roundify_12.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_12.SliceScale = 0.120

Toggle_ClickTP.Name = "Toggle_ClickTP"
Toggle_ClickTP.Parent = Toggles_2
Toggle_ClickTP.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_ClickTP.BackgroundTransparency = 1.000
Toggle_ClickTP.BorderSizePixel = 0
Toggle_ClickTP.Position = UDim2.new(0.0404379405, 0, 0.395000011, 0)
Toggle_ClickTP.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
Toggle_ClickTP.ZIndex = 3
Toggle_ClickTP.Font = Enum.Font.GothamBold
Toggle_ClickTP.Text = "OFF"
Toggle_ClickTP.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_ClickTP.TextSize = 17.000

Roundify_13.Name = "Roundify"
Roundify_13.Parent = Toggle_ClickTP
Roundify_13.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_13.BackgroundTransparency = 1.000
Roundify_13.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_13.Size = UDim2.new(1, 0, 1, 0)
Roundify_13.ZIndex = 2
Roundify_13.Image = "rbxassetid://3570695787"
Roundify_13.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_13.ScaleType = Enum.ScaleType.Slice
Roundify_13.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_13.SliceScale = 0.120

ValueInputs.Name = "ValueInputs"
ValueInputs.Parent = CombatTab

Input_TargetPlayer.Name = "Input_TargetPlayer"
Input_TargetPlayer.Parent = ValueInputs
Input_TargetPlayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Input_TargetPlayer.BackgroundTransparency = 1.000
Input_TargetPlayer.BorderSizePixel = 0
Input_TargetPlayer.Position = UDim2.new(0.235759526, 0, 0.654354274, 0)
Input_TargetPlayer.Size = UDim2.new(0.716833174, 0, 0.0838435888, 0)
Input_TargetPlayer.ZIndex = 3
Input_TargetPlayer.Font = Enum.Font.GothamBold
Input_TargetPlayer.PlaceholderText = "[username]"
Input_TargetPlayer.Text = ""
Input_TargetPlayer.TextColor3 = Color3.fromRGB(198, 198, 198)
Input_TargetPlayer.TextSize = 18.000

Roundify_14.Name = "Roundify"
Roundify_14.Parent = Input_TargetPlayer
Roundify_14.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_14.BackgroundTransparency = 1.000
Roundify_14.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_14.Size = UDim2.new(1, 0, 1, 0)
Roundify_14.ZIndex = 2
Roundify_14.Image = "rbxassetid://3570695787"
Roundify_14.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_14.ScaleType = Enum.ScaleType.Slice
Roundify_14.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_14.SliceScale = 0.120

Other_2.Name = "Other"
Other_2.Parent = CombatTab

Roundify_15.Name = "Roundify"
Roundify_15.Parent = Other_2
Roundify_15.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_15.BackgroundTransparency = 1.000
Roundify_15.Position = UDim2.new(0.5, 0, 0.267553151, 0)
Roundify_15.Size = UDim2.new(0.941604972, 0, 0.460224122, 0)
Roundify_15.Image = "rbxassetid://3570695787"
Roundify_15.ImageColor3 = Color3.fromRGB(43, 43, 43)
Roundify_15.ScaleType = Enum.ScaleType.Slice
Roundify_15.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_15.SliceScale = 0.120

Roundify_16.Name = "Roundify"
Roundify_16.Parent = Other_2
Roundify_16.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_16.BackgroundTransparency = 1.000
Roundify_16.Position = UDim2.new(0.5, 0, 0.642121315, 0)
Roundify_16.Size = UDim2.new(0.941604972, 0, 0.226217225, 0)
Roundify_16.Image = "rbxassetid://3570695787"
Roundify_16.ImageColor3 = Color3.fromRGB(43, 43, 43)
Roundify_16.ScaleType = Enum.ScaleType.Slice
Roundify_16.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_16.SliceScale = 0.120

ExtrasTab.Name = "ExtrasTab"
ExtrasTab.Parent = Tabs
ExtrasTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ExtrasTab.BackgroundTransparency = 1.000
ExtrasTab.Position = UDim2.new(0, 0, 0.174980864, 0)
ExtrasTab.Size = UDim2.new(1, 0, 0.825019062, 0)
ExtrasTab.Visible = false
ExtrasTab.Image = "rbxassetid://3570695787"
ExtrasTab.ImageColor3 = Color3.fromRGB(77, 77, 77)
ExtrasTab.ScaleType = Enum.ScaleType.Slice
ExtrasTab.SliceCenter = Rect.new(100, 100, 100, 100)
ExtrasTab.SliceScale = 0.120

TextLabels_3.Name = "TextLabels"
TextLabels_3.Parent = ExtrasTab

Text_22.Name = "Text"
Text_22.Parent = TextLabels_3
Text_22.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text_22.BackgroundTransparency = 1.000
Text_22.Position = UDim2.new(0.300000101, 0, 0.0549999513, 0)
Text_22.Size = UDim2.new(0.649999976, 0, 0.085651733, 0)
Text_22.ZIndex = 3
Text_22.Font = Enum.Font.GothamBold
Text_22.Text = "Player Health Bars"
Text_22.TextColor3 = Color3.fromRGB(209, 209, 209)
Text_22.TextSize = 18.000
Text_22.TextXAlignment = Enum.TextXAlignment.Left

Toggles_3.Name = "Toggles"
Toggles_3.Parent = ExtrasTab

Toggle_PlayerHealthBars.Name = "Toggle_PlayerHealthBars"
Toggle_PlayerHealthBars.Parent = Toggles_3
Toggle_PlayerHealthBars.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_PlayerHealthBars.BackgroundTransparency = 1.000
Toggle_PlayerHealthBars.BorderSizePixel = 0
Toggle_PlayerHealthBars.Position = UDim2.new(0.0404379405, 0, 0.054999996, 0)
Toggle_PlayerHealthBars.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
Toggle_PlayerHealthBars.ZIndex = 3
Toggle_PlayerHealthBars.Font = Enum.Font.GothamBold
Toggle_PlayerHealthBars.Text = "OFF"
Toggle_PlayerHealthBars.TextColor3 = Color3.fromRGB(216, 34, 128)
Toggle_PlayerHealthBars.TextSize = 17.000

Roundify_17.Name = "Roundify"
Roundify_17.Parent = Toggle_PlayerHealthBars
Roundify_17.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_17.BackgroundTransparency = 1.000
Roundify_17.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_17.Size = UDim2.new(1, 0, 1, 0)
Roundify_17.ZIndex = 2
Roundify_17.Image = "rbxassetid://3570695787"
Roundify_17.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_17.ScaleType = Enum.ScaleType.Slice
Roundify_17.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_17.SliceScale = 0.120

Other_3.Name = "Other"
Other_3.Parent = ExtrasTab

Roundify_18.Name = "Roundify"
Roundify_18.Parent = Other_3
Roundify_18.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_18.BackgroundTransparency = 1.000
Roundify_18.Position = UDim2.new(0.5, 0, 0.100628249, 0)
Roundify_18.Size = UDim2.new(0.941604972, 0, 0.126374319, 0)
Roundify_18.Image = "rbxassetid://3570695787"
Roundify_18.ImageColor3 = Color3.fromRGB(43, 43, 43)
Roundify_18.ScaleType = Enum.ScaleType.Slice
Roundify_18.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_18.SliceScale = 0.120

TopBar.Name = "TopBar"
TopBar.Parent = Frame

Frame_2.Parent = TopBar
Frame_2.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0, 0, 0.0721408725, 0)
Frame_2.Size = UDim2.new(1, 0, 0.00795470085, 0)
Frame_2.ZIndex = 3

Frame_3.Parent = TopBar
Frame_3.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
Frame_3.BorderSizePixel = 0
Frame_3.Position = UDim2.new(0, 0, 0.0397740342, 0)
Frame_3.Size = UDim2.new(1, 0, 0.0403215587, 0)
Frame_3.ZIndex = 2

Frame_4.Name = "Frame"
Frame_4.Parent = TopBar
Frame_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_4.BackgroundTransparency = 1.000
Frame_4.Size = UDim2.new(1, 0, 0.0721408576, 0)
Frame_4.ZIndex = 2
Frame_4.Image = "rbxassetid://3570695787"
Frame_4.ImageColor3 = Color3.fromRGB(77, 77, 77)
Frame_4.ScaleType = Enum.ScaleType.Slice
Frame_4.SliceCenter = Rect.new(100, 100, 100, 100)
Frame_4.SliceScale = 0.120

Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Size = UDim2.new(1, 0, 0.0734477267, 0)
Title.ZIndex = 3
Title.Font = Enum.Font.GothamBold
Title.Text = UI_Name
Title.TextColor3 = Color3.fromRGB(209, 209, 209)
Title.TextSize = 26.000

Frame_5.Name = "Frame"
Frame_5.Parent = Frame
Frame_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_5.BackgroundTransparency = 1.000
Frame_5.Size = UDim2.new(1, 0, 1, 0)
Frame_5.ZIndex = 0
Frame_5.Image = "rbxassetid://3570695787"
Frame_5.ImageColor3 = Color3.fromRGB(97, 97, 97)
Frame_5.ScaleType = Enum.ScaleType.Slice
Frame_5.SliceCenter = Rect.new(100, 100, 100, 100)
Frame_5.SliceScale = 0.120

BorderBG.Name = "BorderBG"
BorderBG.Parent = Frame
BorderBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BorderBG.BackgroundTransparency = 1.000
BorderBG.Position = UDim2.new(-0.00999999978, 0, -0.00999999978, 0)
BorderBG.Size = UDim2.new(1.01999998, 0, 1.01999998, 0)
BorderBG.ZIndex = -1
BorderBG.Image = "rbxassetid://3570695787"
BorderBG.ImageColor3 = Color3.fromRGB(216, 34, 128)
BorderBG.ScaleType = Enum.ScaleType.Slice
BorderBG.SliceCenter = Rect.new(100, 100, 100, 100)
BorderBG.SliceScale = 0.120








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
NotificationsList.BackgroundTransparency = 1.000
NotificationsList.Position = UDim2.new(0.846829891, 0, 0.191411048, 0)
NotificationsList.Size = UDim2.new(0, 236, 0, 553)

UIListLayout.Parent = NotificationsList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
UIListLayout.Padding = UDim.new(0.00999999978, 0)


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
NotificationFrame.BackgroundTransparency = 1.000
NotificationFrame.Size = UDim2.new(0.999999762, 0, 0.149782985, 0)
NotificationFrame.Image = "rbxassetid://3570695787"
NotificationFrame.ImageColor3 = Color3.fromRGB(67, 67, 67)
NotificationFrame.ImageTransparency = 0.200
NotificationFrame.ScaleType = Enum.ScaleType.Slice
NotificationFrame.SliceCenter = Rect.new(100, 100, 100, 100)
NotificationFrame.SliceScale = 0.120

Button1.Name = "Button1"
Button1.Parent = NotificationFrame
Button1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Button1.BackgroundTransparency = 1.000
Button1.BorderSizePixel = 0
Button1.Position = UDim2.new(0.0149999997, 0, 0.6875, 0)
Button1.Size = UDim2.new(0.479999989, 0, 0.280000001, 0)
Button1.ZIndex = 2
Button1.Font = Enum.Font.GothamBold
Button1.TextColor3 = Color3.fromRGB(235, 235, 235)
Button1.TextSize = 14.000

Roundify.Name = "Roundify"
Roundify.Parent = Button1
Roundify.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify.BackgroundTransparency = 1.000
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
Title.BackgroundTransparency = 1.000
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.192139745, 0, 0.0500000007, 0)
Title.Size = UDim2.new(0.600000024, 0, 0.25, 0)
Title.ZIndex = 2
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(232, 232, 232)
Title.TextScaled = true
Title.TextSize = 14.000
Title.TextWrapped = true

Roundify_2.Name = "Roundify"
Roundify_2.Parent = Title
Roundify_2.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_2.BackgroundTransparency = 1.000
Roundify_2.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_2.Size = UDim2.new(1, 0, 1, 0)
Roundify_2.Image = "rbxassetid://3570695787"
Roundify_2.ImageColor3 = Color3.fromRGB(121, 121, 121)
Roundify_2.ImageTransparency = 0.500
Roundify_2.ScaleType = Enum.ScaleType.Slice
Roundify_2.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_2.SliceScale = 0.120

Text.Name = "Text"
Text.Parent = NotificationFrame
Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Text.BackgroundTransparency = 1.000
Text.BorderSizePixel = 0
Text.Position = UDim2.new(0.113537118, 0, 0.349999994, 0)
Text.Size = UDim2.new(0.779999971, 0, 0.300000012, 0)
Text.ZIndex = 2
Text.Font = Enum.Font.GothamBold
Text.TextColor3 = Color3.fromRGB(232, 232, 232)
Text.TextScaled = true
Text.TextSize = 14.000
Text.TextWrapped = true

Roundify_3.Name = "Roundify"
Roundify_3.Parent = Text
Roundify_3.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_3.BackgroundTransparency = 1.000
Roundify_3.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_3.Size = UDim2.new(1, 0, 1, 0)
Roundify_3.Image = "rbxassetid://3570695787"
Roundify_3.ImageColor3 = Color3.fromRGB(121, 121, 121)
Roundify_3.ImageTransparency = 0.500
Roundify_3.ScaleType = Enum.ScaleType.Slice
Roundify_3.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_3.SliceScale = 0.120

Button2.Name = "Button2"
Button2.Parent = NotificationFrame
Button2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Button2.BackgroundTransparency = 1.000
Button2.BorderSizePixel = 0
Button2.Position = UDim2.new(0.509000003, 0, 0.6875, 0)
Button2.Size = UDim2.new(0.479999989, 0, 0.280000001, 0)
Button2.ZIndex = 2
Button2.Font = Enum.Font.GothamBold
Button2.TextColor3 = Color3.fromRGB(235, 235, 235)
Button2.TextSize = 14.000

Roundify_4.Name = "Roundify"
Roundify_4.Parent = Button2
Roundify_4.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_4.BackgroundTransparency = 1.000
Roundify_4.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_4.Size = UDim2.new(1, 0, 1, 0)
Roundify_4.Image = "rbxassetid://3570695787"
Roundify_4.ImageColor3 = Color3.fromRGB(102, 102, 102)
Roundify_4.ImageTransparency = 0.500
Roundify_4.ScaleType = Enum.ScaleType.Slice
Roundify_4.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_4.SliceScale = 0.120

-- Popup Effect:
-- Instances:

local PopupEffect = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local UICorner = Instance.new("UICorner")

--Properties:

PopupEffect.Name = "PopupEffect"
PopupEffect.Parent = NotificationFrame
PopupEffect.BackgroundTransparency = 1
PopupEffect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PopupEffect.BorderSizePixel = 0
PopupEffect.Position = UDim2.new(.5, 0, .5, 0)
PopupEffect.Size = UDim2.new(0, 0, 0, 0)
PopupEffect.ZIndex = 0
PopupEffect.AnchorPoint = Vector2.new(.5, .5)

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(17, 192, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(17, 192, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(17, 192, 255))}
UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.40, 0.76), NumberSequenceKeypoint.new(0.50, 0.66), NumberSequenceKeypoint.new(0.60, 0.76), NumberSequenceKeypoint.new(1.00, 1.00)}
UIGradient.Parent = PopupEffect

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = PopupEffect


-- CONSTRUCTORS / FUNCTION FOR NOTIFICATION:
local function sendNotification(settings)
    local newNotification = NotificationFrame:Clone()
    newNotification.Parent = NotificationsList

    newNotification.Title.Text = settings.Title
    newNotification["Text"].Text = settings.Text
    newNotification["Text"].TextColor3 = settings.Color
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



-- [[ BYPASSES ]] --

-- Anti-Teleport bypass:
old = hookmetamethod(game,"__namecall", function(self,...)
    local args = {...}
    local method = getnamecallmethod()
    if tostring(self) == "Returner" and tostring(method) == "InvokeServer" then
        return "  ___XP DE KEY"
    end
    return old(self, ...)
end)

-- Fly bypass:
local old; old = hookmetamethod(game, "__namecall", function(self, ...)
   args = {...}
       if getnamecallmethod() == "FireServer" and self.Name == "RemoteEvent" and args[1] == "UpdateState" and string.match(tostring(args[2]), "PlatformStanding") then
               return print("master wyv has saved you from getting kicked")
           end
       return old(self,...)
    end)


-- WalkSpeed bypass --
velocity = Instance.new("BodyVelocity")
velocity.maxForce = Vector3.new(100000, 0, 100000)
---vv Use that to change the speed v
local speed = superSpeed_speedValue
gyro = Instance.new("BodyGyro")
gyro.maxTorque = Vector3.new(100000, 0, 100000)





--creating ESP template Part / Setup
local ESP_Part = Instance.new("Part")
ESP_Part.Anchored = true
ESP_Part.Size = Vector3.new(1, 1, 1)
ESP_Part.Transparency = 1
ESP_Part.CanCollide = false
mouse.TargetFilter = ESP_Part

--creating billboard gui for item name
local itemName_BillboardGui = Instance.new("BillboardGui", ESP_Part)
itemName_BillboardGui.Name = "itemName_Billboard"
itemName_BillboardGui.Adornee = ESP_Part
itemName_BillboardGui.ExtentsOffset = Vector3.new(0, 2.5, 0)
itemName_BillboardGui.Size = UDim2.new(8, 0, 2, 0)
itemName_BillboardGui.AlwaysOnTop = true

local itemName_TextLabel = Instance.new("TextLabel", itemName_BillboardGui)
itemName_TextLabel.Name = "itenName"
itemName_TextLabel.Size = UDim2.new(1, 0, 1, 0)
itemName_TextLabel.TextScaled = true
itemName_TextLabel.BackgroundTransparency = 1
itemName_TextLabel.TextColor3 = Color3.fromRGB(255, 1, 5)
itemName_TextLabel.TextStrokeTransparency = .7


local espPartsFolder_Exists =  game.Workspace:FindFirstChild("ESP_Parts")
if espPartsFolder_Exists then
    espPartsFolder_Exists:Destroy()
end
local ESPParts_Folder = Instance.new("Folder", game.Workspace)
ESPParts_Folder.Name = "ESP_Parts"

local surfaceFrame = Instance.new("Frame")
surfaceFrame.Size = UDim2.new(1, 0, 1, 0)
surfaceFrame.BackgroundColor3 = Color3.fromRGB(255, 1, 5)
surfaceFrame.BackgroundTransparency = .3


local topSurfaceGui = Instance.new("SurfaceGui", ESP_Part)
topSurfaceGui.AlwaysOnTop = true
topSurfaceGui.Face = Enum.NormalId.Top
local topFrame = surfaceFrame:Clone()
topFrame.Parent = topSurfaceGui

local bottomSurfaceGui = Instance.new("SurfaceGui", ESP_Part)
bottomSurfaceGui.AlwaysOnTop = true
bottomSurfaceGui.Face = Enum.NormalId.Bottom
local botFrame = surfaceFrame:Clone()
botFrame.Parent = bottomSurfaceGui

local leftSurfaceGui = Instance.new("SurfaceGui", ESP_Part)
leftSurfaceGui.AlwaysOnTop = true
leftSurfaceGui.Face = Enum.NormalId.Left
local leftFrame = surfaceFrame:Clone()
leftFrame.Parent = leftSurfaceGui

local rightSurfaceGui = Instance.new("SurfaceGui", ESP_Part)
rightSurfaceGui.AlwaysOnTop = true
rightSurfaceGui.Face = Enum.NormalId.Right
local rightFrame = surfaceFrame:Clone()
rightFrame.Parent = rightSurfaceGui

local FrontSurfaceGui = Instance.new("SurfaceGui", ESP_Part)
FrontSurfaceGui.AlwaysOnTop = true
FrontSurfaceGui.Face = Enum.NormalId.Front
local frontFrame = surfaceFrame:Clone()
frontFrame.Parent = FrontSurfaceGui

local BackSurfaceGui = Instance.new("SurfaceGui", ESP_Part)
BackSurfaceGui.AlwaysOnTop = true
BackSurfaceGui.Face = Enum.NormalId.Back
local backFrame = surfaceFrame:Clone()
backFrame.Parent = BackSurfaceGui



-- [[ FUNCTIONS 1 ]] (Item Functions mostly) --

local function guessTheItem(itemModelInstance)
    for i, v in pairs(itemModelInstance:GetChildren()) do
        if v.Name == "MeshPart" then
            if v.MeshId == "rbxassetid://7124126253" then
                return "Gold Coin"
        
            elseif v.MeshId == "rbxassetid://7218405255" then
                return "Rokakaka"
        
            elseif v.MeshId == "rbxassetid://875644059" then
                return "Diamond"
                
            elseif v.MeshId == "rbxassetid://7106059151" then
                return "Myst. Arrow"
                
            elseif v.MeshId == "rbxassetid://5249254947" then
                return "Rib Cage"
                
            elseif v.MeshId == "rbxassetid://6924442799" then
                return "Headband"
                
            elseif v.MeshId == "rbxassetid://7138936196" then
                return "Quin. Glove"
                
            elseif v.MeshId == "rbxassetid://5675185488" then
                return "DEO's Diary"
                
            elseif v.MeshId == "rbxassetid://4551120971" then
                return "Stone Mask"
                
            elseif v.MeshId == "rbxassetid://5291254518" then
                return "Steel Ball"
            end
        elseif v.Name == "Part" then
            if v:FindFirstChild("SpecialMesh") then
                if v.SpecialMesh.MeshId == "60791940" then
                    return "Anc. Scroll"
                end
            end
        end
    end
    return "Unknown"
end


local function refreshItemsESP()
    for i, v in pairs(ESPParts_Folder:GetChildren()) do
        v:Destroy()
    end
    for i, v in pairs(itemsFolder:GetChildren()) do
        if v.PrimaryPart ~= nil then
            local new_ESP_Part = ESP_Part:Clone()
            new_ESP_Part.Name = "ESP_Part"
            new_ESP_Part.Parent = ESPParts_Folder
            new_ESP_Part.CFrame = v:GetPrimaryPartCFrame()
            
            local itemName = guessTheItem(v)
            new_ESP_Part.itemName_Billboard.itenName.Text = itemName
        end
    end
end

local function onItemSpawned(itemInstance)
    if itemInstance.PrimaryPart ~= nil then
        wait(.1)
        local itemName = guessTheItem(itemInstance)
        
        if searchForAllItems == true then
            if toggles.ItemESP == true then
                local new_ESP_Part = ESP_Part:Clone()
                new_ESP_Part.Name = "ESP_Part"
                new_ESP_Part.Parent = ESPParts_Folder
                new_ESP_Part.CFrame = itemInstance.PrimaryPart.CFrame
                new_ESP_Part.itemName_Billboard.itenName.Text = itemName
            end
            
            if toggles.ItemNotifs == true then
                sendNotification({
                    Title = "Item found nearby:";
                    Text = itemName;
                    button1Text = "Teleport";
                    button2Text = "Close";
                    onButton1Click = function()
                        player.Character.HumanoidRootPart.CFrame = itemInstance.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
                    end;
                    onButton2Click = function()
                        script.Parent.Parent:Destroy()
                    end;
                    Duration = 5;
                    Color = itemColors[itemName]
                })
            end
            
            if toggles.ItemAutoFarm == true then
                isPickingUpItem = true
                player.Character.HumanoidRootPart.CFrame = itemInstance.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
                local clickDetector = itemInstance:FindFirstChild("ClickDetector")
                if clickDetector then
                    fireclickdetector(clickDetector, 5)
                end
                isPickingUpItem = false
            end
        else
            if table.find(FilterItems, itemName) then
                if toggles.ItemESP == true then
                    local new_ESP_Part = ESP_Part:Clone()
                    new_ESP_Part.Name = "ESP_Part"
                    new_ESP_Part.Parent = ESPParts_Folder
                    new_ESP_Part.CFrame = itemInstance.PrimaryPart.CFrame
                    new_ESP_Part.itemName_Billboard.itenName.Text = itemName
                end
                
                if toggles.ItemNotifs == true then
                    sendNotification({
                        Title = "Item found nearby:";
                        Text = itemName;
                        button1Text = "Teleport";
                        button2Text = "Close";
                        onButton1Click = function()
                            player.Character.HumanoidRootPart.CFrame = itemInstance.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
                        end;
                        onButton2Click = function()
                            script.Parent:Destroy()
                        end;
                        Duration = 5;
                        Color = itemColors[itemName]
                    })
                end
                
                if toggles.ItemAutoFarm == true then
                    isPickingUpItem = true
                    player.Character.HumanoidRootPart.CFrame = itemInstance.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
                    local clickDetector = itemInstance:FindFirstChild("ClickDetector")
                    if clickDetector then
                        fireclickdetector(clickDetector, 5)
                    end
                    isPickingUpItem = false
                end
            end
        end
    end
end

local function pickupNearbyItems()
    for i, v in pairs(itemsFolder:GetChildren()) do
        if v.PrimaryPart ~= nil and toggles.ItemAutoFarm == true then
            isPickingUpItem = true
            player.Character.HumanoidRootPart.CFrame = v.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
            local clickDetector = v:FindFirstChild("ClickDetector")
            if clickDetector then
                fireclickdetector(clickDetector, 5)
            end
            isPickingUpItem = false
        end
    end
end

local function startAutoFarm()
    local lastPosition = player.Character.HumanoidRootPart.CFrame
    player.Character.HumanoidRootPart.Anchored = true
    while toggles.ItemAutoFarm == true and wait(.1) do
        for i, v in pairs(autoFarmPositionCFrames) do
            if toggles.ItemAutoFarm == true then
                if isPickingUpItem == false then
                    player.Character.HumanoidRootPart.CFrame = v
                end
            else
                break
            end
            wait(2)
        end
    end
    player.Character.HumanoidRootPart.CFrame = lastPosition
    player.Character.HumanoidRootPart.Anchored = false
end

local function clearESP_Parts()
    for i, v in pairs(ESPParts_Folder:GetChildren()) do
        v:Destroy()
    end
end

local function onItemDespawned(itemInstance)
    if toggles.ItemESP == true then
        refreshItemsESP()
    end
end

itemsFolder.ChildAdded:Connect(onItemSpawned)
itemsFolder.ChildRemoved:Connect(onItemDespawned)





-- [[ FUNCTIONS 2 ]] (Combat functions mostly) --

local inputBegan_SuperSpeed = nil
local inputEnded_SuperSpeed = nil

local function toggle_SuperSpeed(boolean)
    if boolean == true then
        inputBegan_SuperSpeed = mouse.KeyDown:Connect(function(key)
            if key:lower()== superSpeed_KeyBind then
                speedOn = true
                velocity.Parent = player.Character.UpperTorso
                velocity.velocity = (player.Character.Humanoid.MoveDirection) * speed
                gyro.Parent = player.Character.UpperTorso
                while speedOn do
                    if not speedOn then break end
                    velocity.velocity = (player.Character.Humanoid.MoveDirection) * speed
                    local refpos = gyro.Parent.Position + (gyro.Parent.Position - workspace.CurrentCamera.CoordinateFrame.p).unit * 5
                    gyro.cframe = CFrame.new(gyro.Parent.Position, Vector3.new(refpos.x, gyro.Parent.Position.y, refpos.z))
                    wait(0.1)
                end
            end
        end)

        inputEnded_SuperSpeed = mouse.KeyUp:Connect(function(key)
            if key:lower()== superSpeed_KeyBind then
                velocity.Parent = nil
                gyro.Parent = nil
                speedOn = false
            end
        end)
        
    else
        inputBegan_SuperSpeed:Disconnect()
        inputEnded_SuperSpeed:Disconnect()
        velocity.Parent = nil
        gyro.Parent = nil
        speedOn = false
    end
end

local function toggle_TargetPlayer(playerName)
    local foundPlayer = nil
    for i, v in pairs(players:GetChildren()) do
        if v.Name == playerName then
            foundPlayer = v
        else
            if v.DisplayName == playerName then
                foundPlayer = v
            end
        end
    end
    
    while foundPlayer and toggles.targetPlayer == true and wait(.1) do
        player.Character.HumanoidRootPart.CFrame = foundPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 0, -3)
        --workspace.Living.zakater.RemoteEvent:FireServer("Attack", "m1")
    end
end



local inputBegan_ClickTP = nil
local inputEnded_ClickTP = nil

local function toggle_ClickTP(boolean)
    local ctrlIsDown = false
    if boolean == true then
        inputBegan_ClickTP = UserInputService.InputBegan:Connect(function(key)
            if key.KeyCode == Enum.KeyCode.LeftControl then
                ctrlIsDown = true
                UserInputService.InputBegan:Connect(function(input, processed)
                    if not processed and input.UserInputType == Enum.UserInputType.MouseButton1 and ctrlIsDown then
                        local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
                        pos = CFrame.new(pos.X,pos.Y,pos.Z)
                        player.Character.HumanoidRootPart.CFrame = pos
                    end
                end)
            end
        end)

        inputEnded_ClickTP = UserInputService.InputEnded:Connect(function(key)
            if key.KeyCode == Enum.KeyCode.LeftControl then
                ctrlIsDown = false
            end
        end)
    else
        inputBegan_ClickTP:Disconnect()
        inputEnded_ClickTP:Disconnect()
        ctrlIsDown = false
    end
end




-- FLIGHT FUNCTIONS / LISTENERS --
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local lastctrl = {f = 0, b = 0, l = 0, r = 0}

function Fly()
    local camera = game.Workspace.CurrentCamera
    local torso = player.Character.HumanoidRootPart
    local bg = Instance.new("BodyGyro", torso)
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = torso.CFrame
    local bv = Instance.new("BodyVelocity", torso)
    bv.velocity = Vector3.new(0, .1, 0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)

    if flightSpeed > max_flightSpeed then
        flightSpeed = max_flightSpeed
    end
    
    if flightSpeed < 0 then
        flightSpeed = 25
    end

    local speed = flightSpeed

    repeat wait()
        player.Character.Humanoid.PlatformStand = true
        if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
            --speed = speed + .5 + (speed / max_flightSpeed)
            speed = flightSpeed
        elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
            --speed = speed-1
            speed = 0
        end
        if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
            bv.velocity = ((camera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) + ((camera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r, (ctrl.f + ctrl.b) * .2, 0).p) - camera.CoordinateFrame.p)) * speed
            lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
        elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
            bv.velocity = ((camera.CoordinateFrame.lookVector * (lastctrl.f + lastctrl.b)) + ((camera.CoordinateFrame * CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f+lastctrl.b) * .2, 0).p) - camera.CoordinateFrame.p)) * speed
        else
            bv.velocity = Vector3.new(0, .1, 0)
        end
        bg.cframe = camera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * speed / max_flightSpeed), 0, 0)
    until not toggles.isFlying
    
    ctrl = {f = 0, b = 0, l = 0, r = 0}
    lastctrl = {f = 0, b = 0, l = 0, r = 0}
    --speed = 0
    bg:Destroy()
    bv:Destroy()
    player.Character.Humanoid.PlatformStand = false
end

mouse.KeyDown:connect(function(key)
    if key:lower() == fly_KeyBind then
        if toggles.isFlying then
            toggles.isFlying = false
        else
            toggles.isFlying = true
            Fly()
        end
    elseif key:lower() == "w" then
        ctrl.f = 1
    elseif key:lower() == "s" then
        ctrl.b = -1
    elseif key:lower() == "a" then
        ctrl.l = -1
    elseif key:lower() == "d" then
        ctrl.r = 1
    end
end)

mouse.KeyUp:connect(function(key)
    if key:lower() == "w" then
        ctrl.f = 0
    elseif key:lower() == "s" then
        ctrl.b = 0
    elseif key:lower() == "a" then
        ctrl.l = 0
    elseif key:lower() == "d" then
        ctrl.r = 0
    end
end)






-- [[ FUNCTIONS 3 ]] (Extras functions mostly) --

local function toggle_PlayerHealthBars(boolean)
    for i, v in pairs(players:GetChildren()) do
        if v.Character then
            local playerHumanoid = v.Character:FindFirstChildWhichIsA("Humanoid")
            if playerHumanoid then
                if boolean then
                    playerHumanoid.HumanoidHealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOn
                    playerHumanoid.HealthDisplayDistance = 200
                    playerHumanoid.NameOcclusion = Enum.NameOcclusion.NoOcclusion
                else
                    playerHumanoid.HumanoidHealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
                    playerHumanoid.HealthDisplayDistance = 45
                    playerHumanoid.NameOcclusion = Enum.NameOcclusion.OccludeAll
                end
            end
        end
    end
end









-- [[ UI LOGIC ]] --
Toggle_ItemESP.MouseButton1Click:Connect(function()
    if toggles.ItemESP == false then
        toggles.ItemESP = true
        Toggle_ItemESP.Text = "ON"
        Toggle_ItemESP.TextColor3 = Color3.fromRGB(58, 216, 137)
        refreshItemsESP()
    else
        toggles.ItemESP = false
        Toggle_ItemESP.Text = "OFF"
        Toggle_ItemESP.TextColor3 = Color3.fromRGB(216, 34, 128)
        clearESP_Parts()
    end
end)

Toggle_ItemAutoFarm.MouseButton1Click:Connect(function()
    if toggles.ItemAutoFarm == false then
        toggles.ItemAutoFarm = true
        Toggle_ItemAutoFarm.Text = "ON"
        Toggle_ItemAutoFarm.TextColor3 = Color3.fromRGB(58, 216, 137)
        pickupNearbyItems()
        --startAutoFarm()
    else
        toggles.ItemAutoFarm = false
        Toggle_ItemAutoFarm.Text = "OFF"
        Toggle_ItemAutoFarm.TextColor3 = Color3.fromRGB(216, 34, 128)
    end
end)

Toggle_ItemNotifs.MouseButton1Click:Connect(function()
    if toggles.ItemNotifs == false then
        toggles.ItemNotifs = true
        Toggle_ItemNotifs.Text = "ON"
        Toggle_ItemNotifs.TextColor3 = Color3.fromRGB(58, 216, 137)
    else
        toggles.ItemNotifs = false
        Toggle_ItemNotifs.Text = "OFF"
        Toggle_ItemNotifs.TextColor3 = Color3.fromRGB(216, 34, 128)
    end
end)



Toggle_All.MouseButton1Click:Connect(function()
    if Toggle_All.Text == "" then
        Toggle_All.Text = "X"
        searchForAllItems = true
    else
        Toggle_All.Text = ""
        searchForAllItems = false
    end
end)

Toggle_Arrows.MouseButton1Click:Connect(function()
    if Toggle_Arrows.Text == "" then
        Toggle_Arrows.Text = "X"
        table.insert(FilterItems, "Myst. Arrow")
    else
        Toggle_Arrows.Text = ""
        table.remove("Myst. Arrow")
    end
end)

Toggle_Coins.MouseButton1Click:Connect(function()
    if Toggle_Coins.Text == "" then
        Toggle_Coins.Text = "X"
        table.insert(FilterItems, "Gold Coin")
    else
        Toggle_Coins.Text = ""
        table.remove("Gold Coin")
    end
end)

Toggle_Diamond.MouseButton1Click:Connect(function()
    if Toggle_Diamond.Text == "" then
        Toggle_Diamond.Text = "X"
        table.insert(FilterItems, "Diamond")
    else
        Toggle_Diamond.Text = ""
        table.remove("Diamond")
    end
end)

Toggle_Rokakaka.MouseButton1Click:Connect(function()
    if Toggle_Rokakaka.Text == "" then
        Toggle_Rokakaka.Text = "X"
        table.insert(FilterItems, "Rokakaka")
    else
        Toggle_Rokakaka.Text = ""
        table.remove("Rokakaka")
    end
end)

Toggle_RibCage.MouseButton1Click:Connect(function()
    if Toggle_RibCage.Text == "" then
        Toggle_RibCage.Text = "X"
        table.insert(FilterItems, "Rib Cage")
    else
        Toggle_RibCage.Text = ""
        table.remove("Rib Cage")
    end
end)

Toggle_DEOsDiary.MouseButton1Click:Connect(function()
    if Toggle_DEOsDiary.Text == "" then
        Toggle_DEOsDiary.Text = "X"
        table.insert(FilterItems, "DEO's Diary")
    else
        Toggle_DEOsDiary.Text = ""
        table.remove("DEO's Diary")
    end
end)

Toggle_SteelBall.MouseButton1Click:Connect(function()
    if Toggle_SteelBall.Text == "" then
        Toggle_SteelBall.Text = "X"
        table.insert(FilterItems, "Steel Ball")
    else
        Toggle_SteelBall.Text = ""
        table.remove("Steel Ball")
    end
end)

Toggle_StoneMask.MouseButton1Click:Connect(function()
    if Toggle_StoneMask.Text == "" then
        Toggle_StoneMask.Text = "X"
        table.insert(FilterItems, "Stone Mask")
    else
        Toggle_StoneMask.Text = ""
        table.remove("Stone Mask")
    end
end)

Toggle_PureRokakaka.MouseButton1Click:Connect(function()
    if Toggle_PureRokakaka.Text == "" then
        Toggle_PureRokakaka.Text = "X"
        table.insert(FilterItems, "Pure Roka.")
    else
        Toggle_PureRokakaka.Text = ""
        table.remove("Pure Roka.")
    end
end)

Toggle_Headband.MouseButton1Click:Connect(function()
    if Toggle_Headband.Text == "" then
        Toggle_Headband.Text = "X"
        table.insert(FilterItems, "Headband")
    else
        Toggle_Headband.Text = ""
        table.remove("Headband")
    end
end)

Toggle_LuckyArrow.MouseButton1Click:Connect(function()
    if Toggle_LuckyArrow.Text == "" then
        Toggle_LuckyArrow.Text = "X"
        table.insert(FilterItems, "Lucky Arrow")
    else
        Toggle_LuckyArrow.Text = ""
        table.remove("Lucky Arrow")
    end
end)



-- Combat tab listeners --
Toggle_Speed.MouseButton1Click:Connect(function()
    if toggles.superSpeed == false then
        toggles.superSpeed = true
        Toggle_Speed.Text = "ON"
        Toggle_Speed.TextColor3 = Color3.fromRGB(58, 216, 137)
        toggle_SuperSpeed(true)
    else
        toggles.superSpeed = false
        Toggle_Speed.Text = "OFF"
        Toggle_Speed.TextColor3 = Color3.fromRGB(216, 34, 128)
        toggle_SuperSpeed(false)
    end
end)

Toggle_Jump.MouseButton1Click:Connect(function()
    if toggles.jump == false then
        toggles.jump = true
        Toggle_Jump.Text = "ON"
        Toggle_Jump.TextColor3 = Color3.fromRGB(58, 216, 137)
    else
        toggles.jump = false
        Toggle_Jump.Text = "OFF"
        Toggle_Jump.TextColor3 = Color3.fromRGB(216, 34, 128)
    end
end)

Toggle_Flight.MouseButton1Click:Connect(function()
    if toggles.isFlying == false then
        toggles.isFlying = true
        Toggle_Flight.Text = "ON"
        Toggle_Flight.TextColor3 = Color3.fromRGB(58, 216, 137)
        Fly()
    else
        toggles.isFlying = false
        Toggle_Flight.Text = "OFF"
        Toggle_Flight.TextColor3 = Color3.fromRGB(216, 34, 128)
    end
end)

Toggle_ClickTP.MouseButton1Click:Connect(function()
    if toggles.ClickTP == false then
        toggles.ClickTP = true
        Toggle_ClickTP.Text = "ON"
        Toggle_ClickTP.TextColor3 = Color3.fromRGB(58, 216, 137)
        toggle_ClickTP(true)
    else
        toggles.ClickTP = false
        Toggle_ClickTP.Text = "OFF"
        Toggle_ClickTP.TextColor3 = Color3.fromRGB(216, 34, 128)
        toggle_ClickTP(false)
    end
end)

Toggle_TargetPlayer.MouseButton1Click:Connect(function()
    if toggles.targetPlayer == false then
        toggles.targetPlayer = true
        Toggle_TargetPlayer.Text = "ON"
        Toggle_TargetPlayer.TextColor3 = Color3.fromRGB(58, 216, 137)
        toggle_TargetPlayer(Input_TargetPlayer.Text)
    else
        toggles.targetPlayer = false
        Toggle_TargetPlayer.Text = "OFF"
        Toggle_TargetPlayer.TextColor3 = Color3.fromRGB(216, 34, 128)
    end
end)



-- Extras tab listeners --
Toggle_PlayerHealthBars.MouseButton1Click:Connect(function()
    if toggles.playerHealthBars == false then
        toggles.playerHealthBars = true
        Toggle_PlayerHealthBars.Text = "ON"
        Toggle_PlayerHealthBars.TextColor3 = Color3.fromRGB(58, 216, 137)
        toggle_PlayerHealthBars(true)
    else
        toggles.playerHealthBars = false
        Toggle_PlayerHealthBars.Text = "OFF"
        Toggle_PlayerHealthBars.TextColor3 = Color3.fromRGB(216, 34, 128)
        toggle_PlayerHealthBars(false)
    end
end)



-- Pages --
Combat.MouseButton1Click:Connect(function()
    CombatTab.Visible = true
    ItemsTab.Visible = false
    ExtrasTab.Visible = false
end)

Items.MouseButton1Click:Connect(function()
    ItemsTab.Visible = true
    CombatTab.Visible = false
    ExtrasTab.Visible = false
end)

Extras.MouseButton1Click:Connect(function()
    ExtrasTab.Visible = true
    ItemsTab.Visible = false
    CombatTab.Visible = false
end)



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
local FrameDrag = DraggableObject.new(Frame)
FrameDrag:Enable() --Enable the dragging

--------------------------------------------------------------------------------------------------------------------------------------





