Library = {}
Library.__index = Library

local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local players = game:GetService("Players")

local player = players.LocalPlayer
local mouse = player:GetMouse()

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

function Library.new(UI_Name, version, ThemeColor)
    UI_Name = UI_Name or "Untitled UI"
    version = version or ""
    ThemeColor = ThemeColor or Color3.fromRGB(255, 255, 255)
    local UI_Exists = game.CoreGui:FindFirstChild(UI_Name)
    if UI_Exists then UI_Exists:Destroy() end

    -- Instances:
    local MAIN = Instance.new("ScreenGui")
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
    local Tabs_Folder = Instance.new("Folder")
    local TabButtons = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")

    --Properties:
    MAIN.Name = UI_Name
    MAIN.Parent = game.CoreGui
    MAIN.ResetOnSpawn = false

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = MAIN
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundTransparency = 1
    MainFrame.Position = UDim2.new(0.5, 0, 0.4, 0)
    MainFrame.Size = UDim2.new(0.22200273, 0, 0.311015934, 0)

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
    TopBar.SliceScale = 0.08

    TopBar_BG.Name = "TopBar_BG"
    TopBar_BG.Parent = TopBar
    TopBar_BG.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
    TopBar_BG.BorderSizePixel = 0
    TopBar_BG.Position = UDim2.new(0, 0, 0.8, 0)
    TopBar_BG.Size = UDim2.new(1, 0, 0.2, 0)
    TopBar_BG.ZIndex = 3
    TopBar_BG.ImageColor3 = Color3.fromRGB(61, 61, 61)

    UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(199, 199, 199)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(230, 230, 230)), ColorSequenceKeypoint.new(1, Color3.fromRGB(199, 199, 199))}
    UIGradient.Parent = TopBar

    TopBarBorderLine.Name = "TopBarBorderLine"
    TopBarBorderLine.Parent = TopBar
    TopBarBorderLine.BackgroundColor3 = ThemeColor
    TopBarBorderLine.BorderSizePixel = 0
    TopBarBorderLine.Position = UDim2.new(0, 0, 1, 0)
    TopBarBorderLine.Size = UDim2.new(1, 0, 0.05, 0)
    TopBarBorderLine.ZIndex = 3

    Title_Label.Name = "Title_Label"
    Title_Label.Parent = TopBar
    Title_Label.BackgroundTransparency = 1
    Title_Label.Position = UDim2.new(0.2, 0, 0.25, 0)
    Title_Label.Size = UDim2.new(0.6, 0, 0.6, 0)
    Title_Label.ZIndex = 4
    Title_Label.Font = Enum.Font.GothamBold
    Title_Label.Text = UI_Name
    Title_Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Title_Label.TextScaled = true
    Title_Label.TextWrapped = true

    Version_Label.Name = "Version_Label"
    Version_Label.Parent = TopBar
    Version_Label.BackgroundTransparency = 1
    Version_Label.Position = UDim2.new(0.63, 0, 0.25, 0)
    Version_Label.Size = UDim2.new(0.6, 0, 0.6, 0)
    Version_Label.ZIndex = 4
    Version_Label.Font = Enum.Font.GothamBold
    Version_Label.Text = version
    Version_Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Version_Label.TextScaled = true
    Version_Label.TextWrapped = true

    TopBar_BG_2.Name = "TopBar_BG"
    TopBar_BG_2.Parent = TopBar
    TopBar_BG_2.BackgroundColor3 = Color3.fromRGB(239, 0, 235)
    TopBar_BG_2.BorderSizePixel = 0
    TopBar_BG_2.Position = UDim2.new(0, 0, 0.8, 0)
    TopBar_BG_2.Size = UDim2.new(1, 0, 0.2, 0)
    TopBar_BG_2.ZIndex = 2

    X_Button.Name = "X_Button"
    X_Button.Parent = TopBar_Frame
    X_Button.BackgroundTransparency = 1
    X_Button.Position = UDim2.new(0.03, 0, 0.3, 0)
    X_Button.Size = UDim2.new(0.03, 0, 0.45, 0)
    X_Button.ZIndex = 5
    X_Button.Image = "rbxassetid://3570695787"
    X_Button.ImageColor3 = Color3.fromRGB(249, 77, 78)
    X_Button.ScaleType = Enum.ScaleType.Slice
    X_Button.SliceCenter = Rect.new(100, 100, 100, 100)
    X_Button.SliceScale = 0.120

    Max_Button.Name = "Max_Button"
    Max_Button.Parent = TopBar_Frame
    Max_Button.BackgroundTransparency = 1
    Max_Button.Position = UDim2.new(0.08, 0, 0.3, 0)
    Max_Button.Size = UDim2.new(0.03, 0, 0.45, 0)
    Max_Button.ZIndex = 5
    Max_Button.Image = "rbxassetid://3570695787"
    Max_Button.ImageColor3 = Color3.fromRGB(254, 191, 45)
    Max_Button.ScaleType = Enum.ScaleType.Slice
    Max_Button.SliceCenter = Rect.new(100, 100, 100, 100)
    Max_Button.SliceScale = 0.120

    Min_Button.Name = "Min_Button"
    Min_Button.Parent = TopBar_Frame
    Min_Button.BackgroundTransparency = 1
    Min_Button.Position = UDim2.new(0.13, 0, 0.3, 0)
    Min_Button.Size = UDim2.new(0.03, 0, 0.45, 0)
    Min_Button.ZIndex = 5
    Min_Button.Image = "rbxassetid://3570695787"
    Min_Button.ImageColor3 = Color3.fromRGB(50, 209, 64)
    Min_Button.ScaleType = Enum.ScaleType.Slice
    Min_Button.SliceCenter = Rect.new(100, 100, 100, 100)
    Min_Button.SliceScale = 0.120

    SideBar.Name = "SideBar"
    SideBar.Parent = MainFrame
    SideBar.BackgroundTransparency = 1
    SideBar.Size = UDim2.new(0.228, 0, 1, 0)
    SideBar.Image = "rbxassetid://3570695787"
    SideBar.ImageColor3 = Color3.fromRGB(53, 53, 53)
    SideBar.ScaleType = Enum.ScaleType.Slice
    SideBar.SliceCenter = Rect.new(100, 100, 100, 100)
    SideBar.SliceScale = 0.08

    Tabs_Folder.Name = "Tabs"
    Tabs_Folder.Parent = MainFrame

    TabButtons.Name = "TabButtons"
    TabButtons.Parent = MainFrame
    TabButtons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabButtons.BackgroundTransparency = 1
    TabButtons.Position = UDim2.new(0, 0, 0.1, 0)
    TabButtons.Size = UDim2.new(0.23, 0, 0.875, 0)

    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = TabButtons

    X_Button.MouseButton1Click:Connect(function()
        MainFrame:TweenSize(UDim2.new(0,0,0,0), "In", "Sine", .2)
        wait(.2)
        MainFrame:Destroy()
    end)

    Min_Button.MouseButton1Click:Connect(function()
        MainFrame:TweenSize(UDim2.new(0,0,0,0), "In", "Sine", .2)
    end)

    Max_Button.MouseButton1Click:Connect(function()
        MainFrame:TweenSize(UDim2.new(0,0,0,0), "In", "Sine", .2)
    end)

    Library:DraggingEnabled(MainFrame, TopBar)

    local Tabs = {}
    function Tabs:AddTab(tabName)
        tabName = tabName or "Tab"
        
        --Instances:
        local New_TabButton = Instance.new("TextButton", TabButtons)
        local background = Instance.new("ImageLabel", New_TabButton)
        local NewTab = Instance.new("ScrollingFrame")
        local UIListLayout_Tabs = Instance.new("UIListLayout")

        --Properties:
        New_TabButton.Name = tabName.."_Button"
        New_TabButton.BackgroundTransparency = 1
        New_TabButton.Position = UDim2.new(0, 0, 0, 0)
        New_TabButton.Size = UDim2.new(1, 0, 0.075, 0)
        New_TabButton.ZIndex = 5
        New_TabButton.Font = Enum.Font.GothamBold
        New_TabButton.Text = tabName
        New_TabButton.TextColor3 = Color3.fromRGB(217, 217, 217)
        New_TabButton.TextSize = 14
        New_TabButton.TextWrapped = true
    
        background.Name = "background"
        background.AnchorPoint = Vector2.new(0.5, 0.5)
        background.BackgroundTransparency = 1
        background.Position = UDim2.new(0.5, 0, 0.5, 0)
        background.ZIndex = 4
        background.Image = "rbxassetid://3570695787"
        background.ImageColor3 = Color3.fromRGB(63, 63, 63)
        background.ScaleType = Enum.ScaleType.Slice
        background.SliceCenter = Rect.new(100, 100, 100, 100)
        background.SliceScale = 0.08

        --Tab Frame:
        NewTab.Name = tabName
        NewTab.Parent = Tabs_Folder
        NewTab.Active = true
        NewTab.BackgroundTransparency = 1
        NewTab.BorderSizePixel = 0
        NewTab.Position = UDim2.new(0.246, 0, 0.12, 0)
        NewTab.Size = UDim2.new(0.739, 0, 0.859, 0)
        NewTab.Visible = false
        NewTab.CanvasSize = UDim2.new(0, 0, 1, 0)
        NewTab.ScrollBarThickness = 6
        NewTab.AutomaticCanvasSize = Enum.AutomaticSize.Y
        
        UIListLayout_Tabs.Parent = NewTab
        UIListLayout_Tabs.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_Tabs.Padding = UDim.new(0.025, 0)

        --Tab Button Event/s:
        New_TabButton.MouseEnter:Connect(function()
            local opening_tween = TS:Create(
                background,
                TweenInfo.new(.2, Enum.EasingStyle.Sine),
                {Size = UDim2.new(1, 0, 1, 0)}
            )
            opening_tween:Play()
        end)
        
        New_TabButton.MouseLeave:Connect(function()
            local closing_tween = TS:Create(
                background,
                TweenInfo.new(.2, Enum.EasingStyle.Sine),
                {Size = UDim2.new(0, 0, 0, 0)}
            )
            closing_tween:Play()
        end)

        New_TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(Tabs_Folder:GetChildren()) do
                if v:IsA("Frame") then
                    v.Visible = false
                end
            end
            NewTab.Visible = true
        end)

        Sections = {}
        function Sections:AddSection(SectionName, isVisible)
            SectionName = SectionName or "UnNamed-Section"
            isVisible = isVisible or true

            -- Instances:
            local newSection = Instance.new("ImageLabel")
            local newSection_TL = Instance.new("TextLabel")

            --Properties:
            newSection.Name = SectionName
            newSection.Parent = NewTab
            newSection.BackgroundTransparency = 1
            newSection.Position = UDim2.new(0, 0, 0.130746022, 0)
            newSection.Size = UDim2.new(0.972, 0, 0.09, 0)
            newSection.Image = "rbxassetid://3570695787"
            newSection.ImageColor3 = Color3.fromRGB(38, 38, 38)
            newSection.ScaleType = Enum.ScaleType.Slice
            newSection.SliceCenter = Rect.new(100, 100, 100, 100)
            newSection.SliceScale = 0.06
            newSection.Visible = isVisible

            newSection_TL.Name = SectionName.."_TL"
            newSection_TL.Parent = newSection
            newSection_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            newSection_TL.BackgroundTransparency = 1
            newSection_TL.Position = UDim2.new(0.0489280932, 0, 0, 0)
            newSection_TL.Size = UDim2.new(0.903747737, 0, 1, 0)
            newSection_TL.ZIndex = 6
            newSection_TL.Font = Enum.Font.GothamBold
            newSection_TL.Text = SectionName
            newSection_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
            newSection_TL.TextSize = 12
            newSection_TL.TextWrapped = true
            newSection_TL.TextXAlignment = Enum.TextXAlignment.Left


            Controls = {}
            function Controls:AddLabel(LabelText)
                LabelText = LabelText or "Label"

                -- Instances:
                local newLabel = Instance.new("ImageLabel")
                local newLabelText = Instance.new("TextLabel")

                -- Properties:
                newLabel.Name = LabelText
                newLabel.Parent = NewTab
                newLabel.BackgroundTransparency = 1
                newLabel.Position = UDim2.new(0, 0, 0.130746022, 0)
                newLabel.Size = UDim2.new(0.972, 0, 0.075, 0)
                newLabel.Image = "rbxassetid://3570695787"
                newLabel.ImageColor3 = ThemeColor
                newLabel.ScaleType = Enum.ScaleType.Slice
                newLabel.SliceCenter = Rect.new(100, 100, 100, 100)
                newLabel.SliceScale = 0.06
                newLabel.ImageColor3 = Color3.fromRGB(44, 44, 44)

                newLabelText.Name = LabelText.."_TL"
                newLabelText.Parent = newLabel
                newLabelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                newLabelText.BackgroundTransparency = 1
                newLabelText.Position = UDim2.new(0.0489280932, 0, 0, 0)
                newLabelText.Size = UDim2.new(0.903747737, 0, 1, 0)
                newLabelText.ZIndex = 6
                newLabelText.Font = Enum.Font.GothamBold
                newLabelText.Text = Title
                newLabelText.TextColor3 = Color3.fromRGB(234, 234, 234)
                newLabelText.TextSize = 12
                newLabelText.TextWrapped = true
                newLabelText.TextXAlignment = Enum.TextXAlignment.Left
            end

            function Controls:AddButton(Title, ButtonText, callback)
                Title = Title or "Untitled"
                ButtonText = ButtonText or "Text"
                callback = callback or function() end

                -- Instances:
                local newFeature = Instance.new("ImageLabel")
                local newFeature_TL = Instance.new("TextLabel")
                local new_Button = Instance.new("TextButton")
                local Btn_Background = Instance.new("ImageLabel")

                -- Properties (background):
                newFeature.Name = Title
                newFeature.Parent = NewTab
                newFeature.BackgroundTransparency = 1
                newFeature.Position = UDim2.new(0, 0, 0.130746022, 0)
                newFeature.Size = UDim2.new(0.972, 0, 0.075, 0)
                newFeature.Image = "rbxassetid://3570695787"
                newFeature.ImageColor3 = ThemeColor
                newFeature.ScaleType = Enum.ScaleType.Slice
                newFeature.SliceCenter = Rect.new(100, 100, 100, 100)
                newFeature.SliceScale = 0.06
                newFeature.ImageColor3 = Color3.fromRGB(44, 44, 44)

                newFeature_TL.Name = Title.."_TL"
                newFeature_TL.Parent = newFeature
                newFeature_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                newFeature_TL.BackgroundTransparency = 1
                newFeature_TL.Position = UDim2.new(0.0489280932, 0, 0, 0)
                newFeature_TL.Size = UDim2.new(0.903747737, 0, 1, 0)
                newFeature_TL.ZIndex = 6
                newFeature_TL.Font = Enum.Font.GothamBold
                newFeature_TL.Text = Title
                newFeature_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
                newFeature_TL.TextSize = 12
                newFeature_TL.TextWrapped = true
                newFeature_TL.TextXAlignment = Enum.TextXAlignment.Left

                -- Properties (button):
                new_Button.Name = Title.."_Btn"
                new_Button.Parent = newFeature
                new_Button.AnchorPoint = Vector2.new(0, 0.5)
                new_Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                new_Button.BackgroundTransparency = 1
                new_Button.BorderSizePixel = 0
                new_Button.Position = UDim2.new(0.749213159, 0, 0.5, 0)
                new_Button.Size = UDim2.new(0.23855485, 0, 0.8, 0)
                new_Button.ZIndex = 2
                new_Button.Font = Enum.Font.GothamBold
                new_Button.Text = "Copy"
                new_Button.TextColor3 = Color3.fromRGB(211, 211, 211)
                new_Button.TextSize = 12
                new_Button.TextWrapped = true

                Btn_Background.Name = "Btn_BG"
                Btn_Background.Parent = new_Button
                Btn_Background.AnchorPoint = Vector2.new(0.5, 0.5)
                Btn_Background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Btn_Background.BackgroundTransparency = 1
                Btn_Background.Position = UDim2.new(0.5, 0, 0.5, 0)
                Btn_Background.Size = UDim2.new(1, 0, 1, 0)
                Btn_Background.Image = "rbxassetid://3570695787"
                Btn_Background.ImageColor3 = Color3.fromRGB(62, 62, 62)
                Btn_Background.ScaleType = Enum.ScaleType.Slice
                Btn_Background.SliceCenter = Rect.new(100, 100, 100, 100)
                Btn_Background.SliceScale = 0.06

                new_Button.MouseButton1Click:Connect(function()
                    callback()
                end)
            end

            function Controls:AddTextBox(Title, placeholderText, callback)
                Title = Title or "Untitled"
                placeholderText = placeholderText or ""
                callback = callback or function() end

                -- Instances:
                local newFeature = Instance.new("ImageLabel")
                local newFeature_TL = Instance.new("TextLabel")
                local Input_newFeature = Instance.new("TextBox")
                local Input_Background = Instance.new("ImageLabel")

                -- Properties (background):
                newFeature.Name = Title
                newFeature.Parent = NewTab
                newFeature.BackgroundTransparency = 1
                newFeature.Position = UDim2.new(0, 0, 0.623232245, 0)
                newFeature.Size = UDim2.new(0.972, 0, 0.075, 0)
                newFeature.Image = "rbxassetid://3570695787"
                newFeature.ImageColor3 = Color3.fromRGB(44, 44, 44)
                newFeature.ScaleType = Enum.ScaleType.Slice
                newFeature.SliceCenter = Rect.new(100, 100, 100, 100)
                newFeature.SliceScale = 0.06

                newFeature_TL.Name = Title.."_TL"
                newFeature_TL.Parent = newFeature
                newFeature_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                newFeature_TL.BackgroundTransparency = 1
                newFeature_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
                newFeature_TL.Size = UDim2.new(0.308889121, 0, 1, 0)
                newFeature_TL.ZIndex = 6
                newFeature_TL.Font = Enum.Font.GothamBold
                newFeature_TL.Text = Title
                newFeature_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
                newFeature_TL.TextSize = 12
                newFeature_TL.TextWrapped = true
                newFeature_TL.TextXAlignment = Enum.TextXAlignment.Left

                -- Properties (TextBox):
                Input_newFeature.Name = "Input_"..Title
                Input_newFeature.Parent = newFeature
                Input_newFeature.AnchorPoint = Vector2.new(0, 0.5)
                Input_newFeature.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Input_newFeature.BackgroundTransparency = 1
                Input_newFeature.Position = UDim2.new(0.393182546, 0, 0.5, 0)
                Input_newFeature.Size = UDim2.new(0.585737407, 0, 0.7, 0)
                Input_newFeature.ZIndex = 2
                Input_newFeature.Font = Enum.Font.GothamBold
                Input_newFeature.PlaceholderText = placeholderText
                Input_newFeature.Text = ""
                Input_newFeature.TextColor3 = Color3.fromRGB(232, 232, 232)
                Input_newFeature.TextSize = 12

                Input_Background.Name = "Btn_BG"
                Input_Background.Parent = Input_newFeature
                Input_Background.AnchorPoint = Vector2.new(0.5, 0.5)
                Input_Background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Input_Background.BackgroundTransparency = 1
                Input_Background.Position = UDim2.new(0.486625284, 0, 0.5, 0)
                Input_Background.Size = UDim2.new(1.02674866, 0, 1, 0)
                Input_Background.Image = "rbxassetid://3570695787"
                Input_Background.ImageColor3 = Color3.fromRGB(62, 62, 62)
                Input_Background.ScaleType = Enum.ScaleType.Slice
                Input_Background.SliceCenter = Rect.new(100, 100, 100, 100)
                Input_Background.SliceScale = 0.06

                Input_newFeature.FocusLost:Connect(function(EnterPressed)
                    if EnterPressed then
                        callback(Input_newFeature.Text)
                        wait(0.2)
                        Input_newFeature.Text = ""
                    else
                        return
                    end
                end)
            end

            function Controls:AddToggle(Title, callback)
                Title = Title or "Untitled"
                callback = callback or function() end

                -- Instances:
                local newFeature = Instance.new("ImageLabel")
                local newFeature_TL = Instance.new("TextLabel")
                local newToggle_BG = Instance.new("ImageButton")
                local newToggle_Btn = Instance.new("ImageButton")

                -- Properties:
                newFeature.Name = Title
                newFeature.Parent = NewTab
                newFeature.BackgroundTransparency = 1
                newFeature.Position = UDim2.new(0, 0, 0.702, 0)
                newFeature.Size = UDim2.new(0.972, 0, 0.075, 0)
                newFeature.Image = "rbxassetid://3570695787"
                newFeature.ImageColor3 = Color3.fromRGB(44, 44, 44)
                newFeature.ScaleType = Enum.ScaleType.Slice
                newFeature.SliceCenter = Rect.new(100, 100, 100, 100)
                newFeature.SliceScale = 0.06

                newFeature_TL.Name = Title.."_TL"
                newFeature_TL.Parent = newFeature
                newFeature_TL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                newFeature_TL.BackgroundTransparency = 1
                newFeature_TL.Position = UDim2.new(0.0489282086, 0, 0, 0)
                newFeature_TL.Size = UDim2.new(0.308889121, 0, 1, 0)
                newFeature_TL.ZIndex = 6
                newFeature_TL.Font = Enum.Font.GothamBold
                newFeature_TL.Text = Title
                newFeature_TL.TextColor3 = Color3.fromRGB(234, 234, 234)
                newFeature_TL.TextSize = 12
                newFeature_TL.TextWrapped = true
                newFeature_TL.TextXAlignment = Enum.TextXAlignment.Left

                newToggle_BG.Name = "Toggle_BG"
                newToggle_BG.Parent = newFeature
                newToggle_BG.AnchorPoint = Vector2.new(0, 0.5)
                newToggle_BG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                newToggle_BG.BackgroundTransparency = 1
                newToggle_BG.Position = UDim2.new(0.835, 0, 0.5, 0)
                newToggle_BG.Size = UDim2.new(0.12, 0, 0.5, 0)
                newToggle_BG.Image = "rbxassetid://3570695787"
                newToggle_BG.ImageColor3 = Color3.fromRGB(62, 62, 62)
                newToggle_BG.ScaleType = Enum.ScaleType.Slice
                newToggle_BG.SliceCenter = Rect.new(100, 100, 100, 100)

                newToggle_Btn.Name = "newToggle_Btn"
                newToggle_Btn.Parent = newFeature
                newToggle_Btn.AnchorPoint = Vector2.new(0, 0.5)
                newToggle_Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                newToggle_Btn.BackgroundTransparency = 1
                newToggle_Btn.Position = UDim2.new(0.835, 0, 0.5, 0)
                newToggle_Btn.Size = UDim2.new(0.055, 0, 0.5, 0)
                newToggle_Btn.ZIndex = 2
                newToggle_Btn.Image = "rbxassetid://3570695787"
                newToggle_Btn.ScaleType = Enum.ScaleType.Slice
                newToggle_Btn.SliceCenter = Rect.new(100, 100, 100, 100)

                local isToggled = false

                local function toggle()
                    if not isToggled then
                        isToggled = true
                        newToggle_Btn:TweenPosition(newToggle_Btn.Position + UDim2.new(.066,0,0,0),"In","Sine",.1)
                        newToggle_BG.ImageColor3 = Color3.fromRGB(227, 32, 240)
                        callback(isToggled)
                    else
                        isToggled = false
                        newToggle_Btn:TweenPosition(newToggle_Btn.Position + UDim2.new(-.066,0,0,0),"In","Sine",.1)
                        newToggle_BG.ImageColor3 = Color3.fromRGB(62, 62, 62)
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
                local newSlider = Instance.new("ImageLabel")
                local newSlider_TL = Instance.new("TextLabel")
                local newSliderFrame = Instance.new("ImageButton")
                local newSliderBar = Instance.new("ImageButton")
                local newSliderKnob = Instance.new("ImageButton")
                local newSliderValue_TL = Instance.new("TextLabel")

                -- Properties (background):
                newSlider.Name = Title
                newSlider.Parent = NewTab
                newSlider.BackgroundTransparency = 1
                newSlider.Position = UDim2.new(0, 0, 0.381000012, 0)
                newSlider.Size = UDim2.new(0.972, 0, 0.075, 0)
                newSlider.Image = "rbxassetid://3570695787"
                newSlider.ImageColor3 = Color3.fromRGB(44, 44, 44)
                newSlider.ScaleType = Enum.ScaleType.Slice
                newSlider.SliceCenter = Rect.new(100, 100, 100, 100)
                newSlider.SliceScale = 0.06

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
                newSliderFrame.Size = UDim2.new(0.596787989, 0, 0.4, 0)
                newSliderFrame.Image = "rbxassetid://3570695787"
                newSliderFrame.ImageColor3 = Color3.fromRGB(62, 62, 62)
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
                newSliderBar.ImageColor3 = ThemeColor
                newSliderBar.ScaleType = Enum.ScaleType.Slice
                newSliderBar.SliceCenter = Rect.new(100, 100, 100, 100)

                newSliderKnob.Name = Title.."_Slider"
                newSliderKnob.Parent = newSliderFrame
                newSliderKnob.AnchorPoint = Vector2.new(0, 0.5)
                newSliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                newSliderKnob.BackgroundTransparency = 1
                newSliderKnob.Position = UDim2.new(0.8, 0, 0.5, 0)
                newSliderKnob.Size = UDim2.new(0.08, 0, 1.2, 0)
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
                SelectedOption_Btn_BG.SliceScale = 0.120

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

        return Sections
    end

    return Tabs
end

return Library


--local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zakater5/LuaRepo/main/Other/UI_Lib.lua"))()
--local newUI = Library.new("e", "e", nil)
--local newTab = newUI:NewTab("tabname")
--newTab:AddSlider("Label", 100, 0, 30)
