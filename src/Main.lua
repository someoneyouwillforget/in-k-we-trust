local Library = {}

-- FETCH MODULES
local Theme = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Styles/Theme.lua"))()
local ToggleBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Toggle.lua"))()
local ButtonBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Button.lua"))()

function Library:CreateWindow(userTitle)
    local titleText = userTitle or "In K We Trust"
    local MAIN_COLOR = Theme.Accent or Color3.fromHex("ffffff")

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "In_K_We_Trust"
    ScreenGui.IgnoreGuiInset = true
    
    local success, err = pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    if not success then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end

    -- MAIN FRAME
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 480, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -240, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    MainFrame.BorderSizePixel = 0
    
    local MainCorner = Instance.new("UICorner", MainFrame)
    MainCorner.CornerRadius = UDim.new(0, 20)

    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = MAIN_COLOR
    MainStroke.Thickness = 1.5

    -- HEADER
    local Header = Instance.new("Frame", MainFrame)
    Header.Size = UDim2.new(0.94, 0, 0, 40)
    Header.Position = UDim2.new(0.03, 0, 0.04, 0)
    Header.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    
    local HeaderCorner = Instance.new("UICorner", Header)
    HeaderCorner.CornerRadius = UDim.new(0, 12)

    local Title = Instance.new("TextLabel", Header)
    Title.Text = "  " .. titleText
    Title.Size = UDim2.new(0.5, 0, 1, 0)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- CLOSE BUTTON
    local CloseBtn = Instance.new("TextButton", Header)
    CloseBtn.Size = UDim2.new(0, 28, 0, 28)
    CloseBtn.Position = UDim2.new(0.92, 0, 0.5, -14)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 10, 15)
    CloseBtn.Text = "×"
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- CONTENT CONTAINER
    local Container = Instance.new("ScrollingFrame", MainFrame)
    Container.Name = "UIContent"
    Container.Position = UDim2.new(0.03, 0, 0.2, 0)
    Container.Size = UDim2.new(0.94, 0, 0.75, 0)
    Container.BackgroundTransparency = 1
    Container.ScrollBarThickness = 0
    
    local Layout = Instance.new("UIListLayout", Container)
    Layout.Padding = UDim.new(0, 10)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    -- API EXPORTS
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
