-- Tradelands UI v2 --
local discordLink = "https://discord.com/invite/Tf3NvAEse3"

-- config
local UI_Name = "Tradelands can suck my ass"
local UI_Version = "V2.0.0"
local superSpeed_speedValue = 50
local min_superSpeed_speedValue = 16
local max_superSpeed_speedValue = 300
local superSpeed_KeyBind = "v" --temporary
local close_open_GUI_kb = Enum.KeyCode.RightShift
local autofarmKillswitch_Key = Enum.KeyCode.L
local autofarmKillswitch_Key_Trees = Enum.KeyCode.K

-- services
local players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local RS = game:GetService("RunService")
local Debris = game:GetService("Debris")

-- vars
local player = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local mouse = player:GetMouse()
local autofarm_ACTIVE = false --if set as false, the autofarm function won't work
local autofarm_ACTIVE_Trees = false -- same as above but for trees
local clickTP_ACTIVE = false
local walkOnWater_ACTIVE = false
local hoveringShip_conn
local fastShip_conn

-- [[ Events ]] --
local equipTool = game:GetService("ReplicatedStorage").RemoteFunctionz.Gear.Equip
local inventorySwap = game:GetService("ReplicatedStorage").RemoteFunctionz.Items.InventorySwap
local inventoryTable = game:GetService("ReplicatedStorage").RemoteFunctionz.Items.GetInventory

local islandTeleports = {
    -- ["Island Name"] = {Teleport Position, UI Position}
    ["Clydesdale"] =        {Vector3.new(-8452.83, 12.5491, -8392.31), UDim2.new(.1, 0, .06, 0)},
    ["Harrisburg"] =        {Vector3.new(4265.96, 11.6001, -9262.05), UDim2.new(.63, 0, .04, 0)},
    ["Fort Verner"] =       {Vector3.new(-1965.17, 11.5583, -6915.72), UDim2.new(.36, 0, .12, 0)},
    ["Nova Balreska"] =     {Vector3.new(-3092.22, 10.8918, -2831.56), UDim2.new(.3, 0, .26, 0)},
    ["Salem"] =             {Vector3.new(-7455.71, 9.47243, -1190.74), UDim2.new(.1, 0, .37, 0)},
    ["Blackwind Cove"] =    {Vector3.new(2603.38, 8.19999, -3769.93), UDim2.new(.54, 0, .26, 0)},
    ["Perth"] =             {Vector3.new(-1287.12, 9.35923, -928.268), UDim2.new(.4, 0, .4, 0)},
    ["Fenwick"] =           {Vector3.new(1132.58, 9.35923, 1867), UDim2.new(.47, 0, .5, 0)},
    ["Freeport"] =          {Vector3.new(-2006.26, 7.4606, 4224.06), UDim2.new(.35, 0, .59, 0)},
    ["Whitecrest"] =        {Vector3.new(4081.02, 14.5918, 3812.21), UDim2.new(.605, 0, .58, 0)},
    ["Cannoneer's Key"] =   {Vector3.new(-8453.07, 6.80968, 6571.19), UDim2.new(.1, 0, .7, 0)},
    ["Saint Christopher"] = {Vector3.new(-3709.86, 13.65, 9452.54), UDim2.new(.28, 0, .81, 0)},
    ["Nassau"] =            {Vector3.new(2170.62, 11.882, 10137.7), UDim2.new(.53, 0, .82, 0)},
    
    -- NS = Non-Spawn Islands:
    ["NS1"] =               {Vector3.new(-8916.61, 19.7971, -5259.28), UDim2.new(.05, 0, .21, 0)},
    ["NS2"] =               {Vector3.new(6734.39, 17.2631, -3738.7), UDim2.new(.73, 0, .27, 0)},
    ["NS3"] =               {Vector3.new(-433.382, 18.16, -3776.38), UDim2.new(.42, 0, .27, 0)},
    ["NS4"] =               {Vector3.new(-4063.66, 14.5572, 286.846), UDim2.new(.27, 0, .44, 0)},
    ["NS5"] =               {Vector3.new(-4776.27, 12.8646, 2480.87), UDim2.new(.23, 0, .54, 0)},
    
    -- Notable/Secret locations:
    -- Working chess game : 1735.6, 3.81039, 4295.2
}

local toggles = {
    --player
    superSpeed = false,
    ClickTP = false,
    WalkOnWater = false,
    --ship
    shipHover = false,
    shipSpeed = false,
    --farms
    woodFarm = false,
    rockFarm = false,
}


-- [[ CREATING MAIN UI ]] --
-- Checking for existing UI --
local UI_Exists = game.CoreGui:FindFirstChild(UI_Name)
if UI_Exists then UI_Exists:Destroy() end

-- Instances:
local TRD = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UI_Background = Instance.new("ImageLabel")
local TopBar_Frame = Instance.new("Frame")
local TopBar = Instance.new("ImageLabel")
local TopBar_BG = Instance.new("ImageLabel")
local UIGradient = Instance.new("UIGradient")
local TopBarBorderLine = Instance.new("Frame")
local Title_Label = Instance.new("TextLabel")
local Version_Label = Instance.new("TextLabel")
local TopBar_BG_2 = Instance.new("Frame")
local X_Button = Instance.new("ImageButton")
local Max_Button = Instance.new("ImageButton")
local Min_Button = Instance.new("ImageButton")
local SideBar = Instance.new("ImageLabel")
local Tabs = Instance.new("Folder")
local CreditsTab = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local DiscordLink = Instance.new("ImageLabel")
local DiscordLink_TL = Instance.new("TextLabel")
local CopyLink_Btn = Instance.new("TextButton")
local Roundify = Instance.new("ImageLabel")
local Credit1 = Instance.new("ImageLabel")
local Credit1_TL = Instance.new("TextLabel")
local Credit2 = Instance.new("ImageLabel")
local Credit2_TL = Instance.new("TextLabel")
local PlayerTab = Instance.new("ScrollingFrame")
local SuperSpeed = Instance.new("ImageLabel")
local SuperSpeed_TL = Instance.new("TextLabel")
local Toggle_Speed = Instance.new("ImageButton")
local Roundify_2 = Instance.new("ImageLabel")
local SuperSpeed_Settings = Instance.new("ImageLabel")
local Speed_TL = Instance.new("TextLabel")
local Speed_SliderFrame = Instance.new("ImageButton")
local Speed_Slider = Instance.new("ImageButton")
local SpeedValue_TL = Instance.new("TextLabel")
local WalkOnWater = Instance.new("ImageLabel")
local WalkOnWater_TL = Instance.new("TextLabel")
local Toggle_WalkOnWater = Instance.new("ImageButton")
local Roundify_3 = Instance.new("ImageLabel")
local TpToPlayer = Instance.new("ImageLabel")
local TpToPlayer_TL = Instance.new("TextLabel")
local Toggle_TeleportToPlayer = Instance.new("TextButton")
local Roundify_4 = Instance.new("ImageLabel")
local Input_TeleportToPlayer = Instance.new("TextBox")
local Roundify_5 = Instance.new("ImageLabel")
local ClickTP = Instance.new("ImageLabel")
local ClickTP_TL = Instance.new("TextLabel")
local Toggle_ClickTP = Instance.new("ImageButton")
local Roundify_6 = Instance.new("ImageLabel")
local UIListLayout_2 = Instance.new("UIListLayout")
local TeleportsTab = Instance.new("ScrollingFrame")
local UIListLayout_3 = Instance.new("UIListLayout")
local OpenMAPui = Instance.new("ImageLabel")
local OpenMAPui_TL = Instance.new("TextLabel")
local OpenMAPui_Btn = Instance.new("TextButton")
local Roundify_7 = Instance.new("ImageLabel")
local Clydesdale = Instance.new("ImageLabel")
local Teleport_TL = Instance.new("TextLabel")
local TeleportTo_Btn = Instance.new("TextButton")
local Roundify_8 = Instance.new("ImageLabel")
local Harrisburg = Instance.new("ImageLabel")
local Teleport_TL_2 = Instance.new("TextLabel")
local TeleportTo_Btn_2 = Instance.new("TextButton")
local Roundify_9 = Instance.new("ImageLabel")
local FortVerner = Instance.new("ImageLabel")
local Teleport_TL_3 = Instance.new("TextLabel")
local TeleportTo_Btn_3 = Instance.new("TextButton")
local Roundify_10 = Instance.new("ImageLabel")
local NovaBalreska = Instance.new("ImageLabel")
local Teleport_TL_4 = Instance.new("TextLabel")
local TeleportTo_Btn_4 = Instance.new("TextButton")
local Roundify_11 = Instance.new("ImageLabel")
local Salem = Instance.new("ImageLabel")
local Teleport_TL_5 = Instance.new("TextLabel")
local TeleportTo_Btn_5 = Instance.new("TextButton")
local Roundify_12 = Instance.new("ImageLabel")
local BlackwindCove = Instance.new("ImageLabel")
local Teleport_TL_6 = Instance.new("TextLabel")
local TeleportTo_Btn_6 = Instance.new("TextButton")
local Roundify_13 = Instance.new("ImageLabel")
local Perth = Instance.new("ImageLabel")
local Teleport_TL_7 = Instance.new("TextLabel")
local TeleportTo_Btn_7 = Instance.new("TextButton")
local Roundify_14 = Instance.new("ImageLabel")
local Fenwick = Instance.new("ImageLabel")
local Teleport_TL_8 = Instance.new("TextLabel")
local TeleportTo_Btn_8 = Instance.new("TextButton")
local Roundify_15 = Instance.new("ImageLabel")
local Freeport = Instance.new("ImageLabel")
local Teleport_TL_9 = Instance.new("TextLabel")
local TeleportTo_Btn_9 = Instance.new("TextButton")
local Roundify_16 = Instance.new("ImageLabel")
local Whitecrest = Instance.new("ImageLabel")
local Teleport_TL_10 = Instance.new("TextLabel")
local TeleportTo_Btn_10 = Instance.new("TextButton")
local Roundify_17 = Instance.new("ImageLabel")
local CannoneersKey = Instance.new("ImageLabel")
local Teleport_TL_11 = Instance.new("TextLabel")
local TeleportTo_Btn_11 = Instance.new("TextButton")
local Roundify_18 = Instance.new("ImageLabel")
local SaintChristopher = Instance.new("ImageLabel")
local Teleport_TL_12 = Instance.new("TextLabel")
local TeleportTo_Btn_12 = Instance.new("TextButton")
local Roundify_19 = Instance.new("ImageLabel")
local FarmsTab = Instance.new("ScrollingFrame")
local WoodFarm = Instance.new("ImageLabel")
local WoodFarm_TL = Instance.new("TextLabel")
local Toggle_WoodFarm = Instance.new("ImageButton")
local Roundify_20 = Instance.new("ImageLabel")
local UIListLayout_4 = Instance.new("UIListLayout")
local StoneFarm = Instance.new("ImageLabel")
local StoneFarm_TL = Instance.new("TextLabel")
local Toggle_StoneFarm = Instance.new("ImageButton")
local Roundify_21 = Instance.new("ImageLabel")
local ShipTab = Instance.new("ScrollingFrame")
local ShipHover = Instance.new("ImageLabel")
local ShipHover_TL = Instance.new("TextLabel")
local Toggle_ShipHover = Instance.new("ImageButton")
local Roundify_22 = Instance.new("ImageLabel")
local ShipSpeed = Instance.new("ImageLabel")
local ShipSpeed_TL = Instance.new("TextLabel")
local Toggle_ShipSpeed = Instance.new("ImageButton")
local Roundify_23 = Instance.new("ImageLabel")
local UIListLayout_5 = Instance.new("UIListLayout")
local TpToShip = Instance.new("ImageLabel")
local Teleport_TL_13 = Instance.new("TextLabel")
local TeleportTo_Btn_13 = Instance.new("TextButton")
local Roundify_24 = Instance.new("ImageLabel")
local TabButtons = Instance.new("Folder")
local Ship_Button = Instance.new("TextButton")
local background = Instance.new("ImageLabel")
local Player_Button = Instance.new("TextButton")
local background_2 = Instance.new("ImageLabel")
local Farms_Button = Instance.new("TextButton")
local background = Instance.new("ImageLabel")
local Teleports_Button = Instance.new("TextButton")
local background_4 = Instance.new("ImageLabel")
local Credits_Button = Instance.new("TextButton")
local background_5 = Instance.new("ImageLabel")

local Minimized = Instance.new("ImageButton")
local Logo = Instance.new("ImageButton")
local Logo2 = Instance.new("ImageButton")

local SliderBar = Instance.new("ImageButton")

--Properties:

TRD.Name = UI_Name
TRD.Parent = game.CoreGui
TRD.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = TRD
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundTransparency = 1
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
TS:Create(MainFrame, TweenInfo.new(.2, Enum.EasingStyle.Sine), {Size = UDim2.new(0.22200273, 0, 0.311015934, 0)}):Play()

UI_Background.Name = "UI_Background"
UI_Background.Parent = MainFrame
UI_Background.BackgroundTransparency = 1
UI_Background.Size = UDim2.new(1, 0, 1, 0)
UI_Background.Image = "rbxassetid://3570695787"
UI_Background.ImageColor3 = Color3.fromRGB(63, 63, 63)
UI_Background.ScaleType = Enum.ScaleType.Slice
UI_Background.SliceCenter = Rect.new(100, 100, 100, 100)
UI_Background.SliceScale = 0.080

TopBar_Frame.Name = "TopBar_Frame"
TopBar_Frame.Parent = MainFrame
TopBar_Frame.BackgroundTransparency = 1
TopBar_Frame.Size = UDim2.new(1, 0, 0.0816569924, 0)

TopBar.Name = "TopBar"
TopBar.Parent = TopBar_Frame
TopBar.BackgroundTransparency = 1
TopBar.Size = UDim2.new(1, 0, 1, 0)
TopBar.ZIndex = 4
TopBar.Image = "rbxassetid://3570695787"
TopBar.ImageColor3 = Color3.fromRGB(61, 61, 61)
TopBar.ScaleType = Enum.ScaleType.Slice
TopBar.SliceCenter = Rect.new(100, 100, 100, 100)
TopBar.SliceScale = 0.080

TopBar_BG.Name = "TopBar_BG"
TopBar_BG.Parent = TopBar
TopBar_BG.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
TopBar_BG.BorderSizePixel = 0
TopBar_BG.Position = UDim2.new(0, 0, 0.800000012, 0)
TopBar_BG.Size = UDim2.new(1, 0, 0.200000003, 0)
TopBar_BG.ZIndex = 3
TopBar_BG.ImageColor3 = Color3.fromRGB(61, 61, 61)

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(199, 199, 199)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(230, 230, 230)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(199, 199, 199))}
UIGradient.Parent = TopBar

TopBarBorderLine.Name = "TopBarBorderLine"
TopBarBorderLine.Parent = TopBar
TopBarBorderLine.BackgroundColor3 = Color3.fromRGB(0, 239, 35)
TopBarBorderLine.BorderSizePixel = 0
TopBarBorderLine.Position = UDim2.new(0, 0, 1, 0)
TopBarBorderLine.Size = UDim2.new(1, 0, 0.0500000007, 0)
TopBarBorderLine.ZIndex = 3

Title_Label.Name = "Title_Label"
Title_Label.Parent = TopBar
Title_Label.BackgroundTransparency = 1
Title_Label.Position = UDim2.new(0.200000003, 0, 0.25, 0)
Title_Label.Size = UDim2.new(0.600000024, 0, 0.600000024, 0)
Title_Label.ZIndex = 4
Title_Label.Font = Enum.Font.GothamBold
Title_Label.Text = UI_Name
Title_Label.TextColor3 = Color3.fromRGB(220, 220, 220)
Title_Label.TextScaled = true
Title_Label.TextWrapped = true

