  

 

local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1, u2, p3) -- Line: 3
    -- upvalues: EffectsHandler (copy)
    p1.Character:FindFirstChild("HumanoidRootPart");
    EffectsHandler.CallEffect("ImpaledTorso", u2);

    if not p3 then
        local v4 = {
            Path = "Particles/Impale",
            AutoSerialize = true,
            AttachTo = {
                Part = u2.HumanoidRootPart,
                Offset = CFrame.identity
            },
            Origin = u2.HumanoidRootPart.CFrame
        };

        if p1 and p1:IsA("Player") then
            v4.Player = p1;
        else
            v4.SkinName = nil;
            v4.AbilityName = "The World";
        end;

        EffectsHandler.CallEffect("Emit Particle V3", v4);
    end;

    task.delay(0.06666666666666667, function() -- Line: 35
        -- upvalues: EffectsHandler (ref), u2 (copy)
        EffectsHandler.CallEffect("BloodSplat", u2, nil, {
            Offset = CFrame.Angles(0, 3.141592653589793, 0)
        });
    end);
end;