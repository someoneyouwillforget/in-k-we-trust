local Toggle = {}

function Toggle.new(parent, text, callback)
    local state = false
    local Tgl = Instance.new("TextButton", parent)
    Tgl.Size = UDim2.new(1, 0, 0, 40)
    Tgl.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Tgl.Text = "  " .. text
    Tgl.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tgl.Font = Enum.Font.Gotham
    Tgl.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", Tgl).CornerRadius = UDim.new(0, 8)

    local Switch = Instance.new("Frame", Tgl)
    Switch.Size = UDim2.new(0, 35, 0, 18)
    Switch.Position = UDim2.new(1, -45, 0.5, -9)
    Switch.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)

    local Dot = Instance.new("Frame", Switch)
    Dot.Size = UDim2.new(0, 12, 0, 12)
    Dot.Position = UDim2.new(0, 3, 0.5, -6)
    Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

    Tgl.MouseButton1Click:Connect(function()
        state = not state
        local targetPos = state and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)
        local targetCol = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(40, 40, 40)
        game:GetService("TweenService"):Create(Dot, TweenInfo.new(0.2), {Position = targetPos}):Play()
        game:GetService("TweenService"):Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = targetCol}):Play()
        callback(state)
    end)
    return Tgl
end

return Toggle
