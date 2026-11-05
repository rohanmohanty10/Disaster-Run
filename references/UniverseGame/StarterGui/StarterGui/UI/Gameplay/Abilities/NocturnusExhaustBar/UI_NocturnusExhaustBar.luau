  

 

return function(u1) -- Line: 1
    local Parent = script.Parent;
    game:GetService("TweenService");
    u1.Knit.GetService("StatService");
    local _ = game.Players.LocalPlayer;
    local _ = script.Parent;

    local function SetVisible() -- Line: 12
        -- upvalues: Parent (copy), u1 (copy)
        Parent.Visible = u1.Player.Data.Ability.Value == 502;
    end;

    local function MeterColorChanged(p2) -- Line: 16
        -- upvalues: Parent (copy)
        local v3 = p2:GetAttribute("MeterColor") or Color3.fromRGB(0, 200, 255);
        Parent.Container.Background.ImageColor3 = v3;
        Parent.Container.Bar.Main.ImageLabel.ImageColor3 = v3;
        Parent.Text.Label.UIGradient.Color = ColorSequence.new(v3, Color3.new(1, 1, 1));
        Parent.Text.Label.UIStroke.Color = v3;
        Parent.Text.Value.UIGradient.Color = ColorSequence.new(v3, Color3.new(1, 1, 1));
        Parent.Text.Value.UIStroke.Color = v3;
    end;

    local u4 = nil;

    local function CharacterAdded(u5) -- Line: 29
        -- upvalues: MeterColorChanged (copy), u4 (ref), Parent (copy)
        MeterColorChanged(u5);
        local u6 = u5:GetAttribute("NocturnusExhaustion") or 0;

        if u4 then
            u4:Disconnect();
        end;

        u4 = u5:GetAttributeChangedSignal("NocturnusExhaustion"):Connect(function() -- Line: 35
            -- upvalues: u6 (ref), u5 (copy), Parent (ref)
            u6 = u5:GetAttribute("NocturnusExhaustion") or 0;
            Parent.Container.Bar.Size = UDim2.fromScale(u6, 1);
            Parent.Text.Value.Text = `{math.floor(u6 * 100)}%`;
        end);
        Parent.Container.Bar.Size = UDim2.fromScale(u6, 1);
        Parent.Text.Value.Text = `{math.floor(u6 * 100)}%`;
    end;

    if u1.Character then
        task.spawn(CharacterAdded, u1.Character);
    end;

    u1.Player.CharacterAdded:Connect(CharacterAdded);
    Parent.Visible = u1.Player.Data.Ability.Value == 502;
    u1.Player.Data.Ability.Changed:Connect(SetVisible);
end;