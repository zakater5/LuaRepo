
-- YBA item ESP --


-- config
local UI_Name = "Bitch Boy v1"
local superSpeed_speedValue = 150 --temporary
local max_superSpeed_speedValue = 300
local superJump_jumpValue = 200
local max_superJump_jumpValue = 500
local superSpeed_KeyBind = "v" --temporary
local fly_KeyBind = "e" --temporary
local max_flightSpeed = 200
local flightSpeed = 75
local close_open_GUI_kb = Enum.KeyCode.RightShift

-- services
local players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local RS = game:GetService("RunService")

-- vars
local player = players.LocalPlayer
local itemsFolder = game.Workspace.Item_Spawns.Items
local mouse = player:GetMouse()
local Debris = game:GetService("Debris")

local speedOn = false
local afkSpot = CFrame.new(1283, 1150, -38)

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
    AttachStand = false,
    StandTarget = false,
    
    --NPCs
    NPCFarm = false,
    QuestFarm = false,
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

-- Gui to Lua
-- Version: 3.2

-- Instances:

local YBA = {
	YBA = Instance.new("ScreenGui"),
	Frame = Instance.new("Frame"),
	TabButtons = Instance.new("Folder"),
	Extras = Instance.new("TextButton"),
	Roundify = Instance.new("ImageLabel"),
	Combat = Instance.new("TextButton"),
	Roundify_2 = Instance.new("ImageLabel"),
	Items = Instance.new("TextButton"),
	Roundify_3 = Instance.new("ImageLabel"),
	NPCs = Instance.new("TextButton"),
	Roundify_4 = Instance.new("ImageLabel"),
	Tabs = Instance.new("Folder"),
	ItemsTab = Instance.new("ImageLabel"),
	Toggles = Instance.new("Folder"),
	Toggle_ItemESP = Instance.new("TextButton"),
	Roundify_5 = Instance.new("ImageLabel"),
	Toggle_ItemNotifs = Instance.new("TextButton"),
	Roundify_6 = Instance.new("ImageLabel"),
	Toggle_ItemAutoFarm = Instance.new("TextButton"),
	Roundify_7 = Instance.new("ImageLabel"),
	TextLabels = Instance.new("Folder"),
	Text = Instance.new("TextLabel"),
	Text_2 = Instance.new("TextLabel"),
	Text_3 = Instance.new("TextLabel"),
	CheckBoxes = Instance.new("Folder"),
	Toggle_Rokakaka = Instance.new("TextButton"),
	BG = Instance.new("ImageLabel"),
	Toggle_Arrows = Instance.new("TextButton"),
	BG_2 = Instance.new("ImageLabel"),
	Toggle_Coins = Instance.new("TextButton"),
	BG_3 = Instance.new("ImageLabel"),
	Toggle_Diamond = Instance.new("TextButton"),
	BG_4 = Instance.new("ImageLabel"),
	Toggle_RibCage = Instance.new("TextButton"),
	BG_5 = Instance.new("ImageLabel"),
	Toggle_All = Instance.new("TextButton"),
	BG_6 = Instance.new("ImageLabel"),
	Toggle_DEOsDiary = Instance.new("TextButton"),
	BG_7 = Instance.new("ImageLabel"),
	Toggle_StoneMask = Instance.new("TextButton"),
	BG_8 = Instance.new("ImageLabel"),
	Toggle_SteelBall = Instance.new("TextButton"),
	BG_9 = Instance.new("ImageLabel"),
	Toggle_Headband = Instance.new("TextButton"),
	BG_10 = Instance.new("ImageLabel"),
	Toggle_LuckyArrow = Instance.new("TextButton"),
	BG_11 = Instance.new("ImageLabel"),
	Toggle_PureRokakaka = Instance.new("TextButton"),
	BG_12 = Instance.new("ImageLabel"),
	CheckBoxes_Text = Instance.new("Folder"),
	Text_4 = Instance.new("TextLabel"),
	Text_5 = Instance.new("TextLabel"),
	Text_6 = Instance.new("TextLabel"),
	Text_7 = Instance.new("TextLabel"),
	Text_8 = Instance.new("TextLabel"),
	Text_9 = Instance.new("TextLabel"),
	Text_10 = Instance.new("TextLabel"),
	Text_11 = Instance.new("TextLabel"),
	Text_12 = Instance.new("TextLabel"),
	Text_13 = Instance.new("TextLabel"),
	Text_14 = Instance.new("TextLabel"),
	Text_15 = Instance.new("TextLabel"),
	Other = Instance.new("Folder"),
	Roundify_8 = Instance.new("ImageLabel"),
	Roundify_9 = Instance.new("ImageLabel"),
	CombatTab = Instance.new("ImageLabel"),
	TextLabels_2 = Instance.new("Folder"),
	Text_16 = Instance.new("TextLabel"),
	Text_17 = Instance.new("TextLabel"),
	Text_18 = Instance.new("TextLabel"),
	Text_19 = Instance.new("TextLabel"),
	Text_20 = Instance.new("TextLabel"),
	Text_21 = Instance.new("TextLabel"),
	Text_22 = Instance.new("TextLabel"),
	Text_23 = Instance.new("TextLabel"),
	Toggles_2 = Instance.new("Folder"),
	Toggle_Speed = Instance.new("TextButton"),
	Roundify_10 = Instance.new("ImageLabel"),
	Toggle_Jump = Instance.new("TextButton"),
	Roundify_11 = Instance.new("ImageLabel"),
	Toggle_Flight = Instance.new("TextButton"),
	Roundify_12 = Instance.new("ImageLabel"),
	Toggle_TargetPlayer = Instance.new("TextButton"),
	Roundify_13 = Instance.new("ImageLabel"),
	Toggle_ClickTP = Instance.new("TextButton"),
	Roundify_14 = Instance.new("ImageLabel"),
	Toggle_TeleportToPlayer = Instance.new("TextButton"),
	Roundify_15 = Instance.new("ImageLabel"),
	ValueInputs = Instance.new("Folder"),
	Input_TargetPlayer = Instance.new("TextBox"),
	Roundify_16 = Instance.new("ImageLabel"),
	Input_SuperSpeed = Instance.new("TextBox"),
	Roundify_17 = Instance.new("ImageLabel"),
	Input_SuperJump = Instance.new("TextBox"),
	Roundify_18 = Instance.new("ImageLabel"),
	Input_Flight = Instance.new("TextBox"),
	Roundify_19 = Instance.new("ImageLabel"),
	Input_TeleportToPlayer = Instance.new("TextBox"),
	Roundify_20 = Instance.new("ImageLabel"),
	Other_2 = Instance.new("Folder"),
	Roundify_21 = Instance.new("ImageLabel"),
	Roundify_22 = Instance.new("ImageLabel"),
	Roundify_23 = Instance.new("ImageLabel"),
	KeyBinds = Instance.new("Folder"),
	KeyBind_SuperSpeed = Instance.new("TextBox"),
	Roundify_24 = Instance.new("ImageLabel"),
	KeyBind_Flight = Instance.new("TextBox"),
	Roundify_25 = Instance.new("ImageLabel"),
	ExtrasTab = Instance.new("ImageLabel"),
	TextLabels_3 = Instance.new("Folder"),
	Text_24 = Instance.new("TextLabel"),
	Text_25 = Instance.new("TextLabel"),
	Text_26 = Instance.new("TextLabel"),
	Text_27 = Instance.new("TextLabel"),
	Text_28 = Instance.new("TextLabel"),
	Toggles_3 = Instance.new("Folder"),
	Toggle_PlayerHealthBars = Instance.new("TextButton"),
	Roundify_26 = Instance.new("ImageLabel"),
	Toggle_AttachStand = Instance.new("TextButton"),
	Roundify_27 = Instance.new("ImageLabel"),
	Toggle_StandTarget = Instance.new("TextButton"),
	Roundify_28 = Instance.new("ImageLabel"),
	Other_3 = Instance.new("Folder"),
	Roundify_29 = Instance.new("ImageLabel"),
	Roundify_30 = Instance.new("ImageLabel"),
	Roundify_31 = Instance.new("ImageLabel"),
	ValueInputs_2 = Instance.new("Folder"),
	Input_AttachStand = Instance.new("TextBox"),
	Roundify_32 = Instance.new("ImageLabel"),
	Input_StandTarget = Instance.new("TextBox"),
	Roundify_33 = Instance.new("ImageLabel"),
	NPCsTab = Instance.new("ImageLabel"),
	TextLabels_4 = Instance.new("Folder"),
	Text_29 = Instance.new("TextLabel"),
	Text_30 = Instance.new("TextLabel"),
	Text_31 = Instance.new("TextLabel"),
	Toggles_4 = Instance.new("Folder"),
	Toggle_NPCFarm = Instance.new("TextButton"),
	Roundify_34 = Instance.new("ImageLabel"),
	Toggle_QuestFarm = Instance.new("TextButton"),
	Roundify_35 = Instance.new("ImageLabel"),
	Toggle_QuickSell_One = Instance.new("TextButton"),
	Roundify_36 = Instance.new("ImageLabel"),
	Toggle_QuickSell_All = Instance.new("TextButton"),
	Roundify_37 = Instance.new("ImageLabel"),
	Other_4 = Instance.new("Folder"),
	Roundify_38 = Instance.new("ImageLabel"),
	Roundify_39 = Instance.new("ImageLabel"),
	Roundify_40 = Instance.new("ImageLabel"),
	DropdownMenus = Instance.new("Folder"),
	DropDown_NPCs = Instance.new("TextButton"),
	Roundify_41 = Instance.new("ImageLabel"),
	Arrow = Instance.new("ImageLabel"),
	ScrollingFrame = Instance.new("ScrollingFrame"),
	Dropdown_Items = Instance.new("Folder"),
	UIListLayout = Instance.new("UIListLayout"),
	Option1 = Instance.new("TextButton"),
	Option2 = Instance.new("TextButton"),
	Option3 = Instance.new("TextButton"),
	Option4 = Instance.new("TextButton"),
	Option5 = Instance.new("TextButton"),
	Option6 = Instance.new("TextButton"),
	DropDownBG = Instance.new("ImageLabel"),
	DropDownBG_BG = Instance.new("ImageLabel"),
	ScrollingFrame_2 = Instance.new("ScrollingFrame"),
	Dropdown_Items_2 = Instance.new("Folder"),
	UIListLayout_2 = Instance.new("UIListLayout"),
	Option1_2 = Instance.new("TextButton"),
	Option2_2 = Instance.new("TextButton"),
	Option3_2 = Instance.new("TextButton"),
	Option4_2 = Instance.new("TextButton"),
	Option5_2 = Instance.new("TextButton"),
	Option6_2 = Instance.new("TextButton"),
	DropDown_Quests = Instance.new("TextButton"),
	Roundify_42 = Instance.new("ImageLabel"),
	Arrow_2 = Instance.new("ImageLabel"),
	DropDownBG_2 = Instance.new("ImageLabel"),
	DropDownBG_BG_2 = Instance.new("ImageLabel"),
	ScrollingFrame_3 = Instance.new("ScrollingFrame"),
	Dropdown_Items_3 = Instance.new("Folder"),
	UIListLayout_3 = Instance.new("UIListLayout"),
	Option1_3 = Instance.new("TextButton"),
	Option2_3 = Instance.new("TextButton"),
	Option3_3 = Instance.new("TextButton"),
	Option4_3 = Instance.new("TextButton"),
	Option5_3 = Instance.new("TextButton"),
	Option6_3 = Instance.new("TextButton"),
	Option7 = Instance.new("TextButton"),
	Option8 = Instance.new("TextButton"),
	Option9 = Instance.new("TextButton"),
	Option10 = Instance.new("TextButton"),
	Option11 = Instance.new("TextButton"),
	Option12 = Instance.new("TextButton"),
	DropDownBG_3 = Instance.new("ImageLabel"),
	DropDownBG_BG_2_2 = Instance.new("ImageLabel"),
	DropDown_QuickSell = Instance.new("TextButton"),
	Roundify_43 = Instance.new("ImageLabel"),
	Arrow_2_2 = Instance.new("ImageLabel"),
	TopBar = Instance.new("Folder"),
	Frame_2 = Instance.new("Frame"),
	Frame_3 = Instance.new("Frame"),
	Frame_4 = Instance.new("ImageLabel"),
	Title = Instance.new("TextLabel"),
	KeyBind_HideGui = Instance.new("TextLabel"),
	Frame_5 = Instance.new("ImageLabel"),
	BorderBG = Instance.new("ImageLabel"),
}

--Properties:

YBA.YBA.Name = UI_Name
YBA.YBA.Parent = game.CoreGui
YBA.YBA.ResetOnSpawn = false

YBA.Frame.Parent = YBA.YBA
YBA.Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Frame.BackgroundTransparency = 1.000
YBA.Frame.Position = UDim2.new(0.307000011, 0, 0.207000017, 0)
YBA.Frame.Size = UDim2.new(0.215000004, 0, 0.476662546, 0)
YBA.Frame.ZIndex = 8

YBA.TabButtons.Name = "TabButtons"
YBA.TabButtons.Parent = YBA.Frame

YBA.Extras.Name = "Extras"
YBA.Extras.Parent = YBA.TabButtons
YBA.Extras.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Extras.BackgroundTransparency = 1.000
YBA.Extras.BorderSizePixel = 0
YBA.Extras.Position = UDim2.new(0.507178009, 0, 0.0899999961, 0)
YBA.Extras.Size = UDim2.new(0.227125093, 0, 0.0649230033, 0)
YBA.Extras.ZIndex = 3
YBA.Extras.Font = Enum.Font.GothamBold
YBA.Extras.Text = "Extras"
YBA.Extras.TextColor3 = Color3.fromRGB(206, 206, 206)
YBA.Extras.TextSize = 17.000

YBA.Roundify.Name = "Roundify"
YBA.Roundify.Parent = YBA.Extras
YBA.Roundify.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify.BackgroundTransparency = 1.000
YBA.Roundify.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify.ZIndex = 2
YBA.Roundify.Image = "rbxassetid://3570695787"
YBA.Roundify.ImageColor3 = Color3.fromRGB(79, 79, 79)
YBA.Roundify.ScaleType = Enum.ScaleType.Slice
YBA.Roundify.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify.SliceScale = 0.120

YBA.Combat.Name = "Combat"
YBA.Combat.Parent = YBA.TabButtons
YBA.Combat.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Combat.BackgroundTransparency = 1.000
YBA.Combat.BorderSizePixel = 0
YBA.Combat.Position = UDim2.new(0.019999953, 0, 0.0899999961, 0)
YBA.Combat.Size = UDim2.new(0.227125093, 0, 0.0649230033, 0)
YBA.Combat.ZIndex = 3
YBA.Combat.Font = Enum.Font.GothamBold
YBA.Combat.Text = "Combat"
YBA.Combat.TextColor3 = Color3.fromRGB(206, 206, 206)
YBA.Combat.TextSize = 17.000

YBA.Roundify_2.Name = "Roundify"
YBA.Roundify_2.Parent = YBA.Combat
YBA.Roundify_2.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_2.BackgroundTransparency = 1.000
YBA.Roundify_2.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_2.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_2.ZIndex = 2
YBA.Roundify_2.Image = "rbxassetid://3570695787"
YBA.Roundify_2.ImageColor3 = Color3.fromRGB(79, 79, 79)
YBA.Roundify_2.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_2.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_2.SliceScale = 0.120

YBA.Items.Name = "Items"
YBA.Items.Parent = YBA.TabButtons
YBA.Items.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Items.BackgroundTransparency = 1.000
YBA.Items.BorderSizePixel = 0
YBA.Items.Position = UDim2.new(0.26565364, 0, 0.0899999961, 0)
YBA.Items.Size = UDim2.new(0.227125093, 0, 0.0649230033, 0)
YBA.Items.ZIndex = 3
YBA.Items.Font = Enum.Font.GothamBold
YBA.Items.Text = "Items"
YBA.Items.TextColor3 = Color3.fromRGB(206, 206, 206)
YBA.Items.TextSize = 17.000

YBA.Roundify_3.Name = "Roundify"
YBA.Roundify_3.Parent = YBA.Items
YBA.Roundify_3.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_3.BackgroundTransparency = 1.000
YBA.Roundify_3.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_3.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_3.ZIndex = 2
YBA.Roundify_3.Image = "rbxassetid://3570695787"
YBA.Roundify_3.ImageColor3 = Color3.fromRGB(79, 79, 79)
YBA.Roundify_3.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_3.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_3.SliceScale = 0.120

YBA.NPCs.Name = "NPCs"
YBA.NPCs.Parent = YBA.TabButtons
YBA.NPCs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.NPCs.BackgroundTransparency = 1.000
YBA.NPCs.BorderSizePixel = 0
YBA.NPCs.Position = UDim2.new(0.75, 0, 0.0899999961, 0)
YBA.NPCs.Size = UDim2.new(0.227125093, 0, 0.0649230033, 0)
YBA.NPCs.ZIndex = 3
YBA.NPCs.Font = Enum.Font.GothamBold
YBA.NPCs.Text = "NPCs"
YBA.NPCs.TextColor3 = Color3.fromRGB(206, 206, 206)
YBA.NPCs.TextSize = 17.000

YBA.Roundify_4.Name = "Roundify"
YBA.Roundify_4.Parent = YBA.NPCs
YBA.Roundify_4.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_4.BackgroundTransparency = 1.000
YBA.Roundify_4.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_4.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_4.ZIndex = 2
YBA.Roundify_4.Image = "rbxassetid://3570695787"
YBA.Roundify_4.ImageColor3 = Color3.fromRGB(79, 79, 79)
YBA.Roundify_4.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_4.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_4.SliceScale = 0.120

YBA.Tabs.Name = "Tabs"
YBA.Tabs.Parent = YBA.Frame

YBA.ItemsTab.Name = "ItemsTab"
YBA.ItemsTab.Parent = YBA.Tabs
YBA.ItemsTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.ItemsTab.BackgroundTransparency = 1.000
YBA.ItemsTab.Position = UDim2.new(0, 0, 0.174980864, 0)
YBA.ItemsTab.Size = UDim2.new(1, 0, 0.825019062, 0)
YBA.ItemsTab.Visible = false
YBA.ItemsTab.Image = "rbxassetid://3570695787"
YBA.ItemsTab.ImageColor3 = Color3.fromRGB(77, 77, 77)
YBA.ItemsTab.ScaleType = Enum.ScaleType.Slice
YBA.ItemsTab.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.ItemsTab.SliceScale = 0.120

YBA.Toggles.Name = "Toggles"
YBA.Toggles.Parent = YBA.ItemsTab

YBA.Toggle_ItemESP.Name = "Toggle_ItemESP"
YBA.Toggle_ItemESP.Parent = YBA.Toggles
YBA.Toggle_ItemESP.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_ItemESP.BackgroundTransparency = 1.000
YBA.Toggle_ItemESP.BorderSizePixel = 0
YBA.Toggle_ItemESP.Position = UDim2.new(0.0404379405, 0, 0.054999996, 0)
YBA.Toggle_ItemESP.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
YBA.Toggle_ItemESP.ZIndex = 3
YBA.Toggle_ItemESP.Font = Enum.Font.GothamBold
YBA.Toggle_ItemESP.Text = "OFF"
YBA.Toggle_ItemESP.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_ItemESP.TextSize = 17.000

YBA.Roundify_5.Name = "Roundify"
YBA.Roundify_5.Parent = YBA.Toggle_ItemESP
YBA.Roundify_5.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_5.BackgroundTransparency = 1.000
YBA.Roundify_5.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_5.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_5.ZIndex = 2
YBA.Roundify_5.Image = "rbxassetid://3570695787"
YBA.Roundify_5.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_5.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_5.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_5.SliceScale = 0.120

