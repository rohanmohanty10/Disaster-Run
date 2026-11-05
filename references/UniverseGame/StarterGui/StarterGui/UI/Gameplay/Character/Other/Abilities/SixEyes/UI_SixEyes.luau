  

 

return function(u1) -- Line: 1
    local Parent = script.Parent;
    local u2 = require(u1.Knit.Util.Trove).new();
    require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Stands);

    local function CharacterAdded(u3) -- Line: 7
        -- upvalues: u2 (copy), Parent (copy), u1 (copy)
        u2:Clean();

        local function SetVisible() -- Line: 10
            -- upvalues: Parent (ref), u1 (ref)
            Parent.Visible = u1.Player.Data.Ability.Value == 12789;
        end;

        local function UpdateData() -- Line: 14
            -- upvalues: u3 (copy), Parent (ref)
            local v4 = u3:GetAttribute("SixEyes");
            local v5 = u3:GetAttribute("SixEyesMastery");
            Parent.Mode.Text = v4 == true and "Six Eyes" or "Sealed";
            Parent.Awakened.Visible = v5 == true;
            Parent.Holder.Sealed.Visible = v4 ~= true;
            Parent.Holder.SixEyes.Visible = v4 == true;
        end;

        Parent.Visible = u1.Player.Data.Ability.Value == 12789;
        u2:Add(u3:GetAttributeChangedSignal("SixEyes"):Connect(SetVisible));
        local v6 = u3:GetAttribute("SixEyes");
        local v7 = u3:GetAttribute("SixEyesMastery");
        Parent.Mode.Text = v6 == true and "Six Eyes" or "Sealed";
        Parent.Awakened.Visible = v7 == true;
        Parent.Holder.Sealed.Visible = v6 ~= true;
        Parent.Holder.SixEyes.Visible = v6 == true;
        u2:Add(u3.AttributeChanged:Connect(UpdateData));
    end;

    if u1.Character then
        CharacterAdded(u1.Character);
    end;

    u1.Player.CharacterAdded:Connect(CharacterAdded);
end;