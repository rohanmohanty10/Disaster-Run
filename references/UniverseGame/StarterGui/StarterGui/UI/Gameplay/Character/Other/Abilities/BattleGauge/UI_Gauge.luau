  

 

return function(p1) -- Line: 1
    local Parent = script.Parent;
    local u2 = require(p1.Knit.Util.Trove).new();
    require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Stands);

    local function CharacterAdded(u3) -- Line: 7
        -- upvalues: u2 (copy), Parent (copy)
        u2:Clean();
        local u4 = 0;

        local function Update() -- Line: 11
            -- upvalues: Parent (ref), u3 (copy), u4 (ref)
            Parent.Visible = u3:GetAttribute("BattleGauge") ~= nil;
            local v5 = u3:GetAttribute("BattleGauge") or 0;
            local v6 = u3:GetAttribute("MaxBattleGauge") or 400;
            local v7 = math.round(v6 / 100);
            local v8 = math.floor(v5 / 100);
            local v9 = math.clamp(v8, 0, v7);
            Parent.Label.Level.Text = `Lv. {v9}`;

            if v5 >= v6 then
                Parent.Meter.Bar:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.1, true);
                u4 = 400;

                return;
            end;

            local v10 = v5 % 100;

            if v10 < u4 then
                Parent.Meter.Bar.Size = UDim2.new(0, 0, 1, 0);
            end;

            Parent.Meter.Bar:TweenSize(UDim2.new(v10 / 100, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.1, true);
            u4 = v10;
        end;

        Update();
        u2:Add(u3:GetAttributeChangedSignal("BattleGauge"):Connect(Update));
    end;

    if p1.Character then
        CharacterAdded(p1.Character);
    end;

    p1.Player.CharacterAdded:Connect(CharacterAdded);
end;