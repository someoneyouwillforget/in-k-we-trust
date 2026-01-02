local ToggleModule = {}

function ToggleModule.new(parent, text, callback)
    local toggle = Instance.new("TextButton", parent)
    toggle.Name = text .. "Toggle"
    toggle.Size = UDim2.new(1, 0, 0, 35)
    toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggle.Text = text .. ": OFF"

    local state = false
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = text .. (state and ": ON" or ": OFF")
        toggle.BackgroundColor3 = state and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 60)
        callback(state)
    end)
end

return ToggleModule
