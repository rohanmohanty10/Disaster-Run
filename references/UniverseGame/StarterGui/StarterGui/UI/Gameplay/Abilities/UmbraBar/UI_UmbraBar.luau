  

 

return function(u1) -- Line: 1
    local Parent = script.Parent;
    game:GetService("TweenService");
    u1.Knit.GetService("StatService");
    local _ = game.Players.LocalPlayer;
    local _ = script.Parent;

    local function SetVisible() -- Line: 12
        -- upvalues: Parent (copy), u1 (copy)
        Parent.Visible = u1.Player.Data.Ability.Value == 46;
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

    local function CharacterAdded(u4) -- Line: 28
        -- upvalues: MeterColorChanged (copy), Parent (copy)
        MeterColorChanged(u4);
        local u5 = u4:GetAttribute("UmbraBar") or 0;
        local u6 = u4:GetAttribute("UmbraBarMax") or 100;
        u4:GetAttributeChangedSignal("UmbraBar"):Connect(function() -- Line: 34
            -- upvalues: u5 (ref), u4 (copy), Parent (ref), u6 (copy)
            u5 = u4:GetAttribute("UmbraBar") or 0;
            Parent.Container.Bar.Size = UDim2.fromScale(u5 / u6, 1);
            Parent.Text.Value.Text = math.ceil(u5);
        end);
        Parent.Container.Bar.Size = UDim2.fromScale(u5 / u6, 1);
        Parent.Text.Value.Text = math.ceil(u5);
    end;

    if u1.Character then
        task.spawn(CharacterAdded, u1.Character);
    end;

    u1.Player.CharacterAdded:Connect(CharacterAdded);
    Parent.Visible = u1.Player.Data.Ability.Value == 46;
    u1.Player.Data.Ability.Changed:Connect(SetVisible);
end;