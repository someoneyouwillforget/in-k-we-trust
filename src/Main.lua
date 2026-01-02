local Internal = {}
local User = "someoneyouwillforget" -- Change this to your GitHub username if needed
local Repo = "in-k-we-trust"

local function GetFile(path)
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/"..User.."/"..Repo.."/refs/heads/main/"..path))()
end

function Internal:CreateWindow(cfg)
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 525, 0, 380)
    Main.Position = UDim2.new(0.5, -262, 0.5, -190)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
    
    local TabList = Instance.new("ScrollingFrame", Main)
    TabList.Size = UDim2.new(1, -30, 0, 35)
    TabList.Position = UDim2.new(0, 15, 0, 45)
    TabList.BackgroundTransparency = 1
    TabList.ScrollBarThickness = 0
    local TabListLayout = Instance.new("UIListLayout", TabList)
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.Padding = UDim.new(0, 7)

    local Container = Instance.new("Frame", Main)
    Container.Size = UDim2.new(1, -30, 1, -100)
    Container.Position = UDim2.new(0, 15, 0, 90)
    Container.BackgroundTransparency = 1

    local Window = {}
    function Window:CreateTab(name)
        local TabBtn = Instance.new("TextButton", TabList)
        TabBtn.Size = UDim2.new(0, 100, 1, 0)
        TabBtn.Text = name
        TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 18)

        local Page = Instance.new("ScrollingFrame", Container)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.Visible = false
        Page.BackgroundTransparency = 1
        Instance.new("UIListLayout", Page).Padding = UDim.new(0, 8)

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do v.Visible = false end
            Page.Visible = true
        end)

        local Tab = {}
        function Tab:CreateButton(t, c) return GetFile("src/Elements/Button.lua").new(Page, t, c) end
        function Tab:CreateToggle(t, c) return GetFile("src/Elements/Toggle.lua").new(Page, t, c) end
        function Tab:CreateSection(t) return GetFile("src/Elements/Section.lua").new(Page, t) end
        return Tab
    end
    return Window
end

return Internal
