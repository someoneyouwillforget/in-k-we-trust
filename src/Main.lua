local Internal = {
    Flags = {},
    Theme = loadstring(game:HttpGet("https://raw.githubusercontent.com/someoneyouwillforget/in-k-we-trust/refs/heads/main/src/Styles/Theme.lua"))()
}

local User = "someoneyouwillforget" -- DO NOT CHANGE OTHERWISE IT WONT WORK
local Repo = "in-k-we-trust"
local Branch = "main"

local function GetFile(path)
    local url = "https://raw.githubusercontent.com/"..User.."/"..Repo.."/refs/heads/"..Branch.."/"..path
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success then return result else warn("Failed to load: "..path) return nil end
end

function Internal:CreateWindow(Config)
    local WindowName = Config.Name or "INTERNAL"
    
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    ScreenGui.Name = "Internal_Core"
    
    -- Main UI Frame
    local Main = Instance.new("Frame", ScreenGui)
    Main.Name = "MainFrame"
    Main.Size = UDim2.new(0, 525, 0, 380)
    Main.Position = UDim2.new(0.5, -262, 0.5, -190)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Main.BorderSizePixel = 0
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
    
    -- Top Bar
    local TopBar = Instance.new("Frame", Main)
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundTransparency = 1
    
    local Title = Instance.new("TextLabel", TopBar)
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Text = WindowName
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamMedium
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1

    -- Tab Bar
    local TabList = Instance.new("ScrollingFrame", Main)
    TabList.Size = UDim2.new(1, -30, 0, 35)
    TabList.Position = UDim2.new(0, 15, 0, 45)
    TabList.BackgroundTransparency = 1
    TabList.ScrollBarThickness = 0
    local TabListLayout = Instance.new("UIListLayout", TabList)
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.Padding = UDim.new(0, 7)

    -- Elements Nonsense
    local Container = Instance.new("Frame", Main)
    Container.Size = UDim2.new(1, -30, 1, -100)
    Container.Position = UDim2.new(0, 15, 0, 90)
    Container.BackgroundTransparency = 1

    local Window = {}

    function Window:CreateTab(Name)
        -- Create the Tab Button
        local TabBtn = Instance.new("TextButton", TabList)
        TabBtn.Size = UDim2.new(0, 100, 1, 0)
        TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TabBtn.Text = Name
        TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabBtn.Font = Enum.Font.Gotham
        TabBtn.TextSize = 12
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 18)

        -- Create the Page for this Tab
        local Page = Instance.new("ScrollingFrame", Container)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.Visible = false
        Page.BackgroundTransparency = 1
        Page.ScrollBarThickness = 0
        local PageLayout = Instance.new("UIListLayout", Page)
        PageLayout.Padding = UDim.new(0, 8)

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do v.Visible = false end
            Page.Visible = true
        end)

        -- Default selection
        if #TabList:GetChildren() == 1 then Page.Visible = true end

        -- FINAL INTEGRATION: This stables all of the elements
        local Tab = {}

        function Tab:CreateSection(t) 
            return GetFile("src/Elements/Section.lua").new(Page, t) 
        end

        function Tab:CreateButton(t, c) 
            return GetFile("src/Elements/Button.lua").new(Page, t, c) 
        end

        function Tab:CreateToggle(t, c) 
            return GetFile("src/Elements/Toggle.lua").new(Page, t, c) 
        end

        function Tab:CreateSlider(t, min, max, def, c) 
            return GetFile("src/Elements/Slider.lua").new(Page, t, min, max, def, c) 
        end

        function Tab:CreateDropdown(t, o, c) 
            return GetFile("src/Elements/Dropdown.lua").new(Page, t, o, c) 
        end

        return Tab
    end

    return Window
end

return Internal
