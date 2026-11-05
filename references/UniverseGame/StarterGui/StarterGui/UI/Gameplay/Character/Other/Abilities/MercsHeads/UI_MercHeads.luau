  

 

return function(u1) -- Line: 1
    local Parent = script.Parent;
    local u2 = require(u1.Knit.Util.Trove).new();

    local function CharacterAdded(u3) -- Line: 5
        -- upvalues: u2 (copy), Parent (copy), u1 (copy)
        u2:Clean();

        local function Update() -- Line: 8
            -- upvalues: u3 (copy), Parent (ref), u1 (ref)
            local v4 = u3:GetAttribute("MercHeads");

            if not v4 then
                if v4 or u1.Player.Data.Ability.Value ~= 34 then
                    Parent.Visible = false;

                    return;
                end;

                Parent.Visible = true;
                Parent.AmountText.Text = "0";

                return;
            end;

            Parent.Visible = true;
            local AmountText = Parent.AmountText;
            local v5 = math.floor(v4);
            AmountText.Text = tostring(v5);
        end;

        u2:Add(u3:GetAttributeChangedSignal("MercHeads"):Connect(Update));
        local v6 = u3:GetAttribute("MercHeads");

        if not v6 then
            if v6 or u1.Player.Data.Ability.Value ~= 34 then
                Parent.Visible = false;

                return;
            end;

            Parent.Visible = true;
            Parent.AmountText.Text = "0";

            return;
        end;

        Parent.Visible = true;
        local AmountText = Parent.AmountText;
        local v7 = math.floor(v6);
        AmountText.Text = tostring(v7);
    end;

    if u1.Character then
        CharacterAdded(u1.Character);
    end;

    u1.Player.CharacterAdded:Connect(CharacterAdded);
end;