Version_Label.Name = "Version_Label"
Version_Label.Parent = TopBar
Version_Label.BackgroundTransparency = 1
Version_Label.Position = UDim2.new(0.629999995, 0, 0.25, 0)
Version_Label.Size = UDim2.new(0.600000024, 0, 0.600000024, 0)
Version_Label.ZIndex = 4
Version_Label.Font = Enum.Font.GothamBold
Version_Label.Text = UI_Version
Version_Label.TextColor3 = Color3.fromRGB(220, 220, 220)
Version_Label.TextScaled = true
Version_Label.TextWrapped = true

TopBar_BG_2.Name = "TopBar_BG"
TopBar_BG_2.Parent = TopBar
TopBar_BG_2.BackgroundColor3 = Color3.fromRGB(239, 0, 235)
TopBar_BG_2.BorderSizePixel = 0
TopBar_BG_2.Position = UDim2.new(0, 0, 0.800000012, 0)
TopBar_BG_2.Size = UDim2.new(1, 0, 0.200000003, 0)
TopBar_BG_2.ZIndex = 2

X_Button.Name = "X_Button"
X_Button.Parent = TopBar_Frame
X_Button.BackgroundTransparency = 1
X_Button.Position = UDim2.new(0.0299999993, 0, 0.300000012, 0)
X_Button.Size = UDim2.new(0.0299999993, 0, 0.449999988, 0)
X_Button.ZIndex = 5
X_Button.Image = "rbxassetid://3570695787"
X_Button.ImageColor3 = Color3.fromRGB(249, 77, 78)
X_Button.ScaleType = Enum.ScaleType.Slice
X_Button.SliceCenter = Rect.new(100, 100, 100, 100)
X_Button.SliceScale = 0.120

Max_Button.Name = "Max_Button"
Max_Button.Parent = TopBar_Frame
Max_Button.BackgroundTransparency = 1
Max_Button.Position = UDim2.new(0.0799999982, 0, 0.300000012, 0)
Max_Button.Size = UDim2.new(0.0299999993, 0, 0.449999988, 0)
Max_Button.ZIndex = 5
Max_Button.Image = "rbxassetid://3570695787"
Max_Button.ImageColor3 = Color3.fromRGB(254, 191, 45)
Max_Button.ScaleType = Enum.ScaleType.Slice
Max_Button.SliceCenter = Rect.new(100, 100, 100, 100)
Max_Button.SliceScale = 0.120

Min_Button.Name = "Min_Button"
Min_Button.Parent = TopBar_Frame
Min_Button.BackgroundTransparency = 1
Min_Button.Position = UDim2.new(0.129999995, 0, 0.300000012, 0)
Min_Button.Size = UDim2.new(0.0299999993, 0, 0.449999988, 0)
Min_Button.ZIndex = 5
Min_Button.Image = "rbxassetid://3570695787"
Min_Button.ImageColor3 = Color3.fromRGB(50, 209, 64)
Min_Button.ScaleType = Enum.ScaleType.Slice
Min_Button.SliceCenter = Rect.new(100, 100, 100, 100)
Min_Button.SliceScale = 0.120

SideBar.Name = "SideBar"
SideBar.Parent = MainFrame
SideBar.BackgroundTransparency = 1
SideBar.Size = UDim2.new(0.228034049, 0, 1, 0)
SideBar.Image = "rbxassetid://3570695787"
SideBar.ImageColor3 = Color3.fromRGB(53, 53, 53)
SideBar.ScaleType = Enum.ScaleType.Slice
SideBar.SliceCenter = Rect.new(100, 100, 100, 100)
SideBar.SliceScale = 0.080

Tabs.Name = "Tabs"
Tabs.Parent = MainFrame

CreditsTab.Name = "CreditsTab"
CreditsTab.Parent = Tabs
CreditsTab.Active = true
CreditsTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CreditsTab.BackgroundTransparency = 1
CreditsTab.BorderSizePixel = 0
CreditsTab.Position = UDim2.new(0.245999917, 0, 0.119999997, 0)
CreditsTab.Size = UDim2.new(0.739000142, 0, 0.859000087, 0)
CreditsTab.Visible = false
CreditsTab.CanvasSize = UDim2.new(0, 0, 1, 0)
CreditsTab.ScrollBarThickness = 6

UIListLayout_3.Parent = CreditsTab
UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_3.Padding = UDim.new(0.0250000004, 0)

DiscordLink.Name = "DiscordLink"
DiscordLink.Parent = CreditsTab
DiscordLink.BackgroundTransparency = 1
DiscordLink.Position = UDim2.new(0, 0, 0.130746022, 0)
DiscordLink.Size = UDim2.new(0.971999943, 0, 0.102082856, 0)
DiscordLink.Image = "rbxassetid://3570695787"
DiscordLink.ImageColor3 = Color3.fromRGB(38, 38, 38)
DiscordLink.ScaleType = Enum.ScaleType.Slice
DiscordLink.SliceCenter = Rect.new(100, 100, 100, 100)
DiscordLink.SliceScale = 0.060

DiscordLink_TL.Name = "DiscordLink_TL"
DiscordLink_TL.Parent = DiscordLink
DiscordLink_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DiscordLink_TL.BackgroundTransparency = 1
DiscordLink_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
DiscordLink_TL.Size = UDim2.new(0.663618565, 0, 1, 0)
DiscordLink_TL.ZIndex = 6
DiscordLink_TL.Font = Enum.Font.GothamBold
DiscordLink_TL.Text = "Discord Server Link"
DiscordLink_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
DiscordLink_TL.TextSize = 12
DiscordLink_TL.TextWrapped = true
DiscordLink_TL.TextXAlignment = Enum.TextXAlignment.Left

CopyLink_Btn.Name = "CopyLink_Btn"
CopyLink_Btn.Parent = DiscordLink
CopyLink_Btn.AnchorPoint = Vector2.new(0, 0.5)
CopyLink_Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CopyLink_Btn.BackgroundTransparency = 1
CopyLink_Btn.BorderSizePixel = 0
CopyLink_Btn.Position = UDim2.new(0.749213159, 0, 0.499999881, 0)
CopyLink_Btn.Size = UDim2.new(0.23855485, 0, 0.800000072, 0)
CopyLink_Btn.ZIndex = 2
CopyLink_Btn.Font = Enum.Font.GothamBold
CopyLink_Btn.Text = "Copy"
CopyLink_Btn.TextColor3 = Color3.fromRGB(211, 211, 211)
CopyLink_Btn.TextSize = 12
CopyLink_Btn.TextWrapped = true

Roundify_3.Name = "Roundify"
Roundify_3.Parent = CopyLink_Btn
Roundify_3.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_3.BackgroundTransparency = 1
Roundify_3.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_3.Size = UDim2.new(1, 0, 1, 0)
Roundify_3.Image = "rbxassetid://3570695787"
Roundify_3.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_3.ScaleType = Enum.ScaleType.Slice
Roundify_3.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_3.SliceScale = 0.060

Credit1.Name = "Credit1"
Credit1.Parent = CreditsTab
Credit1.BackgroundTransparency = 1
Credit1.Position = UDim2.new(0, 0, 0.130746022, 0)
Credit1.Size = UDim2.new(0.971999943, 0, 0.102082856, 0)
Credit1.Image = "rbxassetid://3570695787"
Credit1.ImageColor3 = Color3.fromRGB(38, 38, 38)
Credit1.ScaleType = Enum.ScaleType.Slice
Credit1.SliceCenter = Rect.new(100, 100, 100, 100)
Credit1.SliceScale = 0.060

Credit1_TL.Name = "Credit1_TL"
Credit1_TL.Parent = Credit1
Credit1_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Credit1_TL.BackgroundTransparency = 1
Credit1_TL.Position = UDim2.new(0.0489280932, 0, 0, 0)
Credit1_TL.Size = UDim2.new(0.903747737, 0, 1, 0)
Credit1_TL.ZIndex = 6
Credit1_TL.Font = Enum.Font.GothamBold
Credit1_TL.Text = "Made by zakater#1337"
Credit1_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
Credit1_TL.TextSize = 12
Credit1_TL.TextWrapped = true
Credit1_TL.TextXAlignment = Enum.TextXAlignment.Left

Credit2.Name = "Credit2"
Credit2.Parent = CreditsTab
Credit2.BackgroundTransparency = 1
Credit2.Position = UDim2.new(0, 0, 0.130746022, 0)
Credit2.Size = UDim2.new(0.971999943, 0, 0.102082856, 0)
Credit2.Image = "rbxassetid://3570695787"
Credit2.ImageColor3 = Color3.fromRGB(38, 38, 38)
Credit2.ScaleType = Enum.ScaleType.Slice
Credit2.SliceCenter = Rect.new(100, 100, 100, 100)
Credit2.SliceScale = 0.060

Credit2_TL.Name = "Credit2_TL"
Credit2_TL.Parent = Credit2
Credit2_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Credit2_TL.BackgroundTransparency = 1
Credit2_TL.Position = UDim2.new(0.0489280932, 0, 0, 0)
Credit2_TL.Size = UDim2.new(0.903747737, 0, 1, 0)
Credit2_TL.ZIndex = 6
Credit2_TL.Font = Enum.Font.GothamBold
Credit2_TL.Text = "TP script by Bananaa#1736"
Credit2_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
Credit2_TL.TextSize = 12
Credit2_TL.TextWrapped = true
Credit2_TL.TextXAlignment = Enum.TextXAlignment.Left

PlayerTab.Name = "PlayerTab"
PlayerTab.Parent = Tabs
PlayerTab.Active = true
PlayerTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PlayerTab.BackgroundTransparency = 1
PlayerTab.BorderSizePixel = 0
PlayerTab.Position = UDim2.new(0.245999917, 0, 0.119999997, 0)
PlayerTab.Size = UDim2.new(0.739000142, 0, 0.859000087, 0)
PlayerTab.Visible = true
PlayerTab.CanvasSize = UDim2.new(0, 0, 1, 0)
PlayerTab.ScrollBarThickness = 6

SuperSpeed.Name = "SuperSpeed"
SuperSpeed.Parent = PlayerTab
SuperSpeed.BackgroundTransparency = 1
SuperSpeed.Size = UDim2.new(0.971999943, 0, 0.0799999982, 0)
SuperSpeed.Image = "rbxassetid://3570695787"
SuperSpeed.ImageColor3 = Color3.fromRGB(38, 38, 38)
SuperSpeed.ScaleType = Enum.ScaleType.Slice
SuperSpeed.SliceCenter = Rect.new(100, 100, 100, 100)
SuperSpeed.SliceScale = 0.060

SuperSpeed_TL.Name = "SuperSpeed_TL"
SuperSpeed_TL.Parent = SuperSpeed
SuperSpeed_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SuperSpeed_TL.BackgroundTransparency = 1
SuperSpeed_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
SuperSpeed_TL.Size = UDim2.new(0.663618565, 0, 1, 0)
SuperSpeed_TL.ZIndex = 6
SuperSpeed_TL.Font = Enum.Font.GothamBold
SuperSpeed_TL.Text = "Super Speed"
SuperSpeed_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
SuperSpeed_TL.TextSize = 12
SuperSpeed_TL.TextWrapped = true
SuperSpeed_TL.TextXAlignment = Enum.TextXAlignment.Left

Toggle_Speed.Name = "Toggle_Speed"
Toggle_Speed.Parent = SuperSpeed
Toggle_Speed.AnchorPoint = Vector2.new(0, 0.5)
Toggle_Speed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Speed.BackgroundTransparency = 1
Toggle_Speed.Position = UDim2.new(0.834999979, 0, 0.499999881, 0)
Toggle_Speed.Size = UDim2.new(0.0549999997, 0, 0.5, 0)
Toggle_Speed.ZIndex = 2
Toggle_Speed.Image = "rbxassetid://3570695787"
Toggle_Speed.ScaleType = Enum.ScaleType.Slice
Toggle_Speed.SliceCenter = Rect.new(100, 100, 100, 100)

Roundify_2.Name = "Roundify"
Roundify_2.Parent = SuperSpeed
Roundify_2.AnchorPoint = Vector2.new(0, 0.5)
Roundify_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_2.BackgroundTransparency = 1
Roundify_2.Position = UDim2.new(0.834999979, 0, 0.499999881, 0)
Roundify_2.Size = UDim2.new(0.119999997, 0, 0.5, 0)
Roundify_2.Image = "rbxassetid://3570695787"
Roundify_2.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_2.ScaleType = Enum.ScaleType.Slice
Roundify_2.SliceCenter = Rect.new(100, 100, 100, 100)

SuperSpeed_Settings.Name = "SuperSpeed_Settings"
SuperSpeed_Settings.Parent = PlayerTab
SuperSpeed_Settings.BackgroundTransparency = 1
SuperSpeed_Settings.Position = UDim2.new(0, 0, 0.0700000003, 0)
SuperSpeed_Settings.Size = UDim2.new(0.971999943, 0, 0.0799999982, 0)
SuperSpeed_Settings.Image = "rbxassetid://3570695787"
SuperSpeed_Settings.ImageColor3 = Color3.fromRGB(44, 44, 44)
SuperSpeed_Settings.ScaleType = Enum.ScaleType.Slice
SuperSpeed_Settings.SliceCenter = Rect.new(100, 100, 100, 100)
SuperSpeed_Settings.SliceScale = 0.060

Speed_TL.Name = "Speed_TL"
Speed_TL.Parent = SuperSpeed_Settings
Speed_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Speed_TL.BackgroundTransparency = 1
Speed_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
Speed_TL.Size = UDim2.new(0.16822055, 0, 1, 0)
Speed_TL.ZIndex = 6
Speed_TL.Font = Enum.Font.GothamBold
Speed_TL.Text = "Speed"
Speed_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
Speed_TL.TextSize = 12
Speed_TL.TextWrapped = true
Speed_TL.TextXAlignment = Enum.TextXAlignment.Left

Speed_SliderFrame.Name = "Speed_SliderFrame"
Speed_SliderFrame.Parent = SuperSpeed_Settings
Speed_SliderFrame.AnchorPoint = Vector2.new(0, 0.5)
Speed_SliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Speed_SliderFrame.BackgroundTransparency = 1
Speed_SliderFrame.Position = UDim2.new(0.24038364, 0, 0.499999881, 0)
Speed_SliderFrame.Size = UDim2.new(0.596787989, 0, 0.400000006, 0)
Speed_SliderFrame.Image = "rbxassetid://3570695787"
Speed_SliderFrame.ImageColor3 = Color3.fromRGB(62, 62, 62)
Speed_SliderFrame.ScaleType = Enum.ScaleType.Slice
Speed_SliderFrame.SliceCenter = Rect.new(100, 100, 100, 100)

Speed_Slider.Name = "Speed_Slider"
Speed_Slider.Parent = Speed_SliderFrame
Speed_Slider.AnchorPoint = Vector2.new(0, 0.5)
Speed_Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Speed_Slider.BackgroundTransparency = 1
Speed_Slider.Position = UDim2.new(0.800000012, 0, 0.499999881, 0)
Speed_Slider.Size = UDim2.new(0.0799999982, 0, 1.20000005, 0)
Speed_Slider.ZIndex = 3
Speed_Slider.Image = "rbxassetid://3570695787"
Speed_Slider.ScaleType = Enum.ScaleType.Slice
Speed_Slider.SliceCenter = Rect.new(100, 100, 100, 100)

SpeedValue_TL.Name = "SpeedValue_TL"
SpeedValue_TL.Parent = SuperSpeed_Settings
SpeedValue_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SpeedValue_TL.BackgroundTransparency = 1
SpeedValue_TL.Position = UDim2.new(0.867276311, 0, 0, 0)
SpeedValue_TL.Size = UDim2.new(0.104002289, 0, 1, 0)
SpeedValue_TL.ZIndex = 6
SpeedValue_TL.Font = Enum.Font.GothamBold
SpeedValue_TL.Text = "999"
SpeedValue_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
SpeedValue_TL.TextSize = 12
SpeedValue_TL.TextXAlignment = Enum.TextXAlignment.Left

