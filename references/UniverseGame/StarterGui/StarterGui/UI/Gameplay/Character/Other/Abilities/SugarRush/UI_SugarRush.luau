  

 

local function FormatTime(p1) -- Line: 1
    local v2 = math.floor(p1 / 60);

    return p1 > 10000000000 and "∞" or string.format("%i:%02i", v2, p1 % 60);
end;

return function(p3) -- Line: 7
    local Parent = script.Parent;
    local u4 = require(p3.Knit.Util.Trove).new();

    local function CharacterAdded(u5) -- Line: 11
        -- upvalues: u4 (copy), Parent (copy)
        u4:Clean();

        local function Update() -- Line: 14
            -- upvalues: u5 (copy), Parent (ref)
            local v6 = u5:GetAttribute("SugarRushTime");
            Parent.Visible = v6 and true or false;

            if not v6 then
                return;
            end;

            local TimerText = Parent.TimerText;
            local v7 = math.floor(v6 / 60);
            TimerText.Text = v6 > 10000000000 and "∞" or string.format("%i:%02i", v7, v6 % 60);
            Parent.TimerText.TextColor3 = v6 <= 7 and Color3.new(1, 0, 0) or Color3.new(1, 1, 1);
        end;

        u4:Add(u5:GetAttributeChangedSignal("SugarRushTime"):Connect(Update));
        Update();
    end;

    if p3.Character then
        CharacterAdded(p3.Character);
    end;

    p3.Player.CharacterAdded:Connect(CharacterAdded);
end;