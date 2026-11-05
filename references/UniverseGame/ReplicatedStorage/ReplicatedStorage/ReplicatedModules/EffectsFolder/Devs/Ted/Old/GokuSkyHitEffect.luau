  

 

return function(p1, p2, p3) -- Line: 1
    local v4 = game.ReplicatedStorage["Client Assets"]["Goku Rewrite"].HitEffects:FindFirstChild("SkyHit"):Clone();
    v4.CFrame = p1.Torso.CFrame;
    v4.Parent = workspace.Effects;
    local v5 = 1;

    for _, descendant in pairs(v4:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount") or 5);

            if v5 < descendant.Lifetime.Max then
                v5 = descendant.Lifetime.Max;
            end;
        end;
    end;

    game.Debris:AddItem(v4, v5);
end;