WalkOnWater.Name = "WalkOnWater"
WalkOnWater.Parent = PlayerTab
WalkOnWater.BackgroundTransparency = 1
WalkOnWater.Position = UDim2.new(0, 0, 0.319999993, 0)
WalkOnWater.Size = UDim2.new(0.971999943, 0, 0.0799999982, 0)
WalkOnWater.Image = "rbxassetid://3570695787"
WalkOnWater.ImageColor3 = Color3.fromRGB(38, 38, 38)
WalkOnWater.ScaleType = Enum.ScaleType.Slice
WalkOnWater.SliceCenter = Rect.new(100, 100, 100, 100)
WalkOnWater.SliceScale = 0.060

WalkOnWater_TL.Name = "WalkOnWater_TL"
WalkOnWater_TL.Parent = WalkOnWater
WalkOnWater_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WalkOnWater_TL.BackgroundTransparency = 1
WalkOnWater_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
WalkOnWater_TL.Size = UDim2.new(0.663618565, 0, 1, 0)
WalkOnWater_TL.ZIndex = 6
WalkOnWater_TL.Font = Enum.Font.GothamBold
WalkOnWater_TL.Text = "Walk on water"
WalkOnWater_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
WalkOnWater_TL.TextSize = 12
WalkOnWater_TL.TextWrapped = true
WalkOnWater_TL.TextXAlignment = Enum.TextXAlignment.Left

Toggle_WalkOnWater.Name = "Toggle_WalkOnWater"
Toggle_WalkOnWater.Parent = WalkOnWater
Toggle_WalkOnWater.AnchorPoint = Vector2.new(0, 0.5)
Toggle_WalkOnWater.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_WalkOnWater.BackgroundTransparency = 1
Toggle_WalkOnWater.Position = UDim2.new(0.834999979, 0, 0.499999881, 0)
Toggle_WalkOnWater.Size = UDim2.new(0.0549999997, 0, 0.5, 0)
Toggle_WalkOnWater.ZIndex = 2
Toggle_WalkOnWater.Image = "rbxassetid://3570695787"
Toggle_WalkOnWater.ScaleType = Enum.ScaleType.Slice
Toggle_WalkOnWater.SliceCenter = Rect.new(100, 100, 100, 100)

Roundify.Name = "Roundify"
Roundify.Parent = WalkOnWater
Roundify.AnchorPoint = Vector2.new(0, 0.5)
Roundify.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify.BackgroundTransparency = 1
Roundify.Position = UDim2.new(0.834999979, 0, 0.499999881, 0)
Roundify.Size = UDim2.new(0.119999997, 0, 0.5, 0)
Roundify.Image = "rbxassetid://3570695787"
Roundify.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify.ScaleType = Enum.ScaleType.Slice
Roundify.SliceCenter = Rect.new(100, 100, 100, 100)

TpToPlayer.Name = "TpToPlayer"
TpToPlayer.Parent = PlayerTab
TpToPlayer.BackgroundTransparency = 1
TpToPlayer.Position = UDim2.new(0, 0, 0.239999995, 0)
TpToPlayer.Size = UDim2.new(0.971999943, 0, 0.0799999982, 0)
TpToPlayer.Image = "rbxassetid://3570695787"
TpToPlayer.ImageColor3 = Color3.fromRGB(38, 38, 38)
TpToPlayer.ScaleType = Enum.ScaleType.Slice
TpToPlayer.SliceCenter = Rect.new(100, 100, 100, 100)
TpToPlayer.SliceScale = 0.060

TpToPlayer_TL.Name = "TpToPlayer_TL"
TpToPlayer_TL.Parent = TpToPlayer
TpToPlayer_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TpToPlayer_TL.BackgroundTransparency = 1
TpToPlayer_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
TpToPlayer_TL.Size = UDim2.new(0.308889121, 0, 1, 0)
TpToPlayer_TL.ZIndex = 6
TpToPlayer_TL.Font = Enum.Font.GothamBold
TpToPlayer_TL.Text = "Tp To Player"
TpToPlayer_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
TpToPlayer_TL.TextSize = 12
TpToPlayer_TL.TextWrapped = true
TpToPlayer_TL.TextXAlignment = Enum.TextXAlignment.Left

Toggle_TeleportToPlayer.Name = "Toggle_TeleportToPlayer"
Toggle_TeleportToPlayer.Parent = TpToPlayer
Toggle_TeleportToPlayer.AnchorPoint = Vector2.new(0, 0.5)
Toggle_TeleportToPlayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_TeleportToPlayer.BackgroundTransparency = 1
Toggle_TeleportToPlayer.BorderSizePixel = 0
Toggle_TeleportToPlayer.Position = UDim2.new(0.749213159, 0, 0.499999881, 0)
Toggle_TeleportToPlayer.Size = UDim2.new(0.23855485, 0, 0.800000072, 0)
Toggle_TeleportToPlayer.ZIndex = 2
Toggle_TeleportToPlayer.Font = Enum.Font.GothamBold
Toggle_TeleportToPlayer.Text = "Teleport"
Toggle_TeleportToPlayer.TextColor3 = Color3.fromRGB(211, 211, 211)
Toggle_TeleportToPlayer.TextSize = 12
Toggle_TeleportToPlayer.TextWrapped = true

Roundify_4.Name = "Roundify"
Roundify_4.Parent = Toggle_TeleportToPlayer
Roundify_4.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_4.BackgroundTransparency = 1
Roundify_4.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_4.Size = UDim2.new(1, 0, 1, 0)
Roundify_4.Image = "rbxassetid://3570695787"
Roundify_4.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_4.ScaleType = Enum.ScaleType.Slice
Roundify_4.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_4.SliceScale = 0.060

Input_TeleportToPlayer.Name = "Input_TeleportToPlayer"
Input_TeleportToPlayer.Parent = TpToPlayer
Input_TeleportToPlayer.AnchorPoint = Vector2.new(0, 0.5)
Input_TeleportToPlayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Input_TeleportToPlayer.BackgroundTransparency = 1
Input_TeleportToPlayer.Position = UDim2.new(0.385309637, 0, 0.499999642, 0)
Input_TeleportToPlayer.Size = UDim2.new(0.333798528, 0, 0.699999988, 0)
Input_TeleportToPlayer.ZIndex = 2
Input_TeleportToPlayer.Font = Enum.Font.GothamBold
Input_TeleportToPlayer.PlaceholderText = "User"
Input_TeleportToPlayer.Text = ""
Input_TeleportToPlayer.TextColor3 = Color3.fromRGB(232, 232, 232)
Input_TeleportToPlayer.TextSize = 12

Roundify_5.Name = "Roundify"
Roundify_5.Parent = Input_TeleportToPlayer
Roundify_5.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_5.BackgroundTransparency = 1
Roundify_5.Position = UDim2.new(0.486625284, 0, 0.49999994, 0)
Roundify_5.Size = UDim2.new(1.02674866, 0, 1, 0)
Roundify_5.Image = "rbxassetid://3570695787"
Roundify_5.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_5.ScaleType = Enum.ScaleType.Slice
Roundify_5.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_5.SliceScale = 0.060

ClickTP.Name = "ClickTP"
ClickTP.Parent = PlayerTab
ClickTP.BackgroundTransparency = 1
ClickTP.Position = UDim2.new(0, 0, 0.156000003, 0)
ClickTP.Size = UDim2.new(0.971999943, 0, 0.0799999982, 0)
ClickTP.Image = "rbxassetid://3570695787"
ClickTP.ImageColor3 = Color3.fromRGB(38, 38, 38)
ClickTP.ScaleType = Enum.ScaleType.Slice
ClickTP.SliceCenter = Rect.new(100, 100, 100, 100)
ClickTP.SliceScale = 0.060

ClickTP_TL.Name = "ClickTP_TL"
ClickTP_TL.Parent = ClickTP
ClickTP_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClickTP_TL.BackgroundTransparency = 1
ClickTP_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
ClickTP_TL.Size = UDim2.new(0.663618565, 0, 1, 0)
ClickTP_TL.ZIndex = 6
ClickTP_TL.Font = Enum.Font.GothamBold
ClickTP_TL.Text = "Shift + Click = TP"
ClickTP_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
ClickTP_TL.TextSize = 12
ClickTP_TL.TextWrapped = true
ClickTP_TL.TextXAlignment = Enum.TextXAlignment.Left

Toggle_ClickTP.Name = "Toggle_ClickTP"
Toggle_ClickTP.Parent = ClickTP
Toggle_ClickTP.AnchorPoint = Vector2.new(0, 0.5)
Toggle_ClickTP.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_ClickTP.BackgroundTransparency = 1
Toggle_ClickTP.Position = UDim2.new(0.834999979, 0, 0.499999881, 0)
Toggle_ClickTP.Size = UDim2.new(0.0549999997, 0, 0.5, 0)
Toggle_ClickTP.ZIndex = 2
Toggle_ClickTP.Image = "rbxassetid://3570695787"
Toggle_ClickTP.ScaleType = Enum.ScaleType.Slice
Toggle_ClickTP.SliceCenter = Rect.new(100, 100, 100, 100)

Roundify_6.Name = "Roundify"
Roundify_6.Parent = ClickTP
Roundify_6.AnchorPoint = Vector2.new(0, 0.5)
Roundify_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_6.BackgroundTransparency = 1
Roundify_6.Position = UDim2.new(0.834999979, 0, 0.499999881, 0)
Roundify_6.Size = UDim2.new(0.119999997, 0, 0.5, 0)
Roundify_6.Image = "rbxassetid://3570695787"
Roundify_6.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_6.ScaleType = Enum.ScaleType.Slice
Roundify_6.SliceCenter = Rect.new(100, 100, 100, 100)

UIListLayout_2.Parent = PlayerTab
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.Padding = UDim.new(0.0250000004, 0)

TeleportsTab.Name = "TeleportsTab"
TeleportsTab.Parent = Tabs
TeleportsTab.Active = true
TeleportsTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeleportsTab.BackgroundTransparency = 1
TeleportsTab.BorderSizePixel = 0
TeleportsTab.Position = UDim2.new(0.245999917, 0, 0.119999997, 0)
TeleportsTab.Size = UDim2.new(0.739000142, 0, 0.859000087, 0)
TeleportsTab.Visible = false
TeleportsTab.CanvasSize = UDim2.new(0, 0, 1.5, 0)
TeleportsTab.ScrollBarThickness = 6

UIListLayout.Parent = TeleportsTab
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0.00999999978, 0)

OpenMAPui.Name = "OpenMAPui"
OpenMAPui.Parent = TeleportsTab
OpenMAPui.BackgroundTransparency = 1
OpenMAPui.Position = UDim2.new(4.67080184e-07, 0, 0.0198354796, 0)
OpenMAPui.Size = UDim2.new(0.971999943, 0, 0.0568368807, 0)
OpenMAPui.Image = "rbxassetid://3570695787"
OpenMAPui.ImageColor3 = Color3.fromRGB(38, 38, 38)
OpenMAPui.ScaleType = Enum.ScaleType.Slice
OpenMAPui.SliceCenter = Rect.new(100, 100, 100, 100)
OpenMAPui.SliceScale = 0.060

OpenMAPui_TL.Name = "OpenMAPui_TL"
OpenMAPui_TL.Parent = OpenMAPui
OpenMAPui_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
OpenMAPui_TL.BackgroundTransparency = 1
OpenMAPui_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
OpenMAPui_TL.Size = UDim2.new(0.663618565, 0, 1, 0)
OpenMAPui_TL.ZIndex = 6
OpenMAPui_TL.Font = Enum.Font.GothamBold
OpenMAPui_TL.Text = "Open MAP ui"
OpenMAPui_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
OpenMAPui_TL.TextSize = 12
OpenMAPui_TL.TextWrapped = true
OpenMAPui_TL.TextXAlignment = Enum.TextXAlignment.Left

OpenMAPui_Btn.Name = "OpenMAPui_Btn"
OpenMAPui_Btn.Parent = OpenMAPui
OpenMAPui_Btn.AnchorPoint = Vector2.new(0, 0.5)
OpenMAPui_Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
OpenMAPui_Btn.BackgroundTransparency = 1
OpenMAPui_Btn.BorderSizePixel = 0
OpenMAPui_Btn.Position = UDim2.new(0.749213159, 0, 0.499999881, 0)
OpenMAPui_Btn.Size = UDim2.new(0.23855485, 0, 0.800000072, 0)
OpenMAPui_Btn.ZIndex = 2
OpenMAPui_Btn.Font = Enum.Font.GothamBold
OpenMAPui_Btn.Text = "Open"
OpenMAPui_Btn.TextColor3 = Color3.fromRGB(211, 211, 211)
OpenMAPui_Btn.TextSize = 12
OpenMAPui_Btn.TextWrapped = true

Roundify_7.Name = "Roundify"
Roundify_7.Parent = OpenMAPui_Btn
Roundify_7.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_7.BackgroundTransparency = 1
Roundify_7.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_7.Size = UDim2.new(1, 0, 1, 0)
Roundify_7.Image = "rbxassetid://3570695787"
Roundify_7.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_7.ScaleType = Enum.ScaleType.Slice
Roundify_7.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_7.SliceScale = 0.060

Clydesdale.Name = "Clydesdale"
Clydesdale.Parent = TeleportsTab
Clydesdale.BackgroundTransparency = 1
Clydesdale.Position = UDim2.new(4.67080184e-07, 0, 0.279753387, 0)
Clydesdale.Size = UDim2.new(0.971999943, 0, 0.0568368807, 0)
Clydesdale.Image = "rbxassetid://3570695787"
Clydesdale.ImageColor3 = Color3.fromRGB(38, 38, 38)
Clydesdale.ScaleType = Enum.ScaleType.Slice
Clydesdale.SliceCenter = Rect.new(100, 100, 100, 100)
Clydesdale.SliceScale = 0.060

Teleport_TL.Name = "Teleport_TL"
Teleport_TL.Parent = Clydesdale
Teleport_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Teleport_TL.BackgroundTransparency = 1
Teleport_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
Teleport_TL.Size = UDim2.new(0.663618565, 0, 1, 0)
Teleport_TL.ZIndex = 6
Teleport_TL.Font = Enum.Font.GothamBold
Teleport_TL.Text = "Clydesdale"
Teleport_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
Teleport_TL.TextSize = 12
Teleport_TL.TextWrapped = true
Teleport_TL.TextXAlignment = Enum.TextXAlignment.Left

TeleportTo_Btn.Name = "TeleportTo_Btn"
TeleportTo_Btn.Parent = Clydesdale
TeleportTo_Btn.AnchorPoint = Vector2.new(0, 0.5)
TeleportTo_Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeleportTo_Btn.BackgroundTransparency = 1
TeleportTo_Btn.BorderSizePixel = 0
TeleportTo_Btn.Position = UDim2.new(0.749213159, 0, 0.499999881, 0)
TeleportTo_Btn.Size = UDim2.new(0.23855485, 0, 0.800000072, 0)
TeleportTo_Btn.ZIndex = 2
TeleportTo_Btn.Font = Enum.Font.GothamBold
TeleportTo_Btn.Text = "Teleport"
TeleportTo_Btn.TextColor3 = Color3.fromRGB(211, 211, 211)
TeleportTo_Btn.TextSize = 12
TeleportTo_Btn.TextWrapped = true

Roundify_8.Name = "Roundify"
Roundify_8.Parent = TeleportTo_Btn
Roundify_8.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_8.BackgroundTransparency = 1
Roundify_8.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_8.Size = UDim2.new(1, 0, 1, 0)
Roundify_8.Image = "rbxassetid://3570695787"
Roundify_8.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_8.ScaleType = Enum.ScaleType.Slice
Roundify_8.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_8.SliceScale = 0.060

