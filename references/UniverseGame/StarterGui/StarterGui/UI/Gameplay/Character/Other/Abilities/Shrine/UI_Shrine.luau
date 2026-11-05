  

 

return function(p1) -- Line: 1
    local Parent = script.Parent;
    local u2 = require(p1.Knit.Util.Trove).new();
    require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Stands);

    local function CharacterAdded(u3) -- Line: 7
        -- upvalues: u2 (copy), Parent (copy)
        u2:Clean();

        local function Update() -- Line: 10
            -- upvalues: Parent (ref), u3 (copy)
            Parent.Visible = u3:GetAttribute("ShrineOutput") ~= nil;
            local v4 = (u3:GetAttribute("ShrineOutput") or 0) / 125;
            local v5 = math.clamp(v4, 0, 1);
            Parent.Label.Value.Text = `{string.format("%.0f", v5 * 100)}%`;
            Parent.Meter.Bar.Size = UDim2.new(v5, 0, 1, 0);
        end;

        Update();
        u2:Add(u3:GetAttributeChangedSignal("ShrineOutput"):Connect(Update));
    end;

    if p1.Character then
        CharacterAdded(p1.Character);
    end;

    p1.Player.CharacterAdded:Connect(CharacterAdded);
end;