local Library = {}

-- FETCHING RAW FILES
local Theme = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Styles/Theme.lua"))()
local ToggleBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Toggle.lua"))()
local ButtonBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Button.lua"))()

function Library:CreateWindow(userTitle)
    local titleText = userTitle or "In K We Trust"
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = game:GetService("HttpService"):GenerateGUID(false)
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true
    
    local success, err = pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    if not success then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end

    -- MAIN WINDOW
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.BackgroundColor3 = Theme.MainBackground
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true

    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = Theme.CornerRadius or UDim.new(0, 9)

    local UIStroke = Instance.new("UIStroke", MainFrame)
    UIStroke.Thickness = 1.2
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Transparency = 0.8

    -- TITLE BAR
    local Title = Instance.new("TextLabel", MainFrame)
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Size = UDim2.new(1, -30, 0, 40)
    Title.Font = Enum.Font.GothamBold
    Title.Text = titleText
    Title.TextColor3 = Theme.Text
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- DRAG LINE
    local DragLine = Instance.new("Frame", MainFrame)
    DragLine.Size = UDim2.new(0, 100, 0, 2)
    DragLine.Position = UDim2.new(0.5, -50, 0, 38)
    DragLine.BackgroundColor3 = Theme.Accent
    DragLine.BackgroundTransparency = 0.5
    DragLine.BorderSizePixel = 0
    Instance.new("UICorner", DragLine).CornerRadius = UDim.new(1, 0)

    -- CLOSE BUTTON (X)
    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 5)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "×"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    CloseBtn.TextSize = 20
    CloseBtn.Font = Enum.Font.GothamBold

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- MINIMIZE BUTTON (-)
    local MinBtn = Instance.new("TextButton", MainFrame)
    MinBtn.Size = UDim2.new(0, 30, 0, 30)
    MinBtn.Position = UDim2.new(1, -65, 0, 5)
    MinBtn.BackgroundTransparency = 1
    MinBtn.Text = "−"
    MinBtn.TextColor3 = Theme.Text
    MinBtn.TextSize = 20
    MinBtn.Font = Enum.Font.GothamBold

    local minimized = false
    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        local targetSize = minimized and UDim2.new(0, 450, 0, 40) or UDim2.new(0, 450, 0, 300)
        game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = targetSize}):Play()
    end)

    -- CONTAINER
    local Container = Instance.new("ScrollingFrame", MainFrame)
    Container.Name = "Container"
    Container.BackgroundTransparency = 1
    Container.Position = UDim2.new(0, 10, 0, 50)
    Container.Size = UDim2.new(1, -20, 1, -60)
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    Container.ScrollBarThickness = 2
    Container.BorderSizePixel = 0
    
    local UIListLayout = Instance.new("UIListLayout", Container)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)

    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
    end)

    -- DRAGGING NONSENSE
    local UserInputService = game:GetService("UserInputService")
    local dragging, dragInput, dragStart, startPos

    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    local Window = {}
    function Window:AddButton(text, callback) return ButtonBase.new(Container, text, Theme, callback) end
    function Window:AddToggle(text, callback) return ToggleBase.new(Container, text, Theme, callback) end
    return Window
end

return Library
