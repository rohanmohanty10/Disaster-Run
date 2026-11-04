 
 

game:GetService("Lighting");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return {
    [0] = function(p1, p2, p3) -- Line: 6
        local _ = p1.Meshes;
        local Cache = p1.Cache;
        local HumanoidRootPart = p1.Character.HumanoidRootPart;
        local v4 = script.Wind:Clone();
        v4:PivotTo(HumanoidRootPart.CFrame);
        v4.Parent = workspace.Effects;
        Cache.Wind = v4;
    end,

    [0.417] = function(p5, p6, p7) -- Line: 19
        local _ = p5.Cache;
        local _ = p5.Character.HumanoidRootPart;

        for _, descendant in pairs(p5.Meshes.step1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [0.95] = function(p8, p9, p10) -- Line: 33
        local _ = p8.Cache;
        local _ = p8.Character.HumanoidRootPart;

        for _, descendant in pairs(p8.Meshes.step2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [1.25] = function(p11, p12, p13) -- Line: 47
        local _ = p11.Cache;
        local _ = p11.Character.HumanoidRootPart;

        for _, descendant in pairs(p11.Meshes.step3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [1.8] = function(p14, p15, p16) -- Line: 61
        local Meshes = p14.Meshes;
        local MeshEmit = p14.MeshEmit;
        local Cache = p14.Cache;
        local HumanoidRootPart = p14.Character.HumanoidRootPart;
        HumanoidRootPart.Anchored = true;
        HumanoidRootPart.CFrame = CFrame.new(0, 100, 0);
        Meshes:PivotTo(HumanoidRootPart.CFrame);
        MeshEmit:PivotTo(HumanoidRootPart.CFrame);

        for _, descendant in pairs(Meshes.emit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, v in p16.All do
            if v:IsA("ParticleEmitter") or v:IsA("Beam") then
                v.Enabled = true;
            end;
        end;

        for _, descendant in pairs(HumanoidRootPart.blenderCam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        if Cache.Wind then
            Cache.Wind:Destroy();
            Cache.Wind = nil;
        end;

        local v17 = script.IsagiDemonRealm:Clone();
        v17:PivotTo(HumanoidRootPart.CFrame);
        v17.Parent = workspace.Effects;
        table.insert(Cache, v17);
    end,

    [6.5] = function() -- Line: 105
    end
};