Harrisburg.Name = "Harrisburg"
Harrisburg.Parent = TeleportsTab
Harrisburg.BackgroundTransparency = 1
Harrisburg.Position = UDim2.new(4.67080184e-07, 0, 0.279753387, 0)
Harrisburg.Size = UDim2.new(0.971999943, 0, 0.0568368807, 0)
Harrisburg.Image = "rbxassetid://3570695787"
Harrisburg.ImageColor3 = Color3.fromRGB(38, 38, 38)
Harrisburg.ScaleType = Enum.ScaleType.Slice
Harrisburg.SliceCenter = Rect.new(100, 100, 100, 100)
Harrisburg.SliceScale = 0.060

Teleport_TL_2.Name = "Teleport_TL"
Teleport_TL_2.Parent = Harrisburg
Teleport_TL_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Teleport_TL_2.BackgroundTransparency = 1
Teleport_TL_2.Position = UDim2.new(0.0489282086, 0, 0, 0)
Teleport_TL_2.Size = UDim2.new(0.663618565, 0, 1, 0)
Teleport_TL_2.ZIndex = 6
Teleport_TL_2.Font = Enum.Font.GothamBold
Teleport_TL_2.Text = "Harrisburg"
Teleport_TL_2.TextColor3 = Color3.fromRGB(234, 234, 234)
Teleport_TL_2.TextSize = 12
Teleport_TL_2.TextWrapped = true
Teleport_TL_2.TextXAlignment = Enum.TextXAlignment.Left

TeleportTo_Btn_2.Name = "TeleportTo_Btn"
TeleportTo_Btn_2.Parent = Harrisburg
TeleportTo_Btn_2.AnchorPoint = Vector2.new(0, 0.5)
TeleportTo_Btn_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeleportTo_Btn_2.BackgroundTransparency = 1
TeleportTo_Btn_2.BorderSizePixel = 0
TeleportTo_Btn_2.Position = UDim2.new(0.749213159, 0, 0.499999881, 0)
TeleportTo_Btn_2.Size = UDim2.new(0.23855485, 0, 0.800000072, 0)
TeleportTo_Btn_2.ZIndex = 2
TeleportTo_Btn_2.Font = Enum.Font.GothamBold
TeleportTo_Btn_2.Text = "Teleport"
TeleportTo_Btn_2.TextColor3 = Color3.fromRGB(211, 211, 211)
TeleportTo_Btn_2.TextSize = 12
TeleportTo_Btn_2.TextWrapped = true

Roundify_9.Name = "Roundify"
Roundify_9.Parent = TeleportTo_Btn_2
Roundify_9.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_9.BackgroundTransparency = 1
Roundify_9.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_9.Size = UDim2.new(1, 0, 1, 0)
Roundify_9.Image = "rbxassetid://3570695787"
Roundify_9.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_9.ScaleType = Enum.ScaleType.Slice
Roundify_9.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_9.SliceScale = 0.060

FortVerner.Name = "Fort Verner"
FortVerner.Parent = TeleportsTab
FortVerner.BackgroundTransparency = 1
FortVerner.Position = UDim2.new(4.67080184e-07, 0, 0.279753387, 0)
FortVerner.Size = UDim2.new(0.971999943, 0, 0.0568368807, 0)
FortVerner.Image = "rbxassetid://3570695787"
FortVerner.ImageColor3 = Color3.fromRGB(38, 38, 38)
FortVerner.ScaleType = Enum.ScaleType.Slice
FortVerner.SliceCenter = Rect.new(100, 100, 100, 100)
FortVerner.SliceScale = 0.060

Teleport_TL_3.Name = "Teleport_TL"
Teleport_TL_3.Parent = FortVerner
Teleport_TL_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Teleport_TL_3.BackgroundTransparency = 1
Teleport_TL_3.Position = UDim2.new(0.0489282086, 0, 0, 0)
Teleport_TL_3.Size = UDim2.new(0.663618565, 0, 1, 0)
Teleport_TL_3.ZIndex = 6
Teleport_TL_3.Font = Enum.Font.GothamBold
Teleport_TL_3.Text = "Fort Verner"
Teleport_TL_3.TextColor3 = Color3.fromRGB(234, 234, 234)
Teleport_TL_3.TextSize = 12
Teleport_TL_3.TextWrapped = true
Teleport_TL_3.TextXAlignment = Enum.TextXAlignment.Left

TeleportTo_Btn_3.Name = "TeleportTo_Btn"
TeleportTo_Btn_3.Parent = FortVerner
TeleportTo_Btn_3.AnchorPoint = Vector2.new(0, 0.5)
TeleportTo_Btn_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeleportTo_Btn_3.BackgroundTransparency = 1
TeleportTo_Btn_3.BorderSizePixel = 0
TeleportTo_Btn_3.Position = UDim2.new(0.749213159, 0, 0.499999881, 0)
TeleportTo_Btn_3.Size = UDim2.new(0.23855485, 0, 0.800000072, 0)
TeleportTo_Btn_3.ZIndex = 2
TeleportTo_Btn_3.Font = Enum.Font.GothamBold
TeleportTo_Btn_3.Text = "Teleport"
TeleportTo_Btn_3.TextColor3 = Color3.fromRGB(211, 211, 211)
TeleportTo_Btn_3.TextSize = 12
TeleportTo_Btn_3.TextWrapped = true

Roundify_10.Name = "Roundify"
Roundify_10.Parent = TeleportTo_Btn_3
Roundify_10.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_10.BackgroundTransparency = 1
Roundify_10.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_10.Size = UDim2.new(1, 0, 1, 0)
Roundify_10.Image = "rbxassetid://3570695787"
Roundify_10.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_10.ScaleType = Enum.ScaleType.Slice
Roundify_10.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_10.SliceScale = 0.060

NovaBalreska.Name = "Nova Balreska"
NovaBalreska.Parent = TeleportsTab
NovaBalreska.BackgroundTransparency = 1
NovaBalreska.Position = UDim2.new(4.67080184e-07, 0, 0.279753387, 0)
NovaBalreska.Size = UDim2.new(0.971999943, 0, 0.0568368807, 0)
NovaBalreska.Image = "rbxassetid://3570695787"
NovaBalreska.ImageColor3 = Color3.fromRGB(38, 38, 38)
NovaBalreska.ScaleType = Enum.ScaleType.Slice
NovaBalreska.SliceCenter = Rect.new(100, 100, 100, 100)
NovaBalreska.SliceScale = 0.060

Teleport_TL_4.Name = "Teleport_TL"
Teleport_TL_4.Parent = NovaBalreska
Teleport_TL_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Teleport_TL_4.BackgroundTransparency = 1
Teleport_TL_4.Position = UDim2.new(0.0489282086, 0, 0, 0)
Teleport_TL_4.Size = UDim2.new(0.663618565, 0, 1, 0)
Teleport_TL_4.ZIndex = 6
Teleport_TL_4.Font = Enum.Font.GothamBold
Teleport_TL_4.Text = "Nova Balreska"
Teleport_TL_4.TextColor3 = Color3.fromRGB(234, 234, 234)
Teleport_TL_4.TextSize = 12
Teleport_TL_4.TextWrapped = true
Teleport_TL_4.TextXAlignment = Enum.TextXAlignment.Left

TeleportTo_Btn_4.Name = "TeleportTo_Btn"
TeleportTo_Btn_4.Parent = NovaBalreska
TeleportTo_Btn_4.AnchorPoint = Vector2.new(0, 0.5)
TeleportTo_Btn_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeleportTo_Btn_4.BackgroundTransparency = 1
TeleportTo_Btn_4.BorderSizePixel = 0
TeleportTo_Btn_4.Position = UDim2.new(0.749213159, 0, 0.499999881, 0)
TeleportTo_Btn_4.Size = UDim2.new(0.23855485, 0, 0.800000072, 0)
TeleportTo_Btn_4.ZIndex = 2
TeleportTo_Btn_4.Font = Enum.Font.GothamBold
TeleportTo_Btn_4.Text = "Teleport"
TeleportTo_Btn_4.TextColor3 = Color3.fromRGB(211, 211, 211)
TeleportTo_Btn_4.TextSize = 12
TeleportTo_Btn_4.TextWrapped = true

Roundify_11.Name = "Roundify"
Roundify_11.Parent = TeleportTo_Btn_4
Roundify_11.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_11.BackgroundTransparency = 1
Roundify_11.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_11.Size = UDim2.new(1, 0, 1, 0)
Roundify_11.Image = "rbxassetid://3570695787"
Roundify_11.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_11.ScaleType = Enum.ScaleType.Slice
Roundify_11.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_11.SliceScale = 0.060

Salem.Name = "Salem"
Salem.Parent = TeleportsTab
Salem.BackgroundTransparency = 1
Salem.Position = UDim2.new(4.67080184e-07, 0, 0.279753387, 0)
Salem.Size = UDim2.new(0.971999943, 0, 0.0568368807, 0)
Salem.Image = "rbxassetid://3570695787"
Salem.ImageColor3 = Color3.fromRGB(38, 38, 38)
Salem.ScaleType = Enum.ScaleType.Slice
Salem.SliceCenter = Rect.new(100, 100, 100, 100)
Salem.SliceScale = 0.060

Teleport_TL_5.Name = "Teleport_TL"
Teleport_TL_5.Parent = Salem
Teleport_TL_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Teleport_TL_5.BackgroundTransparency = 1
Teleport_TL_5.Position = UDim2.new(0.0489282086, 0, 0, 0)
Teleport_TL_5.Size = UDim2.new(0.663618565, 0, 1, 0)
Teleport_TL_5.ZIndex = 6
Teleport_TL_5.Font = Enum.Font.GothamBold
Teleport_TL_5.Text = "Salem"
Teleport_TL_5.TextColor3 = Color3.fromRGB(234, 234, 234)
Teleport_TL_5.TextSize = 12
Teleport_TL_5.TextWrapped = true
Teleport_TL_5.TextXAlignment = Enum.TextXAlignment.Left

TeleportTo_Btn_5.Name = "TeleportTo_Btn"
TeleportTo_Btn_5.Parent = Salem
TeleportTo_Btn_5.AnchorPoint = Vector2.new(0, 0.5)
TeleportTo_Btn_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeleportTo_Btn_5.BackgroundTransparency = 1
TeleportTo_Btn_5.BorderSizePixel = 0
TeleportTo_Btn_5.Position = UDim2.new(0.749213159, 0, 0.499999881, 0)
TeleportTo_Btn_5.Size = UDim2.new(0.23855485, 0, 0.800000072, 0)
TeleportTo_Btn_5.ZIndex = 2
TeleportTo_Btn_5.Font = Enum.Font.GothamBold
TeleportTo_Btn_5.Text = "Teleport"
TeleportTo_Btn_5.TextColor3 = Color3.fromRGB(211, 211, 211)
TeleportTo_Btn_5.TextSize = 12
TeleportTo_Btn_5.TextWrapped = true

Roundify_12.Name = "Roundify"
Roundify_12.Parent = TeleportTo_Btn_5
Roundify_12.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_12.BackgroundTransparency = 1
Roundify_12.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_12.Size = UDim2.new(1, 0, 1, 0)
Roundify_12.Image = "rbxassetid://3570695787"
Roundify_12.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_12.ScaleType = Enum.ScaleType.Slice
Roundify_12.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_12.SliceScale = 0.060

BlackwindCove.Name = "Blackwind Cove"
BlackwindCove.Parent = TeleportsTab
BlackwindCove.BackgroundTransparency = 1
BlackwindCove.Position = UDim2.new(4.67080184e-07, 0, 0.279753387, 0)
BlackwindCove.Size = UDim2.new(0.971999943, 0, 0.0568368807, 0)
BlackwindCove.Image = "rbxassetid://3570695787"
BlackwindCove.ImageColor3 = Color3.fromRGB(38, 38, 38)
BlackwindCove.ScaleType = Enum.ScaleType.Slice
BlackwindCove.SliceCenter = Rect.new(100, 100, 100, 100)
BlackwindCove.SliceScale = 0.060

Teleport_TL_6.Name = "Teleport_TL"
Teleport_TL_6.Parent = BlackwindCove
Teleport_TL_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Teleport_TL_6.BackgroundTransparency = 1
Teleport_TL_6.Position = UDim2.new(0.0489282086, 0, 0, 0)
Teleport_TL_6.Size = UDim2.new(0.663618565, 0, 1, 0)
Teleport_TL_6.ZIndex = 6
Teleport_TL_6.Font = Enum.Font.GothamBold
Teleport_TL_6.Text = "Blackwind Cove"
Teleport_TL_6.TextColor3 = Color3.fromRGB(234, 234, 234)
Teleport_TL_6.TextSize = 12
Teleport_TL_6.TextWrapped = true
Teleport_TL_6.TextXAlignment = Enum.TextXAlignment.Left

TeleportTo_Btn_6.Name = "TeleportTo_Btn"
TeleportTo_Btn_6.Parent = BlackwindCove
TeleportTo_Btn_6.AnchorPoint = Vector2.new(0, 0.5)
TeleportTo_Btn_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeleportTo_Btn_6.BackgroundTransparency = 1
TeleportTo_Btn_6.BorderSizePixel = 0
TeleportTo_Btn_6.Position = UDim2.new(0.749213159, 0, 0.499999881, 0)
TeleportTo_Btn_6.Size = UDim2.new(0.23855485, 0, 0.800000072, 0)
TeleportTo_Btn_6.ZIndex = 2
TeleportTo_Btn_6.Font = Enum.Font.GothamBold
TeleportTo_Btn_6.Text = "Teleport"
TeleportTo_Btn_6.TextColor3 = Color3.fromRGB(211, 211, 211)
TeleportTo_Btn_6.TextSize = 12
TeleportTo_Btn_6.TextWrapped = true

Roundify_13.Name = "Roundify"
Roundify_13.Parent = TeleportTo_Btn_6
Roundify_13.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_13.BackgroundTransparency = 1
Roundify_13.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_13.Size = UDim2.new(1, 0, 1, 0)
Roundify_13.Image = "rbxassetid://3570695787"
Roundify_13.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_13.ScaleType = Enum.ScaleType.Slice
Roundify_13.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_13.SliceScale = 0.060

Perth.Name = "Perth"
Perth.Parent = TeleportsTab
Perth.BackgroundTransparency = 1
Perth.Position = UDim2.new(4.67080184e-07, 0, 0.279753387, 0)
Perth.Size = UDim2.new(0.971999943, 0, 0.0568368807, 0)
Perth.Image = "rbxassetid://3570695787"
Perth.ImageColor3 = Color3.fromRGB(38, 38, 38)
Perth.ScaleType = Enum.ScaleType.Slice
Perth.SliceCenter = Rect.new(100, 100, 100, 100)
Perth.SliceScale = 0.060

Teleport_TL_7.Name = "Teleport_TL"
Teleport_TL_7.Parent = Perth
Teleport_TL_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Teleport_TL_7.BackgroundTransparency = 1
Teleport_TL_7.Position = UDim2.new(0.0489282086, 0, 0, 0)
Teleport_TL_7.Size = UDim2.new(0.663618565, 0, 1, 0)
Teleport_TL_7.ZIndex = 6
Teleport_TL_7.Font = Enum.Font.GothamBold
Teleport_TL_7.Text = "Perth"
Teleport_TL_7.TextColor3 = Color3.fromRGB(234, 234, 234)
Teleport_TL_7.TextSize = 12
Teleport_TL_7.TextWrapped = true
Teleport_TL_7.TextXAlignment = Enum.TextXAlignment.Left

TeleportTo_Btn_7.Name = "TeleportTo_Btn"
TeleportTo_Btn_7.Parent = Perth
TeleportTo_Btn_7.AnchorPoint = Vector2.new(0, 0.5)
TeleportTo_Btn_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeleportTo_Btn_7.BackgroundTransparency = 1
TeleportTo_Btn_7.BorderSizePixel = 0
TeleportTo_Btn_7.Position = UDim2.new(0.749213159, 0, 0.499999881, 0)
TeleportTo_Btn_7.Size = UDim2.new(0.23855485, 0, 0.800000072, 0)
TeleportTo_Btn_7.ZIndex = 2
TeleportTo_Btn_7.Font = Enum.Font.GothamBold
TeleportTo_Btn_7.Text = "Teleport"
TeleportTo_Btn_7.TextColor3 = Color3.fromRGB(211, 211, 211)
TeleportTo_Btn_7.TextSize = 12
TeleportTo_Btn_7.TextWrapped = true

