local ButtonModule = {}

function ButtonModule.new(parent, text, theme, callback)
    local Button = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")

    -- Setup
    Button.Name = text .. "Button"
    Button.Parent = parent
    Button.BackgroundColor3 = theme.MainBackground
    Button.Size = UDim2.new(1, 0, 0, 32)
    Button.AutoButtonColor = false
    Button.Font = Enum.Font.Gotham
    Button.Text = text
    Button.TextColor3 = theme.Text
    Button.TextSize = 13
    Button.BorderSizePixel = 0

    -- Style
    UICorner.CornerRadius = theme.CornerRadius or UDim.new(0, 6)
    UICorner.Parent = Button

    UIStroke.Thickness = 1
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Transparency = 0.9
    UIStroke.Parent = Button

    -- Hover & Click Nonsense
    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(
            theme.MainBackground.R * 255 + 10,
            theme.MainBackground.G * 255 + 10,
            theme.MainBackground.B * 255 + 10
        )
    end)

    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = theme.MainBackground
    end)

    Button.MouseButton1Click:Connect(function()
        Button.BackgroundColor3 = theme.Accent
        task.wait(0.1)
        Button.BackgroundColor3 = theme.MainBackground
        
        callback()
    end)

    return Button
end

return ButtonModule
