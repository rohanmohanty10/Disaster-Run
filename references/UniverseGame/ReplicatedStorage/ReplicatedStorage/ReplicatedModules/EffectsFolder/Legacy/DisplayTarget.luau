  

 

local LocalPlayer = game.Players.LocalPlayer;

return function(p1, u2) -- Line: 3
    -- upvalues: LocalPlayer (copy)
    local function getClosestEntityOnMouse() -- Line: 4
        -- upvalues: LocalPlayer (ref), u2 (copy)
        local v3 = LocalPlayer:GetMouse();
        local v4 = Vector2.new(v3.X, v3.Y);
        local v5 = nil;
        local v6 = nil;

        for _, child in pairs(workspace.Living:GetChildren()) do
            local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart ~= nil and (child ~= LocalPlayer.Character and u2 >= (HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude) then
                local v7, v8 = workspace.Camera:WorldToScreenPoint(HumanoidRootPart.Position);
                local v9 = Vector2.new(v7.X, v7.Y);

                if v8 then
                    local magnitude = (v4 - v9).magnitude;

                    if v5 and v6 then
                        if magnitude < v6 then
                            v6 = magnitude;
                            v5 = child;
                        end;
                    else
                        v6 = magnitude;
                        v5 = child;
                    end;
                end;
            end;
        end;

        return v5;
    end;

    local TargetGUI = LocalPlayer.PlayerGui.Extra:WaitForChild("TargetGUI");
    TargetGUI.Enabled = p1;

    if p1 == true then
        local v10 = nil;

        while true do
            local v11;

            if true then
                v11 = getClosestEntityOnMouse();

                if v11 and (v11.Head and v11 ~= v10) then
                    TargetGUI.Adornee = v11.Head;
                else
                    v11 = v10;
                end;
            end;

            wait();

            if TargetGUI.Enabled == false then
                break;
            end;

            v10 = v11;
        end;

        TargetGUI.Adornee = nil;
    end;
end;