Roundify_14.Name = "Roundify"
Roundify_14.Parent = TeleportTo_Btn_7
Roundify_14.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_14.BackgroundTransparency = 1
Roundify_14.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_14.Size = UDim2.new(1, 0, 1, 0)
Roundify_14.Image = "rbxassetid://3570695787"
Roundify_14.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_14.ScaleType = Enum.ScaleType.Slice
Roundify_14.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_14.SliceScale = 0.060

Fenwick.Name = "Fenwick"
Fenwick.Parent = TeleportsTab
Fenwick.BackgroundTransparency = 1
Fenwick.Position = UDim2.new(4.67080184e-07, 0, 0.279753387, 0)
Fenwick.Size = UDim2.new(0.971999943, 0, 0.0568368807, 0)
Fenwick.Image = "rbxassetid://3570695787"
Fenwick.ImageColor3 = Color3.fromRGB(38, 38, 38)
Fenwick.ScaleType = Enum.ScaleType.Slice
Fenwick.SliceCenter = Rect.new(100, 100, 100, 100)
Fenwick.SliceScale = 0.060

Teleport_TL_8.Name = "Teleport_TL"
Teleport_TL_8.Parent = Fenwick
Teleport_TL_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Teleport_TL_8.BackgroundTransparency = 1
Teleport_TL_8.Position = UDim2.new(0.0489282086, 0, 0, 0)
Teleport_TL_8.Size = UDim2.new(0.663618565, 0, 1, 0)
Teleport_TL_8.ZIndex = 6
Teleport_TL_8.Font = Enum.Font.GothamBold
Teleport_TL_8.Text = "Fenwick"
Teleport_TL_8.TextColor3 = Color3.fromRGB(234, 234, 234)
Teleport_TL_8.TextSize = 12
Teleport_TL_8.TextWrapped = true
Teleport_TL_8.TextXAlignment = Enum.TextXAlignment.Left

TeleportTo_Btn_8.Name = "TeleportTo_Btn"
TeleportTo_Btn_8.Parent = Fenwick
TeleportTo_Btn_8.AnchorPoint = Vector2.new(0, 0.5)
TeleportTo_Btn_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeleportTo_Btn_8.BackgroundTransparency = 1
TeleportTo_Btn_8.BorderSizePixel = 0
TeleportTo_Btn_8.Position = UDim2.new(0.749213159, 0, 0.499999881, 0)
TeleportTo_Btn_8.Size = UDim2.new(0.23855485, 0, 0.800000072, 0)
TeleportTo_Btn_8.ZIndex = 2
TeleportTo_Btn_8.Font = Enum.Font.GothamBold
TeleportTo_Btn_8.Text = "Teleport"
TeleportTo_Btn_8.TextColor3 = Color3.fromRGB(211, 211, 211)
TeleportTo_Btn_8.TextSize = 12
TeleportTo_Btn_8.TextWrapped = true

Roundify_15.Name = "Roundify"
Roundify_15.Parent = TeleportTo_Btn_8
Roundify_15.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_15.BackgroundTransparency = 1
Roundify_15.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_15.Size = UDim2.new(1, 0, 1, 0)
Roundify_15.Image = "rbxassetid://3570695787"
Roundify_15.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_15.ScaleType = Enum.ScaleType.Slice
Roundify_15.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_15.SliceScale = 0.060

Freeport.Name = "Freeport"
Freeport.Parent = TeleportsTab
Freeport.BackgroundTransparency = 1
Freeport.Position = UDim2.new(4.67080184e-07, 0, 0.279753387, 0)
Freeport.Size = UDim2.new(0.971999943, 0, 0.0568368807, 0)
Freeport.Image = "rbxassetid://3570695787"
Freeport.ImageColor3 = Color3.fromRGB(38, 38, 38)
Freeport.ScaleType = Enum.ScaleType.Slice
Freeport.SliceCenter = Rect.new(100, 100, 100, 100)
Freeport.SliceScale = 0.060

Teleport_TL_9.Name = "Teleport_TL"
Teleport_TL_9.Parent = Freeport
Teleport_TL_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Teleport_TL_9.BackgroundTransparency = 1
Teleport_TL_9.Position = UDim2.new(0.0489282086, 0, 0, 0)
Teleport_TL_9.Size = UDim2.new(0.663618565, 0, 1, 0)
Teleport_TL_9.ZIndex = 6
Teleport_TL_9.Font = Enum.Font.GothamBold
Teleport_TL_9.Text = "Freeport"
Teleport_TL_9.TextColor3 = Color3.fromRGB(234, 234, 234)
Teleport_TL_9.TextSize = 12
Teleport_TL_9.TextWrapped = true
Teleport_TL_9.TextXAlignment = Enum.TextXAlignment.Left

TeleportTo_Btn_9.Name = "TeleportTo_Btn"
TeleportTo_Btn_9.Parent = Freeport
TeleportTo_Btn_9.AnchorPoint = Vector2.new(0, 0.5)
TeleportTo_Btn_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeleportTo_Btn_9.BackgroundTransparency = 1
TeleportTo_Btn_9.BorderSizePixel = 0
TeleportTo_Btn_9.Position = UDim2.new(0.749213159, 0, 0.499999881, 0)
TeleportTo_Btn_9.Size = UDim2.new(0.23855485, 0, 0.800000072, 0)
TeleportTo_Btn_9.ZIndex = 2
TeleportTo_Btn_9.Font = Enum.Font.GothamBold
TeleportTo_Btn_9.Text = "Teleport"
TeleportTo_Btn_9.TextColor3 = Color3.fromRGB(211, 211, 211)
TeleportTo_Btn_9.TextSize = 12
TeleportTo_Btn_9.TextWrapped = true

Roundify_16.Name = "Roundify"
Roundify_16.Parent = TeleportTo_Btn_9
Roundify_16.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_16.BackgroundTransparency = 1
Roundify_16.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_16.Size = UDim2.new(1, 0, 1, 0)
Roundify_16.Image = "rbxassetid://3570695787"
Roundify_16.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_16.ScaleType = Enum.ScaleType.Slice
Roundify_16.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_16.SliceScale = 0.060

Whitecrest.Name = "Whitecrest"
Whitecrest.Parent = TeleportsTab
Whitecrest.BackgroundTransparency = 1
Whitecrest.Position = UDim2.new(4.67080184e-07, 0, 0.279753387, 0)
Whitecrest.Size = UDim2.new(0.971999943, 0, 0.0568368807, 0)
Whitecrest.Image = "rbxassetid://3570695787"
Whitecrest.ImageColor3 = Color3.fromRGB(38, 38, 38)
Whitecrest.ScaleType = Enum.ScaleType.Slice
Whitecrest.SliceCenter = Rect.new(100, 100, 100, 100)
Whitecrest.SliceScale = 0.060

Teleport_TL_10.Name = "Teleport_TL"
Teleport_TL_10.Parent = Whitecrest
Teleport_TL_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Teleport_TL_10.BackgroundTransparency = 1
Teleport_TL_10.Position = UDim2.new(0.0489282086, 0, 0, 0)
Teleport_TL_10.Size = UDim2.new(0.663618565, 0, 1, 0)
Teleport_TL_10.ZIndex = 6
Teleport_TL_10.Font = Enum.Font.GothamBold
Teleport_TL_10.Text = "Whitecrest"
Teleport_TL_10.TextColor3 = Color3.fromRGB(234, 234, 234)
Teleport_TL_10.TextSize = 12
Teleport_TL_10.TextWrapped = true
Teleport_TL_10.TextXAlignment = Enum.TextXAlignment.Left

TeleportTo_Btn_10.Name = "TeleportTo_Btn"
TeleportTo_Btn_10.Parent = Whitecrest
TeleportTo_Btn_10.AnchorPoint = Vector2.new(0, 0.5)
TeleportTo_Btn_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeleportTo_Btn_10.BackgroundTransparency = 1
TeleportTo_Btn_10.BorderSizePixel = 0
TeleportTo_Btn_10.Position = UDim2.new(0.749213159, 0, 0.499999881, 0)
TeleportTo_Btn_10.Size = UDim2.new(0.23855485, 0, 0.800000072, 0)
TeleportTo_Btn_10.ZIndex = 2
TeleportTo_Btn_10.Font = Enum.Font.GothamBold
TeleportTo_Btn_10.Text = "Teleport"
TeleportTo_Btn_10.TextColor3 = Color3.fromRGB(211, 211, 211)
TeleportTo_Btn_10.TextSize = 12
TeleportTo_Btn_10.TextWrapped = true

Roundify_17.Name = "Roundify"
Roundify_17.Parent = TeleportTo_Btn_10
Roundify_17.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_17.BackgroundTransparency = 1
Roundify_17.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_17.Size = UDim2.new(1, 0, 1, 0)
Roundify_17.Image = "rbxassetid://3570695787"
Roundify_17.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_17.ScaleType = Enum.ScaleType.Slice
Roundify_17.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_17.SliceScale = 0.060

CannoneersKey.Name = "Cannoneer's Key"
CannoneersKey.Parent = TeleportsTab
CannoneersKey.BackgroundTransparency = 1
CannoneersKey.Position = UDim2.new(4.67080184e-07, 0, 0.279753387, 0)
CannoneersKey.Size = UDim2.new(0.971999943, 0, 0.0568368807, 0)
CannoneersKey.Image = "rbxassetid://3570695787"
CannoneersKey.ImageColor3 = Color3.fromRGB(38, 38, 38)
CannoneersKey.ScaleType = Enum.ScaleType.Slice
CannoneersKey.SliceCenter = Rect.new(100, 100, 100, 100)
CannoneersKey.SliceScale = 0.060

Teleport_TL_11.Name = "Teleport_TL"
Teleport_TL_11.Parent = CannoneersKey
Teleport_TL_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Teleport_TL_11.BackgroundTransparency = 1
Teleport_TL_11.Position = UDim2.new(0.0489282086, 0, 0, 0)
Teleport_TL_11.Size = UDim2.new(0.663618565, 0, 1, 0)
Teleport_TL_11.ZIndex = 6
Teleport_TL_11.Font = Enum.Font.GothamBold
Teleport_TL_11.Text = "Cannoneer's Key"
Teleport_TL_11.TextColor3 = Color3.fromRGB(234, 234, 234)
Teleport_TL_11.TextSize = 12
Teleport_TL_11.TextWrapped = true
Teleport_TL_11.TextXAlignment = Enum.TextXAlignment.Left

TeleportTo_Btn_11.Name = "TeleportTo_Btn"
TeleportTo_Btn_11.Parent = CannoneersKey
TeleportTo_Btn_11.AnchorPoint = Vector2.new(0, 0.5)
TeleportTo_Btn_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeleportTo_Btn_11.BackgroundTransparency = 1
TeleportTo_Btn_11.BorderSizePixel = 0
TeleportTo_Btn_11.Position = UDim2.new(0.749213159, 0, 0.499999881, 0)
TeleportTo_Btn_11.Size = UDim2.new(0.23855485, 0, 0.800000072, 0)
TeleportTo_Btn_11.ZIndex = 2
TeleportTo_Btn_11.Font = Enum.Font.GothamBold
TeleportTo_Btn_11.Text = "Teleport"
TeleportTo_Btn_11.TextColor3 = Color3.fromRGB(211, 211, 211)
TeleportTo_Btn_11.TextSize = 12
TeleportTo_Btn_11.TextWrapped = true

Roundify_18.Name = "Roundify"
Roundify_18.Parent = TeleportTo_Btn_11
Roundify_18.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_18.BackgroundTransparency = 1
Roundify_18.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_18.Size = UDim2.new(1, 0, 1, 0)
Roundify_18.Image = "rbxassetid://3570695787"
Roundify_18.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_18.ScaleType = Enum.ScaleType.Slice
Roundify_18.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_18.SliceScale = 0.060

SaintChristopher.Name = "Saint Christopher"
SaintChristopher.Parent = TeleportsTab
SaintChristopher.BackgroundTransparency = 1
SaintChristopher.Position = UDim2.new(4.67080184e-07, 0, 0.279753387, 0)
SaintChristopher.Size = UDim2.new(0.971999943, 0, 0.0568368807, 0)
SaintChristopher.Image = "rbxassetid://3570695787"
SaintChristopher.ImageColor3 = Color3.fromRGB(38, 38, 38)
SaintChristopher.ScaleType = Enum.ScaleType.Slice
SaintChristopher.SliceCenter = Rect.new(100, 100, 100, 100)
SaintChristopher.SliceScale = 0.060

Teleport_TL_12.Name = "Teleport_TL"
Teleport_TL_12.Parent = SaintChristopher
Teleport_TL_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Teleport_TL_12.BackgroundTransparency = 1
Teleport_TL_12.Position = UDim2.new(0.0489282086, 0, 0, 0)
Teleport_TL_12.Size = UDim2.new(0.663618565, 0, 1, 0)
Teleport_TL_12.ZIndex = 6
Teleport_TL_12.Font = Enum.Font.GothamBold
Teleport_TL_12.Text = "Saint Christopher"
Teleport_TL_12.TextColor3 = Color3.fromRGB(234, 234, 234)
Teleport_TL_12.TextSize = 12
Teleport_TL_12.TextWrapped = true
Teleport_TL_12.TextXAlignment = Enum.TextXAlignment.Left

TeleportTo_Btn_12.Name = "TeleportTo_Btn"
TeleportTo_Btn_12.Parent = SaintChristopher
TeleportTo_Btn_12.AnchorPoint = Vector2.new(0, 0.5)
TeleportTo_Btn_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeleportTo_Btn_12.BackgroundTransparency = 1
TeleportTo_Btn_12.BorderSizePixel = 0
TeleportTo_Btn_12.Position = UDim2.new(0.749213159, 0, 0.499999881, 0)
TeleportTo_Btn_12.Size = UDim2.new(0.23855485, 0, 0.800000072, 0)
TeleportTo_Btn_12.ZIndex = 2
TeleportTo_Btn_12.Font = Enum.Font.GothamBold
TeleportTo_Btn_12.Text = "Teleport"
TeleportTo_Btn_12.TextColor3 = Color3.fromRGB(211, 211, 211)
TeleportTo_Btn_12.TextSize = 12
TeleportTo_Btn_12.TextWrapped = true

Roundify_19.Name = "Roundify"
Roundify_19.Parent = TeleportTo_Btn_12
Roundify_19.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_19.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_19.BackgroundTransparency = 1
Roundify_19.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_19.Size = UDim2.new(1, 0, 1, 0)
Roundify_19.Image = "rbxassetid://3570695787"
Roundify_19.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_19.ScaleType = Enum.ScaleType.Slice
Roundify_19.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_19.SliceScale = 0.060

FarmsTab.Name = "FarmsTab"
FarmsTab.Parent = Tabs
FarmsTab.Active = true
FarmsTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FarmsTab.BackgroundTransparency = 1
FarmsTab.BorderSizePixel = 0
FarmsTab.Position = UDim2.new(0.245999917, 0, 0.119999997, 0)
FarmsTab.Size = UDim2.new(0.739000142, 0, 0.859000087, 0)
FarmsTab.CanvasSize = UDim2.new(0, 0, 1, 0)
FarmsTab.ScrollBarThickness = 6
FarmsTab.Visible = false

WoodFarm.Name = "WoodFarm"
WoodFarm.Parent = FarmsTab
WoodFarm.BackgroundTransparency = 1
WoodFarm.Size = UDim2.new(0.971999943, 0, 0.0799999982, 0)
WoodFarm.Image = "rbxassetid://3570695787"
WoodFarm.ImageColor3 = Color3.fromRGB(38, 38, 38)
WoodFarm.ScaleType = Enum.ScaleType.Slice
WoodFarm.SliceCenter = Rect.new(100, 100, 100, 100)
WoodFarm.SliceScale = 0.060

