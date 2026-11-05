  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);

return function(p1) -- Line: 5
    -- upvalues: Trove (copy)
    local Relative = p1.Relative;
    local Particle = p1.Particle;
    local Max = p1.Max;
    local Offset = p1.Offset;
    local u2 = Trove.new();
    u2:AttachToInstance(Relative);
    u2:Connect(Relative.AncestryChanged, function() -- Line: 14
        -- upvalues: Relative (copy), u2 (copy)
        if not Relative:IsDescendantOf(workspace) then
            u2:Destroy();
        end;
    end);
    local u3 = 0;
    u2:Connect(Relative.Touched, function(p4) -- Line: 22
        -- upvalues: Relative (copy), Offset (copy), u3 (ref), Max (copy), u2 (copy), Particle (copy)
        if p4:IsDescendantOf(Relative) then
            return;
        end;

        if not p4.CanCollide then
            return;
        end;

        local v5 = RaycastParams.new();
        v5.FilterType = Enum.RaycastFilterType.Whitelist;
        v5.FilterDescendantsInstances = { workspace.Map };
        local v6 = workspace:Raycast(Relative.Position, Vector3.new(0, -Relative.Size.Magnitude, 0), v5);

        if not v6 then
            return;
        end;

        local v7 = CFrame.lookAt(v6.Position, v6.Position - v6.Normal);

        if Offset then
            v7 = v7 * Offset;
        end;

        if u3 < Max then
            u3 = u3 + 1;

            if Max <= u3 then
                u2:Destroy();
            end;

            local v8 = Particle:Clone();
            v8.Parent = workspace.Effects;
            v8.CFrame = v7;
            local v9 = 0;

            for _, descendant in pairs(v8:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    local v10 = descendant.Lifetime.Max / descendant.TimeScale;

                    if v9 >= v10 then
                        v10 = v9;
                    end;

                    local v11 = descendant:GetAttribute("EmitCount");

                    if v11 and typeof(v11) == "number" then
                        descendant:Emit(v11);
                        v9 = v10;
                    else
                        v9 = v10;
                    end;
                end;
            end;

            task.delay(v9, v8.Destroy, v8);
        end;
    end);
end;