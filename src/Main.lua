local Library = {}

-- FETCHING RAW FILES
local Theme = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Styles/Theme.lua"))()
local ToggleBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Toggle.lua"))()
local ButtonBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Button.lua"))()

function Library:CreateWindow(userTitle)
    local titleText = userTitle or "In K We Trust"
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = game:GetService("HttpService"):GenerateGUID(false)
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local success, err = pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    if not success then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end

    -- MAIN WINDOW (Now styled exactly like the elements)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.BackgroundColor3 = Theme.MainBackground -- Make sure this is dark in Theme.lua
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true

    -- ROUNDING (Matches your buttons/toggles)
    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = Theme.CornerRadius or UDim.new(0, 9)

    -- THE BORDER (Essential for the "High-End" look)
    local UIStroke = Instance.new("UIStroke", MainFrame)
    UIStroke.Thickness = 1
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Transparency = 0.9 -- Very subtle outline
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- TITLE BAR AREA
    local Title = Instance.new("TextLabel", MainFrame)
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 15, 0, 8)
    Title.Size = UDim2.new(1, -30, 0, 25)
    Title.Font = Enum.Font.GothamBold
    Title.Text = titleText:upper() -- Uppercase looks cleaner for titles
    Title.TextColor3 = Theme.Text
    Title.TextSize = 12
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- THE DRAG HANDLE LINE (Matching the Tab style)
    local DragLine = Instance.new("Frame", MainFrame)
    DragLine.Size = UDim2.new(0, 40, 0, 2)
    DragLine.Position = UDim2.new(0.5, -20, 0, 35)
    DragLine.BackgroundColor3 = Theme.Accent
    DragLine.BorderSizePixel = 0
    Instance.new("UICorner", DragLine).CornerRadius = UDim.new(1, 0)

    -- WINDOW CONTROLS
    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 20, 0, 20)
    CloseBtn.Position = UDim2.new(1, -30, 0, 10)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Theme.Text
    CloseBtn.TextSize = 14
    CloseBtn.Font = Enum.Font.GothamBold

    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- CONTAINER (With Padding so elements don't touch the edges)
    local Container = Instance.new("ScrollingFrame", MainFrame)
    Container.Name = "Container"
    Container.BackgroundTransparency = 1
    Container.Position = UDim2.new(0, 10, 0, 50)
    Container.Size = UDim2.new(1, -20, 1, -60)
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    Container.ScrollBarThickness = 0 -- Hide scrollbar for a cleaner look
    
    local UIListLayout = Instance.new("UIListLayout", Container)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 8) -- Space between elements

    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
    end)

    -- DRAGGING LOGIC
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
