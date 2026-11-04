 

 

game:GetService("Lighting");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return {
    [0] = function(p1, p2, p3) -- Line: 6
        local Character = p1.Character;
        local _ = Character.HumanoidRootPart;
        local Cache = p1.Cache;
        Cache.Aura = {};
        Cache.Tension = {};

        for _, child in ipairs(Character:GetChildren()) do
            if child:IsA("Part") and child.Transparency < 1 then
                local v4 = child;

                for _, child2 in ipairs(script.Aura:GetChildren()) do
                    local v5 = child2:Clone();
                    v5.Parent = v4;
                    v5.Enabled = false;
                    table.insert(Cache.Aura, v5);
                end;
            end;
        end;

        task.spawn(function() -- Line: 25
            -- upvalues: Character (copy)
            for _, descendant in Character:GetDescendants() do
                if (descendant.Name == "Wings" or descendant.Name == "Halo") and descendant:IsA("MeshPart") then
                    descendant.Transparency = 1;
                end;
            end;
        end);
    end,

    [2.183333333333333] = function(p6, p7, p8) -- Line: 34
        local _ = p6.Character.HumanoidRootPart;

        for _, descendant in pairs(p7.HumanoidRootPart.CHARGE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [3.0166666666666666] = function(p9, u10, p11) -- Line: 46
        local _ = p9.Character;
        task.spawn(function() -- Line: 50
            -- upvalues: u10 (copy)
            for _, descendant in pairs(u10.HumanoidRootPart.CHARGE:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end);

        for _, descendant in pairs(u10.HumanoidRootPart.explosion:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant:GetAttribute("EmitCount") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [3.1333333333333333] = function(p12, p13, p14) -- Line: 70
        local Character = p12.Character;
        local _ = Character.HumanoidRootPart;
        local v15 = script.Themightyshaftstudio:Clone();
        v15.Parent = Character;
        v15:PivotTo(Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 24));
        v15["cone lines"].Anchored = true;
        v15["cone lines"]:PivotTo(v15.RootPart.CFrame * CFrame.new(0, 170, 0));
    end,

    [8.5] = function(p16, p17, p18) -- Line: 80
        local Character = p16.Character;
        local _ = Character.HumanoidRootPart;
        Character.Themightyshaftstudio["cone lines"]:Destroy();
    end,

    [9.016666666666667] = function(p19, p20, p21) -- Line: 86
        local Character = p19.Character;
        local _ = Character.HumanoidRootPart;
        local Aura = p19.Cache.Aura;
        task.spawn(function() -- Line: 92
            -- upvalues: Aura (copy)
            for _, v in Aura do
                v.Enabled = true;
            end;
        end);
        task.spawn(function() -- Line: 98
            -- upvalues: Character (copy)
            for _, descendant in Character:GetDescendants() do
                if (descendant.Name == "Wings" or descendant.Name == "Halo") and descendant:IsA("MeshPart") then
                    descendant.Transparency = 0;
                end;
            end;
        end);

        for _, descendant in Character.Head:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                if descendant:GetAttribute("EmitCount") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            elseif descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [13.45] = function(p22) -- Line: 116
        p22.Cache.Aura = nil;
    end
};