WoodFarm_TL.Name = "WoodFarm_TL"
WoodFarm_TL.Parent = WoodFarm
WoodFarm_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WoodFarm_TL.BackgroundTransparency = 1
WoodFarm_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
WoodFarm_TL.Size = UDim2.new(0.663618565, 0, 1, 0)
WoodFarm_TL.ZIndex = 6
WoodFarm_TL.Font = Enum.Font.GothamBold
WoodFarm_TL.Text = "Wood Auto-Farm [K]"
WoodFarm_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
WoodFarm_TL.TextSize = 12
WoodFarm_TL.TextWrapped = true
WoodFarm_TL.TextXAlignment = Enum.TextXAlignment.Left

Toggle_WoodFarm.Name = "Toggle_WoodFarm"
Toggle_WoodFarm.Parent = WoodFarm
Toggle_WoodFarm.AnchorPoint = Vector2.new(0, 0.5)
Toggle_WoodFarm.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_WoodFarm.BackgroundTransparency = 1
Toggle_WoodFarm.Position = UDim2.new(0.834999979, 0, 0.499999881, 0)
Toggle_WoodFarm.Size = UDim2.new(0.0549999997, 0, 0.5, 0)
Toggle_WoodFarm.ZIndex = 2
Toggle_WoodFarm.Image = "rbxassetid://3570695787"
Toggle_WoodFarm.ScaleType = Enum.ScaleType.Slice
Toggle_WoodFarm.SliceCenter = Rect.new(100, 100, 100, 100)

Roundify_20.Name = "Roundify"
Roundify_20.Parent = WoodFarm
Roundify_20.AnchorPoint = Vector2.new(0, 0.5)
Roundify_20.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_20.BackgroundTransparency = 1
Roundify_20.Position = UDim2.new(0.834999979, 0, 0.499999881, 0)
Roundify_20.Size = UDim2.new(0.119999997, 0, 0.5, 0)
Roundify_20.Image = "rbxassetid://3570695787"
Roundify_20.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_20.ScaleType = Enum.ScaleType.Slice
Roundify_20.SliceCenter = Rect.new(100, 100, 100, 100)

UIListLayout_4.Parent = FarmsTab
UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_4.Padding = UDim.new(0.0250000004, 0)

StoneFarm.Name = "StoneFarm"
StoneFarm.Parent = FarmsTab
StoneFarm.BackgroundTransparency = 1
StoneFarm.Size = UDim2.new(0.971999943, 0, 0.0799999982, 0)
StoneFarm.Image = "rbxassetid://3570695787"
StoneFarm.ImageColor3 = Color3.fromRGB(38, 38, 38)
StoneFarm.ScaleType = Enum.ScaleType.Slice
StoneFarm.SliceCenter = Rect.new(100, 100, 100, 100)
StoneFarm.SliceScale = 0.060

StoneFarm_TL.Name = "StoneFarm_TL"
StoneFarm_TL.Parent = StoneFarm
StoneFarm_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
StoneFarm_TL.BackgroundTransparency = 1
StoneFarm_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
StoneFarm_TL.Size = UDim2.new(0.663618565, 0, 1, 0)
StoneFarm_TL.ZIndex = 6
StoneFarm_TL.Font = Enum.Font.GothamBold
StoneFarm_TL.Text = "Stone Auto-Farm [L]"
StoneFarm_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
StoneFarm_TL.TextSize = 12
StoneFarm_TL.TextWrapped = true
StoneFarm_TL.TextXAlignment = Enum.TextXAlignment.Left

Toggle_StoneFarm.Name = "Toggle_StoneFarm"
Toggle_StoneFarm.Parent = StoneFarm
Toggle_StoneFarm.AnchorPoint = Vector2.new(0, 0.5)
Toggle_StoneFarm.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_StoneFarm.BackgroundTransparency = 1
Toggle_StoneFarm.Position = UDim2.new(0.834999979, 0, 0.499999881, 0)
Toggle_StoneFarm.Size = UDim2.new(0.0549999997, 0, 0.5, 0)
Toggle_StoneFarm.ZIndex = 2
Toggle_StoneFarm.Image = "rbxassetid://3570695787"
Toggle_StoneFarm.ScaleType = Enum.ScaleType.Slice
Toggle_StoneFarm.SliceCenter = Rect.new(100, 100, 100, 100)

Roundify_21.Name = "Roundify"
Roundify_21.Parent = StoneFarm
Roundify_21.AnchorPoint = Vector2.new(0, 0.5)
Roundify_21.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_21.BackgroundTransparency = 1
Roundify_21.Position = UDim2.new(0.834999979, 0, 0.499999881, 0)
Roundify_21.Size = UDim2.new(0.119999997, 0, 0.5, 0)
Roundify_21.Image = "rbxassetid://3570695787"
Roundify_21.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_21.ScaleType = Enum.ScaleType.Slice
Roundify_21.SliceCenter = Rect.new(100, 100, 100, 100)

ShipTab.Name = "ShipTab"
ShipTab.Parent = Tabs
ShipTab.Active = true
ShipTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ShipTab.BackgroundTransparency = 1
ShipTab.BorderSizePixel = 0
ShipTab.Position = UDim2.new(0.245999917, 0, 0.119999997, 0)
ShipTab.Size = UDim2.new(0.739000142, 0, 0.859000087, 0)
ShipTab.Visible = false
ShipTab.CanvasSize = UDim2.new(0, 0, 1, 0)
ShipTab.ScrollBarThickness = 6

ShipHover.Name = "ShipHover"
ShipHover.Parent = ShipTab
ShipHover.BackgroundTransparency = 1
ShipHover.Size = UDim2.new(0.971999943, 0, 0.0799999982, 0)
ShipHover.Image = "rbxassetid://3570695787"
ShipHover.ImageColor3 = Color3.fromRGB(38, 38, 38)
ShipHover.ScaleType = Enum.ScaleType.Slice
ShipHover.SliceCenter = Rect.new(100, 100, 100, 100)
ShipHover.SliceScale = 0.060

ShipHover_TL.Name = "ShipHover_TL"
ShipHover_TL.Parent = ShipHover
ShipHover_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ShipHover_TL.BackgroundTransparency = 1
ShipHover_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
ShipHover_TL.Size = UDim2.new(0.663618565, 0, 1, 0)
ShipHover_TL.ZIndex = 6
ShipHover_TL.Font = Enum.Font.GothamBold
ShipHover_TL.Text = "Ship Hover"
ShipHover_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
ShipHover_TL.TextSize = 12
ShipHover_TL.TextWrapped = true
ShipHover_TL.TextXAlignment = Enum.TextXAlignment.Left

Toggle_ShipHover.Name = "Toggle_ShipHover"
Toggle_ShipHover.Parent = ShipHover
Toggle_ShipHover.AnchorPoint = Vector2.new(0, 0.5)
Toggle_ShipHover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_ShipHover.BackgroundTransparency = 1
Toggle_ShipHover.Position = UDim2.new(0.834999979, 0, 0.499999881, 0)
Toggle_ShipHover.Size = UDim2.new(0.0549999997, 0, 0.5, 0)
Toggle_ShipHover.ZIndex = 2
Toggle_ShipHover.Image = "rbxassetid://3570695787"
Toggle_ShipHover.ScaleType = Enum.ScaleType.Slice
Toggle_ShipHover.SliceCenter = Rect.new(100, 100, 100, 100)

Roundify_22.Name = "Roundify"
Roundify_22.Parent = ShipHover
Roundify_22.AnchorPoint = Vector2.new(0, 0.5)
Roundify_22.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_22.BackgroundTransparency = 1
Roundify_22.Position = UDim2.new(0.834999979, 0, 0.499999881, 0)
Roundify_22.Size = UDim2.new(0.119999997, 0, 0.5, 0)
Roundify_22.Image = "rbxassetid://3570695787"
Roundify_22.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_22.ScaleType = Enum.ScaleType.Slice
Roundify_22.SliceCenter = Rect.new(100, 100, 100, 100)

ShipSpeed.Name = "ShipSpeed"
ShipSpeed.Parent = ShipTab
ShipSpeed.BackgroundTransparency = 1
ShipSpeed.Position = UDim2.new(0, 0, 0.0700000003, 0)
ShipSpeed.Size = UDim2.new(0.971999943, 0, 0.0799999982, 0)
ShipSpeed.Image = "rbxassetid://3570695787"
ShipSpeed.ImageColor3 = Color3.fromRGB(38, 38, 38)
ShipSpeed.ScaleType = Enum.ScaleType.Slice
ShipSpeed.SliceCenter = Rect.new(100, 100, 100, 100)
ShipSpeed.SliceScale = 0.060

ShipSpeed_TL.Name = "ShipSpeed_TL"
ShipSpeed_TL.Parent = ShipSpeed
ShipSpeed_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ShipSpeed_TL.BackgroundTransparency = 1
ShipSpeed_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
ShipSpeed_TL.Size = UDim2.new(0.663618565, 0, 1, 0)
ShipSpeed_TL.ZIndex = 6
ShipSpeed_TL.Font = Enum.Font.GothamBold
ShipSpeed_TL.Text = "Ship Speed"
ShipSpeed_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
ShipSpeed_TL.TextSize = 12
ShipSpeed_TL.TextWrapped = true
ShipSpeed_TL.TextXAlignment = Enum.TextXAlignment.Left

Toggle_ShipSpeed.Name = "Toggle_ShipSpeed"
Toggle_ShipSpeed.Parent = ShipSpeed
Toggle_ShipSpeed.AnchorPoint = Vector2.new(0, 0.5)
Toggle_ShipSpeed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_ShipSpeed.BackgroundTransparency = 1
Toggle_ShipSpeed.Position = UDim2.new(0.834999979, 0, 0.499999881, 0)
Toggle_ShipSpeed.Size = UDim2.new(0.0549999997, 0, 0.5, 0)
Toggle_ShipSpeed.ZIndex = 2
Toggle_ShipSpeed.Image = "rbxassetid://3570695787"
Toggle_ShipSpeed.ScaleType = Enum.ScaleType.Slice
Toggle_ShipSpeed.SliceCenter = Rect.new(100, 100, 100, 100)

Roundify_23.Name = "Roundify"
Roundify_23.Parent = ShipSpeed
Roundify_23.AnchorPoint = Vector2.new(0, 0.5)
Roundify_23.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_23.BackgroundTransparency = 1
Roundify_23.Position = UDim2.new(0.834999979, 0, 0.499999881, 0)
Roundify_23.Size = UDim2.new(0.119999997, 0, 0.5, 0)
Roundify_23.Image = "rbxassetid://3570695787"
Roundify_23.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_23.ScaleType = Enum.ScaleType.Slice
Roundify_23.SliceCenter = Rect.new(100, 100, 100, 100)

UIListLayout_5.Parent = ShipTab
UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_5.Padding = UDim.new(0.0250000004, 0)

TpToShip.Name = "TpToShip"
TpToShip.Parent = ShipTab
TpToShip.BackgroundTransparency = 1
TpToShip.Position = UDim2.new(4.67080184e-07, 0, 0.279753387, 0)
TpToShip.Size = UDim2.new(0.971999943, 0, 0.0799999982, 0)
TpToShip.Image = "rbxassetid://3570695787"
TpToShip.ImageColor3 = Color3.fromRGB(38, 38, 38)
TpToShip.ScaleType = Enum.ScaleType.Slice
TpToShip.SliceCenter = Rect.new(100, 100, 100, 100)
TpToShip.SliceScale = 0.060

Teleport_TL_13.Name = "Teleport_TL"
Teleport_TL_13.Parent = TpToShip
Teleport_TL_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Teleport_TL_13.BackgroundTransparency = 1
Teleport_TL_13.Position = UDim2.new(0.0489282086, 0, 0, 0)
Teleport_TL_13.Size = UDim2.new(0.663618565, 0, 1, 0)
Teleport_TL_13.ZIndex = 6
Teleport_TL_13.Font = Enum.Font.GothamBold
Teleport_TL_13.Text = "Teleport to ship"
Teleport_TL_13.TextColor3 = Color3.fromRGB(234, 234, 234)
Teleport_TL_13.TextSize = 12
Teleport_TL_13.TextWrapped = true
Teleport_TL_13.TextXAlignment = Enum.TextXAlignment.Left

TeleportTo_Btn_13.Name = "TeleportTo_Btn"
TeleportTo_Btn_13.Parent = TpToShip
TeleportTo_Btn_13.AnchorPoint = Vector2.new(0, 0.5)
TeleportTo_Btn_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeleportTo_Btn_13.BackgroundTransparency = 1
TeleportTo_Btn_13.BorderSizePixel = 0
TeleportTo_Btn_13.Position = UDim2.new(0.749213159, 0, 0.499999881, 0)
TeleportTo_Btn_13.Size = UDim2.new(0.23855485, 0, 0.800000072, 0)
TeleportTo_Btn_13.ZIndex = 2
TeleportTo_Btn_13.Font = Enum.Font.GothamBold
TeleportTo_Btn_13.Text = "Teleport"
TeleportTo_Btn_13.TextColor3 = Color3.fromRGB(211, 211, 211)
TeleportTo_Btn_13.TextSize = 12
TeleportTo_Btn_13.TextWrapped = true

Roundify_24.Name = "Roundify"
Roundify_24.Parent = TeleportTo_Btn_13
Roundify_24.AnchorPoint = Vector2.new(0.5, 0.5)
Roundify_24.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Roundify_24.BackgroundTransparency = 1
Roundify_24.Position = UDim2.new(0.5, 0, 0.5, 0)
Roundify_24.Size = UDim2.new(1, 0, 1, 0)
Roundify_24.Image = "rbxassetid://3570695787"
Roundify_24.ImageColor3 = Color3.fromRGB(62, 62, 62)
Roundify_24.ScaleType = Enum.ScaleType.Slice
Roundify_24.SliceCenter = Rect.new(100, 100, 100, 100)
Roundify_24.SliceScale = 0.060

TabButtons.Name = "TabButtons"
TabButtons.Parent = MainFrame

Ship_Button.Name = "Ship_Button"
Ship_Button.Parent = TabButtons
Ship_Button.BackgroundTransparency = 1
Ship_Button.Position = UDim2.new(0.0228033531, 0, 0.300000012, 0)
Ship_Button.Size = UDim2.new(0.182427242, 0, 0.075000003, 0)
Ship_Button.ZIndex = 5
Ship_Button.Font = Enum.Font.GothamBold
Ship_Button.Text = "Ship"
Ship_Button.TextColor3 = Color3.fromRGB(217, 217, 217)
Ship_Button.TextSize = 14
Ship_Button.TextWrapped = true

background.Name = "background"
background.Parent = Ship_Button
background.AnchorPoint = Vector2.new(0.5, 0.5)
background.BackgroundTransparency = 1
background.Position = UDim2.new(0.5, 0, 0.5, 0)
background.ZIndex = 4
background.Image = "rbxassetid://3570695787"
background.ImageColor3 = Color3.fromRGB(63, 63, 63)
background.ScaleType = Enum.ScaleType.Slice
background.SliceCenter = Rect.new(100, 100, 100, 100)
background.SliceScale = 0.080

Player_Button.Name = "Player_Button"
Player_Button.Parent = TabButtons
Player_Button.BackgroundTransparency = 1
Player_Button.Position = UDim2.new(0.0228033531, 0, 0.100000001, 0)
Player_Button.Size = UDim2.new(0.182427242, 0, 0.075000003, 0)
Player_Button.ZIndex = 5
Player_Button.Font = Enum.Font.GothamBold
Player_Button.Text = "Player"
Player_Button.TextColor3 = Color3.fromRGB(217, 217, 217)
Player_Button.TextSize = 14
Player_Button.TextWrapped = true