YBA.Toggle_ItemNotifs.Name = "Toggle_ItemNotifs"
YBA.Toggle_ItemNotifs.Parent = YBA.Toggles
YBA.Toggle_ItemNotifs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_ItemNotifs.BackgroundTransparency = 1.000
YBA.Toggle_ItemNotifs.BorderSizePixel = 0
YBA.Toggle_ItemNotifs.Position = UDim2.new(0.0404379405, 0, 0.168972045, 0)
YBA.Toggle_ItemNotifs.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
YBA.Toggle_ItemNotifs.ZIndex = 3
YBA.Toggle_ItemNotifs.Font = Enum.Font.GothamBold
YBA.Toggle_ItemNotifs.Text = "OFF"
YBA.Toggle_ItemNotifs.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_ItemNotifs.TextSize = 17.000

YBA.Roundify_6.Name = "Roundify"
YBA.Roundify_6.Parent = YBA.Toggle_ItemNotifs
YBA.Roundify_6.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_6.BackgroundTransparency = 1.000
YBA.Roundify_6.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_6.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_6.ZIndex = 2
YBA.Roundify_6.Image = "rbxassetid://3570695787"
YBA.Roundify_6.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_6.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_6.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_6.SliceScale = 0.120

YBA.Toggle_ItemAutoFarm.Name = "Toggle_ItemAutoFarm"
YBA.Toggle_ItemAutoFarm.Parent = YBA.Toggles
YBA.Toggle_ItemAutoFarm.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_ItemAutoFarm.BackgroundTransparency = 1.000
YBA.Toggle_ItemAutoFarm.BorderSizePixel = 0
YBA.Toggle_ItemAutoFarm.Position = UDim2.new(0.0404379405, 0, 0.282944143, 0)
YBA.Toggle_ItemAutoFarm.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
YBA.Toggle_ItemAutoFarm.ZIndex = 3
YBA.Toggle_ItemAutoFarm.Font = Enum.Font.GothamBold
YBA.Toggle_ItemAutoFarm.Text = "OFF"
YBA.Toggle_ItemAutoFarm.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_ItemAutoFarm.TextSize = 17.000

YBA.Roundify_7.Name = "Roundify"
YBA.Roundify_7.Parent = YBA.Toggle_ItemAutoFarm
YBA.Roundify_7.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_7.BackgroundTransparency = 1.000
YBA.Roundify_7.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_7.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_7.ZIndex = 2
YBA.Roundify_7.Image = "rbxassetid://3570695787"
YBA.Roundify_7.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_7.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_7.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_7.SliceScale = 0.120

YBA.TextLabels.Name = "TextLabels"
YBA.TextLabels.Parent = YBA.ItemsTab

YBA.Text.Name = "Text"
YBA.Text.Parent = YBA.TextLabels
YBA.Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text.BackgroundTransparency = 1.000
YBA.Text.Position = UDim2.new(0.300000101, 0, 0.282944143, 0)
YBA.Text.Size = UDim2.new(0.649999976, 0, 0.085651733, 0)
YBA.Text.ZIndex = 3
YBA.Text.Font = Enum.Font.GothamBold
YBA.Text.Text = "Item Auto-Farm"
YBA.Text.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text.TextSize = 18.000
YBA.Text.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_2.Name = "Text"
YBA.Text_2.Parent = YBA.TextLabels
YBA.Text_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_2.BackgroundTransparency = 1.000
YBA.Text_2.Position = UDim2.new(0.300000101, 0, 0.168972045, 0)
YBA.Text_2.Size = UDim2.new(0.649999976, 0, 0.085651733, 0)
YBA.Text_2.ZIndex = 3
YBA.Text_2.Font = Enum.Font.GothamBold
YBA.Text_2.Text = "Item Notifications"
YBA.Text_2.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_2.TextSize = 18.000
YBA.Text_2.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_3.Name = "Text"
YBA.Text_3.Parent = YBA.TextLabels
YBA.Text_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_3.BackgroundTransparency = 1.000
YBA.Text_3.Position = UDim2.new(0.300000101, 0, 0.0549999513, 0)
YBA.Text_3.Size = UDim2.new(0.649999976, 0, 0.085651733, 0)
YBA.Text_3.ZIndex = 3
YBA.Text_3.Font = Enum.Font.GothamBold
YBA.Text_3.Text = "Item ESP"
YBA.Text_3.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_3.TextSize = 18.000
YBA.Text_3.TextXAlignment = Enum.TextXAlignment.Left

YBA.CheckBoxes.Name = "CheckBoxes"
YBA.CheckBoxes.Parent = YBA.ItemsTab

YBA.Toggle_Rokakaka.Name = "Toggle_Rokakaka"
YBA.Toggle_Rokakaka.Parent = YBA.CheckBoxes
YBA.Toggle_Rokakaka.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_Rokakaka.BackgroundTransparency = 1.000
YBA.Toggle_Rokakaka.BorderSizePixel = 0
YBA.Toggle_Rokakaka.Position = UDim2.new(0.349999934, 0, 0.449921429, 0)
YBA.Toggle_Rokakaka.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
YBA.Toggle_Rokakaka.ZIndex = 3
YBA.Toggle_Rokakaka.Font = Enum.Font.GothamBold
YBA.Toggle_Rokakaka.Text = ""
YBA.Toggle_Rokakaka.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_Rokakaka.TextSize = 17.000

YBA.BG.Name = "BG"
YBA.BG.Parent = YBA.Toggle_Rokakaka
YBA.BG.Active = true
YBA.BG.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.BG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.BG.BackgroundTransparency = 1.000
YBA.BG.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.BG.Selectable = true
YBA.BG.Size = UDim2.new(1, 0, 1, 0)
YBA.BG.ZIndex = 2
YBA.BG.Image = "rbxassetid://3570695787"
YBA.BG.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.BG.ScaleType = Enum.ScaleType.Slice
YBA.BG.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.BG.SliceScale = 0.060

YBA.Toggle_Arrows.Name = "Toggle_Arrows"
YBA.Toggle_Arrows.Parent = YBA.CheckBoxes
YBA.Toggle_Arrows.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_Arrows.BackgroundTransparency = 1.000
YBA.Toggle_Arrows.BorderSizePixel = 0
YBA.Toggle_Arrows.Position = UDim2.new(0.0500000194, 0, 0.549768269, 0)
YBA.Toggle_Arrows.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
YBA.Toggle_Arrows.ZIndex = 3
YBA.Toggle_Arrows.Font = Enum.Font.GothamBold
YBA.Toggle_Arrows.Text = ""
YBA.Toggle_Arrows.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_Arrows.TextSize = 17.000

YBA.BG_2.Name = "BG"
YBA.BG_2.Parent = YBA.Toggle_Arrows
YBA.BG_2.Active = true
YBA.BG_2.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.BG_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.BG_2.BackgroundTransparency = 1.000
YBA.BG_2.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.BG_2.Selectable = true
YBA.BG_2.Size = UDim2.new(1, 0, 1, 0)
YBA.BG_2.ZIndex = 2
YBA.BG_2.Image = "rbxassetid://3570695787"
YBA.BG_2.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.BG_2.ScaleType = Enum.ScaleType.Slice
YBA.BG_2.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.BG_2.SliceScale = 0.060

YBA.Toggle_Coins.Name = "Toggle_Coins"
YBA.Toggle_Coins.Parent = YBA.CheckBoxes
YBA.Toggle_Coins.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_Coins.BackgroundTransparency = 1.000
YBA.Toggle_Coins.BorderSizePixel = 0
YBA.Toggle_Coins.Position = UDim2.new(0.0500000194, 0, 0.64961499, 0)
YBA.Toggle_Coins.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
YBA.Toggle_Coins.ZIndex = 3
YBA.Toggle_Coins.Font = Enum.Font.GothamBold
YBA.Toggle_Coins.Text = ""
YBA.Toggle_Coins.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_Coins.TextSize = 17.000

YBA.BG_3.Name = "BG"
YBA.BG_3.Parent = YBA.Toggle_Coins
YBA.BG_3.Active = true
YBA.BG_3.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.BG_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.BG_3.BackgroundTransparency = 1.000
YBA.BG_3.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.BG_3.Selectable = true
YBA.BG_3.Size = UDim2.new(1, 0, 1, 0)
YBA.BG_3.ZIndex = 2
YBA.BG_3.Image = "rbxassetid://3570695787"
YBA.BG_3.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.BG_3.ScaleType = Enum.ScaleType.Slice
YBA.BG_3.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.BG_3.SliceScale = 0.060

YBA.Toggle_Diamond.Name = "Toggle_Diamond"
YBA.Toggle_Diamond.Parent = YBA.CheckBoxes
YBA.Toggle_Diamond.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_Diamond.BackgroundTransparency = 1.000
YBA.Toggle_Diamond.BorderSizePixel = 0
YBA.Toggle_Diamond.Position = UDim2.new(0.349999934, 0, 0.549768269, 0)
YBA.Toggle_Diamond.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
YBA.Toggle_Diamond.ZIndex = 3
YBA.Toggle_Diamond.Font = Enum.Font.GothamBold
YBA.Toggle_Diamond.Text = ""
YBA.Toggle_Diamond.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_Diamond.TextSize = 17.000

YBA.BG_4.Name = "BG"
YBA.BG_4.Parent = YBA.Toggle_Diamond
YBA.BG_4.Active = true
YBA.BG_4.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.BG_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.BG_4.BackgroundTransparency = 1.000
YBA.BG_4.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.BG_4.Selectable = true
YBA.BG_4.Size = UDim2.new(1, 0, 1, 0)
YBA.BG_4.ZIndex = 2
YBA.BG_4.Image = "rbxassetid://3570695787"
YBA.BG_4.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.BG_4.ScaleType = Enum.ScaleType.Slice
YBA.BG_4.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.BG_4.SliceScale = 0.060

YBA.Toggle_RibCage.Name = "Toggle_RibCage"
YBA.Toggle_RibCage.Parent = YBA.CheckBoxes
YBA.Toggle_RibCage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_RibCage.BackgroundTransparency = 1.000
YBA.Toggle_RibCage.BorderSizePixel = 0
YBA.Toggle_RibCage.Position = UDim2.new(0.349999934, 0, 0.64961499, 0)
YBA.Toggle_RibCage.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
YBA.Toggle_RibCage.ZIndex = 3
YBA.Toggle_RibCage.Font = Enum.Font.GothamBold
YBA.Toggle_RibCage.Text = ""
YBA.Toggle_RibCage.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_RibCage.TextSize = 17.000

YBA.BG_5.Name = "BG"
YBA.BG_5.Parent = YBA.Toggle_RibCage
YBA.BG_5.Active = true
YBA.BG_5.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.BG_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.BG_5.BackgroundTransparency = 1.000
YBA.BG_5.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.BG_5.Selectable = true
YBA.BG_5.Size = UDim2.new(1, 0, 1, 0)
YBA.BG_5.ZIndex = 2
YBA.BG_5.Image = "rbxassetid://3570695787"
YBA.BG_5.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.BG_5.ScaleType = Enum.ScaleType.Slice
YBA.BG_5.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.BG_5.SliceScale = 0.060

YBA.Toggle_All.Name = "Toggle_All"
YBA.Toggle_All.Parent = YBA.CheckBoxes
YBA.Toggle_All.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_All.BackgroundTransparency = 1.000
YBA.Toggle_All.BorderSizePixel = 0
YBA.Toggle_All.Position = UDim2.new(0.0500000194, 0, 0.449921429, 0)
YBA.Toggle_All.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
YBA.Toggle_All.ZIndex = 3
YBA.Toggle_All.Font = Enum.Font.GothamBold
YBA.Toggle_All.Text = "X"
YBA.Toggle_All.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_All.TextSize = 17.000

YBA.BG_6.Name = "BG"
YBA.BG_6.Parent = YBA.Toggle_All
YBA.BG_6.Active = true
YBA.BG_6.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.BG_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.BG_6.BackgroundTransparency = 1.000
YBA.BG_6.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.BG_6.Selectable = true
YBA.BG_6.Size = UDim2.new(1, 0, 1, 0)
YBA.BG_6.ZIndex = 2
YBA.BG_6.Image = "rbxassetid://3570695787"
YBA.BG_6.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.BG_6.ScaleType = Enum.ScaleType.Slice
YBA.BG_6.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.BG_6.SliceScale = 0.060

YBA.Toggle_DEOsDiary.Name = "Toggle_DEOsDiary"
YBA.Toggle_DEOsDiary.Parent = YBA.CheckBoxes
YBA.Toggle_DEOsDiary.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_DEOsDiary.BackgroundTransparency = 1.000
YBA.Toggle_DEOsDiary.BorderSizePixel = 0
YBA.Toggle_DEOsDiary.Position = UDim2.new(0.649999857, 0, 0.64961499, 0)
YBA.Toggle_DEOsDiary.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
YBA.Toggle_DEOsDiary.ZIndex = 3
YBA.Toggle_DEOsDiary.Font = Enum.Font.GothamBold
YBA.Toggle_DEOsDiary.Text = ""
YBA.Toggle_DEOsDiary.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_DEOsDiary.TextSize = 17.000

YBA.BG_7.Name = "BG"
YBA.BG_7.Parent = YBA.Toggle_DEOsDiary
YBA.BG_7.Active = true
YBA.BG_7.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.BG_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.BG_7.BackgroundTransparency = 1.000
YBA.BG_7.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.BG_7.Selectable = true
YBA.BG_7.Size = UDim2.new(1, 0, 1, 0)
YBA.BG_7.ZIndex = 2
YBA.BG_7.Image = "rbxassetid://3570695787"
YBA.BG_7.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.BG_7.ScaleType = Enum.ScaleType.Slice
YBA.BG_7.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.BG_7.SliceScale = 0.060

YBA.Toggle_StoneMask.Name = "Toggle_StoneMask"
YBA.Toggle_StoneMask.Parent = YBA.CheckBoxes
YBA.Toggle_StoneMask.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_StoneMask.BackgroundTransparency = 1.000
YBA.Toggle_StoneMask.BorderSizePixel = 0
YBA.Toggle_StoneMask.Position = UDim2.new(0.649999857, 0, 0.549768269, 0)
YBA.Toggle_StoneMask.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
YBA.Toggle_StoneMask.ZIndex = 3
YBA.Toggle_StoneMask.Font = Enum.Font.GothamBold
YBA.Toggle_StoneMask.Text = ""
YBA.Toggle_StoneMask.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_StoneMask.TextSize = 17.000

YBA.BG_8.Name = "BG"
YBA.BG_8.Parent = YBA.Toggle_StoneMask
YBA.BG_8.Active = true
YBA.BG_8.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.BG_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.BG_8.BackgroundTransparency = 1.000
YBA.BG_8.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.BG_8.Selectable = true
YBA.BG_8.Size = UDim2.new(1, 0, 1, 0)
YBA.BG_8.ZIndex = 2
YBA.BG_8.Image = "rbxassetid://3570695787"
YBA.BG_8.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.BG_8.ScaleType = Enum.ScaleType.Slice
YBA.BG_8.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.BG_8.SliceScale = 0.060

YBA.Toggle_SteelBall.Name = "Toggle_SteelBall"
YBA.Toggle_SteelBall.Parent = YBA.CheckBoxes
YBA.Toggle_SteelBall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_SteelBall.BackgroundTransparency = 1.000
YBA.Toggle_SteelBall.BorderSizePixel = 0
YBA.Toggle_SteelBall.Position = UDim2.new(0.649999857, 0, 0.449921429, 0)
YBA.Toggle_SteelBall.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
YBA.Toggle_SteelBall.ZIndex = 3
YBA.Toggle_SteelBall.Font = Enum.Font.GothamBold
YBA.Toggle_SteelBall.Text = ""
YBA.Toggle_SteelBall.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_SteelBall.TextSize = 17.000

YBA.BG_9.Name = "BG"
YBA.BG_9.Parent = YBA.Toggle_SteelBall
YBA.BG_9.Active = true
YBA.BG_9.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.BG_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.BG_9.BackgroundTransparency = 1.000
YBA.BG_9.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.BG_9.Selectable = true
YBA.BG_9.Size = UDim2.new(1, 0, 1, 0)
YBA.BG_9.ZIndex = 2
YBA.BG_9.Image = "rbxassetid://3570695787"
YBA.BG_9.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.BG_9.ScaleType = Enum.ScaleType.Slice
YBA.BG_9.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.BG_9.SliceScale = 0.060

YBA.Toggle_Headband.Name = "Toggle_Headband"
YBA.Toggle_Headband.Parent = YBA.CheckBoxes
YBA.Toggle_Headband.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_Headband.BackgroundTransparency = 1.000
YBA.Toggle_Headband.BorderSizePixel = 0
YBA.Toggle_Headband.Position = UDim2.new(0.349999934, 0, 0.74946177, 0)
YBA.Toggle_Headband.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
YBA.Toggle_Headband.ZIndex = 3
YBA.Toggle_Headband.Font = Enum.Font.GothamBold
YBA.Toggle_Headband.Text = ""
YBA.Toggle_Headband.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_Headband.TextSize = 17.000

YBA.BG_10.Name = "BG"
YBA.BG_10.Parent = YBA.Toggle_Headband
YBA.BG_10.Active = true
YBA.BG_10.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.BG_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.BG_10.BackgroundTransparency = 1.000
YBA.BG_10.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.BG_10.Selectable = true
YBA.BG_10.Size = UDim2.new(1, 0, 1, 0)
YBA.BG_10.ZIndex = 2
YBA.BG_10.Image = "rbxassetid://3570695787"
YBA.BG_10.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.BG_10.ScaleType = Enum.ScaleType.Slice
YBA.BG_10.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.BG_10.SliceScale = 0.060

YBA.Toggle_LuckyArrow.Name = "Toggle_LuckyArrow"
YBA.Toggle_LuckyArrow.Parent = YBA.CheckBoxes
YBA.Toggle_LuckyArrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_LuckyArrow.BackgroundTransparency = 1.000
YBA.Toggle_LuckyArrow.BorderSizePixel = 0
YBA.Toggle_LuckyArrow.Position = UDim2.new(0.649999857, 0, 0.74946177, 0)
YBA.Toggle_LuckyArrow.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
YBA.Toggle_LuckyArrow.ZIndex = 3
YBA.Toggle_LuckyArrow.Font = Enum.Font.GothamBold
YBA.Toggle_LuckyArrow.Text = ""
YBA.Toggle_LuckyArrow.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_LuckyArrow.TextSize = 17.000

YBA.BG_11.Name = "BG"
YBA.BG_11.Parent = YBA.Toggle_LuckyArrow
YBA.BG_11.Active = true
YBA.BG_11.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.BG_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.BG_11.BackgroundTransparency = 1.000
YBA.BG_11.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.BG_11.Selectable = true
YBA.BG_11.Size = UDim2.new(1, 0, 1, 0)
YBA.BG_11.ZIndex = 2
YBA.BG_11.Image = "rbxassetid://3570695787"
YBA.BG_11.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.BG_11.ScaleType = Enum.ScaleType.Slice
YBA.BG_11.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.BG_11.SliceScale = 0.060

YBA.Toggle_PureRokakaka.Name = "Toggle_PureRokakaka"
YBA.Toggle_PureRokakaka.Parent = YBA.CheckBoxes
YBA.Toggle_PureRokakaka.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_PureRokakaka.BackgroundTransparency = 1.000
YBA.Toggle_PureRokakaka.BorderSizePixel = 0
YBA.Toggle_PureRokakaka.Position = UDim2.new(0.0500000194, 0, 0.74946177, 0)
YBA.Toggle_PureRokakaka.Size = UDim2.new(0.0686131194, 0, 0.0760508925, 0)
YBA.Toggle_PureRokakaka.ZIndex = 3
YBA.Toggle_PureRokakaka.Font = Enum.Font.GothamBold
YBA.Toggle_PureRokakaka.Text = ""
YBA.Toggle_PureRokakaka.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_PureRokakaka.TextSize = 17.000

