local ButtonModule = {}

function ButtonModule.new(parent, text, theme, callback)
    local Button = Instance.new("TextButton")
    Button.Name = text .. "Button"
    Button.Parent = parent
    Button.Size = UDim2.new(1, 0, 0, 38)
    Button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Button.AutoButtonColor = false
    Button.Text = "  " .. text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 13
    Button.TextXAlignment = Enum.TextXAlignment.Left

    local UICorner = Instance.new("UICorner", Button)
    UICorner.CornerRadius = UDim.new(0, 8)

    local UIStroke = Instance.new("UIStroke", Button)
    UIStroke.Color = Color3.fromRGB(40, 40, 40)
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- Minimalist Click Animation
    Button.MouseButton1Down:Connect(function()
        UIStroke.Color = Color3.fromRGB(255, 255, 255)
        game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
    end)

    Button.MouseButton1Up:Connect(function()
        UIStroke.Color = Color3.fromRGB(40, 40, 40)
        game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}):Play()
        callback()
    end)

    return Button
end

return ButtonModule
