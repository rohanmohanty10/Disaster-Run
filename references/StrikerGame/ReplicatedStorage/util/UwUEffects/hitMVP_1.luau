 
 

game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return {
    [0] = function(p1, p2, p3) -- Line: 6
        local Character = p1.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local Torso = Character.Torso;
        local Cache = p1.Cache;
        Cache.Aura = {};
        Cache.Tension = {};
        Cache.allparts = {};
        local effs = Torso.effs;
        Cache.effs = effs;
        effs:PivotTo(HumanoidRootPart.CFrame);
        effs.Parent = workspace.Effects;
    end,

    [0.23333333333333334] = function(p4, p5, p6) -- Line: 23
        local Character = p4.Character;
        local _ = Character.HumanoidRootPart;
        local Torso = Character.Torso;
        local _ = p4.Cache;
        task.spawn(function() -- Line: 29
            -- upvalues: Torso (copy)
            for _, descendant in pairs(Torso["Footstep 1"]:GetDescendants()) do
                if descendant:GetAttribute("EmitCount") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
    end,

    [1.15] = function(p7, p8, p9) -- Line: 42
        local Character = p7.Character;
        local _ = Character.HumanoidRootPart;
        local Torso = Character.Torso;
        local _ = p7.Cache;
        task.spawn(function() -- Line: 48
            -- upvalues: Torso (copy)
            for _, descendant in pairs(Torso["Footstep 2"]:GetDescendants()) do
                if descendant:GetAttribute("EmitCount") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
    end,

    [1.8833333333333333] = function(p10, p11, p12) -- Line: 59
        local Character = p10.Character;
        local _ = Character.HumanoidRootPart;
        local Torso = Character.Torso;
        local _ = p10.Cache;
        task.spawn(function() -- Line: 65
            -- upvalues: Torso (copy)
            for _, descendant in pairs(Torso["Footstep 1"]:GetDescendants()) do
                if descendant:GetAttribute("EmitCount") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
    end,

    [2.6] = function(p13, p14, p15) -- Line: 77
        local Character = p13.Character;
        local _ = Character.HumanoidRootPart;
        local Torso = Character.Torso;
        local _ = p13.Cache;
        task.spawn(function() -- Line: 83
            -- upvalues: Torso (copy)
            for _, descendant in pairs(Torso["Footstep 2"]:GetDescendants()) do
                if descendant:GetAttribute("EmitCount") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
    end,

    [3.2333333333333334] = function(p16, p17, p18) -- Line: 94
        local _ = p16.Character.HumanoidRootPart;
        local HITSTUDIO = p16.Cache.effs.HITSTUDIO;
        HITSTUDIO.Hit1.Transparency = 0;
        task.spawn(function() -- Line: 103
            -- upvalues: HITSTUDIO (copy)
            for _, descendant in pairs(HITSTUDIO.Hit1:GetDescendants()) do
                if descendant:GetAttribute("EmitCount") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
    end,

    [3.966666666666667] = function(p19, p20, p21) -- Line: 114
        local _ = p19.Character.HumanoidRootPart;
        local HITSTUDIO = p19.Cache.effs.HITSTUDIO;
        HITSTUDIO.Hit2.Transparency = 0;
        task.spawn(function() -- Line: 122
            -- upvalues: HITSTUDIO (copy)
            for _, descendant in pairs(HITSTUDIO.Hit2:GetDescendants()) do
                if descendant:GetAttribute("EmitCount") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
    end,

    [5] = function(p22, p23, p24) -- Line: 133
        local _ = p22.Character.HumanoidRootPart;
        local HITSTUDIO = p22.Cache.effs.HITSTUDIO;
        HITSTUDIO.Hit3.Transparency = 0;
        task.spawn(function() -- Line: 142
            -- upvalues: HITSTUDIO (copy)
            for _, descendant in pairs(HITSTUDIO.Hit3:GetDescendants()) do
                if descendant:GetAttribute("EmitCount") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
    end,

    [5.333333333333333] = function(p25, p26, p27) -- Line: 153
        -- upvalues: TweenService (copy)
        local Character = p25.Character;
        local _ = Character.HumanoidRootPart;
        local Cache = p25.Cache;
        local effs = Cache.effs;
        local HITSTUDIO = effs.HITSTUDIO;
        HITSTUDIO.Hit1.Transparency = 1;
        HITSTUDIO.Hit2.Transparency = 1;
        HITSTUDIO.Hit3.Transparency = 1;
        local allparts = Cache.allparts;

        for i = 1, 2 do
            task.wait(0.1);
            local u28 = script.distortion:Clone();
            u28.Parent = workspace.Camera;
            u28.CFrame = effs.MeshPart.CFrame;
            local u29 = TweenService:Create(u28, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Size = Vector3.new(25, 25, 25),
                Transparency = 1
            });
            u29:Play();
            task.spawn(function() -- Line: 173
                -- upvalues: u29 (copy), u28 (copy)
                u29.Completed:Wait();
                u29:Destroy();
                u28:Destroy();
            end);
            local _ = i;
        end;

        for _, descendant in ipairs(Character:GetDescendants()) do
            if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                allparts[descendant] = descendant.Transparency;
                descendant.Transparency = 1;
            end;
        end;

        task.spawn(function() -- Line: 187
            -- upvalues: effs (copy)
            for _, descendant in pairs(effs.Teleport:GetDescendants()) do
                if descendant:GetAttribute("EmitCount") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
    end,

    [6.966666666666667] = function(p30, p31, p32) -- Line: 198
        local _ = p30.Character.HumanoidRootPart;
        local Cache = p30.Cache;
        local allparts = Cache.allparts;

        for i, v in allparts do
            i.Transparency = v;
        end;

        table.clear(allparts);
        local effs = Cache.effs;
        task.spawn(function() -- Line: 210
            -- upvalues: effs (copy)
            for _, descendant in pairs(effs["BEAM WINDS"]:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end);
        task.spawn(function() -- Line: 220
            -- upvalues: effs (copy)
            for _, descendant in pairs(effs.Appear:GetDescendants()) do
                if descendant:GetAttribute("EmitCount") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
    end,

    [11.966666666666667] = function(p33) -- Line: 233
        local Cache = p33.Cache;
        Cache.effs:Destroy();
        Cache.effs = nil;
    end
};