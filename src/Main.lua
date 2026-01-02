local Internal = {
    Flags = {},
    Theme = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Styles/Theme.lua"))()
}

-- Fetch Element Modules
local ToggleBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Toggle.lua"))()
local ButtonBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Button.lua"))()

function Internal:CreateWindow(Settings)
    local TitleText = Settings.Name or "INTERNAL"
    
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    ScreenGui.Name = "Internal_UI"

    -- MAIN WINDOW
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 550, 0, 380)
    Main.Position = UDim2.new(0.5, -275, 0.5, -190)
    Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Main.BorderSizePixel = 0
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
    
    -- Subtle White Glow/Stroke
    local Stroke = Instance.new("UIStroke", Main)
    Stroke.Color = Color3.fromRGB(40, 40, 40)
    Stroke.Thickness = 1

    -- TOP BAR
    local TopBar = Instance.new("Frame", Main)
    TopBar.Size = UDim2.new(1, 0, 0, 45)
    TopBar.BackgroundTransparency = 1

    local Title = Instance.new("TextLabel", TopBar)
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = TitleText
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 13
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- TAB HOLDER (Top Horizontal)
    local TabHolder = Instance.new("ScrollingFrame", Main)
    TabHolder.Size = UDim2.new(1, -30, 0, 32)
    TabHolder.Position = UDim2.new(0, 15, 0, 45)
    TabHolder.BackgroundTransparency = 1
    TabHolder.ScrollBarThickness = 0
    TabHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local TabLayout = Instance.new("UIListLayout", TabHolder)
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.Padding = UDim.new(0, 8)

    -- PAGE CONTAINER
    local PageContainer = Instance.new("Frame", Main)
    PageContainer.Size = UDim2.new(1, -30, 1, -105)
    PageContainer.Position = UDim2.new(0, 15, 0, 90)
    PageContainer.BackgroundTransparency = 1

    local Window = {}

    function Window:CreateTab(Name)
        -- Tab Pill (White Highlight when active)
        local TabBtn = Instance.new("TextButton", TabHolder)
        TabBtn.Size = UDim2.new(0, 100, 1, 0)
        TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TabBtn.Text = Name
        TabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
        TabBtn.Font = Enum.Font.GothamMedium
        TabBtn.TextSize = 12
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 20)

        local Page = Instance.new("ScrollingFrame", PageContainer)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.ScrollBarThickness = 0
        Instance.new("UIListLayout", Page).Padding = UDim.new(0, 8)

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(PageContainer:GetChildren()) do v.Visible = false end
            for _, v in pairs(TabHolder:GetChildren()) do 
                if v:IsA("TextButton") then 
                    v.BackgroundColor3 = Color3.fromRGB(25, 25, 25) 
                    v.TextColor3 = Color3.fromRGB(180, 180, 180)
                end 
            end
            Page.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- White Highlight
            TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0) -- Dark text on white
        end)

        -- Default Tab Selection
        if #TabHolder:GetChildren() == 1 then
            Page.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        end

        local Tab = {}
        function Tab:CreateButton(text, callback) return ButtonBase.new(Page, text, Internal.Theme, callback) end
        function Tab:CreateToggle(text, callback) return ToggleBase.new(Page, text, Internal.Theme, callback) end
        
        function Tab:CreateSection(Name)
            local lbl = Instance.new("TextLabel", Page)
            lbl.Size = UDim2.new(1, 0, 0, 20)
            lbl.Text = Name
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 10
            lbl.TextColor3 = Color3.fromRGB(100, 100, 100)
            lbl.BackgroundTransparency = 1
            lbl.TextXAlignment = Enum.TextXAlignment.Left
        end

        return Tab
    end

    return Window
end

return Internal