YBA.BG_12.Name = "BG"
YBA.BG_12.Parent = YBA.Toggle_PureRokakaka
YBA.BG_12.Active = true
YBA.BG_12.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.BG_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.BG_12.BackgroundTransparency = 1.000
YBA.BG_12.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.BG_12.Selectable = true
YBA.BG_12.Size = UDim2.new(1, 0, 1, 0)
YBA.BG_12.ZIndex = 2
YBA.BG_12.Image = "rbxassetid://3570695787"
YBA.BG_12.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.BG_12.ScaleType = Enum.ScaleType.Slice
YBA.BG_12.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.BG_12.SliceScale = 0.060

YBA.CheckBoxes_Text.Name = "CheckBoxes_Text"
YBA.CheckBoxes_Text.Parent = YBA.ItemsTab

YBA.Text_4.Name = "Text"
YBA.Text_4.Parent = YBA.CheckBoxes_Text
YBA.Text_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_4.BackgroundTransparency = 1.000
YBA.Text_4.Position = UDim2.new(0.128832042, 0, 0.449921429, 0)
YBA.Text_4.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
YBA.Text_4.ZIndex = 3
YBA.Text_4.Font = Enum.Font.GothamBold
YBA.Text_4.Text = "All Items"
YBA.Text_4.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_4.TextScaled = true
YBA.Text_4.TextSize = 18.000
YBA.Text_4.TextWrapped = true
YBA.Text_4.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_5.Name = "Text"
YBA.Text_5.Parent = YBA.CheckBoxes_Text
YBA.Text_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_5.BackgroundTransparency = 1.000
YBA.Text_5.Position = UDim2.new(0.128832042, 0, 0.549768388, 0)
YBA.Text_5.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
YBA.Text_5.ZIndex = 3
YBA.Text_5.Font = Enum.Font.GothamBold
YBA.Text_5.Text = "Arrows"
YBA.Text_5.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_5.TextScaled = true
YBA.Text_5.TextSize = 18.000
YBA.Text_5.TextWrapped = true
YBA.Text_5.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_6.Name = "Text"
YBA.Text_6.Parent = YBA.CheckBoxes_Text
YBA.Text_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_6.BackgroundTransparency = 1.000
YBA.Text_6.Position = UDim2.new(0.128832042, 0, 0.64961499, 0)
YBA.Text_6.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
YBA.Text_6.ZIndex = 3
YBA.Text_6.Font = Enum.Font.GothamBold
YBA.Text_6.Text = "Coins"
YBA.Text_6.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_6.TextScaled = true
YBA.Text_6.TextSize = 18.000
YBA.Text_6.TextWrapped = true
YBA.Text_6.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_7.Name = "Text"
YBA.Text_7.Parent = YBA.CheckBoxes_Text
YBA.Text_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_7.BackgroundTransparency = 1.000
YBA.Text_7.Position = UDim2.new(0.424999982, 0, 0.449921429, 0)
YBA.Text_7.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
YBA.Text_7.ZIndex = 3
YBA.Text_7.Font = Enum.Font.GothamBold
YBA.Text_7.Text = "Rokakaka"
YBA.Text_7.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_7.TextScaled = true
YBA.Text_7.TextSize = 18.000
YBA.Text_7.TextWrapped = true
YBA.Text_7.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_8.Name = "Text"
YBA.Text_8.Parent = YBA.CheckBoxes_Text
YBA.Text_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_8.BackgroundTransparency = 1.000
YBA.Text_8.Position = UDim2.new(0.424999982, 0, 0.549768388, 0)
YBA.Text_8.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
YBA.Text_8.ZIndex = 3
YBA.Text_8.Font = Enum.Font.GothamBold
YBA.Text_8.Text = "Diamond"
YBA.Text_8.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_8.TextScaled = true
YBA.Text_8.TextSize = 18.000
YBA.Text_8.TextWrapped = true
YBA.Text_8.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_9.Name = "Text"
YBA.Text_9.Parent = YBA.CheckBoxes_Text
YBA.Text_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_9.BackgroundTransparency = 1.000
YBA.Text_9.Position = UDim2.new(0.424999982, 0, 0.64961499, 0)
YBA.Text_9.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
YBA.Text_9.ZIndex = 3
YBA.Text_9.Font = Enum.Font.GothamBold
YBA.Text_9.Text = "Rib Cage"
YBA.Text_9.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_9.TextScaled = true
YBA.Text_9.TextSize = 18.000
YBA.Text_9.TextWrapped = true
YBA.Text_9.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_10.Name = "Text"
YBA.Text_10.Parent = YBA.CheckBoxes_Text
YBA.Text_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_10.BackgroundTransparency = 1.000
YBA.Text_10.Position = UDim2.new(0.725000083, 0, 0.449921429, 0)
YBA.Text_10.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
YBA.Text_10.ZIndex = 3
YBA.Text_10.Font = Enum.Font.GothamBold
YBA.Text_10.Text = "Steel Ball"
YBA.Text_10.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_10.TextScaled = true
YBA.Text_10.TextSize = 18.000
YBA.Text_10.TextWrapped = true
YBA.Text_10.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_11.Name = "Text"
YBA.Text_11.Parent = YBA.CheckBoxes_Text
YBA.Text_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_11.BackgroundTransparency = 1.000
YBA.Text_11.Position = UDim2.new(0.725000083, 0, 0.549768388, 0)
YBA.Text_11.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
YBA.Text_11.ZIndex = 3
YBA.Text_11.Font = Enum.Font.GothamBold
YBA.Text_11.Text = "Stone Mask"
YBA.Text_11.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_11.TextScaled = true
YBA.Text_11.TextSize = 18.000
YBA.Text_11.TextWrapped = true
YBA.Text_11.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_12.Name = "Text"
YBA.Text_12.Parent = YBA.CheckBoxes_Text
YBA.Text_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_12.BackgroundTransparency = 1.000
YBA.Text_12.Position = UDim2.new(0.725000083, 0, 0.64961499, 0)
YBA.Text_12.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
YBA.Text_12.ZIndex = 3
YBA.Text_12.Font = Enum.Font.GothamBold
YBA.Text_12.Text = "DEO's Diary"
YBA.Text_12.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_12.TextScaled = true
YBA.Text_12.TextSize = 18.000
YBA.Text_12.TextWrapped = true
YBA.Text_12.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_13.Name = "Text"
YBA.Text_13.Parent = YBA.CheckBoxes_Text
YBA.Text_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_13.BackgroundTransparency = 1.000
YBA.Text_13.Position = UDim2.new(0.725000083, 0, 0.74946177, 0)
YBA.Text_13.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
YBA.Text_13.ZIndex = 3
YBA.Text_13.Font = Enum.Font.GothamBold
YBA.Text_13.Text = "Lucky_Arrow"
YBA.Text_13.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_13.TextScaled = true
YBA.Text_13.TextSize = 18.000
YBA.Text_13.TextWrapped = true
YBA.Text_13.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_14.Name = "Text"
YBA.Text_14.Parent = YBA.CheckBoxes_Text
YBA.Text_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_14.BackgroundTransparency = 1.000
YBA.Text_14.Position = UDim2.new(0.424999982, 0, 0.74946177, 0)
YBA.Text_14.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
YBA.Text_14.ZIndex = 3
YBA.Text_14.Font = Enum.Font.GothamBold
YBA.Text_14.Text = "Headband"
YBA.Text_14.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_14.TextScaled = true
YBA.Text_14.TextSize = 18.000
YBA.Text_14.TextWrapped = true
YBA.Text_14.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_15.Name = "Text"
YBA.Text_15.Parent = YBA.CheckBoxes_Text
YBA.Text_15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_15.BackgroundTransparency = 1.000
YBA.Text_15.Position = UDim2.new(0.128832042, 0, 0.74946177, 0)
YBA.Text_15.Size = UDim2.new(0.209124073, 0, 0.0759214833, 0)
YBA.Text_15.ZIndex = 3
YBA.Text_15.Font = Enum.Font.GothamBold
YBA.Text_15.Text = "Pure Roka."
YBA.Text_15.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_15.TextScaled = true
YBA.Text_15.TextSize = 18.000
YBA.Text_15.TextWrapped = true
YBA.Text_15.TextXAlignment = Enum.TextXAlignment.Left

YBA.Other.Name = "Other"
YBA.Other.Parent = YBA.ItemsTab

YBA.Roundify_8.Name = "Roundify"
YBA.Roundify_8.Parent = YBA.Other
YBA.Roundify_8.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_8.BackgroundTransparency = 1.000
YBA.Roundify_8.Position = UDim2.new(0.5, 0, 0.214511603, 0)
YBA.Roundify_8.Size = UDim2.new(0.941604972, 0, 0.354140997, 0)
YBA.Roundify_8.Image = "rbxassetid://3570695787"
YBA.Roundify_8.ImageColor3 = Color3.fromRGB(43, 43, 43)
YBA.Roundify_8.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_8.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_8.SliceScale = 0.120

YBA.Roundify_9.Name = "Roundify"
YBA.Roundify_9.Parent = YBA.Other
YBA.Roundify_9.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_9.BackgroundTransparency = 1.000
YBA.Roundify_9.Position = UDim2.new(0.5, 0, 0.637441158, 0)
YBA.Roundify_9.Size = UDim2.new(0.941604972, 0, 0.429023296, 0)
YBA.Roundify_9.Image = "rbxassetid://3570695787"
YBA.Roundify_9.ImageColor3 = Color3.fromRGB(43, 43, 43)
YBA.Roundify_9.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_9.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_9.SliceScale = 0.120

YBA.CombatTab.Name = "CombatTab"
YBA.CombatTab.Parent = YBA.Tabs
YBA.CombatTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.CombatTab.BackgroundTransparency = 1.000
YBA.CombatTab.Position = UDim2.new(0, 0, 0.174980864, 0)
YBA.CombatTab.Size = UDim2.new(1, 0, 0.825019062, 0)
YBA.CombatTab.Image = "rbxassetid://3570695787"
YBA.CombatTab.ImageColor3 = Color3.fromRGB(77, 77, 77)
YBA.CombatTab.ScaleType = Enum.ScaleType.Slice
YBA.CombatTab.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.CombatTab.SliceScale = 0.120

YBA.TextLabels_2.Name = "TextLabels"
YBA.TextLabels_2.Parent = YBA.CombatTab

YBA.Text_16.Name = "Text"
YBA.Text_16.Parent = YBA.TextLabels_2
YBA.Text_16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_16.BackgroundTransparency = 1.000
YBA.Text_16.Position = UDim2.new(0.244524837, 0, 0.282944143, 0)
YBA.Text_16.Size = UDim2.new(0.442697614, 0, 0.085651733, 0)
YBA.Text_16.ZIndex = 3
YBA.Text_16.Font = Enum.Font.GothamBold
YBA.Text_16.Text = "Flight"
YBA.Text_16.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_16.TextSize = 18.000
YBA.Text_16.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_17.Name = "Text"
YBA.Text_17.Parent = YBA.TextLabels_2
YBA.Text_17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_17.BackgroundTransparency = 1.000
YBA.Text_17.Position = UDim2.new(0.244524837, 0, 0.168972045, 0)
YBA.Text_17.Size = UDim2.new(0.442697614, 0, 0.085651733, 0)
YBA.Text_17.ZIndex = 3
YBA.Text_17.Font = Enum.Font.GothamBold
YBA.Text_17.Text = "Super Jump"
YBA.Text_17.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_17.TextSize = 18.000
YBA.Text_17.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_18.Name = "Text"
YBA.Text_18.Parent = YBA.TextLabels_2
YBA.Text_18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_18.BackgroundTransparency = 1.000
YBA.Text_18.Position = UDim2.new(0.244524837, 0, 0.0549999513, 0)
YBA.Text_18.Size = UDim2.new(0.442697614, 0, 0.085651733, 0)
YBA.Text_18.ZIndex = 3
YBA.Text_18.Font = Enum.Font.GothamBold
YBA.Text_18.Text = "Super Speed"
YBA.Text_18.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_18.TextSize = 18.000
YBA.Text_18.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_19.Name = "Text"
YBA.Text_19.Parent = YBA.TextLabels_2
YBA.Text_19.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_19.BackgroundTransparency = 1.000
YBA.Text_19.Position = UDim2.new(0.244524837, 0, 0.53579396, 0)
YBA.Text_19.Size = UDim2.new(0.442697614, 0, 0.0809906274, 0)
YBA.Text_19.ZIndex = 3
YBA.Text_19.Font = Enum.Font.GothamBold
YBA.Text_19.Text = "Target Player"
YBA.Text_19.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_19.TextSize = 18.000
YBA.Text_19.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_20.Name = "Text"
YBA.Text_20.Parent = YBA.TextLabels_2
YBA.Text_20.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_20.BackgroundTransparency = 1.000
YBA.Text_20.Position = UDim2.new(0.089635849, 0, 0.633907259, 0)
YBA.Text_20.Size = UDim2.new(0.133204013, 0, 0.0868912414, 0)
YBA.Text_20.ZIndex = 3
YBA.Text_20.Font = Enum.Font.GothamBold
YBA.Text_20.Text = "User:"
YBA.Text_20.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_20.TextSize = 18.000
YBA.Text_20.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_21.Name = "Text"
YBA.Text_21.Parent = YBA.TextLabels_2
YBA.Text_21.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_21.BackgroundTransparency = 1.000
YBA.Text_21.Position = UDim2.new(0.244524837, 0, 0.395000011, 0)
YBA.Text_21.Size = UDim2.new(0.442697614, 0, 0.085651733, 0)
YBA.Text_21.ZIndex = 3
YBA.Text_21.Font = Enum.Font.GothamBold
YBA.Text_21.Text = "Ctrl + Click = TP"
YBA.Text_21.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_21.TextSize = 18.000
YBA.Text_21.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_22.Name = "Text"
YBA.Text_22.Parent = YBA.TextLabels_2
YBA.Text_22.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_22.BackgroundTransparency = 1.000
YBA.Text_22.Position = UDim2.new(0.089635849, 0, 0.871605933, 0)
YBA.Text_22.Size = UDim2.new(0.133204013, 0, 0.0849530622, 0)
YBA.Text_22.ZIndex = 3
YBA.Text_22.Font = Enum.Font.GothamBold
YBA.Text_22.Text = "User:"
YBA.Text_22.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_22.TextSize = 18.000
YBA.Text_22.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_23.Name = "Text"
YBA.Text_23.Parent = YBA.TextLabels_2
YBA.Text_23.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_23.BackgroundTransparency = 1.000
YBA.Text_23.Position = UDim2.new(0.244524837, 0, 0.7756809, 0)
YBA.Text_23.Size = UDim2.new(0.442697614, 0, 0.0791840553, 0)
YBA.Text_23.ZIndex = 3
YBA.Text_23.Font = Enum.Font.GothamBold
YBA.Text_23.Text = "Teleport To Player"
YBA.Text_23.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_23.TextSize = 18.000
YBA.Text_23.TextXAlignment = Enum.TextXAlignment.Left

YBA.Toggles_2.Name = "Toggles"
YBA.Toggles_2.Parent = YBA.CombatTab

YBA.Toggle_Speed.Name = "Toggle_Speed"
YBA.Toggle_Speed.Parent = YBA.Toggles_2
YBA.Toggle_Speed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_Speed.BackgroundTransparency = 1.000
YBA.Toggle_Speed.BorderSizePixel = 0
YBA.Toggle_Speed.Position = UDim2.new(0.0404379405, 0, 0.0549999997, 0)
YBA.Toggle_Speed.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
YBA.Toggle_Speed.ZIndex = 3
YBA.Toggle_Speed.Font = Enum.Font.GothamBold
YBA.Toggle_Speed.Text = "OFF"
YBA.Toggle_Speed.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_Speed.TextSize = 17.000

YBA.Roundify_10.Name = "Roundify"
YBA.Roundify_10.Parent = YBA.Toggle_Speed
YBA.Roundify_10.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_10.BackgroundTransparency = 1.000
YBA.Roundify_10.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_10.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_10.ZIndex = 2
YBA.Roundify_10.Image = "rbxassetid://3570695787"
YBA.Roundify_10.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_10.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_10.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_10.SliceScale = 0.120

YBA.Toggle_Jump.Name = "Toggle_Jump"
YBA.Toggle_Jump.Parent = YBA.Toggles_2
YBA.Toggle_Jump.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_Jump.BackgroundTransparency = 1.000
YBA.Toggle_Jump.BorderSizePixel = 0
YBA.Toggle_Jump.Position = UDim2.new(0.0404379405, 0, 0.169, 0)
YBA.Toggle_Jump.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
YBA.Toggle_Jump.ZIndex = 3
YBA.Toggle_Jump.Font = Enum.Font.GothamBold
YBA.Toggle_Jump.Text = "OFF"
YBA.Toggle_Jump.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_Jump.TextSize = 17.000

YBA.Roundify_11.Name = "Roundify"
YBA.Roundify_11.Parent = YBA.Toggle_Jump
YBA.Roundify_11.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_11.BackgroundTransparency = 1.000
YBA.Roundify_11.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_11.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_11.ZIndex = 2
YBA.Roundify_11.Image = "rbxassetid://3570695787"
YBA.Roundify_11.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_11.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_11.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_11.SliceScale = 0.120

YBA.Toggle_Flight.Name = "Toggle_Flight"
YBA.Toggle_Flight.Parent = YBA.Toggles_2
YBA.Toggle_Flight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_Flight.BackgroundTransparency = 1.000
YBA.Toggle_Flight.BorderSizePixel = 0
YBA.Toggle_Flight.Position = UDim2.new(0.0404379405, 0, 0.282999992, 0)
YBA.Toggle_Flight.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
YBA.Toggle_Flight.ZIndex = 3
YBA.Toggle_Flight.Font = Enum.Font.GothamBold
YBA.Toggle_Flight.Text = "OFF"
YBA.Toggle_Flight.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_Flight.TextSize = 17.000

YBA.Roundify_12.Name = "Roundify"
YBA.Roundify_12.Parent = YBA.Toggle_Flight
YBA.Roundify_12.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_12.BackgroundTransparency = 1.000
YBA.Roundify_12.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_12.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_12.ZIndex = 2
YBA.Roundify_12.Image = "rbxassetid://3570695787"
YBA.Roundify_12.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_12.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_12.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_12.SliceScale = 0.120

YBA.Toggle_TargetPlayer.Name = "Toggle_TargetPlayer"
YBA.Toggle_TargetPlayer.Parent = YBA.Toggles_2
YBA.Toggle_TargetPlayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_TargetPlayer.BackgroundTransparency = 1.000
YBA.Toggle_TargetPlayer.BorderSizePixel = 0
YBA.Toggle_TargetPlayer.Position = UDim2.new(0.0400000848, 0, 0.535793841, 0)
YBA.Toggle_TargetPlayer.Size = UDim2.new(0.164963469, 0, 0.0807784647, 0)
YBA.Toggle_TargetPlayer.ZIndex = 3
YBA.Toggle_TargetPlayer.Font = Enum.Font.GothamBold
YBA.Toggle_TargetPlayer.Text = "OFF"
YBA.Toggle_TargetPlayer.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_TargetPlayer.TextSize = 17.000

