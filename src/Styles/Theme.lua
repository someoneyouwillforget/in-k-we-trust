local ToggleModule = {}

function ToggleModule.new(parent, text, theme, callback)
    local state = false
    local toggle = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local Indicator = Instance.new("Frame")

    toggle.Name = text .. "Toggle"
    toggle.Parent = parent
    toggle.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    toggle.Size = UDim2.new(1, 0, 0, 35)
    toggle.Text = "  " .. text
    toggle.TextColor3 = Color3.new(1, 1, 1)
    toggle.Font = Enum.Font.Gotham
    toggle.TextSize = 13
    toggle.TextXAlignment = Enum.TextXAlignment.Left

    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = toggle

    UIStroke.Color = theme.Accent
    UIStroke.Thickness = 1
    UIStroke.Transparency = 0.7
    UIStroke.Parent = toggle

    -- The "On/Off" Dot
    Indicator.Name = "Indicator"
    Indicator.Parent = toggle
    Indicator.AnchorPoint = Vector2.new(0, 0.5)
    Indicator.Position = UDim2.new(1, -30, 0.5, 0)
    Indicator.Size = UDim2.new(0, 15, 0, 15)
    Indicator.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

    toggle.MouseButton1Click:Connect(function()
        state = not state
        local targetColor = state and theme.Accent or Color3.fromRGB(30, 30, 30)
        
        -- Smooth transition
        game:GetService("TweenService"):Create(Indicator, TweenInfo.new(0.2), {
            BackgroundColor3 = targetColor
        }):Play()
        
        callback(state)
    end)

    return toggle
end

return ToggleModule
