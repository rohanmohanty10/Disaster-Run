  

 

return function(p1) -- Line: 1
    local v2 = p1:IsA("Part") and p1 and p1 or p1:FindFirstChild("Torso");

    if v2 then
        local u3 = game.ReplicatedStorage["Client Assets"].Whitesnake.Effects.HeavyHit:Clone();
        u3.Position = v2.Position;
        u3.Parent = game.Workspace.Terrain;

        for _, child in pairs(u3:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                local v4 = math.floor(child.Rate / 2);
                child:Emit((math.max(v4, 1)));
            end;
        end;

        task.delay(1.25, function() -- Line: 16
            -- upvalues: u3 (copy)
            u3:Destroy();
        end);
    end;
end;