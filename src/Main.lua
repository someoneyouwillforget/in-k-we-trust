local Library = {
    Flags = {},
    Theme = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Styles/Theme.lua"))()
}

-- Fetch Element Modules
local ToggleBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Toggle.lua"))()
local ButtonBase = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Elements/Button.lua"))()

function Library:CreateWindow(Settings)
    local Title = Settings.Name or "In K We Trust"
    
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    ScreenGui.Name = "In_K_We_Trust"

    -- MAIN HUB
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 9)
    
    local Stroke = Instance.new("UIStroke", Main)
    Stroke.Color = Library.Theme.Accent
    Stroke.Thickness = 1.2

    -- SIDEBAR (Navigation)
    local SideBar = Instance.new("Frame", Main)
    SideBar.Size = UDim2.new(0, 120, 1, -40)
    SideBar.Position = UDim2.new(0, 10, 0, 30)
    SideBar.BackgroundTransparency = 1
    
    local NavLayout = Instance.new("UIListLayout", SideBar)
    NavLayout.Padding = UDim.new(0, 5)

    -- CONTAINER
    local PageContainer = Instance.new("Frame", Main)
    PageContainer.Size = UDim2.new(1, -150, 1, -50)
    PageContainer.Position = UDim2.new(0, 140, 0, 40)
    PageContainer.BackgroundTransparency = 1

    local Window = {CurrentPage = nil}

    function Window:CreateTab(Name)
        local TabBtn = Instance.new("TextButton", SideBar)
        TabBtn.Size = UDim2.new(1, 0, 0, 30)
        TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TabBtn.Text = Name
        TabBtn.TextColor3 = Color3.new(1, 1, 1)
        TabBtn.Font = Enum.Font.Gotham
        TabBtn.TextSize = 12
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

        local Page = Instance.new("ScrollingFrame", PageContainer)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.ScrollBarThickness = 0
        
        local PageLayout = Instance.new("UIListLayout", Page)
        PageLayout.Padding = UDim.new(0, 8)

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(PageContainer:GetChildren()) do v.Visible = false end
            Page.Visible = true
        end)

        -- Page API
        local Tab = {}
        function Tab:CreateButton(text, callback)
            return ButtonBase.new(Page, text, Library.Theme, callback)
        end
        function Tab:CreateToggle(text, callback)
            return ToggleBase.new(Page, text, Library.Theme, callback)
        end
        
        return Tab
    end

    return Window
end

return Library