background_2.Name = "background"
background_2.Parent = Player_Button
background_2.AnchorPoint = Vector2.new(0.5, 0.5)
background_2.BackgroundTransparency = 1
background_2.Position = UDim2.new(0.5, 0, 0.5, 0)
background_2.ZIndex = 4
background_2.Image = "rbxassetid://3570695787"
background_2.ImageColor3 = Color3.fromRGB(63, 63, 63)
background_2.ScaleType = Enum.ScaleType.Slice
background_2.SliceCenter = Rect.new(100, 100, 100, 100)
background_2.SliceScale = 0.080

Farms_Button.Name = "Farms_Button"
Farms_Button.Parent = TabButtons
Farms_Button.BackgroundTransparency = 1
Farms_Button.Position = UDim2.new(0.0228033531, 0, 0.200000003, 0)
Farms_Button.Size = UDim2.new(0.182427242, 0, 0.075000003, 0)
Farms_Button.ZIndex = 5
Farms_Button.Font = Enum.Font.GothamBold
Farms_Button.Text = "Farms"
Farms_Button.TextColor3 = Color3.fromRGB(217, 217, 217)
Farms_Button.TextSize = 14
Farms_Button.TextWrapped = true

background.Name = "background"
background.Parent = Farms_Button
background.AnchorPoint = Vector2.new(0.5, 0.5)
background.BackgroundTransparency = 1
background.Position = UDim2.new(0.5, 0, 0.5, 0)
background.ZIndex = 4
background.Image = "rbxassetid://3570695787"
background.ImageColor3 = Color3.fromRGB(63, 63, 63)
background.ScaleType = Enum.ScaleType.Slice
background.SliceCenter = Rect.new(100, 100, 100, 100)
background.SliceScale = 0.080

Teleports_Button.Name = "Teleports_Button"
Teleports_Button.Parent = TabButtons
Teleports_Button.BackgroundTransparency = 1
Teleports_Button.Position = UDim2.new(0.0228033531, 0, 0.400000006, 0)
Teleports_Button.Size = UDim2.new(0.182427242, 0, 0.075000003, 0)
Teleports_Button.ZIndex = 5
Teleports_Button.Font = Enum.Font.GothamBold
Teleports_Button.Text = "Teleports"
Teleports_Button.TextColor3 = Color3.fromRGB(217, 217, 217)
Teleports_Button.TextSize = 14
Teleports_Button.TextWrapped = true

background_4.Name = "background"
background_4.Parent = Teleports_Button
background_4.AnchorPoint = Vector2.new(0.5, 0.5)
background_4.BackgroundTransparency = 1
background_4.Position = UDim2.new(0.5, 0, 0.5, 0)
background_4.ZIndex = 4
background_4.Image = "rbxassetid://3570695787"
background_4.ImageColor3 = Color3.fromRGB(63, 63, 63)
background_4.ScaleType = Enum.ScaleType.Slice
background_4.SliceCenter = Rect.new(100, 100, 100, 100)
background_4.SliceScale = 0.080

Credits_Button.Name = "Credits_Button"
Credits_Button.Parent = TabButtons
Credits_Button.BackgroundTransparency = 1
Credits_Button.Position = UDim2.new(0.0228033531, 0, 0.5, 0)
Credits_Button.Size = UDim2.new(0.182427242, 0, 0.075000003, 0)
Credits_Button.ZIndex = 5
Credits_Button.Font = Enum.Font.GothamBold
Credits_Button.Text = "Credits"
Credits_Button.TextColor3 = Color3.fromRGB(217, 217, 217)
Credits_Button.TextSize = 14
Credits_Button.TextWrapped = true

background_5.Name = "background"
background_5.Parent = Credits_Button
background_5.AnchorPoint = Vector2.new(0.5, 0.5)
background_5.BackgroundTransparency = 1
background_5.Position = UDim2.new(0.5, 0, 0.5, 0)
background_5.ZIndex = 4
background_5.Image = "rbxassetid://3570695787"
background_5.ImageColor3 = Color3.fromRGB(63, 63, 63)
background_5.ScaleType = Enum.ScaleType.Slice
background_5.SliceCenter = Rect.new(100, 100, 100, 100)
background_5.SliceScale = 0.080


Minimized.Name = "Minimized"
Minimized.Parent = TRD
Minimized.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Minimized.BackgroundTransparency = 1
Minimized.Position = UDim2.new(0.481481493, 0, 0.05, 0)
Minimized.Size = UDim2.new(0.02, 0, 0.04, 0)
Minimized.Image = "rbxassetid://3570695787"
Minimized.ImageColor3 = Color3.fromRGB(0, 239, 35)
Minimized.ScaleType = Enum.ScaleType.Slice
Minimized.SliceCenter = Rect.new(100, 100, 100, 100)
Minimized.SliceScale = 0.100
Minimized.Visible = false

Logo.Name = "Logo"
Logo.Parent = Minimized
Logo.AnchorPoint = Vector2.new(0.5, 0.5)
Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Logo.BackgroundTransparency = 1
Logo.Position = UDim2.new(0.5, 0, 0.5, 0)
Logo.Size = UDim2.new(0.949999988, 0, 0.949999988, 0)
Logo.Image = "rbxassetid://3570695787"
Logo.ImageColor3 = Color3.fromRGB(66, 66, 66)
Logo.ScaleType = Enum.ScaleType.Slice
Logo.SliceCenter = Rect.new(100, 100, 100, 100)
Logo.SliceScale = 0.100

Logo2.Name = "Logo"
Logo2.Parent = Logo
Logo2.AnchorPoint = Vector2.new(0.5, 0.5)
Logo2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Logo2.BackgroundTransparency = 1
Logo2.Position = UDim2.new(0.5, 0, 0.5, 0)
Logo2.Size = UDim2.new(0.8, 0, 0.8, 0)
Logo2.Image = "rbxassetid://9309160657"
Logo2.ScaleType = Enum.ScaleType.Stretch

SliderBar.Name = "SliderBar"
SliderBar.Parent = Speed_SliderFrame
SliderBar.AnchorPoint = Vector2.new(0, 0.5)
SliderBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SliderBar.BackgroundTransparency = 1
SliderBar.Position = UDim2.new(0, 0, 0.5, 0)
SliderBar.Size = UDim2.new(1, 0, 1, 0)
SliderBar.ZIndex = 2
SliderBar.Image = "rbxassetid://3570695787"
SliderBar.ImageColor3 = Color3.fromRGB(0, 239, 35)
SliderBar.ScaleType = Enum.ScaleType.Slice
SliderBar.SliceCenter = Rect.new(100, 100, 100, 100)


-- Map UI (for teleports):
local Map_Frame = Instance.new("Frame", TRD)
Map_Frame.Size = UDim2.new(0, 410, 0, 410)
Map_Frame.Position = UDim2.new(.5, 0, .1, 0)
Map_Frame.BackgroundTransparency = .3
Map_Frame.BackgroundColor3 = Color3.fromRGB()
Map_Frame.Visible = false

local Map_Image = Instance.new("ImageLabel", Map_Frame)
Map_Image.Size = UDim2.new(1, 0, 1, 0)
Map_Image.Image = "rbxassetid://6694679979"
Map_Image.BackgroundTransparency = .3
Map_Image.BorderColor3 = Color3.fromRGB(270, 42, 53)
Map_Image.ZIndex = 2

for i, v in pairs(islandTeleports) do -- Map buttons
    local mapButton = Instance.new("TextButton", Map_Frame)
    mapButton.Name = i
    mapButton.Text = i
    mapButton.TextScaled = true
    mapButton.Size = UDim2.new(0.12, 0, 0.05, 0)
    mapButton.Position = islandTeleports[i][2]
    mapButton.ZIndex = 3
    mapButton.MouseButton1Click:Connect(function()
        teleportPlayer(islandTeleports[i][1] + Vector3.new(0, 5, 0))
    end)
end



-- [[ Functions ]] --
function WalkOnWater_Enable()
    local oceanWaves = game.Workspace:WaitForChild("OceanWaves")
    for i, v in pairs(oceanWaves:GetChildren()) do
        v.CanCollide = true
    end
end

function WalkOnWater_Disable()
    local oceanWaves = game.Workspace:WaitForChild("OceanWaves")
    for i, v in pairs(oceanWaves:GetChildren()) do
        v.CanCollide = false
    end
end

function teleportPlayer(coordinates)
    local teleportDistance = (player.Character.HumanoidRootPart.Position - coordinates).Magnitude
    local SPEED_LIMITER = 600
    local WAIT_SPEED = 1 / 30

    if teleportDistance >= 500 then
        local start = player.Character.HumanoidRootPart.CFrame
        local target = CFrame.new(coordinates)
        for i = 0, 1, (SPEED_LIMITER / teleportDistance) * WAIT_SPEED do
            local new_position = start:lerp(target, i)
            player.Character.HumanoidRootPart.CFrame = new_position
            wait(WAIT_SPEED)
        end
    elseif teleportDistance < 500 then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(coordinates)
    end
end

function lookAt(chr, target)
    if chr.PrimaryPart then
        local chrPos = chr.PrimaryPart.Position
        local tPos = target.Position
        local newCF = CFrame.new(chrPos, tPos)
        chr:SetPrimaryPartCFrame(newCF)
    end
end

function equipPickaxe_orFind()
    for i, v in pairs(inventoryTable:InvokeServer(nil)) do
        if i ~= nil then
            if i == 1 or i == 2 or i == 3 then
                if string.find(v[1], "Pickaxe") then
                    equipTool:FireServer(true, i, "Pickaxe", v[3], v[4])
                    break
                end
            else
                for p, g in pairs(v) do
                    if g == "Pickaxe" then
                        inventorySwap:FireServer(1, v)
                        equipTool:FireServer(true, 1, "Pickaxe", v[3], v[4])
                        break
                    end
                end
            end
        end
    end
end

function equipAxe_orFind()
    for i, v in pairs(inventoryTable:InvokeServer(nil)) do
        if i ~= nil then
            if i == 1 or i == 2 or i == 3 then
                if string.find(v[1], "Axe") then
                    equipTool:FireServer(true, i, "Axe", v[3], v[4])
                    break
                end
            else
                for p, g in pairs(v) do
                    if g == "Axe" then
                        inventorySwap:FireServer(1, v)
                        equipTool:FireServer(true, 1, "Axe", v[3], v[4])
                        break
                    end
                end
            end
        end
    end
end

function runAutofarm()
    while(toggles.rockFarm == true) do
        -- Equip pickaxe or find one in inventory --
        equipPickaxe_orFind()
        
        -- search for closest ore node --
        local currentClosestOre = nil
        local currentClosestOre_Distance = nil

        for i, v in pairs(game.Workspace.OreNodes:GetChildren() or game.Workspace:WaitForChild("OreNodes"):GetChildren()) do
            wait(0.001)
            for p, g in pairs(v:GetChildren()) do
                local oreNode_Position = g.Position
                
                if not g:FindFirstChild("BrokenOre") then
                    if currentClosestOre == nil then
                        currentClosestOre = g
                        currentClosestOre_Distance = (oreNode_Position - player.Character.HumanoidRootPart.Position).Magnitude
                    else
                        if (oreNode_Position - player.Character.HumanoidRootPart.Position).Magnitude < currentClosestOre_Distance then
                            currentClosestOre = g
                            currentClosestOre_Distance = (oreNode_Position - player.Character.HumanoidRootPart.Position).Magnitude
                        end
                    end
                end
            end
        end
        
        -- Setup (equip weapon, set camera,...) --
        Camera.CameraType = Enum.CameraType.Custom
        UserInputService.MouseIconEnabled = true
        
        local SwingEvent = player.Character.ActiveGear.ToolScript:FindFirstChild("Swing")
        if SwingEvent then
            local count = 0
            
            while(not currentClosestOre:FindFirstChild("BrokenOre") and toggles.rockFarm == true) do
                equipPickaxe_orFind()
                
                if count % 2 == 0 then --sometimes the charcter could get stuck in one position so we try the other
                    teleportPlayer(currentClosestOre.Position + Vector3.new(5, 2, 0)) --teleports player infront of the oreNode
                else
                    teleportPlayer(currentClosestOre.Position + Vector3.new(-5, 2, 0))
                end
                lookAt(player.Character, currentClosestOre) -- Look towards the rock
                SwingEvent:FireServer("Left", {}) -- Swing at the rock
                wait(1.5)
                count = count + 1
            end
        end
    end
end

function runAutofarm_Trees()
    while(toggles.woodFarm == true) do
        -- Equip axe or find one in inventory --
        equipAxe_orFind()
        
        -- search for closest tree --
        local currentClosestTree = nil
        local currentClosestTree_Distance = nil
        local treeParent = nil

        for i, v in pairs(game.Workspace.Trees:GetDescendants() or game.Workspace:WaitForChild("Trees"):GetDescendants()) do
            if v.Name == "Trunk" then
                if v.Parent then
                    if not v.Parent:FindFirstChild("FallenTree") then
                        if currentClosestTree == nil then
                            currentClosestTree = v
                            currentClosestTree_Distance = (v.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        else
                            if (v.Position - player.Character.HumanoidRootPart.Position).Magnitude < currentClosestTree_Distance then
                                currentClosestTree = v
                                currentClosestTree_Distance = (v.Position - player.Character.HumanoidRootPart.Position).Magnitude
                            end
                        end
                    end
                end
            end
        end
        treeParent = currentClosestTree.Parent
        
        -- Setup (equip weapon, set camera,...) --
        Camera.CameraType = Enum.CameraType.Custom
        UserInputService.MouseIconEnabled = true
        local count = 0
        
        while toggles.woodFarm == true do
            equipAxe_orFind()

            if count % 2 == 0 then --sometimes the charcter could get stuck in one position so we try the other
                teleportPlayer(currentClosestTree.Position + Vector3.new(3, 2, 0)) --teleports player infront of the tree
            else
                teleportPlayer(currentClosestTree.Position + Vector3.new(-3, 2, 0))
            end
            lookAt(player.Character, currentClosestTree) -- Look towards the tree
            player.Character.ActiveGear.ToolScript:FindFirstChild("Swing"):FireServer("Left", {}) -- Swing at the tree
            wait(1.5)
            count = count + 1
            
            if treeParent == nil then
                break
            else
               if treeParent:FindFirstChild("FallenTree") then break end 
            end
            if toggles.woodFarm == false then break end
        end
        --currentClosestTree = nil
    end
end

local inputBegan_ClickTP = nil
local inputEnded_ClickTP = nil
local function toggle_ClickTP(boolean)
    local ctrlIsDown = false
    if boolean == true then
        inputBegan_ClickTP = UserInputService.InputBegan:Connect(function(key)
            if key.KeyCode == Enum.KeyCode.LeftShift then
                ctrlIsDown = true
                UserInputService.InputBegan:Connect(function(input, processed)
                    if not processed and input.UserInputType == Enum.UserInputType.MouseButton1 and ctrlIsDown and toggles.ClickTP then
                        local pos = mouse.Hit.p + Vector3.new(0, 2.5, 0)
                        pos = CFrame.new(pos.X,pos.Y,pos.Z)
                        player.Character.HumanoidRootPart.CFrame = pos
                    end
                end)
            end
        end)

        inputEnded_ClickTP = UserInputService.InputEnded:Connect(function(key)
            if key.KeyCode == Enum.KeyCode.LeftShift then
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
        teleportPlayer(foundPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 0, 3))
    end
end



local function toggle_SuperSpeed()
    while toggles.superSpeed do
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-superSpeed_speedValue / 10)
        end;
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(-superSpeed_speedValue / 10,0,0)
        end;
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,superSpeed_speedValue / 10)
        end;
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(superSpeed_speedValue / 10,0,0)
        end;
        wait()
    end
end


