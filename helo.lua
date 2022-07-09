
-- [[ Author : zakater#8888 ]] --

local MenuName = "Hydra"


-- [[ Variables ]] --
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- UI --
local AlreadyExistingUI = game.CoreGui:FindFirstChild(MenuName) -- Checks if THIS UI already exists
if AlreadyExistingUI then
    AlreadyExistingUI:Destroy()
end

local BaseGui = Instance.new("ScreenGui", game.CoreGui) --Changed from ("ScreenGui", plr.PlayerGui)
BaseGui.ResetOnSpawn = false
BaseGui.Name = MenuName
BaseGui.Enabled = false

local Background = Instance.new("Frame", BaseGui)
Background.Size = UDim2.new(1, 0, 1.2, 0)
Background.Position = UDim2.new(0, 0, -.2, 0)
Background.BackgroundColor3 = Color3.fromRGB(38, 38, 38)

local Logo = Instance.new("ImageLabel", Background)
Logo.Image = "rbxassetid://9309160657"
Logo.AnchorPoint = Vector2.new(.5, .5)
Logo.Position = UDim2.new(.5, 0, .5, 0)
Logo.Size = UDim2.new(.35, 0, .35, 0)
Logo.BackgroundTransparency = 1

--local Desc = Instance.new("TextLabel", Background)
--Desc.Size = UDim2.new(.4, 0, .1, 0)
--Desc.AnchorPoint = Vector2.new(.5, .5)
--Desc.Position = UDim2.new(.5, 0, .55, 0)
--Desc.Font = Enum.Font.GothamBold
--Desc.Text = "xxxxx"
--Desc.BackgroundTransparency = 1


-- Lower CPU Usage + FPS --
local WindowFocusReleasedFunction = function()
	RunService:Set3dRenderingEnabled(false)
	setfpscap(10)
	BaseGui.Enabled = true
	return
end

local WindowFocusedFunction = function()
	RunService:Set3dRenderingEnabled(true)
	setfpscap(60)
	BaseGui.Enabled = false
	return
end

local Initialize = function()
	UserInputService.WindowFocusReleased:Connect(WindowFocusReleasedFunction)
	UserInputService.WindowFocused:Connect(WindowFocusedFunction)
	return
end
Initialize()