YBA.Roundify_13.Name = "Roundify"
YBA.Roundify_13.Parent = YBA.Toggle_TargetPlayer
YBA.Roundify_13.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_13.BackgroundTransparency = 1.000
YBA.Roundify_13.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_13.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_13.ZIndex = 2
YBA.Roundify_13.Image = "rbxassetid://3570695787"
YBA.Roundify_13.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_13.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_13.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_13.SliceScale = 0.120

YBA.Toggle_ClickTP.Name = "Toggle_ClickTP"
YBA.Toggle_ClickTP.Parent = YBA.Toggles_2
YBA.Toggle_ClickTP.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_ClickTP.BackgroundTransparency = 1.000
YBA.Toggle_ClickTP.BorderSizePixel = 0
YBA.Toggle_ClickTP.Position = UDim2.new(0.0404379405, 0, 0.395000011, 0)
YBA.Toggle_ClickTP.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
YBA.Toggle_ClickTP.ZIndex = 3
YBA.Toggle_ClickTP.Font = Enum.Font.GothamBold
YBA.Toggle_ClickTP.Text = "OFF"
YBA.Toggle_ClickTP.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_ClickTP.TextSize = 17.000

YBA.Roundify_14.Name = "Roundify"
YBA.Roundify_14.Parent = YBA.Toggle_ClickTP
YBA.Roundify_14.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_14.BackgroundTransparency = 1.000
YBA.Roundify_14.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_14.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_14.ZIndex = 2
YBA.Roundify_14.Image = "rbxassetid://3570695787"
YBA.Roundify_14.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_14.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_14.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_14.SliceScale = 0.120

YBA.Toggle_TeleportToPlayer.Name = "Toggle_TeleportToPlayer"
YBA.Toggle_TeleportToPlayer.Parent = YBA.Toggles_2
YBA.Toggle_TeleportToPlayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_TeleportToPlayer.BackgroundTransparency = 1.000
YBA.Toggle_TeleportToPlayer.BorderSizePixel = 0
YBA.Toggle_TeleportToPlayer.Position = UDim2.new(0.0400000848, 0, 0.775680721, 0)
YBA.Toggle_TeleportToPlayer.Size = UDim2.new(0.164963469, 0, 0.0789766461, 0)
YBA.Toggle_TeleportToPlayer.ZIndex = 3
YBA.Toggle_TeleportToPlayer.Font = Enum.Font.GothamBold
YBA.Toggle_TeleportToPlayer.Text = "RUN"
YBA.Toggle_TeleportToPlayer.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_TeleportToPlayer.TextSize = 17.000

YBA.Roundify_15.Name = "Roundify"
YBA.Roundify_15.Parent = YBA.Toggle_TeleportToPlayer
YBA.Roundify_15.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_15.BackgroundTransparency = 1.000
YBA.Roundify_15.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_15.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_15.ZIndex = 2
YBA.Roundify_15.Image = "rbxassetid://3570695787"
YBA.Roundify_15.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_15.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_15.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_15.SliceScale = 0.120

YBA.ValueInputs.Name = "ValueInputs"
YBA.ValueInputs.Parent = YBA.CombatTab

YBA.Input_TargetPlayer.Name = "Input_TargetPlayer"
YBA.Input_TargetPlayer.Parent = YBA.ValueInputs
YBA.Input_TargetPlayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Input_TargetPlayer.BackgroundTransparency = 1.000
YBA.Input_TargetPlayer.BorderSizePixel = 0
YBA.Input_TargetPlayer.Position = UDim2.new(0.235759526, 0, 0.639807701, 0)
YBA.Input_TargetPlayer.Size = UDim2.new(0.716833174, 0, 0.0803743601, 0)
YBA.Input_TargetPlayer.ZIndex = 3
YBA.Input_TargetPlayer.Font = Enum.Font.GothamBold
YBA.Input_TargetPlayer.PlaceholderText = "[username]"
YBA.Input_TargetPlayer.Text = ""
YBA.Input_TargetPlayer.TextColor3 = Color3.fromRGB(198, 198, 198)
YBA.Input_TargetPlayer.TextSize = 18.000

YBA.Roundify_16.Name = "Roundify"
YBA.Roundify_16.Parent = YBA.Input_TargetPlayer
YBA.Roundify_16.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_16.BackgroundTransparency = 1.000
YBA.Roundify_16.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_16.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_16.ZIndex = 2
YBA.Roundify_16.Image = "rbxassetid://3570695787"
YBA.Roundify_16.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_16.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_16.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_16.SliceScale = 0.120

YBA.Input_SuperSpeed.Name = "Input_SuperSpeed"
YBA.Input_SuperSpeed.Parent = YBA.ValueInputs
YBA.Input_SuperSpeed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Input_SuperSpeed.BackgroundTransparency = 1.000
YBA.Input_SuperSpeed.Position = UDim2.new(0.610000014, 0, 0.0549999997, 0)
YBA.Input_SuperSpeed.Size = UDim2.new(0.165000007, 0, 0.0850000009, 0)
YBA.Input_SuperSpeed.ZIndex = 3
YBA.Input_SuperSpeed.Font = Enum.Font.GothamBold
YBA.Input_SuperSpeed.Text = "N/A"
YBA.Input_SuperSpeed.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Input_SuperSpeed.TextSize = 17.000

YBA.Roundify_17.Name = "Roundify"
YBA.Roundify_17.Parent = YBA.Input_SuperSpeed
YBA.Roundify_17.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_17.BackgroundTransparency = 1.000
YBA.Roundify_17.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_17.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_17.ZIndex = 2
YBA.Roundify_17.Image = "rbxassetid://3570695787"
YBA.Roundify_17.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_17.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_17.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_17.SliceScale = 0.120

YBA.Input_SuperJump.Name = "Input_SuperJump"
YBA.Input_SuperJump.Parent = YBA.ValueInputs
YBA.Input_SuperJump.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Input_SuperJump.BackgroundTransparency = 1.000
YBA.Input_SuperJump.Position = UDim2.new(0.610000014, 0, 0.169, 0)
YBA.Input_SuperJump.Size = UDim2.new(0.165000007, 0, 0.0850000009, 0)
YBA.Input_SuperJump.ZIndex = 3
YBA.Input_SuperJump.Font = Enum.Font.GothamBold
YBA.Input_SuperJump.Text = "N/A"
YBA.Input_SuperJump.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Input_SuperJump.TextSize = 17.000

YBA.Roundify_18.Name = "Roundify"
YBA.Roundify_18.Parent = YBA.Input_SuperJump
YBA.Roundify_18.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_18.BackgroundTransparency = 1.000
YBA.Roundify_18.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_18.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_18.ZIndex = 2
YBA.Roundify_18.Image = "rbxassetid://3570695787"
YBA.Roundify_18.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_18.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_18.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_18.SliceScale = 0.120

YBA.Input_Flight.Name = "Input_Flight"
YBA.Input_Flight.Parent = YBA.ValueInputs
YBA.Input_Flight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Input_Flight.BackgroundTransparency = 1.000
YBA.Input_Flight.Position = UDim2.new(0.610000014, 0, 0.282999992, 0)
YBA.Input_Flight.Size = UDim2.new(0.165000007, 0, 0.0850000009, 0)
YBA.Input_Flight.ZIndex = 3
YBA.Input_Flight.Font = Enum.Font.GothamBold
YBA.Input_Flight.Text = "N/A"
YBA.Input_Flight.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Input_Flight.TextSize = 17.000

YBA.Roundify_19.Name = "Roundify"
YBA.Roundify_19.Parent = YBA.Input_Flight
YBA.Roundify_19.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_19.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_19.BackgroundTransparency = 1.000
YBA.Roundify_19.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_19.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_19.ZIndex = 2
YBA.Roundify_19.Image = "rbxassetid://3570695787"
YBA.Roundify_19.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_19.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_19.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_19.SliceScale = 0.120

YBA.Input_TeleportToPlayer.Name = "Input_TeleportToPlayer"
YBA.Input_TeleportToPlayer.Parent = YBA.ValueInputs
YBA.Input_TeleportToPlayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Input_TeleportToPlayer.BackgroundTransparency = 1.000
YBA.Input_TeleportToPlayer.BorderSizePixel = 0
YBA.Input_TeleportToPlayer.Position = UDim2.new(0.235759526, 0, 0.877374828, 0)
YBA.Input_TeleportToPlayer.Size = UDim2.new(0.716833174, 0, 0.0785815492, 0)
YBA.Input_TeleportToPlayer.ZIndex = 3
YBA.Input_TeleportToPlayer.Font = Enum.Font.GothamBold
YBA.Input_TeleportToPlayer.PlaceholderText = "[username]"
YBA.Input_TeleportToPlayer.Text = ""
YBA.Input_TeleportToPlayer.TextColor3 = Color3.fromRGB(198, 198, 198)
YBA.Input_TeleportToPlayer.TextSize = 18.000

YBA.Roundify_20.Name = "Roundify"
YBA.Roundify_20.Parent = YBA.Input_TeleportToPlayer
YBA.Roundify_20.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_20.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_20.BackgroundTransparency = 1.000
YBA.Roundify_20.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_20.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_20.ZIndex = 2
YBA.Roundify_20.Image = "rbxassetid://3570695787"
YBA.Roundify_20.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_20.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_20.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_20.SliceScale = 0.120

YBA.Other_2.Name = "Other"
YBA.Other_2.Parent = YBA.CombatTab

YBA.Roundify_21.Name = "Roundify"
YBA.Roundify_21.Parent = YBA.Other_2
YBA.Roundify_21.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_21.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_21.BackgroundTransparency = 1.000
YBA.Roundify_21.Position = UDim2.new(0.5, 0, 0.267553151, 0)
YBA.Roundify_21.Size = UDim2.new(0.941604972, 0, 0.460224122, 0)
YBA.Roundify_21.Image = "rbxassetid://3570695787"
YBA.Roundify_21.ImageColor3 = Color3.fromRGB(43, 43, 43)
YBA.Roundify_21.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_21.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_21.SliceScale = 0.120

YBA.Roundify_22.Name = "Roundify"
YBA.Roundify_22.Parent = YBA.Other_2
YBA.Roundify_22.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_22.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_22.BackgroundTransparency = 1.000
YBA.Roundify_22.Position = UDim2.new(0.5, 0, 0.628080845, 0)
YBA.Roundify_22.Size = UDim2.new(0.941604972, 0, 0.216856956, 0)
YBA.Roundify_22.Image = "rbxassetid://3570695787"
YBA.Roundify_22.ImageColor3 = Color3.fromRGB(43, 43, 43)
YBA.Roundify_22.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_22.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_22.SliceScale = 0.120

YBA.Roundify_23.Name = "Roundify"
YBA.Roundify_23.Parent = YBA.Other_2
YBA.Roundify_23.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_23.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_23.BackgroundTransparency = 1.000
YBA.Roundify_23.Position = UDim2.new(0.5, 0, 0.865909457, 0)
YBA.Roundify_23.Size = UDim2.new(0.941604972, 0, 0.212019801, 0)
YBA.Roundify_23.Image = "rbxassetid://3570695787"
YBA.Roundify_23.ImageColor3 = Color3.fromRGB(43, 43, 43)
YBA.Roundify_23.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_23.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_23.SliceScale = 0.120

YBA.KeyBinds.Name = "KeyBinds"
YBA.KeyBinds.Parent = YBA.CombatTab

YBA.KeyBind_SuperSpeed.Name = "KeyBind_SuperSpeed"
YBA.KeyBind_SuperSpeed.Parent = YBA.KeyBinds
YBA.KeyBind_SuperSpeed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.KeyBind_SuperSpeed.BackgroundTransparency = 1.000
YBA.KeyBind_SuperSpeed.Position = UDim2.new(0.790000021, 0, 0.0549999997, 0)
YBA.KeyBind_SuperSpeed.Size = UDim2.new(0.165000007, 0, 0.0850000009, 0)
YBA.KeyBind_SuperSpeed.ZIndex = 3
YBA.KeyBind_SuperSpeed.Font = Enum.Font.GothamBold
YBA.KeyBind_SuperSpeed.Text = "N/A"
YBA.KeyBind_SuperSpeed.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.KeyBind_SuperSpeed.TextSize = 17.000

YBA.Roundify_24.Name = "Roundify"
YBA.Roundify_24.Parent = YBA.KeyBind_SuperSpeed
YBA.Roundify_24.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_24.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_24.BackgroundTransparency = 1.000
YBA.Roundify_24.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_24.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_24.ZIndex = 2
YBA.Roundify_24.Image = "rbxassetid://3570695787"
YBA.Roundify_24.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_24.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_24.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_24.SliceScale = 0.120

YBA.KeyBind_Flight.Name = "KeyBind_Flight"
YBA.KeyBind_Flight.Parent = YBA.KeyBinds
YBA.KeyBind_Flight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.KeyBind_Flight.BackgroundTransparency = 1.000
YBA.KeyBind_Flight.Position = UDim2.new(0.790000021, 0, 0.282999992, 0)
YBA.KeyBind_Flight.Size = UDim2.new(0.165000007, 0, 0.0850000009, 0)
YBA.KeyBind_Flight.ZIndex = 3
YBA.KeyBind_Flight.Font = Enum.Font.GothamBold
YBA.KeyBind_Flight.Text = "N/A"
YBA.KeyBind_Flight.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.KeyBind_Flight.TextSize = 17.000

YBA.Roundify_25.Name = "Roundify"
YBA.Roundify_25.Parent = YBA.KeyBind_Flight
YBA.Roundify_25.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_25.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_25.BackgroundTransparency = 1.000
YBA.Roundify_25.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_25.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_25.ZIndex = 2
YBA.Roundify_25.Image = "rbxassetid://3570695787"
YBA.Roundify_25.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_25.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_25.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_25.SliceScale = 0.120

YBA.ExtrasTab.Name = "ExtrasTab"
YBA.ExtrasTab.Parent = YBA.Tabs
YBA.ExtrasTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.ExtrasTab.BackgroundTransparency = 1.000
YBA.ExtrasTab.Position = UDim2.new(0, 0, 0.174980864, 0)
YBA.ExtrasTab.Size = UDim2.new(1, 0, 0.825019062, 0)
YBA.ExtrasTab.Visible = false
YBA.ExtrasTab.Image = "rbxassetid://3570695787"
YBA.ExtrasTab.ImageColor3 = Color3.fromRGB(77, 77, 77)
YBA.ExtrasTab.ScaleType = Enum.ScaleType.Slice
YBA.ExtrasTab.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.ExtrasTab.SliceScale = 0.120

YBA.TextLabels_3.Name = "TextLabels"
YBA.TextLabels_3.Parent = YBA.ExtrasTab

YBA.Text_24.Name = "Text"
YBA.Text_24.Parent = YBA.TextLabels_3
YBA.Text_24.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_24.BackgroundTransparency = 1.000
YBA.Text_24.Position = UDim2.new(0.241605088, 0, 0.0599999987, 0)
YBA.Text_24.Size = UDim2.new(0.442999989, 0, 0.0790000036, 0)
YBA.Text_24.ZIndex = 3
YBA.Text_24.Font = Enum.Font.GothamBold
YBA.Text_24.Text = "Player Health Bars"
YBA.Text_24.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_24.TextSize = 18.000
YBA.Text_24.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_25.Name = "Text"
YBA.Text_25.Parent = YBA.TextLabels_3
YBA.Text_25.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_25.BackgroundTransparency = 1.000
YBA.Text_25.Position = UDim2.new(0.089635849, 0, 0.296149015, 0)
YBA.Text_25.Size = UDim2.new(0.133204013, 0, 0.0862917826, 0)
YBA.Text_25.ZIndex = 3
YBA.Text_25.Font = Enum.Font.GothamBold
YBA.Text_25.Text = "User:"
YBA.Text_25.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_25.TextSize = 18.000
YBA.Text_25.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_26.Name = "Text"
YBA.Text_26.Parent = YBA.TextLabels_3
YBA.Text_26.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_26.BackgroundTransparency = 1.000
YBA.Text_26.Position = UDim2.new(0.244524837, 0, 0.198712707, 0)
YBA.Text_26.Size = UDim2.new(0.442697614, 0, 0.0804318786, 0)
YBA.Text_26.ZIndex = 3
YBA.Text_26.Font = Enum.Font.GothamBold
YBA.Text_26.Text = "Attach Stand"
YBA.Text_26.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_26.TextSize = 18.000
YBA.Text_26.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_27.Name = "Text"
YBA.Text_27.Parent = YBA.TextLabels_3
YBA.Text_27.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_27.BackgroundTransparency = 1.000
YBA.Text_27.Position = UDim2.new(0.089635849, 0, 0.532207847, 0)
YBA.Text_27.Size = UDim2.new(0.133204013, 0, 0.0843669772, 0)
YBA.Text_27.ZIndex = 3
YBA.Text_27.Font = Enum.Font.GothamBold
YBA.Text_27.Text = "User:"
YBA.Text_27.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_27.TextSize = 18.000
YBA.Text_27.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_28.Name = "Text"
YBA.Text_28.Parent = YBA.TextLabels_3
YBA.Text_28.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_28.BackgroundTransparency = 1.000
YBA.Text_28.Position = UDim2.new(0.245000005, 0, 0.436944604, 0)
YBA.Text_28.Size = UDim2.new(0.442697614, 0, 0.0786377713, 0)
YBA.Text_28.ZIndex = 3
YBA.Text_28.Font = Enum.Font.GothamBold
YBA.Text_28.Text = "Stand Target"
YBA.Text_28.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_28.TextSize = 18.000
YBA.Text_28.TextXAlignment = Enum.TextXAlignment.Left

YBA.Toggles_3.Name = "Toggles"
YBA.Toggles_3.Parent = YBA.ExtrasTab

YBA.Toggle_PlayerHealthBars.Name = "Toggle_PlayerHealthBars"
YBA.Toggle_PlayerHealthBars.Parent = YBA.Toggles_3
YBA.Toggle_PlayerHealthBars.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_PlayerHealthBars.BackgroundTransparency = 1.000
YBA.Toggle_PlayerHealthBars.BorderSizePixel = 0
YBA.Toggle_PlayerHealthBars.Position = UDim2.new(0.0404379405, 0, 0.054999996, 0)
YBA.Toggle_PlayerHealthBars.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
YBA.Toggle_PlayerHealthBars.ZIndex = 3
YBA.Toggle_PlayerHealthBars.Font = Enum.Font.GothamBold
YBA.Toggle_PlayerHealthBars.Text = "OFF"
YBA.Toggle_PlayerHealthBars.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_PlayerHealthBars.TextSize = 17.000

YBA.Roundify_26.Name = "Roundify"
YBA.Roundify_26.Parent = YBA.Toggle_PlayerHealthBars
YBA.Roundify_26.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_26.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_26.BackgroundTransparency = 1.000
YBA.Roundify_26.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_26.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_26.ZIndex = 2
YBA.Roundify_26.Image = "rbxassetid://3570695787"
YBA.Roundify_26.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_26.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_26.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_26.SliceScale = 0.120

YBA.Toggle_AttachStand.Name = "Toggle_AttachStand"
YBA.Toggle_AttachStand.Parent = YBA.Toggles_3
YBA.Toggle_AttachStand.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_AttachStand.BackgroundTransparency = 1.000
YBA.Toggle_AttachStand.BorderSizePixel = 0
YBA.Toggle_AttachStand.Position = UDim2.new(0.0400000848, 0, 0.198712617, 0)
YBA.Toggle_AttachStand.Size = UDim2.new(0.164963469, 0, 0.0802211836, 0)
YBA.Toggle_AttachStand.ZIndex = 3
YBA.Toggle_AttachStand.Font = Enum.Font.GothamBold
YBA.Toggle_AttachStand.Text = "OFF"
YBA.Toggle_AttachStand.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_AttachStand.TextSize = 17.000

