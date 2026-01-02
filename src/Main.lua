local Library = {}

-- LINKING THE RAW FILES
local Theme = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Styles/Theme.lua"))()
local ToggleBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Toggle.lua"))()

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "InKWeTrust"
    ScreenGui.IgnoreGuiInset = true
    
    -- Safety check for Executors
    local success, err = pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    if not success then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end

    -- THE WINDOW
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    MainFrame.BackgroundColor3 = Theme.MainBackground
    MainFrame.BorderSizePixel = 0
    
    -- Adding Rounded Corners from Theme
    local Corner = Instance.new("UICorner", MainFrame)
    Corner.CornerRadius = Theme.CornerRadius

    -- CONTAINER FOR ELEMENTS
    local Container = Instance.new("ScrollingFrame", MainFrame)
    Container.Size = UDim2.new(1, -20, 1, -45)
    Container.Position = UDim2.new(0, 10, 0, 35)
    Container.BackgroundTransparency = 1
    
    local Layout = Instance.new("UIListLayout", Container)
    Layout.Padding = UDim.new(0, 5)

    -- THE API
    local Window = {}
    
    function Window:AddToggle(text, callback)
        -- Sending the Container and Theme to the Toggle module
        return ToggleBase.new(Container, text, Theme, callback)
    end
    
    return Window
end

return Library
