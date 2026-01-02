local InKWeTrust = {
    Flags = {},
    Theme = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Styles/Theme.lua"))()
}

-- Fetch Element Modules
local ToggleBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Toggle.lua"))()
local ButtonBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Button.lua"))()

function InKWeTrust:CreateWindow(Settings)
    local TitleText = Settings.Name or "In K We Trust"
    
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    ScreenGui.Name = "InKWeTrust_Internal"

    -- MAIN WINDOW
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 520, 0, 360)
    Main.Position = UDim2.new(0.5, -260, 0.5, -180)
    Main.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    Main.BorderSizePixel = 0
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
    
    local Stroke = Instance.new("UIStroke", Main)
    Stroke.Color = InKWeTrust.Theme.Accent
    Stroke.Thickness = 1.5

    -- SIDEBAR NAVIGATION
    local SideBar = Instance.new("Frame", Main)
    SideBar.Size = UDim2.new(0, 130, 1, -50)
    SideBar.Position = UDim2.new(0, 10, 0, 40)
    SideBar.BackgroundTransparency = 1
    
    local NavLayout = Instance.new("UIListLayout", SideBar)
    NavLayout.Padding = UDim.new(0, 6)

    -- TITLE BAR
    local Header = Instance.new("TextLabel", Main)
    Header.Size = UDim2.new(1, -20, 0, 35)
    Header.Position = UDim2.new(0, 15, 0, 0)
    Header.BackgroundTransparency = 1
    Header.Text = TitleText:upper()
    Header.TextColor3 = InKWeTrust.Theme.Text
    Header.Font = Enum.Font.GothamBold
    Header.TextSize = 14
    Header.TextXAlignment = Enum.TextXAlignment.Left

    -- DRAG LINE
    local DragLine = Instance.new("Frame", Main)
    DragLine.Size = UDim2.new(0, 60, 0, 2)
    DragLine.Position = UDim2.new(0.5, -30, 0, 32)
    DragLine.BackgroundColor3 = InKWeTrust.Theme.Accent
    DragLine.BorderSizePixel = 0
    Instance.new("UICorner", DragLine).CornerRadius = UDim.new(1, 0)

    -- PAGE CONTAINER
    local PageContainer = Instance.new("Frame", Main)
    PageContainer.Size = UDim2.new(1, -160, 1, -50)
    PageContainer.Position = UDim2.new(0, 150, 0, 40)
    PageContainer.BackgroundTransparency = 1

    local Window = {Tabs = {}}

    function Window:CreateTab(Name)
        -- Tab Button
        local TabBtn = Instance.new("TextButton", SideBar)
        TabBtn.Size = UDim2.new(1, 0, 0, 34)
        TabBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
        TabBtn.Text = "  " .. Name
        TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.TextSize = 12
        TabBtn.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)

        -- Page Frame
        local Page = Instance.new("ScrollingFrame", PageContainer)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.ScrollBarThickness = 0
        
        local PageLayout = Instance.new("UIListLayout", Page)
        PageLayout.Padding = UDim.new(0, 8)

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(PageContainer:GetChildren()) do v.Visible = false end
            for _, v in pairs(SideBar:GetChildren()) do 
                if v:IsA("TextButton") then v.TextColor3 = Color3.fromRGB(150, 150, 150) end 
            end
            Page.Visible = true
            TabBtn.TextColor3 = InKWeTrust.Theme.Accent
        end)

        -- First Tab Auto-Selection
        if #SideBar:GetChildren() == 1 then
            Page.Visible = true
            TabBtn.TextColor3 = InKWeTrust.Theme.Accent
        end

        local Tab = {}
        function Tab:CreateButton(text, callback)
            return ButtonBase.new(Page, text, InKWeTrust.Theme, callback)
        end
        function Tab:CreateToggle(text, callback)
            return ToggleBase.new(Page, text, InKWeTrust.Theme, callback)
        end
        
        return Tab
    end

    return Window
end

return InKWeTrust