YBA.Roundify_27.Name = "Roundify"
YBA.Roundify_27.Parent = YBA.Toggle_AttachStand
YBA.Roundify_27.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_27.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_27.BackgroundTransparency = 1.000
YBA.Roundify_27.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_27.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_27.ZIndex = 2
YBA.Roundify_27.Image = "rbxassetid://3570695787"
YBA.Roundify_27.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_27.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_27.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_27.SliceScale = 0.120

YBA.Toggle_StandTarget.Name = "Toggle_StandTarget"
YBA.Toggle_StandTarget.Parent = YBA.Toggles_3
YBA.Toggle_StandTarget.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_StandTarget.BackgroundTransparency = 1.000
YBA.Toggle_StandTarget.BorderSizePixel = 0
YBA.Toggle_StandTarget.Position = UDim2.new(0.0400000848, 0, 0.436944395, 0)
YBA.Toggle_StandTarget.Size = UDim2.new(0.164963469, 0, 0.0784317851, 0)
YBA.Toggle_StandTarget.ZIndex = 3
YBA.Toggle_StandTarget.Font = Enum.Font.GothamBold
YBA.Toggle_StandTarget.Text = "OFF"
YBA.Toggle_StandTarget.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_StandTarget.TextSize = 17.000

YBA.Roundify_28.Name = "Roundify"
YBA.Roundify_28.Parent = YBA.Toggle_StandTarget
YBA.Roundify_28.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_28.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_28.BackgroundTransparency = 1.000
YBA.Roundify_28.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_28.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_28.ZIndex = 2
YBA.Roundify_28.Image = "rbxassetid://3570695787"
YBA.Roundify_28.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_28.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_28.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_28.SliceScale = 0.120

YBA.Other_3.Name = "Other"
YBA.Other_3.Parent = YBA.ExtrasTab

YBA.Roundify_29.Name = "Roundify"
YBA.Roundify_29.Parent = YBA.Other_3
YBA.Roundify_29.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_29.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_29.BackgroundTransparency = 1.000
YBA.Roundify_29.Position = UDim2.new(0.5, 0, 0.100628249, 0)
YBA.Roundify_29.Size = UDim2.new(0.941604972, 0, 0.126374319, 0)
YBA.Roundify_29.Image = "rbxassetid://3570695787"
YBA.Roundify_29.ImageColor3 = Color3.fromRGB(43, 43, 43)
YBA.Roundify_29.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_29.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_29.SliceScale = 0.120

YBA.Roundify_30.Name = "Roundify"
YBA.Roundify_30.Parent = YBA.Other_3
YBA.Roundify_30.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_30.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_30.BackgroundTransparency = 1.000
YBA.Roundify_30.Position = UDim2.new(0.5, 0, 0.526550651, 0)
YBA.Roundify_30.Size = UDim2.new(0.941604972, 0, 0.210557088, 0)
YBA.Roundify_30.Image = "rbxassetid://3570695787"
YBA.Roundify_30.ImageColor3 = Color3.fromRGB(43, 43, 43)
YBA.Roundify_30.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_30.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_30.SliceScale = 0.120

YBA.Roundify_31.Name = "Roundify"
YBA.Roundify_31.Parent = YBA.Other_3
YBA.Roundify_31.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_31.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_31.BackgroundTransparency = 1.000
YBA.Roundify_31.Position = UDim2.new(0.5, 0, 0.290362835, 0)
YBA.Roundify_31.Size = UDim2.new(0.941604972, 0, 0.215360865, 0)
YBA.Roundify_31.Image = "rbxassetid://3570695787"
YBA.Roundify_31.ImageColor3 = Color3.fromRGB(43, 43, 43)
YBA.Roundify_31.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_31.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_31.SliceScale = 0.120

YBA.ValueInputs_2.Name = "ValueInputs"
YBA.ValueInputs_2.Parent = YBA.ExtrasTab

YBA.Input_AttachStand.Name = "Input_AttachStand"
YBA.Input_AttachStand.Parent = YBA.ValueInputs_2
YBA.Input_AttachStand.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Input_AttachStand.BackgroundTransparency = 1.000
YBA.Input_AttachStand.BorderSizePixel = 0
YBA.Input_AttachStand.Position = UDim2.new(0.235759526, 0, 0.302008808, 0)
YBA.Input_AttachStand.Size = UDim2.new(0.716833174, 0, 0.0798198581, 0)
YBA.Input_AttachStand.ZIndex = 3
YBA.Input_AttachStand.Font = Enum.Font.GothamBold
YBA.Input_AttachStand.PlaceholderText = "[username]"
YBA.Input_AttachStand.Text = ""
YBA.Input_AttachStand.TextColor3 = Color3.fromRGB(198, 198, 198)
YBA.Input_AttachStand.TextSize = 18.000

YBA.Roundify_32.Name = "Roundify"
YBA.Roundify_32.Parent = YBA.Input_AttachStand
YBA.Roundify_32.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_32.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_32.BackgroundTransparency = 1.000
YBA.Roundify_32.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_32.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_32.ZIndex = 2
YBA.Roundify_32.Image = "rbxassetid://3570695787"
YBA.Roundify_32.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_32.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_32.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_32.SliceScale = 0.120

YBA.Input_StandTarget.Name = "Input_StandTarget"
YBA.Input_StandTarget.Parent = YBA.ValueInputs_2
YBA.Input_StandTarget.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Input_StandTarget.BackgroundTransparency = 1.000
YBA.Input_StandTarget.BorderSizePixel = 0
YBA.Input_StandTarget.Position = UDim2.new(0.235759526, 0, 0.537936985, 0)
YBA.Input_StandTarget.Size = UDim2.new(0.716833174, 0, 0.0780394226, 0)
YBA.Input_StandTarget.ZIndex = 3
YBA.Input_StandTarget.Font = Enum.Font.GothamBold
YBA.Input_StandTarget.PlaceholderText = "[username]"
YBA.Input_StandTarget.Text = ""
YBA.Input_StandTarget.TextColor3 = Color3.fromRGB(198, 198, 198)
YBA.Input_StandTarget.TextSize = 18.000

YBA.Roundify_33.Name = "Roundify"
YBA.Roundify_33.Parent = YBA.Input_StandTarget
YBA.Roundify_33.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_33.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_33.BackgroundTransparency = 1.000
YBA.Roundify_33.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_33.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_33.ZIndex = 2
YBA.Roundify_33.Image = "rbxassetid://3570695787"
YBA.Roundify_33.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_33.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_33.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_33.SliceScale = 0.120

YBA.NPCsTab.Name = "NPCsTab"
YBA.NPCsTab.Parent = YBA.Tabs
YBA.NPCsTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.NPCsTab.BackgroundTransparency = 1.000
YBA.NPCsTab.Position = UDim2.new(0, 0, 0.174980864, 0)
YBA.NPCsTab.Size = UDim2.new(1, 0, 0.825019062, 0)
YBA.NPCsTab.Visible = false
YBA.NPCsTab.Image = "rbxassetid://3570695787"
YBA.NPCsTab.ImageColor3 = Color3.fromRGB(77, 77, 77)
YBA.NPCsTab.ScaleType = Enum.ScaleType.Slice
YBA.NPCsTab.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.NPCsTab.SliceScale = 0.120

YBA.TextLabels_4.Name = "TextLabels"
YBA.TextLabels_4.Parent = YBA.NPCsTab

YBA.Text_29.Name = "Text"
YBA.Text_29.Parent = YBA.TextLabels_4
YBA.Text_29.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_29.BackgroundTransparency = 1.000
YBA.Text_29.Position = UDim2.new(0.300000101, 0, 0.0549999513, 0)
YBA.Text_29.Size = UDim2.new(0.649999976, 0, 0.085651733, 0)
YBA.Text_29.ZIndex = 3
YBA.Text_29.Font = Enum.Font.GothamBold
YBA.Text_29.Text = "NPC Auto-Farm"
YBA.Text_29.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_29.TextSize = 18.000
YBA.Text_29.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_30.Name = "Text"
YBA.Text_30.Parent = YBA.TextLabels_4
YBA.Text_30.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_30.BackgroundTransparency = 1.000
YBA.Text_30.Position = UDim2.new(0.300000101, 0, 0.316515207, 0)
YBA.Text_30.Size = UDim2.new(0.649999976, 0, 0.0828600526, 0)
YBA.Text_30.ZIndex = 3
YBA.Text_30.Font = Enum.Font.GothamBold
YBA.Text_30.Text = "Quest Auto-Farm"
YBA.Text_30.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_30.TextSize = 18.000
YBA.Text_30.TextXAlignment = Enum.TextXAlignment.Left

YBA.Text_31.Name = "Text"
YBA.Text_31.Parent = YBA.TextLabels_4
YBA.Text_31.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Text_31.BackgroundTransparency = 1.000
YBA.Text_31.Position = UDim2.new(0.300000101, 0, 0.575578272, 0)
YBA.Text_31.Size = UDim2.new(0.649999976, 0, 0.0833253041, 0)
YBA.Text_31.ZIndex = 3
YBA.Text_31.Font = Enum.Font.GothamBold
YBA.Text_31.Text = "Quick Sell"
YBA.Text_31.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Text_31.TextSize = 18.000
YBA.Text_31.TextXAlignment = Enum.TextXAlignment.Left

YBA.Toggles_4.Name = "Toggles"
YBA.Toggles_4.Parent = YBA.NPCsTab

YBA.Toggle_NPCFarm.Name = "Toggle_NPCFarm"
YBA.Toggle_NPCFarm.Parent = YBA.Toggles_4
YBA.Toggle_NPCFarm.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_NPCFarm.BackgroundTransparency = 1.000
YBA.Toggle_NPCFarm.BorderSizePixel = 0
YBA.Toggle_NPCFarm.Position = UDim2.new(0.0404379405, 0, 0.054999996, 0)
YBA.Toggle_NPCFarm.Size = UDim2.new(0.164963469, 0, 0.0854273587, 0)
YBA.Toggle_NPCFarm.ZIndex = 3
YBA.Toggle_NPCFarm.Font = Enum.Font.GothamBold
YBA.Toggle_NPCFarm.Text = "OFF"
YBA.Toggle_NPCFarm.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_NPCFarm.TextSize = 17.000

YBA.Roundify_34.Name = "Roundify"
YBA.Roundify_34.Parent = YBA.Toggle_NPCFarm
YBA.Roundify_34.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_34.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_34.BackgroundTransparency = 1.000
YBA.Roundify_34.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_34.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_34.ZIndex = 2
YBA.Roundify_34.Image = "rbxassetid://3570695787"
YBA.Roundify_34.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_34.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_34.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_34.SliceScale = 0.120

YBA.Toggle_QuestFarm.Name = "Toggle_QuestFarm"
YBA.Toggle_QuestFarm.Parent = YBA.Toggles_4
YBA.Toggle_QuestFarm.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_QuestFarm.BackgroundTransparency = 1.000
YBA.Toggle_QuestFarm.BorderSizePixel = 0
YBA.Toggle_QuestFarm.Position = UDim2.new(0.0404379405, 0, 0.316515207, 0)
YBA.Toggle_QuestFarm.Size = UDim2.new(0.164963469, 0, 0.0826429948, 0)
YBA.Toggle_QuestFarm.ZIndex = 3
YBA.Toggle_QuestFarm.Font = Enum.Font.GothamBold
YBA.Toggle_QuestFarm.Text = "OFF"
YBA.Toggle_QuestFarm.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_QuestFarm.TextSize = 17.000

YBA.Roundify_35.Name = "Roundify"
YBA.Roundify_35.Parent = YBA.Toggle_QuestFarm
YBA.Roundify_35.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_35.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_35.BackgroundTransparency = 1.000
YBA.Roundify_35.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_35.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_35.ZIndex = 2
YBA.Roundify_35.Image = "rbxassetid://3570695787"
YBA.Roundify_35.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_35.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_35.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_35.SliceScale = 0.120

YBA.Toggle_QuickSell_One.Name = "Toggle_QuickSell_One"
YBA.Toggle_QuickSell_One.Parent = YBA.Toggles_4
YBA.Toggle_QuickSell_One.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_QuickSell_One.BackgroundTransparency = 1.000
YBA.Toggle_QuickSell_One.BorderSizePixel = 0
YBA.Toggle_QuickSell_One.Position = UDim2.new(0.0404379405, 0, 0.575578272, 0)
YBA.Toggle_QuickSell_One.Size = UDim2.new(0.164963469, 0, 0.0831070468, 0)
YBA.Toggle_QuickSell_One.ZIndex = 3
YBA.Toggle_QuickSell_One.Font = Enum.Font.GothamBold
YBA.Toggle_QuickSell_One.Text = "ONE"
YBA.Toggle_QuickSell_One.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_QuickSell_One.TextSize = 17.000

YBA.Roundify_36.Name = "Roundify"
YBA.Roundify_36.Parent = YBA.Toggle_QuickSell_One
YBA.Roundify_36.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_36.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_36.BackgroundTransparency = 1.000
YBA.Roundify_36.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_36.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_36.ZIndex = 2
YBA.Roundify_36.Image = "rbxassetid://3570695787"
YBA.Roundify_36.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_36.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_36.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_36.SliceScale = 0.120

YBA.Toggle_QuickSell_All.Name = "Toggle_QuickSell_All"
YBA.Toggle_QuickSell_All.Parent = YBA.Toggles_4
YBA.Toggle_QuickSell_All.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Toggle_QuickSell_All.BackgroundTransparency = 1.000
YBA.Toggle_QuickSell_All.BorderSizePixel = 0
YBA.Toggle_QuickSell_All.Position = UDim2.new(0.0404379405, 0, 0.689999998, 0)
YBA.Toggle_QuickSell_All.Size = UDim2.new(0.164963469, 0, 0.0831070468, 0)
YBA.Toggle_QuickSell_All.ZIndex = 3
YBA.Toggle_QuickSell_All.Font = Enum.Font.GothamBold
YBA.Toggle_QuickSell_All.Text = "ALL"
YBA.Toggle_QuickSell_All.TextColor3 = Color3.fromRGB(216, 34, 128)
YBA.Toggle_QuickSell_All.TextSize = 17.000

YBA.Roundify_37.Name = "Roundify"
YBA.Roundify_37.Parent = YBA.Toggle_QuickSell_All
YBA.Roundify_37.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_37.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_37.BackgroundTransparency = 1.000
YBA.Roundify_37.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_37.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_37.ZIndex = 2
YBA.Roundify_37.Image = "rbxassetid://3570695787"
YBA.Roundify_37.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_37.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_37.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_37.SliceScale = 0.120

YBA.Other_4.Name = "Other"
YBA.Other_4.Parent = YBA.NPCsTab

YBA.Roundify_38.Name = "Roundify"
YBA.Roundify_38.Parent = YBA.Other_4
YBA.Roundify_38.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_38.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_38.BackgroundTransparency = 1.000
YBA.Roundify_38.Position = UDim2.new(0.5, 0, 0.155229852, 0)
YBA.Roundify_38.Size = UDim2.new(0.941604972, 0, 0.235577524, 0)
YBA.Roundify_38.Image = "rbxassetid://3570695787"
YBA.Roundify_38.ImageColor3 = Color3.fromRGB(43, 43, 43)
YBA.Roundify_38.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_38.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_38.SliceScale = 0.120

YBA.Roundify_39.Name = "Roundify"
YBA.Roundify_39.Parent = YBA.Other_4
YBA.Roundify_39.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_39.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_39.BackgroundTransparency = 1.000
YBA.Roundify_39.Position = UDim2.new(0.5, 0, 0.413478404, 0)
YBA.Roundify_39.Size = UDim2.new(0.941604972, 0, 0.227899268, 0)
YBA.Roundify_39.Image = "rbxassetid://3570695787"
YBA.Roundify_39.ImageColor3 = Color3.fromRGB(43, 43, 43)
YBA.Roundify_39.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_39.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_39.SliceScale = 0.120

YBA.Roundify_40.Name = "Roundify"
YBA.Roundify_40.Parent = YBA.Other_4
YBA.Roundify_40.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_40.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_40.BackgroundTransparency = 1.000
YBA.Roundify_40.Position = UDim2.new(0.5, 0, 0.673085868, 0)
YBA.Roundify_40.Size = UDim2.new(0.941604972, 0, 0.22917895, 0)
YBA.Roundify_40.Image = "rbxassetid://3570695787"
YBA.Roundify_40.ImageColor3 = Color3.fromRGB(43, 43, 43)
YBA.Roundify_40.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_40.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_40.SliceScale = 0.120

YBA.DropdownMenus.Name = "DropdownMenus"
YBA.DropdownMenus.Parent = YBA.NPCsTab

YBA.DropDown_NPCs.Name = "DropDown_NPCs"
YBA.DropDown_NPCs.Parent = YBA.DropdownMenus
YBA.DropDown_NPCs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.DropDown_NPCs.BackgroundTransparency = 1.000
YBA.DropDown_NPCs.BorderSizePixel = 0
YBA.DropDown_NPCs.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.DropDown_NPCs.Size = UDim2.new(0.708037317, 0, 0.0947876275, 0)
YBA.DropDown_NPCs.ZIndex = 9
YBA.DropDown_NPCs.Font = Enum.Font.GothamBold
YBA.DropDown_NPCs.Text = "Thug"
YBA.DropDown_NPCs.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.DropDown_NPCs.TextSize = 17.000

YBA.Roundify_41.Name = "Roundify"
YBA.Roundify_41.Parent = YBA.DropDown_NPCs
YBA.Roundify_41.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_41.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_41.BackgroundTransparency = 1.000
YBA.Roundify_41.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_41.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_41.ZIndex = 2
YBA.Roundify_41.Image = "rbxassetid://3570695787"
YBA.Roundify_41.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_41.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_41.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_41.SliceScale = 0.120

YBA.Arrow.Name = "Arrow"
YBA.Arrow.Parent = YBA.DropDown_NPCs
YBA.Arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Arrow.BackgroundTransparency = 1.000
YBA.Arrow.Position = UDim2.new(0.0500000007, 0, 0.150000006, 0)
YBA.Arrow.Rotation = 90.000
YBA.Arrow.Size = UDim2.new(0.0700000003, 0, 0.699999988, 0)
YBA.Arrow.ZIndex = 2
YBA.Arrow.Image = "rbxassetid://71659683"
YBA.Arrow.ImageColor3 = Color3.fromRGB(230, 230, 230)

YBA.ScrollingFrame.Parent = YBA.DropdownMenus
YBA.ScrollingFrame.Active = true
YBA.ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.ScrollingFrame.BackgroundTransparency = 1.000
YBA.ScrollingFrame.BorderSizePixel = 0
YBA.ScrollingFrame.Position = UDim2.new(0.250999987, 0, 0.25, 0)
YBA.ScrollingFrame.Size = UDim2.new(0.708000004, 0, 0.335000008, 0)
YBA.ScrollingFrame.Visible = false
YBA.ScrollingFrame.ZIndex = 8
YBA.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)
YBA.ScrollingFrame.ScrollBarThickness = 10

YBA.Dropdown_Items.Name = "Dropdown_Items"
YBA.Dropdown_Items.Parent = YBA.ScrollingFrame

YBA.UIListLayout.Parent = YBA.Dropdown_Items
YBA.UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

YBA.Option1.Name = "Option1"
YBA.Option1.Parent = YBA.Dropdown_Items
YBA.Option1.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option1.BorderSizePixel = 0
YBA.Option1.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option1.Size = UDim2.new(1, 0, 0.056499999, 0)
YBA.Option1.ZIndex = 9
YBA.Option1.Font = Enum.Font.GothamBold
YBA.Option1.Text = "Thug"
YBA.Option1.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option1.TextSize = 17.000

