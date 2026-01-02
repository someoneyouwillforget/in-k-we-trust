local Library = {}

-- 1. FETCHING THE FILES
local Theme = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Styles/Theme.lua"))()
local ToggleBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Toggle.lua"))()
local ButtonBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Button.lua"))()

function Library:CreateWindow(userTitle)
    local titleText = userTitle or "In K We Trust"
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = game:GetService("HttpService"):GenerateGUID(false)
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true
    
    -- Universal Parenting
    local success, err = pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    if not success then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end

    -- MAIN WINDOW FRAME
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Theme.MainBackground
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    MainFrame.BorderSizePixel = 0

    -- ROUNDED CORNERS
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = Theme.CornerRadius or UDim.new(0, 9)
    UICorner.Parent = MainFrame

    -- BORDER STROKES
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 1.2
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Transparency = Theme.StrokeTransparency or 0.8
    UIStroke.Parent = MainFrame

    -- TITLE LABEL
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Size = UDim2.new(1, -30, 0, 40)
    Title.Font = Enum.Font.GothamBold
    Title.Text = titleText
    Title.TextColor3 = Theme.Text
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- SCROLLING CONTAINER
    local Container = Instance.new("ScrollingFrame")
    Container.Name = "Container"
    Container.Parent = MainFrame
    Container.BackgroundTransparency = 1
    Container.Position = UDim2.new(0, 10, 0, 45)
    Container.Size = UDim2.new(1, -20, 1, -55)
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    Container.ScrollBarThickness = 2
    Container.ScrollBarImageColor3 = Theme.Accent
    Container.BorderSizePixel = 0
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Container
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)

    -- AUTO-RESIZE FOR SCROLLING
    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
    end)

    -- DRAGGABLE LOGIC
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

    -- API SECTION
    local Window = {}

    function Window:AddButton(text, callback)
        return ButtonBase.new(Container, text, Theme, callback)
    end

    function Window:AddToggle(text, callback)
        return ToggleBase.new(Container, text, Theme, callback)
    end

    return Window
end

return Library
