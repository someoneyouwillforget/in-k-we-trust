local ToggleModule = {}

function ToggleModule.new(parent, text, theme, callback)
    local state = false
    local Toggle = Instance.new("TextButton", parent)
    Toggle.Size = UDim2.new(1, 0, 0, 40)
    Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Toggle.Text = "  " .. text
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.Font = Enum.Font.Gotham
    Toggle.TextSize = 13
    Toggle.TextXAlignment = Enum.TextXAlignment.Left

    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 8)
    local Stroke = Instance.new("UIStroke", Toggle)
    Stroke.Color = Color3.fromRGB(40, 40, 40)

    -- The Switch Container
    local Switch = Instance.new("Frame", Toggle)
    Switch.Size = UDim2.new(0, 35, 0, 18)
    Switch.Position = UDim2.new(1, -45, 0.5, -9)
    Switch.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)

    -- The Moving Dot
    local Dot = Instance.new("Frame", Switch)
    Dot.Size = UDim2.new(0, 14, 0, 14)
    Dot.Position = UDim2.new(0, 2, 0.5, -7)
    Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

    Toggle.MouseButton1Click:Connect(function()
        state = not state
        local targetPos = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        local targetColor = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(40, 40, 40)

        game:GetService("TweenService"):Create(Dot, TweenInfo.new(0.2), {Position = targetPos}):Play()
        game:GetService("TweenService"):Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
        
        Dot.BackgroundColor3 = state and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
        
        callback(state)
    end)

    return Toggle
end

return ToggleModule
