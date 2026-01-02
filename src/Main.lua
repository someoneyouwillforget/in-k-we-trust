local Internal = {
    Flags = {},
    Theme = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Styles/Theme.lua"))()
}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

function Internal:CreateWindow(Config)
    local WindowName = Config.Name or "INTERNAL"
    
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    ScreenGui.Name = "Internal_Rayfield"
    
    -- MAIN BOX
    local Main = Instance.new("Frame", ScreenGui)
    Main.Name = "Main"
    Main.Position = UDim2.new(0.5, -262, 0.5, -190)
    Main.Size = UDim2.new(0, 525, 0, 380)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Main.ClipsDescendants = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
    
    -- TOP BAR
    local TopBar = Instance.new("Frame", Main)
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundTransparency = 1
    
    local Title = Instance.new("TextLabel", TopBar)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Size = UDim2.new(1, -15, 1, 0)
    Title.Text = WindowName
    Title.Font = Enum.Font.GothamMedium
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1

    -- TAB NAVIGATION
    local TabList = Instance.new("ScrollingFrame", Main)
    TabList.Name = "TabList"
    TabList.Position = UDim2.new(0, 15, 0, 45)
    TabList.Size = UDim2.new(1, -30, 0, 35)
    TabList.BackgroundTransparency = 1
    TabList.ScrollBarThickness = 0
    
    local TabListLayout = Instance.new("UIListLayout", TabList)
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.Padding = UDim.new(0, 7)

    -- ELEMENTS CONTAINER
    local Container = Instance.new("Frame", Main)
    Container.Name = "Container"
    Container.Position = UDim2.new(0, 15, 0, 90)
    Container.Size = UDim2.new(1, -30, 1, -105)
    Container.BackgroundTransparency = 1

    local Window = {Tabs = {}}

    function Window:CreateTab(Name)
        local TabBtn = Instance.new("TextButton", TabList)
        TabBtn.Name = Name .. "Tab"
        TabBtn.Size = UDim2.new(0, 100, 1, 0)
        TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TabBtn.Text = Name
        TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabBtn.Font = Enum.Font.Gotham
        TabBtn.TextSize = 12
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 18)

        local Page = Instance.new("ScrollingFrame", Container)
        Page.Name = Name .. "Page"
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.ScrollBarThickness = 0
        Instance.new("UIListLayout", Page).Padding = UDim.new(0, 8)

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do v.Visible = false end
            for _, v in pairs(TabList:GetChildren()) do
                if v:IsA("TextButton") then
                    TweenService:Create(v, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25), TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                end
            end
            Page.Visible = true
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 255, 255), TextColor3 = Color3.fromRGB(0, 0, 0)}):Play()
        end)

        -- Element API
        local Elements = {}
        function Elements:CreateButton(t, c) return loadstring(game:HttpGet(".../Button.lua"))().new(Page, t, c) end
        function Elements:CreateToggle(t, c) return loadstring(game:HttpGet(".../Toggle.lua"))().new(Page, t, c) end
        
        return Elements
    end

    return Window
end

return Internal
