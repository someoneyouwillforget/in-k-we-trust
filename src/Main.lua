local Library = {}

-- FETCH THE MODULES (Same as before)
local Theme = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Styles/Theme.lua"))()
local ToggleBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Toggle.lua"))()
local ButtonBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Button.lua"))()

function Library:CreateWindow(userTitle)
    local titleText = userTitle or "In K We Trust"
    local MAIN_COLOR = Theme.Accent or Color3.fromHex("ffffff")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "In_K_We_Trust"
    screenGui.ResetOnSpawn = false
    
    local success, err = pcall(function()
        screenGui.Parent = game:GetService("CoreGui")
    end)
    if not success then
        screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end

    -- MAIN WINDOW
    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Size = UDim2.new(0, 480, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -240, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    mainFrame.BorderSizePixel = 0
    mainFrame.Visible = true 
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 20)
    
    local mainStroke = Instance.new("UIStroke", mainFrame)
    mainStroke.Color = MAIN_COLOR
    mainStroke.Thickness = 1.5

    -- THE HEADER
    local headerFrame = Instance.new("Frame", mainFrame)
    headerFrame.Size = UDim2.new(0.94, 0, 0, 40)
    headerFrame.Position = UDim2.new(0.03, 0, 0.04, 0)
    headerFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Instance.new("UICorner", headerFrame).CornerRadius = UDim.new(0, 12)

    local titleLabel = Instance.new("TextLabel", headerFrame)
    titleLabel.Text = "  " .. titleText
    titleLabel.Size = UDim2.new(0.5, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 20
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- NONSENSE FOR ELEMENTS
    local Container = Instance.new("ScrollingFrame", mainFrame)
    Container.Position = UDim2.new(0.03, 0, 0, 55)
    Container.Size = UDim2.new(0.94, 0, 1, -65)
    Container.BackgroundTransparency = 1
    Container.ScrollBarThickness = 0
    
    local Layout = Instance.new("UIListLayout", Container)
    Layout.Padding = UDim.new(0, 8)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    -- MOBILE DRAG & TOGGLE NONSENSE
    local UIS = game:GetService("UserInputService")
    local dragging, dragStart, startPos
    
    toggleBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = toggleBtn.Position
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType.Touch) then
            local delta = input.Position - dragStart
            toggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        dragging = false
    end)

    toggleBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
    end)

    -- API
    local Window = {}
    function Window:AddButton(text, callback) return ButtonBase.new(Container, text, Theme, callback) end
    function Window:AddToggle(text, callback) return ToggleBase.new(Container, text, Theme, callback) end
    
    return Window
end

return Library
