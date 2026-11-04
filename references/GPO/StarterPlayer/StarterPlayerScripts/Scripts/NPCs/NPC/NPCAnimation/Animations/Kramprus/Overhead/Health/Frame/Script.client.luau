 

local u1 = script.char.Value.Humanoid
if u1:IsA("Humanoid") then
    if _G.isCustomHUB ~= true then
        local u2 = script.Parent.BackgroundColor3
        local _ = script.Parent.Parent.Parent
        local function v4(_) --[[ Line: 15 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u2
            --]]
            local v3 = u1.Health / u1.MaxHealth
            script.Parent.BackgroundColor3 = Color3.fromRGB(255, 255, 255):Lerp(u2, v3)
            script.Parent:TweenSize(UDim2.new(v3, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
            if u1.Health <= 0 then
                script.Parent.Parent.Parent:Destroy()
            end
        end
        v4()
        u1.HealthChanged:Connect(v4)
    end
else
    return
end