YBA.Option2.Name = "Option2"
YBA.Option2.Parent = YBA.Dropdown_Items
YBA.Option2.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option2.BorderSizePixel = 0
YBA.Option2.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option2.Size = UDim2.new(1, 0, 0.056499999, 0)
YBA.Option2.ZIndex = 9
YBA.Option2.Font = Enum.Font.GothamBold
YBA.Option2.Text = "Alpha Thug"
YBA.Option2.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option2.TextSize = 17.000

YBA.Option3.Name = "Option3"
YBA.Option3.Parent = YBA.Dropdown_Items
YBA.Option3.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option3.BorderSizePixel = 0
YBA.Option3.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option3.Size = UDim2.new(1, 0, 0.056499999, 0)
YBA.Option3.ZIndex = 9
YBA.Option3.Font = Enum.Font.GothamBold
YBA.Option3.Text = "Security Guard"
YBA.Option3.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option3.TextSize = 17.000

YBA.Option4.Name = "Option4"
YBA.Option4.Parent = YBA.Dropdown_Items
YBA.Option4.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option4.BorderSizePixel = 0
YBA.Option4.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option4.Size = UDim2.new(1, 0, 0.056499999, 0)
YBA.Option4.ZIndex = 9
YBA.Option4.Font = Enum.Font.GothamBold
YBA.Option4.Text = "Corrupt Police"
YBA.Option4.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option4.TextSize = 17.000

YBA.Option5.Name = "Option5"
YBA.Option5.Parent = YBA.Dropdown_Items
YBA.Option5.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option5.BorderSizePixel = 0
YBA.Option5.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option5.Size = UDim2.new(1, 0, 0.056499999, 0)
YBA.Option5.ZIndex = 9
YBA.Option5.Font = Enum.Font.GothamBold
YBA.Option5.Text = "Zombie Henchman"
YBA.Option5.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option5.TextSize = 17.000

YBA.Option6.Name = "Option6"
YBA.Option6.Parent = YBA.Dropdown_Items
YBA.Option6.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option6.BorderSizePixel = 0
YBA.Option6.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option6.Size = UDim2.new(1, 0, 0.056499999, 0)
YBA.Option6.ZIndex = 9
YBA.Option6.Font = Enum.Font.GothamBold
YBA.Option6.Text = "Vampire"
YBA.Option6.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option6.TextSize = 17.000

YBA.DropDownBG.Name = "DropDownBG"
YBA.DropDownBG.Parent = YBA.DropdownMenus
YBA.DropDownBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.DropDownBG.BackgroundTransparency = 1.000
YBA.DropDownBG.Position = UDim2.new(0.251000017, 0, 0.158000022, 0)
YBA.DropDownBG.Size = UDim2.new(0.708000064, 0, 0.453810632, 0)
YBA.DropDownBG.Visible = false
YBA.DropDownBG.ZIndex = 7
YBA.DropDownBG.Image = "rbxassetid://3570695787"
YBA.DropDownBG.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.DropDownBG.ScaleType = Enum.ScaleType.Slice
YBA.DropDownBG.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.DropDownBG.SliceScale = 0.120

YBA.DropDownBG_BG.Name = "DropDownBG_BG"
YBA.DropDownBG_BG.Parent = YBA.DropDownBG
YBA.DropDownBG_BG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.DropDownBG_BG.BackgroundTransparency = 1.000
YBA.DropDownBG_BG.Position = UDim2.new(-0.00999999978, 0, -0.00999999978, 0)
YBA.DropDownBG_BG.Size = UDim2.new(1.01999998, 0, 1.01999998, 0)
YBA.DropDownBG_BG.Image = "rbxassetid://3570695787"
YBA.DropDownBG_BG.ImageColor3 = Color3.fromRGB(216, 34, 128)
YBA.DropDownBG_BG.ScaleType = Enum.ScaleType.Slice
YBA.DropDownBG_BG.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.DropDownBG_BG.SliceScale = 0.120

YBA.ScrollingFrame_2.Name = "ScrollingFrame_2"
YBA.ScrollingFrame_2.Parent = YBA.DropdownMenus
YBA.ScrollingFrame_2.Active = true
YBA.ScrollingFrame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.ScrollingFrame_2.BackgroundTransparency = 1.000
YBA.ScrollingFrame_2.BorderSizePixel = 0
YBA.ScrollingFrame_2.Position = UDim2.new(0.251000017, 0, 0.505159676, 0)
YBA.ScrollingFrame_2.Size = UDim2.new(0.708000004, 0, 0.324081242, 0)
YBA.ScrollingFrame_2.Visible = false
YBA.ScrollingFrame_2.ZIndex = 5
YBA.ScrollingFrame_2.CanvasSize = UDim2.new(0, 0, 1.5, 0)
YBA.ScrollingFrame_2.ScrollBarThickness = 10

YBA.Dropdown_Items_2.Name = "Dropdown_Items_2"
YBA.Dropdown_Items_2.Parent = YBA.ScrollingFrame_2

YBA.UIListLayout_2.Parent = YBA.Dropdown_Items_2
YBA.UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

YBA.Option1_2.Name = "Option1"
YBA.Option1_2.Parent = YBA.Dropdown_Items_2
YBA.Option1_2.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option1_2.BorderSizePixel = 0
YBA.Option1_2.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option1_2.Size = UDim2.new(1, 0, 0.056499999, 0)
YBA.Option1_2.ZIndex = 4
YBA.Option1_2.Font = Enum.Font.GothamBold
YBA.Option1_2.Text = "Officer Sam [Lvl. 1+]"
YBA.Option1_2.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option1_2.TextSize = 17.000
YBA.Option1_2.TextWrapped = true

YBA.Option2_2.Name = "Option2"
YBA.Option2_2.Parent = YBA.Dropdown_Items_2
YBA.Option2_2.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option2_2.BorderSizePixel = 0
YBA.Option2_2.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option2_2.Size = UDim2.new(1, 0, 0.056499999, 0)
YBA.Option2_2.ZIndex = 4
YBA.Option2_2.Font = Enum.Font.GothamBold
YBA.Option2_2.Text = "Deputy Bertrude [Lvl. 10+]"
YBA.Option2_2.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option2_2.TextSize = 17.000
YBA.Option2_2.TextWrapped = true

YBA.Option3_2.Name = "Option3"
YBA.Option3_2.Parent = YBA.Dropdown_Items_2
YBA.Option3_2.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option3_2.BorderSizePixel = 0
YBA.Option3_2.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option3_2.Size = UDim2.new(1, 0, 0.056499999, 0)
YBA.Option3_2.ZIndex = 4
YBA.Option3_2.Font = Enum.Font.GothamBold
YBA.Option3_2.Text = "Lion Abbacho's Partner [Lvl 15+]"
YBA.Option3_2.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option3_2.TextScaled = true
YBA.Option3_2.TextSize = 17.000
YBA.Option3_2.TextWrapped = true

YBA.Option4_2.Name = "Option4"
YBA.Option4_2.Parent = YBA.Dropdown_Items_2
YBA.Option4_2.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option4_2.BorderSizePixel = 0
YBA.Option4_2.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option4_2.Size = UDim2.new(1, 0, 0.056499999, 0)
YBA.Option4_2.ZIndex = 4
YBA.Option4_2.Font = Enum.Font.GothamBold
YBA.Option4_2.Text = "Dracula [Lvl. 20+]"
YBA.Option4_2.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option4_2.TextSize = 17.000
YBA.Option4_2.TextWrapped = true

YBA.Option5_2.Name = "Option5"
YBA.Option5_2.Parent = YBA.Dropdown_Items_2
YBA.Option5_2.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option5_2.BorderSizePixel = 0
YBA.Option5_2.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option5_2.Size = UDim2.new(1, 0, 0.056499999, 0)
YBA.Option5_2.ZIndex = 4
YBA.Option5_2.Font = Enum.Font.GothamBold
YBA.Option5_2.Text = "Dopey [Lvl. 30+]"
YBA.Option5_2.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option5_2.TextSize = 17.000
YBA.Option5_2.TextWrapped = true

YBA.Option6_2.Name = "Option6"
YBA.Option6_2.Parent = YBA.Dropdown_Items_2
YBA.Option6_2.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option6_2.BorderSizePixel = 0
YBA.Option6_2.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option6_2.Size = UDim2.new(1, 0, 0.056499999, 0)
YBA.Option6_2.ZIndex = 4
YBA.Option6_2.Font = Enum.Font.GothamBold
YBA.Option6_2.Text = "Deo [Lvl. 35+]"
YBA.Option6_2.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option6_2.TextSize = 17.000
YBA.Option6_2.TextWrapped = true

YBA.DropDown_Quests.Name = "DropDown_Quests"
YBA.DropDown_Quests.Parent = YBA.DropdownMenus
YBA.DropDown_Quests.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.DropDown_Quests.BackgroundTransparency = 1.000
YBA.DropDown_Quests.BorderSizePixel = 0
YBA.DropDown_Quests.Position = UDim2.new(0.250659823, 0, 0.416122407, 0)
YBA.DropDown_Quests.Size = UDim2.new(0.708037317, 0, 0.0916981772, 0)
YBA.DropDown_Quests.ZIndex = 6
YBA.DropDown_Quests.Font = Enum.Font.GothamBold
YBA.DropDown_Quests.Text = "Officer Sam [Lvl. 1+]"
YBA.DropDown_Quests.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.DropDown_Quests.TextSize = 17.000

YBA.Roundify_42.Name = "Roundify"
YBA.Roundify_42.Parent = YBA.DropDown_Quests
YBA.Roundify_42.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_42.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_42.BackgroundTransparency = 1.000
YBA.Roundify_42.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_42.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_42.ZIndex = 2
YBA.Roundify_42.Image = "rbxassetid://3570695787"
YBA.Roundify_42.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_42.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_42.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_42.SliceScale = 0.120

YBA.Arrow_2.Name = "Arrow_2"
YBA.Arrow_2.Parent = YBA.DropDown_Quests
YBA.Arrow_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Arrow_2.BackgroundTransparency = 1.000
YBA.Arrow_2.Position = UDim2.new(0.0500000007, 0, 0.150000006, 0)
YBA.Arrow_2.Rotation = 90.000
YBA.Arrow_2.Size = UDim2.new(0.0700000003, 0, 0.699999988, 0)
YBA.Arrow_2.ZIndex = 2
YBA.Arrow_2.Image = "rbxassetid://71659683"
YBA.Arrow_2.ImageColor3 = Color3.fromRGB(230, 230, 230)

YBA.DropDownBG_2.Name = "DropDownBG_2"
YBA.DropDownBG_2.Parent = YBA.DropdownMenus
YBA.DropDownBG_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.DropDownBG_2.BackgroundTransparency = 1.000
YBA.DropDownBG_2.Position = UDim2.new(0.251000017, 0, 0.416158289, 0)
YBA.DropDownBG_2.Size = UDim2.new(0.708000004, 0, 0.439019442, 0)
YBA.DropDownBG_2.Visible = false
YBA.DropDownBG_2.ZIndex = 2
YBA.DropDownBG_2.Image = "rbxassetid://3570695787"
YBA.DropDownBG_2.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.DropDownBG_2.ScaleType = Enum.ScaleType.Slice
YBA.DropDownBG_2.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.DropDownBG_2.SliceScale = 0.120

YBA.DropDownBG_BG_2.Name = "DropDownBG_BG_2"
YBA.DropDownBG_BG_2.Parent = YBA.DropDownBG_2
YBA.DropDownBG_BG_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.DropDownBG_BG_2.BackgroundTransparency = 1.000
YBA.DropDownBG_BG_2.Position = UDim2.new(-0.00999999978, 0, -0.00999999978, 0)
YBA.DropDownBG_BG_2.Size = UDim2.new(1.01999998, 0, 1.01999998, 0)
YBA.DropDownBG_BG_2.Image = "rbxassetid://3570695787"
YBA.DropDownBG_BG_2.ImageColor3 = Color3.fromRGB(216, 34, 128)
YBA.DropDownBG_BG_2.ScaleType = Enum.ScaleType.Slice
YBA.DropDownBG_BG_2.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.DropDownBG_BG_2.SliceScale = 0.120

YBA.ScrollingFrame_3.Name = "ScrollingFrame_3"
YBA.ScrollingFrame_3.Parent = YBA.DropdownMenus
YBA.ScrollingFrame_3.Active = true
YBA.ScrollingFrame_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.ScrollingFrame_3.BackgroundTransparency = 1.000
YBA.ScrollingFrame_3.BorderSizePixel = 0
YBA.ScrollingFrame_3.Position = UDim2.new(0.251000017, 0, 0.765281975, 0)
YBA.ScrollingFrame_3.Size = UDim2.new(0.708000004, 0, 0.325900972, 0)
YBA.ScrollingFrame_3.Visible = false
YBA.ScrollingFrame_3.ZIndex = 2
YBA.ScrollingFrame_3.CanvasSize = UDim2.new(0, 0, 3, 0)
YBA.ScrollingFrame_3.ScrollBarThickness = 10

YBA.Dropdown_Items_3.Name = "Dropdown_Items_3"
YBA.Dropdown_Items_3.Parent = YBA.ScrollingFrame_3

YBA.UIListLayout_3.Parent = YBA.Dropdown_Items_3
YBA.UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder

YBA.Option1_3.Name = "Option1"
YBA.Option1_3.Parent = YBA.Dropdown_Items_3
YBA.Option1_3.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option1_3.BorderSizePixel = 0
YBA.Option1_3.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option1_3.Size = UDim2.new(1, 0, 0.0270000007, 0)
YBA.Option1_3.ZIndex = 2
YBA.Option1_3.Font = Enum.Font.GothamBold
YBA.Option1_3.Text = "All Items"
YBA.Option1_3.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option1_3.TextSize = 17.000
YBA.Option1_3.TextWrapped = true

YBA.Option2_3.Name = "Option2"
YBA.Option2_3.Parent = YBA.Dropdown_Items_3
YBA.Option2_3.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option2_3.BorderSizePixel = 0
YBA.Option2_3.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option2_3.Size = UDim2.new(1, 0, 0.0270000007, 0)
YBA.Option2_3.ZIndex = 2
YBA.Option2_3.Font = Enum.Font.GothamBold
YBA.Option2_3.Text = "Mysterious Arrow"
YBA.Option2_3.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option2_3.TextSize = 17.000
YBA.Option2_3.TextWrapped = true

YBA.Option3_3.Name = "Option3"
YBA.Option3_3.Parent = YBA.Dropdown_Items_3
YBA.Option3_3.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option3_3.BorderSizePixel = 0
YBA.Option3_3.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option3_3.Size = UDim2.new(1, 0, 0.0270000007, 0)
YBA.Option3_3.ZIndex = 2
YBA.Option3_3.Font = Enum.Font.GothamBold
YBA.Option3_3.Text = "Rokakaka"
YBA.Option3_3.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option3_3.TextSize = 17.000
YBA.Option3_3.TextWrapped = true

YBA.Option4_3.Name = "Option4"
YBA.Option4_3.Parent = YBA.Dropdown_Items_3
YBA.Option4_3.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option4_3.BorderSizePixel = 0
YBA.Option4_3.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option4_3.Size = UDim2.new(1, 0, 0.0270000007, 0)
YBA.Option4_3.ZIndex = 2
YBA.Option4_3.Font = Enum.Font.GothamBold
YBA.Option4_3.Text = "Pure Rokakaka"
YBA.Option4_3.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option4_3.TextSize = 17.000
YBA.Option4_3.TextWrapped = true

YBA.Option5_3.Name = "Option5"
YBA.Option5_3.Parent = YBA.Dropdown_Items_3
YBA.Option5_3.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option5_3.BorderSizePixel = 0
YBA.Option5_3.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option5_3.Size = UDim2.new(1, 0, 0.0270000007, 0)
YBA.Option5_3.ZIndex = 2
YBA.Option5_3.Font = Enum.Font.GothamBold
YBA.Option5_3.Text = "Gold Coin"
YBA.Option5_3.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option5_3.TextSize = 17.000
YBA.Option5_3.TextWrapped = true

YBA.Option6_3.Name = "Option6"
YBA.Option6_3.Parent = YBA.Dropdown_Items_3
YBA.Option6_3.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option6_3.BorderSizePixel = 0
YBA.Option6_3.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option6_3.Size = UDim2.new(1, 0, 0.0270000007, 0)
YBA.Option6_3.ZIndex = 2
YBA.Option6_3.Font = Enum.Font.GothamBold
YBA.Option6_3.Text = "Diamond"
YBA.Option6_3.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option6_3.TextSize = 17.000
YBA.Option6_3.TextWrapped = true

YBA.Option7.Name = "Option7"
YBA.Option7.Parent = YBA.Dropdown_Items_3
YBA.Option7.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option7.BorderSizePixel = 0
YBA.Option7.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option7.Size = UDim2.new(1, 0, 0.0270000007, 0)
YBA.Option7.ZIndex = 2
YBA.Option7.Font = Enum.Font.GothamBold
YBA.Option7.Text = "Stone Mask"
YBA.Option7.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option7.TextSize = 17.000
YBA.Option7.TextWrapped = true

YBA.Option8.Name = "Option8"
YBA.Option8.Parent = YBA.Dropdown_Items_3
YBA.Option8.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option8.BorderSizePixel = 0
YBA.Option8.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option8.Size = UDim2.new(1, 0, 0.0270000007, 0)
YBA.Option8.ZIndex = 2
YBA.Option8.Font = Enum.Font.GothamBold
YBA.Option8.Text = "Quinton's Glove"
YBA.Option8.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option8.TextSize = 17.000
YBA.Option8.TextWrapped = true

YBA.Option9.Name = "Option9"
YBA.Option9.Parent = YBA.Dropdown_Items_3
YBA.Option9.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option9.BorderSizePixel = 0
YBA.Option9.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option9.Size = UDim2.new(1, 0, 0.0270000007, 0)
YBA.Option9.ZIndex = 2
YBA.Option9.Font = Enum.Font.GothamBold
YBA.Option9.Text = "Zepellin's Headband"
YBA.Option9.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option9.TextSize = 17.000
YBA.Option9.TextWrapped = true

YBA.Option10.Name = "Option10"
YBA.Option10.Parent = YBA.Dropdown_Items_3
YBA.Option10.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option10.BorderSizePixel = 0
YBA.Option10.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option10.Size = UDim2.new(1, 0, 0.0270000007, 0)
YBA.Option10.ZIndex = 2
YBA.Option10.Font = Enum.Font.GothamBold
YBA.Option10.Text = "Ancient Scroll"
YBA.Option10.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option10.TextSize = 17.000
YBA.Option10.TextWrapped = true

YBA.Option11.Name = "Option11"
YBA.Option11.Parent = YBA.Dropdown_Items_3
YBA.Option11.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option11.BorderSizePixel = 0
YBA.Option11.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option11.Size = UDim2.new(1, 0, 0.0270000007, 0)
YBA.Option11.ZIndex = 2
YBA.Option11.Font = Enum.Font.GothamBold
YBA.Option11.Text = "Steel Ball"
YBA.Option11.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option11.TextSize = 17.000
YBA.Option11.TextWrapped = true

YBA.Option12.Name = "Option12"
YBA.Option12.Parent = YBA.Dropdown_Items_3
YBA.Option12.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Option12.BorderSizePixel = 0
YBA.Option12.Position = UDim2.new(0.250659823, 0, 0.157962978, 0)
YBA.Option12.Size = UDim2.new(1, 0, 0.0270000007, 0)
YBA.Option12.ZIndex = 2
YBA.Option12.Font = Enum.Font.GothamBold
YBA.Option12.Text = "Ribcage Of The Saint's Corpse"
YBA.Option12.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.Option12.TextSize = 17.000
YBA.Option12.TextWrapped = true

