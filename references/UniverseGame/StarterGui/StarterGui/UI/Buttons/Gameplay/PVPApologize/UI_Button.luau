  

 

return function(u1) -- Line: 1
    local Remotes = game:GetService("ReplicatedStorage").Remotes;
    local u2 = nil;

    local function UpdateVisibility(p3) -- Line: 5
        if not p3 then
            script.Parent.Visible = false;

            return;
        end;

        local v4 = p3:GetAttribute("PVPTag");

        if not v4 then
            script.Parent.Visible = false;
        end;

        if script.Parent.Visible and (typeof(v4) == "number" and v4 < workspace:GetServerTimeNow()) then
            script.Parent.Visible = false;
        end;
    end;

    local function ConnectCharacter(u5) -- Line: 20
        -- upvalues: u2 (ref), UpdateVisibility (copy)
        if u2 then
            u2:Disconnect();
            u2 = nil;
        end;

        u2 = u5:GetAttributeChangedSignal("PVPTag"):Connect(function() -- Line: 26
            -- upvalues: UpdateVisibility (ref), u5 (copy)
            UpdateVisibility(u5);
        end);
        UpdateVisibility(u5);
    end;

    task.spawn(function() -- Line: 34
        -- upvalues: UpdateVisibility (copy), u1 (copy)
        while true do
            UpdateVisibility(u1.Player.Character);
            task.wait(1);
        end;
    end);
    script.Parent.MouseButton1Click:Connect(function() -- Line: 41
        -- upvalues: Remotes (copy)
        Remotes.CombatApology:FireServer({ 1 });
    end);
    Remotes.CombatApology.OnClientEvent:Connect(function(u6) -- Line: 45
        -- upvalues: u1 (copy), Remotes (copy)
        local v7 = u6[1];

        if v7 == 0 then
            script.Parent.Visible = true;

            return;
        end;

        if v7 == 2 then
            u1:Notify("Combat Apology", `{u6[2].Name} wants to drop combat`, 4, { "Accept", "Decline" }, function(p8, p9, p10) -- Line: 54
                -- upvalues: Remotes (ref), u6 (copy)
                if p9 == 1 then
                    Remotes.CombatApology:FireServer({ 3, u6[2] });
                end;
            end);
        end;
    end);

    if u1.Player.Character then
        ConnectCharacter(u1.Player.Character);
    end;

    u1.Player.CharacterAdded:Connect(ConnectCharacter);
end;