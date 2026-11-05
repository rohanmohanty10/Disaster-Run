  

 

return function(p1) -- Line: 1
    local Parent = script.Parent;
    local u2 = require(p1.Knit.Util.Trove).new();
    local Stands = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Stands);

    local function CharacterAdded(u3) -- Line: 7
        -- upvalues: u2 (copy), Parent (copy), Stands (copy)
        u2:Clean();

        local function SetVisible() -- Line: 10
            -- upvalues: Parent (ref), u3 (copy)
            Parent.Visible = u3:GetAttribute("Mimicry") ~= nil;
        end;

        local function UpdateData() -- Line: 14
            -- upvalues: u3 (copy), Stands (ref), Parent (ref)
            u3:GetAttribute("MimicryAbilityId");
            local v4 = u3:GetAttribute("MimicryAbilityName");
            local v5 = u3:GetAttribute("MimicryAmount");
            local v6 = u3:GetAttribute("MimicryMax");
            local v7 = u3:GetAttribute("MimicryMove1");
            local v8 = u3:GetAttribute("MimicryMove1Cost") or "?";
            local v9 = u3:GetAttribute("MimicryMove2");
            local v10 = u3:GetAttribute("MimicryMove2Cost") or "?";
            local v11 = u3:GetAttribute("MimicryStoredId");
            local v12 = u3:GetAttribute("MimicryStoredAmount");
            local v13 = Stands[v11];
            Parent.Ability.Text = not v4 and "None" or `{string.upper(v4)} [{v5}/{v6}]`;
            Parent.Move1.Text = (not v7 or v7 == "") and "" or `[TAP] {v7} [-{v8}]`;
            Parent.Move1.Visible = v7 and v7 ~= "" and true or false;
            Parent.Move2.Text = (not v9 or v9 == "") and "" or `[HOLD] {v9} [-{v10}]`;
            Parent.Move2.Visible = v9 and v9 ~= "" and true or false;
            Parent.Swap.Text = not v13 and "[BLOCK + TAP] Store" or `[BLOCK + TAP] Swap with {string.upper(v13)} [{v12 or 0}]`;
            Parent.Swap.Visible = (v4 or v13) and true or false;
            Parent.Discard.Visible = v4 and true or false;
        end;

        Parent.Visible = u3:GetAttribute("Mimicry") ~= nil;
        u2:Add(u3:GetAttributeChangedSignal("Mimicry"):Connect(SetVisible));
        UpdateData();
        u2:Add(u3.AttributeChanged:Connect(UpdateData));
    end;

    if p1.Character then
        CharacterAdded(p1.Character);
    end;

    p1.Player.CharacterAdded:Connect(CharacterAdded);
end;