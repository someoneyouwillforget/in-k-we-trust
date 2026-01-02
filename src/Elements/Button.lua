local Button = {}

function Button.new(parent, text, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, 0, 0, 40)
    Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Btn.Text = "  " .. text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 13
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    local Stroke = Instance.new("UIStroke", Btn)
    Stroke.Color = Color3.fromRGB(40, 40, 40)

    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

return Button
