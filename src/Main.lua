local Library = {}

-- 1. FETCHING THE FILES
local Theme = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/main/src/Styles/Theme.lua"))()
local ToggleBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/main/src/Elements/Toggle.lua"))()

function Library:CreateWindow(title)
    -- Create the UI Container
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "InKWeTrust_UI"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true -- Makes it universal/full screen
    
    local success, err = pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    if not success then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end

    -- MAIN FRAME
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Theme.MainBackground
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    MainFrame.BorderSizePixel = 0

    -- STYLE: ROUNDED CORNERS
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = Theme.CornerRadius or UDim.new(0, 8)
    UICorner.Parent = MainFrame

    -- TITLE BAR
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 0, 35)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "  " .. title
    Title.TextColor3 = Theme.Text
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- SCROLLING CONTAINER (Where the toggles go)
    local Container = Instance.new("ScrollingFrame")
    Container.Name = "Container"
    Container.Parent = MainFrame
    Container.BackgroundTransparency = 1
    Container.Position = UDim2.new(0, 10, 0, 40)
    Container.Size = UDim2.new(1, -20, 1, -50)
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    Container.ScrollBarThickness = 2
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Container
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    -- DRAGGABLE NONSENSE
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

    -- THE API
    local Window = {}

    function Window:AddToggle(text, callback)
        return ToggleBase.new(Container, text, Theme, callback)
    end

    return Window
end

return Library