-- ship functions:
function flyingShip()
    if hoveringShip_conn then
        if hoveringShip_conn.Connected then
            hoveringShip_conn:Disconnect()
        end
    end
    local ships_F = game.Workspace.Ships
    local playerShip = ships_F:FindFirstChild("Ship_"..player.Name)
    if playerShip then
        local BodyPosition = playerShip.Base.BodyPosition
        BodyPosition.D = 10000
        BodyPosition.P = 100000
        hoveringShip_conn = RS.RenderStepped:Connect(function()
            BodyPosition.Position = Vector3.new(0, 30, 0)
        end)
    end
end

function fastShip()
    if fastShip_conn then
        if fastShip_conn.Connected then
            hoveringShip_conn:Disconnect()
        end
    end
    local ships_F = game.Workspace.Ships
    local playerShip = ships_F:FindFirstChild("Ship_"..player.Name)
    if playerShip then
        local BodyVelocity = playerShip.Base.BodyVelocity
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
        fastShip_conn = RS.RenderStepped:Connect(function()
            BodyVelocity.Velocity = Vector3.new(
                BodyVelocity.Velocity.X * 1.5,
                BodyVelocity.Velocity.Y,
                BodyVelocity.Velocity.Z * 1.5
            )
        end)
    end
end




-- [[ Button Listeners ]] --

-- Player tab:
Toggle_ClickTP.MouseButton1Click:Connect(function()
    if toggles.ClickTP == false then
        toggles.ClickTP = true
        Toggle_ClickTP:TweenPosition(Toggle_ClickTP.Position + UDim2.new(.066,0,0,0),"In","Sine",.1)
        Toggle_ClickTP.Parent.Roundify.ImageColor3 = Color3.fromRGB(0, 239, 35)
        toggle_ClickTP(true)
    else
        toggles.ClickTP = false
        Toggle_ClickTP:TweenPosition(Toggle_ClickTP.Position + UDim2.new(-.066,0,0,0),"In","Sine",.1)
        Toggle_ClickTP.Parent.Roundify.ImageColor3 = Color3.fromRGB(62, 62, 62)
        toggle_ClickTP(false)
    end
end)

Toggle_WalkOnWater.MouseButton1Click:Connect(function()
    if toggles.WalkOnWater == false then
        toggles.WalkOnWater = true
        Toggle_WalkOnWater:TweenPosition(Toggle_WalkOnWater.Position + UDim2.new(.066,0,0,0),"In","Sine",.1)
        Toggle_WalkOnWater.Parent.Roundify.ImageColor3 = Color3.fromRGB(0, 239, 35)
        WalkOnWater_Enable()
    else
        toggles.WalkOnWater = false
        Toggle_WalkOnWater:TweenPosition(Toggle_WalkOnWater.Position + UDim2.new(-.066,0,0,0),"In","Sine",.1)
        Toggle_WalkOnWater.Parent.Roundify.ImageColor3 = Color3.fromRGB(62, 62, 62)
        WalkOnWater_Disable()
    end
end)

Toggle_Speed.MouseButton1Click:Connect(function()
    if toggles.superSpeed == false then
        toggles.superSpeed = true
        Toggle_Speed:TweenPosition(Toggle_Speed.Position + UDim2.new(.066,0,0,0),"In","Sine",.1)
        Toggle_Speed.Parent.Roundify.ImageColor3 = Color3.fromRGB(0, 239, 35)
        toggle_SuperSpeed()
    else
        toggles.superSpeed = false
        Toggle_Speed:TweenPosition(Toggle_Speed.Position + UDim2.new(-.066,0,0,0),"In","Sine",.1)
        Toggle_Speed.Parent.Roundify.ImageColor3 = Color3.fromRGB(62, 62, 62)
    end
end)

Toggle_TeleportToPlayer.MouseButton1Click:Connect(function()
    Toggle_TeleportToPlayer.Text = "Teleporting"
    teleportToPlayer(Input_TeleportToPlayer.Text)
    Toggle_TeleportToPlayer.Text = "Teleport"
end)

-- Ship tab:
Toggle_ShipHover.MouseButton1Click:Connect(function()
    if toggles.shipHover == false then
        toggles.shipHover = true
        Toggle_ShipHover:TweenPosition(Toggle_ShipHover.Position + UDim2.new(.066,0,0,0),"In","Sine",.1)
        Toggle_ShipHover.Parent.Roundify.ImageColor3 = Color3.fromRGB(0, 239, 35)
        flyingShip()
    else
        toggles.shipHover = false
        Toggle_ShipHover:TweenPosition(Toggle_ShipHover.Position + UDim2.new(-.066,0,0,0),"In","Sine",.1)
        Toggle_ShipHover.Parent.Roundify.ImageColor3 = Color3.fromRGB(62, 62, 62)
    end
end)

Toggle_ShipSpeed.MouseButton1Click:Connect(function()
    if toggles.shipSpeed == false then
        toggles.shipSpeed = true
        Toggle_ShipSpeed:TweenPosition(Toggle_ShipSpeed.Position + UDim2.new(.066,0,0,0),"In","Sine",.1)
        Toggle_ShipSpeed.Parent.Roundify.ImageColor3 = Color3.fromRGB(0, 239, 35)
        fastShip()
    else
        toggles.shipSpeed = false
        Toggle_ShipSpeed:TweenPosition(Toggle_ShipSpeed.Position + UDim2.new(-.066,0,0,0),"In","Sine",.1)
        Toggle_ShipSpeed.Parent.Roundify.ImageColor3 = Color3.fromRGB(62, 62, 62)
    end
end)

TeleportTo_Btn_13.MouseButton1Click:Connect(function()
    local playerShip = game.Workspace.Ships:FindFirstChild("Ship_"..player.Name)
    if playerShip then
        TeleportTo_Btn_13.Text = "Teleporting"
        teleportPlayer(playerShip.Seat.Position + Vector3.new(0, 5, 0))
        TeleportTo_Btn_13.Text = "Teleport"
    end
end)


-- Farms tab:
Toggle_WoodFarm.MouseButton1Click:Connect(function()
    if toggles.woodFarm == false then
        toggles.woodFarm = true
        Toggle_WoodFarm:TweenPosition(Toggle_WoodFarm.Position + UDim2.new(.066,0,0,0),"In","Sine",.1)
        Toggle_WoodFarm.Parent.Roundify.ImageColor3 = Color3.fromRGB(0, 239, 35)
        runAutofarm_Trees()
    else
        toggles.woodFarm = false
        Toggle_WoodFarm:TweenPosition(Toggle_WoodFarm.Position + UDim2.new(-.066,0,0,0),"In","Sine",.1)
        Toggle_WoodFarm.Parent.Roundify.ImageColor3 = Color3.fromRGB(62, 62, 62)
    end
end)

Toggle_StoneFarm.MouseButton1Click:Connect(function()
    if toggles.rockFarm == false then
        toggles.rockFarm = true
        Toggle_StoneFarm:TweenPosition(Toggle_StoneFarm.Position + UDim2.new(.066,0,0,0),"In","Sine",.1)
        Toggle_StoneFarm.Parent.Roundify.ImageColor3 = Color3.fromRGB(0, 239, 35)
        runAutofarm()
    else
        toggles.rockFarm = false
        Toggle_StoneFarm:TweenPosition(Toggle_StoneFarm.Position + UDim2.new(-.066,0,0,0),"In","Sine",.1)
        Toggle_StoneFarm.Parent.Roundify.ImageColor3 = Color3.fromRGB(62, 62, 62)
    end
end)

-- Teleports tab
OpenMAPui_Btn.MouseButton1Click:Connect(function()
    if Map_Frame.Visible == false then
        Map_Frame.Visible = true
        OpenMAPui_Btn.Text = "Close"
    else
        Map_Frame.Visible = false
        OpenMAPui_Btn.Text = "Open"
    end
end)




-- [[ Sliders ]] --
local isDragging_Speed = false
reverse_percentage = (superSpeed_speedValue * Speed_SliderFrame.Size.X.Scale) / max_superSpeed_speedValue * 2
Speed_Slider.Position = UDim2.new(reverse_percentage - Speed_Slider.Size.X.Scale / 2, 0, .5, 0)
SliderBar.Size = UDim2.new(reverse_percentage, 0, SliderBar.Size.Y.Scale, 0)
SpeedValue_TL.Text = superSpeed_speedValue

-- Speed slider:
Speed_Slider.MouseButton1Down:Connect(function()
	isDragging_Speed = true
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isDragging_Speed = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		if isDragging_Speed then
			local mouseLoc = UserInputService:GetMouseLocation()
			local relativePos = mouseLoc - Speed_SliderFrame.AbsolutePosition
			local percentage = math.clamp(relativePos.X / Speed_SliderFrame.AbsoluteSize.X, 0, 1)
			Speed_Slider.Position = UDim2.new(percentage - Speed_Slider.Size.X.Scale / 2, 0, .5, 0)
			SliderBar.Size = UDim2.new(percentage, 0, SliderBar.Size.Y.Scale, 0)
			local value = math.floor(math.clamp((percentage * max_superSpeed_speedValue), min_superSpeed_speedValue, max_superSpeed_speedValue))
			SpeedValue_TL.Text = value
			superSpeed_speedValue = value
		end
	end
end)

Speed_SliderFrame.MouseButton1Click:Connect(function()
	if not isDragging_Speed then
		local mouseLoc = UserInputService:GetMouseLocation()
		local relativePos = mouseLoc - Speed_SliderFrame.AbsolutePosition
		local percentage = math.clamp(relativePos.X / Speed_SliderFrame.AbsoluteSize.X, 0, 1)
		Speed_Slider:TweenPosition(UDim2.new(percentage - Speed_Slider.Size.X.Scale / 2, 0, .5, 0),"In","Sine",.1)
		SliderBar:TweenSize(UDim2.new(percentage, 0, SliderBar.Size.Y.Scale, 0),"In","Sine",.1)
		local value = math.floor(math.clamp((percentage * max_superSpeed_speedValue), min_superSpeed_speedValue, max_superSpeed_speedValue))
		SpeedValue_TL.Text = value
		superSpeed_speedValue = value
	end
end)

SliderBar.MouseButton1Click:Connect(function()
	if not isDragging_Speed then
		local mouseLoc = UserInputService:GetMouseLocation()
		local relativePos = mouseLoc - Speed_SliderFrame.AbsolutePosition
		local percentage = math.clamp(relativePos.X / Speed_SliderFrame.AbsoluteSize.X, 0, 1)
		Speed_Slider:TweenPosition(UDim2.new(percentage - Speed_Slider.Size.X.Scale / 2, 0, .5, 0),"In","Sine",.1)
		SliderBar:TweenSize(UDim2.new(percentage, 0, SliderBar.Size.Y.Scale, 0),"In","Sine",.1)
		local value = math.floor(math.clamp((percentage * max_superSpeed_speedValue), min_superSpeed_speedValue, max_superSpeed_speedValue))
		SpeedValue_TL.Text = value
		superSpeed_speedValue = value
	end
end)



-- Misc UIS --
for _, v in pairs(TabButtons:GetChildren()) do
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
end

for _, v in pairs(TeleportsTab:GetChildren()) do
    if v:IsA("ImageLabel") then
        print(v.Name)
        local tp_button = v:FindFirstChild("TeleportTo_Btn")
        if tp_button then
            tp_button.MouseButton1Click:Connect(function()
                player.Character.HumanoidRootPart.CFrame = teleportPlayer(islandTeleports[v.Teleport_TL.Text][1])
            end)
        end
    end
end


-- discord link funcs --
CopyLink_Btn.MouseButton1Click:Connect(function()
    setclipboard(discordLink)
    local tempText = CopyLink_Btn.Text
    CopyLink_Btn.Text = "Copied!"
    wait(.5)
    CopyLink_Btn.Text = tempText
end)


-- [[ Page Button Listeners ]] --
local function OpenPage(Page)
    for _, v in pairs(Tabs:GetChildren()) do --Close all other pages
        v.Visible = false
    end
    Page.Visible = true
end

Credits_Button.MouseButton1Click:Connect(function() OpenPage(CreditsTab) end)
Player_Button.MouseButton1Click:Connect(function() OpenPage(PlayerTab) end)
Farms_Button.MouseButton1Click:Connect(function() OpenPage(FarmsTab) end)
Ship_Button.MouseButton1Click:Connect(function() OpenPage(ShipTab) end)
Teleports_Button.MouseButton1Click:Connect(function() OpenPage(TeleportsTab) end)



X_Button.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

Max_Button.MouseButton1Click:Connect(function()
    MainFrame:TweenPosition(UDim2.new(.5, 0, -2, 0),"In","Sine",.3)
    wait(.3)
    MainFrame.Visible = false
    Minimized.Visible = true
end)

Min_Button.MouseButton1Click:Connect(function()
    MainFrame:TweenPosition(UDim2.new(.5, 0, -2, 0),"In","Sine",.3)
    wait(.3)
    MainFrame.Visible = false
    Minimized.Visible = true
end)

Minimized.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    Minimized.Visible = false
    MainFrame:TweenPosition(UDim2.new(.5, 0, .5, 0),"In","Sine",.3)
end)

Logo.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    Minimized.Visible = false
    MainFrame:TweenPosition(UDim2.new(.5, 0, .5, 0),"In","Sine",.3)
end)

Logo2.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    Minimized.Visible = false
    MainFrame:TweenPosition(UDim2.new(.5, 0, .5, 0),"In","Sine",.3)
end)


-- [[ Input Listeners ]] --
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed then
        if input.KeyCode == close_open_GUI_kb then
            if MainFrame.Visible == true then
                MainFrame:TweenPosition(UDim2.new(.5, 0, -2, 0),"In","Sine",.3)
                wait(.3)
                MainFrame.Visible = false
                Minimized.Visible = true
            else
                MainFrame.Visible = true
                Minimized.Visible = false
                MainFrame:TweenPosition(UDim2.new(.5, 0, .5, 0),"In","Sine",.3)
            end
    
        elseif input.KeyCode == autofarmKillswitch_Key then
            if toggles.rockFarm == false then
                toggles.rockFarm = true
                Toggle_StoneFarm:TweenPosition(Toggle_StoneFarm.Position + UDim2.new(.066,0,0,0),"In","Sine",.1)
                Toggle_StoneFarm.Parent.Roundify.ImageColor3 = Color3.fromRGB(0, 239, 35)
                runAutofarm()
            else
                toggles.rockFarm = false
                Toggle_StoneFarm:TweenPosition(Toggle_StoneFarm.Position + UDim2.new(-.066,0,0,0),"In","Sine",.1)
                Toggle_StoneFarm.Parent.Roundify.ImageColor3 = Color3.fromRGB(62, 62, 62)
            end
    
        elseif input.KeyCode == autofarmKillswitch_Key_Trees then
            if toggles.woodFarm == false then
                toggles.woodFarm = true
                Toggle_WoodFarm:TweenPosition(Toggle_WoodFarm.Position + UDim2.new(.066,0,0,0),"In","Sine",.1)
                Toggle_WoodFarm.Parent.Roundify.ImageColor3 = Color3.fromRGB(0, 239, 35)
                runAutofarm_Trees()
            else
                toggles.woodFarm = false
                Toggle_WoodFarm:TweenPosition(Toggle_WoodFarm.Position + UDim2.new(-.066,0,0,0),"In","Sine",.1)
                Toggle_WoodFarm.Parent.Roundify.ImageColor3 = Color3.fromRGB(62, 62, 62)
            end
        end
    end
end)



--------------------------------------------------------------------------------------------------------------------------------------

-- Draggable UI functionality [ Made by : Spynaz ] --
local UDim2_new = UDim2.new
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
local MapFrameDrag = DraggableObject.new(Map_Frame)
MapFrameDrag:Enable()

--------------------------------------------------------------------------------------------------------------------------------------

-- Anti afk script --
local bb = game:service'VirtualUser'
player.Idled:connect(function()
    bb:CaptureController()bb:ClickButton2(Vector2.new())
    wait(2)
end)