YBA.DropDownBG_3.Name = "DropDownBG_3"
YBA.DropDownBG_3.Parent = YBA.DropdownMenus
YBA.DropDownBG_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.DropDownBG_3.BackgroundTransparency = 1.000
YBA.DropDownBG_3.Position = UDim2.new(0.251000017, 0, 0.675780714, 0)
YBA.DropDownBG_3.Size = UDim2.new(0.708000004, 0, 0.441484571, 0)
YBA.DropDownBG_3.Visible = false
YBA.DropDownBG_3.Image = "rbxassetid://3570695787"
YBA.DropDownBG_3.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.DropDownBG_3.ScaleType = Enum.ScaleType.Slice
YBA.DropDownBG_3.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.DropDownBG_3.SliceScale = 0.120

YBA.DropDownBG_BG_2_2.Name = "DropDownBG_BG_2"
YBA.DropDownBG_BG_2_2.Parent = YBA.DropDownBG_3
YBA.DropDownBG_BG_2_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.DropDownBG_BG_2_2.BackgroundTransparency = 1.000
YBA.DropDownBG_BG_2_2.Position = UDim2.new(-0.00999999978, 0, -0.00999999978, 0)
YBA.DropDownBG_BG_2_2.Size = UDim2.new(1.01999998, 0, 1.01999998, 0)
YBA.DropDownBG_BG_2_2.Image = "rbxassetid://3570695787"
YBA.DropDownBG_BG_2_2.ImageColor3 = Color3.fromRGB(216, 34, 128)
YBA.DropDownBG_BG_2_2.ScaleType = Enum.ScaleType.Slice
YBA.DropDownBG_BG_2_2.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.DropDownBG_BG_2_2.SliceScale = 0.120

YBA.DropDown_QuickSell.Name = "DropDown_QuickSell"
YBA.DropDown_QuickSell.Parent = YBA.DropdownMenus
YBA.DropDown_QuickSell.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.DropDown_QuickSell.BackgroundTransparency = 1.000
YBA.DropDown_QuickSell.BorderSizePixel = 0
YBA.DropDown_QuickSell.Position = UDim2.new(0.250659823, 0, 0.675744653, 0)
YBA.DropDown_QuickSell.Size = UDim2.new(0.708037317, 0, 0.0922130644, 0)
YBA.DropDown_QuickSell.ZIndex = 3
YBA.DropDown_QuickSell.Font = Enum.Font.GothamBold
YBA.DropDown_QuickSell.Text = "Mysterious Arrow"
YBA.DropDown_QuickSell.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.DropDown_QuickSell.TextSize = 17.000

YBA.Roundify_43.Name = "Roundify"
YBA.Roundify_43.Parent = YBA.DropDown_QuickSell
YBA.Roundify_43.AnchorPoint = Vector2.new(0.5, 0.5)
YBA.Roundify_43.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Roundify_43.BackgroundTransparency = 1.000
YBA.Roundify_43.Position = UDim2.new(0.5, 0, 0.5, 0)
YBA.Roundify_43.Size = UDim2.new(1, 0, 1, 0)
YBA.Roundify_43.ZIndex = 2
YBA.Roundify_43.Image = "rbxassetid://3570695787"
YBA.Roundify_43.ImageColor3 = Color3.fromRGB(62, 62, 62)
YBA.Roundify_43.ScaleType = Enum.ScaleType.Slice
YBA.Roundify_43.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Roundify_43.SliceScale = 0.120

YBA.Arrow_2_2.Name = "Arrow_2"
YBA.Arrow_2_2.Parent = YBA.DropDown_QuickSell
YBA.Arrow_2_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Arrow_2_2.BackgroundTransparency = 1.000
YBA.Arrow_2_2.Position = UDim2.new(0.0500000007, 0, 0.150000006, 0)
YBA.Arrow_2_2.Rotation = 90.000
YBA.Arrow_2_2.Size = UDim2.new(0.0700000003, 0, 0.699999988, 0)
YBA.Arrow_2_2.ZIndex = 2
YBA.Arrow_2_2.Image = "rbxassetid://71659683"
YBA.Arrow_2_2.ImageColor3 = Color3.fromRGB(230, 230, 230)

YBA.TopBar.Name = "TopBar"
YBA.TopBar.Parent = YBA.Frame

YBA.Frame_2.Parent = YBA.TopBar
YBA.Frame_2.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
YBA.Frame_2.BorderSizePixel = 0
YBA.Frame_2.Position = UDim2.new(0, 0, 0.0721408725, 0)
YBA.Frame_2.Size = UDim2.new(1, 0, 0.00795470085, 0)
YBA.Frame_2.ZIndex = 3

YBA.Frame_3.Parent = YBA.TopBar
YBA.Frame_3.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
YBA.Frame_3.BorderSizePixel = 0
YBA.Frame_3.Position = UDim2.new(0, 0, 0.0397740342, 0)
YBA.Frame_3.Size = UDim2.new(1, 0, 0.0403215587, 0)
YBA.Frame_3.ZIndex = 2

YBA.Frame_4.Name = "Frame"
YBA.Frame_4.Parent = YBA.TopBar
YBA.Frame_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Frame_4.BackgroundTransparency = 1.000
YBA.Frame_4.Size = UDim2.new(1, 0, 0.0721408576, 0)
YBA.Frame_4.ZIndex = 2
YBA.Frame_4.Image = "rbxassetid://3570695787"
YBA.Frame_4.ImageColor3 = Color3.fromRGB(77, 77, 77)
YBA.Frame_4.ScaleType = Enum.ScaleType.Slice
YBA.Frame_4.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Frame_4.SliceScale = 0.120

YBA.Title.Name = "Title"
YBA.Title.Parent = YBA.TopBar
YBA.Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Title.BackgroundTransparency = 1.000
YBA.Title.Size = UDim2.new(0.716784179, 0, 0.0734477267, 0)
YBA.Title.ZIndex = 3
YBA.Title.Font = Enum.Font.GothamBold
YBA.Title.Text = UI_Name
YBA.Title.TextColor3 = Color3.fromRGB(255, 44, 157)
YBA.Title.TextSize = 24.000

YBA.KeyBind_HideGui.Name = "KeyBind_HideGui"
YBA.KeyBind_HideGui.Parent = YBA.TopBar
YBA.KeyBind_HideGui.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.KeyBind_HideGui.BackgroundTransparency = 1.000
YBA.KeyBind_HideGui.Position = UDim2.new(0.724098146, 0, 0, 0)
YBA.KeyBind_HideGui.Size = UDim2.new(0.258383334, 0, 0.0631511956, 0)
YBA.KeyBind_HideGui.ZIndex = 3
YBA.KeyBind_HideGui.Font = Enum.Font.GothamBold
YBA.KeyBind_HideGui.Text = "Hide [RShift]"
YBA.KeyBind_HideGui.TextColor3 = Color3.fromRGB(209, 209, 209)
YBA.KeyBind_HideGui.TextScaled = true
YBA.KeyBind_HideGui.TextSize = 26.000
YBA.KeyBind_HideGui.TextWrapped = true

YBA.Frame_5.Name = "Frame"
YBA.Frame_5.Parent = YBA.Frame
YBA.Frame_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.Frame_5.BackgroundTransparency = 1.000
YBA.Frame_5.Size = UDim2.new(1, 0, 1, 0)
YBA.Frame_5.ZIndex = 0
YBA.Frame_5.Image = "rbxassetid://3570695787"
YBA.Frame_5.ImageColor3 = Color3.fromRGB(97, 97, 97)
YBA.Frame_5.ScaleType = Enum.ScaleType.Slice
YBA.Frame_5.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.Frame_5.SliceScale = 0.120

YBA.BorderBG.Name = "BorderBG"
YBA.BorderBG.Parent = YBA.Frame
YBA.BorderBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YBA.BorderBG.BackgroundTransparency = 1.000
YBA.BorderBG.Position = UDim2.new(-0.00999999978, 0, -0.00999999978, 0)
YBA.BorderBG.Size = UDim2.new(1.01999998, 0, 1.01999998, 0)
YBA.BorderBG.ZIndex = -1
YBA.BorderBG.Image = "rbxassetid://3570695787"
YBA.BorderBG.ImageColor3 = Color3.fromRGB(216, 34, 128)
YBA.BorderBG.ScaleType = Enum.ScaleType.Slice
YBA.BorderBG.SliceCenter = Rect.new(100, 100, 100, 100)
YBA.BorderBG.SliceScale = 0.120








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


-- Health Bar Billboard --
local BillboardGui = Instance.new("BillboardGui")
local Frame = Instance.new("Frame")
local Frame_2 = Instance.new("Frame")

--Properties:
BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
BillboardGui.Active = true
BillboardGui.ExtentsOffset = Vector3.new(0, 2, 0)
BillboardGui.LightInfluence = 1
BillboardGui.Size = UDim2.new(3, 0, .3, 0)

Frame.Parent = BillboardGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 62, 65)
Frame.BorderSizePixel = 0
Frame.Size = UDim2.new(1, 0, 1, 0)

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(94, 255, 99)
Frame_2.BorderSizePixel = 0
Frame_2.Size = UDim2.new(.5, 0, 1, 0)




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
                if v.Material == Enum.Material.ForceField then
                    return "Pure Roka."
                else
                    return "Rokakaka"
                end
                
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


local function toggle_SuperJump()
    while toggles.jump == true and wait(.2) do
        player.Character.Humanoid.JumpPower = superJump_jumpValue
    end
end


local function toggle_TargetPlayer(playerName)
    local lastPosition = player.Character.HumanoidRootPart.CFrame
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
    
    local connection = RS.Heartbeat:Connect(function()
        if foundPlayer and toggles.targetPlayer == true then
            player.Character.HumanoidRootPart.CFrame = foundPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
        end
    end)
    
    while foundPlayer and toggles.targetPlayer == true and wait(.5) do
        local rand = math.random(4)
        if rand == 4 then
            player.Character.RemoteEvent:FireServer("Attack", "m2")
        else
            player.Character.RemoteEvent:FireServer("Attack", "m1")
        end
    end
    
    connection:Disconnect()
    player.Character.HumanoidRootPart.CFrame = lastPosition
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


local function teleportToPlayer(playerName)
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
    
    if foundPlayer then
        player.Character.HumanoidRootPart.CFrame = foundPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
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

    local speed = flightSpeed

    repeat wait()
        player.Character.Humanoid.PlatformStand = true
        if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
            speed = flightSpeed
        elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
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
    if key:lower() == fly_KeyBind and YBA.Toggle_Flight.Text == "ON" then
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

local function toggle_PlayerHealthBars()
    while wait(.1) and toggles.playerHealthBars == true do
        for i, v in pairs(game:GetService("Players"):GetChildren()) do
            if v.Character then
                local head = v.Character:WaitForChild("Head")
                local health = v.Character:WaitForChild("Health")
                local healthBillboard = head:FindFirstChild(BillboardGui.Name)
                if healthBillboard then
                    local result = 1 * health.Value / health.MaxValue --new size
                    healthBillboard.Frame.Frame.Size = UDim2.new(result, 0, 1, 0)
                else
                    new_BillboardGui = BillboardGui:Clone()
                    new_BillboardGui.Parent = v.Character.Head
                    new_BillboardGui.Adornee = v.Character.Head
                    local result = 1 * health.Value / health.MaxValue --new size
                    new_BillboardGui.Frame.Frame.Size = UDim2.new(result, 0, 1, 0)
                end
            end
        end
    end
    for _, v in pairs(players:GetChildren()) do
        if v.Character then
            local healthBillboard = v.Character:FindFirstChild(BillboardGui.Name)
            if healthBillboard then healthBillboard:Destroy() end
        end
    end
end



local function toggle_standAttach(playerName)
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
    
    local char = player.Character
    local standMorph = char:FindFirstChild("StandMorph")
    
    if not standMorph then
        char.RemoteFunction:InvokeServer("Toggle", "ToggleStand")
    end
    
    if foundPlayer then
        local alignPos = standMorph.HumanoidRootPart.StandAttach.AlignPosition
        local alignOri = standMorph.HumanoidRootPart.StandAttach.AlignOrientation
        
        local target_char = game.Workspace.Living:FindFirstChild(playerName)
        if target_char then
            local target_RootPart = target_char.HumanoidRootPart
            
            alignPos.Attachment1 = target_RootPart.RootRigAttachment
            alignOri.Attachment1 = target_RootPart.RootRigAttachment
            
            target_RootPart.RootRigAttachment.CFrame = CFrame.new(0, -5, 0) * CFrame.Angles(math.rad(-90), math.rad(180), 0)
            
            repeat wait(.2) until toggles.AttachStand == false
            
            alignPos.Attachment1 = standMorph.HumanoidRootPart.StandAttach
            alignOri.Attachment1 = standMorph.HumanoidRootPart.StandAttach
        end
    end
end


local function toggle_standTarget(playerName)
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
    
    local char = player.Character
    local standMorph = char:FindFirstChild("StandMorph")
    
    if not standMorph then
        char.RemoteFunction:InvokeServer("Toggle", "ToggleStand")
    end
    
    if foundPlayer then
        local alignPos = standMorph.HumanoidRootPart.StandAttach.AlignPosition
        local alignOri = standMorph.HumanoidRootPart.StandAttach.AlignOrientation
        
        local target_char = game.Workspace.Living:FindFirstChild(playerName)
        if target_char then
            local target_RootPart = target_char.HumanoidRootPart
            
            alignPos.Attachment1 = target_RootPart.RootRigAttachment
            alignOri.Attachment1 = target_RootPart.RootRigAttachment
            
            target_RootPart.RootRigAttachment.CFrame = CFrame.new(0, -5, 0) * CFrame.Angles(math.rad(-90), math.rad(180), 0)
            
            repeat wait(.1)
                local rand = math.random(4)
                target_RootPart.RootRigAttachment.CFrame = CFrame.new(0, -5, 0) * CFrame.Angles(math.rad(-90), math.rad(180), 0)
                
                if rand == 4 then
                    player.Character.RemoteEvent:FireServer("Attack", "m2")
                else
                    player.Character.RemoteEvent:FireServer("Attack", "m1")
                end
                wait(.3)
                target_RootPart.RootRigAttachment.CFrame = CFrame.new(0, -30, 0)
            until toggles.StandTarget == false
            
            alignPos.Attachment1 = standMorph.HumanoidRootPart.StandAttach
            alignOri.Attachment1 = standMorph.HumanoidRootPart.StandAttach
        end
    end
end






-- [[ FUNCTIONS 4 ]] (NPCs functions mostly) --

local function toggle_NPCFarm(npcName, amount)
    if amount == 0 then
        return
    elseif amount == nil then
        amount = -1
    end
    
    local humanoid
    repeat wait(.1)
        humanoid = player.Character:FindFirstChild("Humanoid")
    until humanoid and humanoid.Health > .2
    
    local rootPart = player.Character.HumanoidRootPart
    local lastPosition = player.Character.HumanoidRootPart.CFrame

    local foundNPC
    for _, v in pairs(game.Workspace.Living:GetChildren()) do
        if v.Name == npcName and v.Humanoid.Health > .2 then
            foundNPC = v
        end
    end
    
    if not foundNPC then
        wait(.2)
        if toggles.NPCFarm == false and toggles.QuestFarm == false then
            toggle_NPCFarm(npcName, amount)
        else
            return
        end
    end
    
    local npcRoot = foundNPC:FindFirstChild("HumanoidRootPart")
    local human = foundNPC:WaitForChild("Humanoid")
    
    local connection = RS.Heartbeat:Connect(function()
        if foundNPC and (toggles.NPCFarm == true or toggles.QuestFarm == true) then
            rootPart.CFrame = npcRoot.CFrame * CFrame.new(0, 0, 3)
            local distance = (rootPart.Position - npcRoot.Position).Magnitude
            if distance > 5 then
                rootPart.CFrame = afkSpot
            end
        end
    end)
    
    repeat wait(.5)
        player.Character.RemoteEvent:FireServer("Attack", "m1")
        if not foundNPC then break end
        if foundNPC:FindFirstChild("Humanoid") then
            if foundNPC:FindFirstChild("Humanoid").Health < .2 then
                break
            end
        end
        
    until (toggles.NPCFarm == false and toggles.QuestFarm == false) or humanoid.Health < .2
    
    connection:Disconnect()
    rootPart.CFrame = afkSpot
    wait(.1)
    rootPart.CFrame = lastPosition
    
    if toggles.NPCFarm == true then
        toggle_NPCFarm(npcName, nil)
    elseif toggles.QuestFarm == true then
        if humanoid.Health < .2 then
            toggle_NPCFarm(npcName, amount)
        else
            toggle_NPCFarm(npcName, amount-1)
        end
    end
end


local function toggle_QuestFarm(questTitle)
    if toggles.QuestFarm == false then
        return
    end
    
    if questTitle == "Officer Sam [Lvl. 1+]" then
        player.Character.RemoteEvent:FireServer("EndDialogue", {["NPC"] = "Officer Sam", ["Option"] = "Option1", ["Dialogue"] = "Dialogue5"}) --if not first time
        player.Character.RemoteEvent:FireServer("EndDialogue", {["NPC"] = "Officer Sam", ["Option"] = "Option1", ["Dialogue"] = "Dialogue2"}) --if first time
        toggle_NPCFarm("Thug", 5)
        
    elseif questTitle == "Deputy Bertrude [Lvl. 10+]" then
        player.Character.RemoteEvent:FireServer("EndDialogue", {["NPC"] = "Deputy Bertrude", ["Option"] = "Option1", ["Dialogue"] = "Dialogue5"}) --if not first time
        player.Character.RemoteEvent:FireServer("EndDialogue", {["NPC"] = "Deputy Bertrude", ["Option"] = "Option1", ["Dialogue"] = "Dialogue2"}) --if first time
        toggle_NPCFarm("Corrupt Police", 5)
    
    elseif questTitle == "Lion Abbacho's Partner [Lvl 15+]" then
        player.Character.RemoteEvent:FireServer("EndDialogue", {["NPC"] = "Lion Abbacho's Partner", ["Option"] = "Option1", ["Dialogue"] = "Dialogue7"}) --if not first time
        player.Character.RemoteEvent:FireServer("EndDialogue", {["NPC"] = "Lion Abbacho's Partner", ["Option"] = "Option1", ["Dialogue"] = "Dialogue6"}) --if first time
        toggle_NPCFarm("Alpha Thug", 5)
    
    elseif questTitle == "Dracula [Lvl. 20+]" then
        player.Character.RemoteEvent:FireServer("EndDialogue", {["NPC"] = "Dracula", ["Option"] = "Option1", ["Dialogue"] = "Dialogue4"}) --if first time or not
        toggle_NPCFarm("Zombie Henchman", 3)
        
    elseif questTitle == "Dopey [Lvl. 30+]" then
        player.Character.RemoteEvent:FireServer("EndDialogue", {["NPC"] = "Dopey", ["Option"] = "Option1", ["Dialogue"] = "Dialogue5"}) --if not first time
        toggle_NPCFarm("Deo", 1)
    end
    toggle_QuestFarm(questTitle)
end


