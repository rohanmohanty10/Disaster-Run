  

 

return function(u1) -- Line: 1
    local Parent = script.Parent;
    game:GetService("TweenService");
    local u2 = u1.Knit.GetService("StatService");
    local LocalPlayer = game.Players.LocalPlayer;
    local Parent2 = script.Parent;

    local function SetVisible() -- Line: 12
        -- upvalues: Parent (copy), u1 (copy)
        Parent.Visible = u1.Player.Data.Ability.Value == 6666666;
    end;

    local function CharacterAdded(p3) -- Line: 16
        -- upvalues: Parent2 (copy), LocalPlayer (copy), u2 (copy)
        while p3.Parent do
            Parent2.Souls.Text = `Souls: {LocalPlayer:GetAttribute("ShinigamiSouls")}`;
            task.wait(1);
            local v4 = u2:GetExternalStats("ShinigamiStats"):expect();

            if v4 then
                local v5 = `Health: {v4.Health}\nDefense: {v4.Defense}\nAttack: {v4.Attack}\nSpecial: {v4.Special}`;
                Parent2.Stats.Text = v5;
            end;
        end;
    end;

    if u1.Character then
        task.spawn(CharacterAdded, u1.Character);
    end;

    u1.Player.CharacterAdded:Connect(CharacterAdded);
    Parent.Visible = u1.Player.Data.Ability.Value == 6666666;
    u1.Player.Data.Ability.Changed:Connect(SetVisible);
end;