  

 

return function(p1) -- Line: 1
    local Parent = script.Parent;
    local u2 = require(p1.Knit.Util.Trove).new();

    local function CharacterAdded(u3) -- Line: 5
        -- upvalues: u2 (copy), Parent (copy)
        u2:Clean();

        local function UpdateFrame() -- Line: 8
            -- upvalues: u3 (copy), Parent (ref)
            local v4 = u3:GetAttribute("SpiritualLevel");

            if v4 == nil then
                Parent.Visible = false;

                return;
            end;

            Parent.Visible = true;
            Parent.Level.Text = `[ Spiritual LVL {v4} ]`;
        end;

        u2:Add(u3:GetAttributeChangedSignal("SpiritualLevel"):Connect(UpdateFrame));
        local v5 = u3:GetAttribute("SpiritualLevel");

        if v5 == nil then
            Parent.Visible = false;

            return;
        end;

        Parent.Visible = true;
        Parent.Level.Text = `[ Spiritual LVL {v5} ]`;
    end;

    if p1.Character then
        CharacterAdded(p1.Character);
    end;

    p1.Player.CharacterAdded:Connect(CharacterAdded);
end;