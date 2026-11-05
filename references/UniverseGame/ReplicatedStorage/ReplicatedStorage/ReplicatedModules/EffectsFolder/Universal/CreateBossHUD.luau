  

 

local BossHUD = script.BossHUD;

return function(p1) -- Line: 2
    -- upvalues: BossHUD (copy)
    if not (p1:GetAttribute("NPC") and p1:FindFirstChild("Head")) then
        return;
    end;

    local Head = p1.Head;
    local Humanoid = p1.Humanoid;
    local v2 = BossHUD:Clone();
    v2.Adornee = Head;
    local HealthDisplay = v2.Health.HealthDisplay;
    local Bar = v2.Health.Bar;

    if p1:GetAttribute("NameColor") then
        v2.Display.Text = `<font color="{p1:GetAttribute("NameColor")}">{Humanoid.DisplayName}</font>`;
    else
        v2.Display.Text = Humanoid.DisplayName;
    end;

    if p1:GetAttribute("Level") then
        local Display = v2.Display;
        Display.Text = Display.Text .. `\n<font color="#03fcbe">LEVEL: {p1:GetAttribute("Level")}</font>`;
    end;

    v2.Parent = Head;
    Humanoid.HealthChanged:Connect(function(p3) -- Line: 24
        -- upvalues: Humanoid (copy), Bar (copy), HealthDisplay (copy)
        local u4 = p3 / Humanoid.MaxHealth;
        Bar.Size = UDim2.fromScale(u4, 1);
        HealthDisplay.Text = string.format("%s/%s (%.1f%%)", math.round(p3), Humanoid.MaxHealth, u4 * 100);
        local v6 = (function() -- Line: 29, Name: GetHealthColor
            -- upvalues: u4 (copy)
            local v5 = Color3.fromRGB(0, 255, 0);

            if u4 <= 0.25 then
                return Color3.fromRGB(255, 0, 0);
            end;

            if u4 <= 0.5 then
                v5 = Color3.fromRGB(255, 255, 0);
            end;

            return v5;
        end)();

        if Bar.BackgroundColor3 ~= v6 then
            Bar.BackgroundColor3 = v6;
        end;
    end);
    HealthDisplay.Text = string.format("%s/%s", math.round(Humanoid.Health), Humanoid.MaxHealth) .. " 100%";
end;