local function toggle_QuickSell(item, amount)
    if item == "All Items" then
        for _, v in pairs(player.Backpack:GetChildren()) do
            if v:IsA("Tool") then
                v.Parent = player.Character
                player.Character.RemoteEvent:FireServer("EndDialogue", {["NPC"] = "Merchant", ["Dialogue"] = "Dialogue5", ["Option"] = "Option2"})
            end
        end
    else    
        local itemObj = player.Character:FindFirstChild(item) or player.Backpack:FindFirstChild(item)
        if itemObj then
            itemObj.Parent = player.Character
            if amount == "one" then
                player.Character.RemoteEvent:FireServer("EndDialogue", {["NPC"] = "Merchant", ["Dialogue"] = "Dialogue5", ["Option"] = "Option1"})
        
            elseif amount == "all" then
                player.Character.RemoteEvent:FireServer("EndDialogue", {["NPC"] = "Merchant", ["Dialogue"] = "Dialogue5", ["Option"] = "Option2"})
            end 
        end
    end
end




-- [[ UI LOGIC ]] --
YBA.Toggle_ItemESP.MouseButton1Click:Connect(function()
    if toggles.ItemESP == false then
        toggles.ItemESP = true
        YBA.Toggle_ItemESP.Text = "ON"
        YBA.Toggle_ItemESP.TextColor3 = Color3.fromRGB(58, 216, 137)
        refreshItemsESP()
    else
        toggles.ItemESP = false
        YBA.Toggle_ItemESP.Text = "OFF"
        YBA.Toggle_ItemESP.TextColor3 = Color3.fromRGB(216, 34, 128)
        clearESP_Parts()
    end
end)

YBA.Toggle_ItemAutoFarm.MouseButton1Click:Connect(function()
    if toggles.ItemAutoFarm == false then
        toggles.ItemAutoFarm = true
        YBA.Toggle_ItemAutoFarm.Text = "ON"
        YBA.Toggle_ItemAutoFarm.TextColor3 = Color3.fromRGB(58, 216, 137)
        pickupNearbyItems()
        --startAutoFarm()
    else
        toggles.ItemAutoFarm = false
        YBA.Toggle_ItemAutoFarm.Text = "OFF"
        YBA.Toggle_ItemAutoFarm.TextColor3 = Color3.fromRGB(216, 34, 128)
    end
end)

YBA.Toggle_ItemNotifs.MouseButton1Click:Connect(function()
    if toggles.ItemNotifs == false then
        toggles.ItemNotifs = true
        YBA.Toggle_ItemNotifs.Text = "ON"
        YBA.Toggle_ItemNotifs.TextColor3 = Color3.fromRGB(58, 216, 137)
    else
        toggles.ItemNotifs = false
        YBA.Toggle_ItemNotifs.Text = "OFF"
        YBA.Toggle_ItemNotifs.TextColor3 = Color3.fromRGB(216, 34, 128)
    end
end)



YBA.Toggle_All.MouseButton1Click:Connect(function()
    if YBA.Toggle_All.Text == "" then
        YBA.Toggle_All.Text = "X"
        searchForAllItems = true
    else
        YBA.Toggle_All.Text = ""
        searchForAllItems = false
    end
end)

YBA.Toggle_Arrows.MouseButton1Click:Connect(function()
    if YBA.Toggle_Arrows.Text == "" then
        YBA.Toggle_Arrows.Text = "X"
        table.insert(FilterItems, "Myst. Arrow")
    else
        YBA.Toggle_Arrows.Text = ""
        table.remove("Myst. Arrow")
    end
end)

YBA.Toggle_Coins.MouseButton1Click:Connect(function()
    if YBA.Toggle_Coins.Text == "" then
        YBA.Toggle_Coins.Text = "X"
        table.insert(FilterItems, "Gold Coin")
    else
        YBA.Toggle_Coins.Text = ""
        table.remove("Gold Coin")
    end
end)

YBA.Toggle_Diamond.MouseButton1Click:Connect(function()
    if YBA.Toggle_Diamond.Text == "" then
        YBA.Toggle_Diamond.Text = "X"
        table.insert(FilterItems, "Diamond")
    else
        YBA.Toggle_Diamond.Text = ""
        table.remove("Diamond")
    end
end)

YBA.Toggle_Rokakaka.MouseButton1Click:Connect(function()
    if YBA.Toggle_Rokakaka.Text == "" then
        YBA.Toggle_Rokakaka.Text = "X"
        table.insert(FilterItems, "Rokakaka")
    else
        YBA.Toggle_Rokakaka.Text = ""
        table.remove("Rokakaka")
    end
end)

YBA.Toggle_RibCage.MouseButton1Click:Connect(function()
    if YBA.Toggle_RibCage.Text == "" then
        YBA.Toggle_RibCage.Text = "X"
        table.insert(FilterItems, "Rib Cage")
    else
        YBA.Toggle_RibCage.Text = ""
        table.remove("Rib Cage")
    end
end)

YBA.Toggle_DEOsDiary.MouseButton1Click:Connect(function()
    if YBA.Toggle_DEOsDiary.Text == "" then
        YBA.Toggle_DEOsDiary.Text = "X"
        table.insert(FilterItems, "DEO's Diary")
    else
        YBA.Toggle_DEOsDiary.Text = ""
        table.remove("DEO's Diary")
    end
end)

YBA.Toggle_SteelBall.MouseButton1Click:Connect(function()
    if YBA.Toggle_SteelBall.Text == "" then
        YBA.Toggle_SteelBall.Text = "X"
        table.insert(FilterItems, "Steel Ball")
    else
        YBA.Toggle_SteelBall.Text = ""
        table.remove("Steel Ball")
    end
end)

YBA.Toggle_StoneMask.MouseButton1Click:Connect(function()
    if YBA.Toggle_StoneMask.Text == "" then
        YBA.Toggle_StoneMask.Text = "X"
        table.insert(FilterItems, "Stone Mask")
    else
        YBA.Toggle_StoneMask.Text = ""
        table.remove("Stone Mask")
    end
end)

YBA.Toggle_PureRokakaka.MouseButton1Click:Connect(function()
    if YBA.Toggle_PureRokakaka.Text == "" then
        YBA.Toggle_PureRokakaka.Text = "X"
        table.insert(FilterItems, "Pure Roka.")
    else
        YBA.Toggle_PureRokakaka.Text = ""
        table.remove("Pure Roka.")
    end
end)

YBA.Toggle_Headband.MouseButton1Click:Connect(function()
    if YBA.Toggle_Headband.Text == "" then
        YBA.Toggle_Headband.Text = "X"
        table.insert(FilterItems, "Headband")
    else
        YBA.Toggle_Headband.Text = ""
        table.remove("Headband")
    end
end)

YBA.Toggle_LuckyArrow.MouseButton1Click:Connect(function()
    if YBA.Toggle_LuckyArrow.Text == "" then
        YBA.Toggle_LuckyArrow.Text = "X"
        table.insert(FilterItems, "Lucky Arrow")
    else
        YBA.Toggle_LuckyArrow.Text = ""
        table.remove("Lucky Arrow")
    end
end)



-- Combat tab listeners --
YBA.Toggle_Speed.MouseButton1Click:Connect(function()
    if toggles.superSpeed == false then
        toggles.superSpeed = true
        YBA.Toggle_Speed.Text = "ON"
        YBA.Toggle_Speed.TextColor3 = Color3.fromRGB(58, 216, 137)
        toggle_SuperSpeed(true)
    else
        toggles.superSpeed = false
        YBA.Toggle_Speed.Text = "OFF"
        YBA.Toggle_Speed.TextColor3 = Color3.fromRGB(216, 34, 128)
        toggle_SuperSpeed(false)
    end
end)

YBA.Toggle_Jump.MouseButton1Click:Connect(function()
    if toggles.jump == false then
        toggles.jump = true
        YBA.Toggle_Jump.Text = "ON"
        YBA.Toggle_Jump.TextColor3 = Color3.fromRGB(58, 216, 137)
        toggle_SuperJump()
    else
        toggles.jump = false
        YBA.Toggle_Jump.Text = "OFF"
        YBA.Toggle_Jump.TextColor3 = Color3.fromRGB(216, 34, 128)
    end
end)

YBA.Toggle_Flight.MouseButton1Click:Connect(function()
    if toggles.isFlying == false then
        toggles.isFlying = true
        YBA.Toggle_Flight.Text = "ON"
        YBA.Toggle_Flight.TextColor3 = Color3.fromRGB(58, 216, 137)
        Fly()
    else
        toggles.isFlying = false
        YBA.Toggle_Flight.Text = "OFF"
        YBA.Toggle_Flight.TextColor3 = Color3.fromRGB(216, 34, 128)
    end
end)

YBA.Toggle_ClickTP.MouseButton1Click:Connect(function()
    if toggles.ClickTP == false then
        toggles.ClickTP = true
        YBA.Toggle_ClickTP.Text = "ON"
        YBA.Toggle_ClickTP.TextColor3 = Color3.fromRGB(58, 216, 137)
        toggle_ClickTP(true)
    else
        toggles.ClickTP = false
        YBA.Toggle_ClickTP.Text = "OFF"
        YBA.Toggle_ClickTP.TextColor3 = Color3.fromRGB(216, 34, 128)
        toggle_ClickTP(false)
    end
end)

YBA.Toggle_TargetPlayer.MouseButton1Click:Connect(function()
    if toggles.targetPlayer == false then
        toggles.targetPlayer = true
        YBA.Toggle_TargetPlayer.Text = "ON"
        YBA.Toggle_TargetPlayer.TextColor3 = Color3.fromRGB(58, 216, 137)
        toggle_TargetPlayer(YBA.Input_TargetPlayer.Text)
    else
        toggles.targetPlayer = false
        YBA.Toggle_TargetPlayer.Text = "OFF"
        YBA.Toggle_TargetPlayer.TextColor3 = Color3.fromRGB(216, 34, 128)
    end
end)

YBA.Toggle_TeleportToPlayer.MouseButton1Click:Connect(function()
    teleportToPlayer(YBA.Input_TeleportToPlayer.Text)
end)



-- Extras tab listeners --
YBA.Toggle_PlayerHealthBars.MouseButton1Click:Connect(function()
    if toggles.playerHealthBars == false then
        toggles.playerHealthBars = true
        YBA.Toggle_PlayerHealthBars.Text = "ON"
        YBA.Toggle_PlayerHealthBars.TextColor3 = Color3.fromRGB(58, 216, 137)
        toggle_PlayerHealthBars()
    else
        toggles.playerHealthBars = false
        YBA.Toggle_PlayerHealthBars.Text = "OFF"
        YBA.Toggle_PlayerHealthBars.TextColor3 = Color3.fromRGB(216, 34, 128)
    end
end)

YBA.Toggle_AttachStand.MouseButton1Click:Connect(function()
    if toggles.AttachStand == false then
        toggles.AttachStand = true
        YBA.Toggle_AttachStand.Text = "ON"
        YBA.Toggle_AttachStand.TextColor3 = Color3.fromRGB(58, 216, 137)
        toggle_standAttach(YBA.Input_AttachStand.Text)
    else
        toggles.AttachStand = false
        YBA.Toggle_AttachStand.Text = "OFF"
        YBA.Toggle_AttachStand.TextColor3 = Color3.fromRGB(216, 34, 128)
    end
end)

YBA.Toggle_StandTarget.MouseButton1Click:Connect(function()
    if toggles.StandTarget == false then
        toggles.StandTarget = true
        YBA.Toggle_StandTarget.Text = "ON"
        YBA.Toggle_StandTarget.TextColor3 = Color3.fromRGB(58, 216, 137)
        toggle_standTarget(YBA.Input_StandTarget.Text)
    else
        toggles.StandTarget = false
        YBA.Toggle_StandTarget.Text = "OFF"
        YBA.Toggle_StandTarget.TextColor3 = Color3.fromRGB(216, 34, 128)
    end
end)



-- NPCs tab listeners --
YBA.Toggle_NPCFarm.MouseButton1Click:Connect(function()
    if toggles.NPCFarm == false then
        toggles.NPCFarm = true
        YBA.Toggle_NPCFarm.Text = "ON"
        YBA.Toggle_NPCFarm.TextColor3 = Color3.fromRGB(58, 216, 137)
        toggle_NPCFarm(YBA.DropDown_NPCs.Text, nil)
    else
        toggles.NPCFarm = false
        YBA.Toggle_NPCFarm.Text = "OFF"
        YBA.Toggle_NPCFarm.TextColor3 = Color3.fromRGB(216, 34, 128)
    end
end)

YBA.Toggle_QuestFarm.MouseButton1Click:Connect(function()
    if toggles.QuestFarm == false then
        toggles.QuestFarm = true
        YBA.Toggle_QuestFarm.Text = "ON"
        YBA.Toggle_QuestFarm.TextColor3 = Color3.fromRGB(58, 216, 137)
        toggle_QuestFarm(YBA.DropDown_Quests.Text)
    else
        toggles.QuestFarm = false
        YBA.Toggle_QuestFarm.Text = "OFF"
        YBA.Toggle_QuestFarm.TextColor3 = Color3.fromRGB(216, 34, 128)
    end
end)

YBA.Toggle_QuickSell_One.MouseButton1Click:Connect(function()
    toggle_QuickSell(YBA.DropDown_QuickSell.Text, "one")
end)

YBA.Toggle_QuickSell_All.MouseButton1Click:Connect(function()
    toggle_QuickSell(YBA.DropDown_QuickSell.Text, "all")
end)



-- Pages --
YBA.Combat.MouseButton1Click:Connect(function()
    YBA.CombatTab.Visible = true
    YBA.ItemsTab.Visible = false
    YBA.ExtrasTab.Visible = false
    YBA.NPCsTab.Visible = false
end)

YBA.Items.MouseButton1Click:Connect(function()
    YBA.ItemsTab.Visible = true
    YBA.CombatTab.Visible = false
    YBA.ExtrasTab.Visible = false
    YBA.NPCsTab.Visible = false
end)

YBA.Extras.MouseButton1Click:Connect(function()
    YBA.ExtrasTab.Visible = true
    YBA.ItemsTab.Visible = false
    YBA.CombatTab.Visible = false
    YBA.NPCsTab.Visible = false
end)

YBA.NPCs.MouseButton1Click:Connect(function()
    YBA.NPCsTab.Visible = true
    YBA.ExtrasTab.Visible = false
    YBA.ItemsTab.Visible = false
    YBA.CombatTab.Visible = false
end)



-- UI INPUT HANDLERS --
YBA.Input_SuperSpeed.Text = superSpeed_speedValue
YBA.Input_SuperJump.Text = superJump_jumpValue
YBA.Input_Flight.Text = flightSpeed

YBA.Input_SuperSpeed:GetPropertyChangedSignal("Text"):Connect(function()
    local newValue = tonumber(YBA.Input_SuperSpeed.Text)
    if newValue then
        if newValue > max_superSpeed_speedValue then
            superSpeed_speedValue = max_superSpeed_speedValue
            YBA.Input_SuperSpeed.Text = max_superSpeed_speedValue
        elseif newValue <= 0 then
            superSpeed_speedValue = 1
            YBA.Input_SuperSpeed.Text = 1
        else
            superSpeed_speedValue = YBA.Input_SuperSpeed.Text
        end
    end
end)

YBA.Input_SuperJump:GetPropertyChangedSignal("Text"):Connect(function()
    local newValue = tonumber(YBA.Input_SuperJump.Text)
    if newValue then
        if newValue > max_superJump_jumpValue then
            superJump_jumpValue = max_superJump_jumpValue
            YBA.Input_SuperJump.Text = max_superJump_jumpValue
        elseif newValue <= 0 then
            superJump_jumpValue = 1
            YBA.Input_SuperJump.Text = 1
        else
            superJump_jumpValue = YBA.Input_SuperJump.Text
        end
    end
end)

YBA.Input_Flight:GetPropertyChangedSignal("Text"):Connect(function()
    local newValue = tonumber(YBA.Input_Flight.Text)
    if newValue then
        if newValue > max_flightSpeed then
            flightSpeed = max_flightSpeed
            YBA.Input_Flight.Text = max_flightSpeed
        elseif newValue <= 0 then
            flightSpeed = 1
            YBA.Input_Flight.Text = 1
        else
            flightSpeed = YBA.Input_Flight.Text
        end
    end
end)


-- UI KEYBIND HANDLERS --
YBA.KeyBind_Flight.Text = "[" .. fly_KeyBind .. "]"
YBA.KeyBind_SuperSpeed.Text = "[" .. superSpeed_KeyBind .. "]"

YBA.KeyBind_Flight:GetPropertyChangedSignal("Text"):Connect(function()
    local newValue = YBA.KeyBind_Flight.Text
    if string.len(newValue) == 1 then
        fly_KeyBind = newValue
        YBA.KeyBind_Flight.Text = "[" .. newValue .. "]"
    elseif string.len(newValue) > 1 then
        YBA.KeyBind_Flight.Text = "[" .. fly_KeyBind .. "]"
    end
end)

YBA.KeyBind_SuperSpeed:GetPropertyChangedSignal("Text"):Connect(function()
    local newValue = YBA.KeyBind_SuperSpeed.Text
    if string.len(newValue) == 1 then
        superSpeed_KeyBind = newValue
        YBA.KeyBind_SuperSpeed.Text = "[" .. newValue .. "]"
    elseif string.len(newValue) > 1 then
        YBA.KeyBind_SuperSpeed.Text = "[" .. superSpeed_KeyBind .. "]"
    end
end)


-- UI DROPDOWN MENU/S HANDLERS --
YBA.DropDown_NPCs.MouseButton1Click:Connect(function()
    if YBA.ScrollingFrame.Visible == true then
        YBA.ScrollingFrame.Visible = false
        YBA.DropDownBG.Visible = false
    else
        YBA.ScrollingFrame.Visible = true
        YBA.DropDownBG.Visible = true
    end
end)

for _, v in pairs(YBA.Dropdown_Items:GetChildren()) do
    if v:IsA("TextButton") then
        v.MouseButton1Click:Connect(function()
            YBA.DropDown_NPCs.Text = v.Text
            YBA.ScrollingFrame.Visible = false
            YBA.DropDownBG.Visible = false
        end)
    end
end


YBA.DropDown_Quests.MouseButton1Click:Connect(function()
    if YBA.ScrollingFrame_2.Visible == true then
        YBA.ScrollingFrame_2.Visible = false
        YBA.DropDownBG_2.Visible = false
    else
        YBA.ScrollingFrame_2.Visible = true
        YBA.DropDownBG_2.Visible = true
    end
end)

for _, v in pairs(YBA.Dropdown_Items_2:GetChildren()) do
    if v:IsA("TextButton") then
        v.MouseButton1Click:Connect(function()
            YBA.DropDown_Quests.Text = v.Text
            YBA.ScrollingFrame_2.Visible = false
            YBA.DropDownBG_2.Visible = false
        end)
    end
end


YBA.DropDown_QuickSell.MouseButton1Click:Connect(function()
    if YBA.ScrollingFrame_3.Visible == true then
        YBA.ScrollingFrame_3.Visible = false
        YBA.DropDownBG_3.Visible = false
    else
        YBA.ScrollingFrame_3.Visible = true
        YBA.DropDownBG_3.Visible = true
    end
end)

for _, v in pairs(YBA.Dropdown_Items_3:GetChildren()) do
    if v:IsA("TextButton") then
        v.MouseButton1Click:Connect(function()
            YBA.DropDown_QuickSell.Text = v.Text
            YBA.ScrollingFrame_3.Visible = false
            YBA.DropDownBG_3.Visible = false
        end)
    end
end


-- Misc UIS --
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == close_open_GUI_kb then
        if YBA.YBA.Enabled == false then
            YBA.YBA.Enabled = true
        else
            YBA.YBA.Enabled = false
        end
    end
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
local FrameDrag = DraggableObject.new(YBA.Frame)
FrameDrag:Enable() --Enable the dragging

--------------------------------------------------------------------------------------------------------------------------------------


