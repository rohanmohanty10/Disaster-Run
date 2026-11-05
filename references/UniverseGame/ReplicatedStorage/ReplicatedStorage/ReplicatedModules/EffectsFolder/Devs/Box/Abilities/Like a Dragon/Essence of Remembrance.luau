  

 

local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
game:GetService("TweenService");
local PathShortcuts = require(ReplicatedModules.PathShortcuts);
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Sequence_V2 = require(ReplicatedModules.Classes.Sequence_V2);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.KnitPath.TableUtil);
local Trove = require(PathShortcuts.KnitPath.Trove);

return function(p1) -- Line: 12
    -- upvalues: AssetHandler (copy), Trove (copy), ParticleHandler (copy), Sequence_V2 (copy)
    local Attacker = p1.Attacker;
    local _ = p1.Target;
    local v2 = p1.MoveData or {};
    local u3 = {};
    local u4 = AssetHandler.GetAsset("Particles/Remembrance", v2);
    local u5 = AssetHandler.GetAsset("Particles/Remembrance/Beginning", v2);
    local u6 = Trove.new();
    local u46 = Sequence_V2.CreateFromOldSequence({
        Frames = {
            { 0, function(p7, p8) -- Line: 25
                    -- upvalues: u5 (copy), Attacker (copy), u3 (copy), ParticleHandler (ref)
                    local v9 = u5.SmokeEnabled:Clone();
                    v9.CFrame = Attacker.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0) * CFrame.Angles(1.5707963267948966, 0, 0);
                    v9.Parent = workspace.Effects;
                    u3.SmokeParticle = v9;
                    ParticleHandler.EnableParticles(v9, true);
                end },
            { 65, function(p10, p11) -- Line: 35
                    -- upvalues: u5 (copy), Attacker (copy), u3 (copy), ParticleHandler (ref)
                    local v12 = u5.Sigil:Clone();
                    v12.CFrame = Attacker.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966);
                    v12.Parent = workspace.Effects;
                    u3.Sigil = v12;
                    ParticleHandler.EnableParticles(v12, true);
                end },
            { 135, function(p13, p14) -- Line: 45
                    -- upvalues: ParticleHandler (ref), u3 (copy)
                    ParticleHandler.EnableParticles(u3.Sigil, false);
                end },
            { 285, function(p15, p16) -- Line: 49
                    -- upvalues: ParticleHandler (ref), u3 (copy)
                    ParticleHandler.EnableParticles(u3.SmokeParticle, false);
                end },
            { 377, function(p17, p18) -- Line: 53
                    -- upvalues: u4 (copy), Attacker (copy), u3 (copy), ParticleHandler (ref)
                    local v19 = u4.FirstBrance.HandAuraCharge:Clone();
                    v19.CFrame = Attacker["Right Arm"].CFrame * CFrame.new(0, -1, 0);
                    v19.Parent = workspace.Effects;
                    u3.AuraCharge = v19;
                    ParticleHandler.AttachTo(v19, {
                        MakePartP0 = true,
                        Part = Attacker["Right Arm"],
                        C0 = CFrame.new(0, -1, 0)
                    });
                    ParticleHandler.EnableParticles(v19, true);
                    local v20 = u4.FirstBrance.DragonSigilBack:Clone();
                    v20.CFrame = Attacker.Torso.CFrame * CFrame.new(0, 1, 1.5) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966);
                    v20.Parent = workspace.Effects;
                    ParticleHandler.EnableParticles(v20, true);
                    u3.FirstSigil = v20;
                    local v21 = u4.FirstBrance.AuraEnabled:Clone();
                    v21.CFrame = Attacker.Torso.CFrame * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966);
                    v21.Parent = workspace.Effects;
                    ParticleHandler.AttachTo(v21, {
                        MakePartP0 = true,
                        Part = Attacker.Torso,
                        C0 = CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966)
                    });
                    ParticleHandler.EnableParticles(v21, true);
                    u3.FirstAura = v21;
                end },
            { 468, function(p22, p23) -- Line: 93
                    -- upvalues: ParticleHandler (ref), u3 (copy)
                    ParticleHandler.EnableParticles(u3.FirstSigil, false);
                end },
            { 545, function(p24, p25) -- Line: 97
                    -- upvalues: ParticleHandler (ref), u3 (copy)
                    ParticleHandler.EnableParticles(u3.AuraCharge, false);
                end },
            { 686, function(p26, p27) -- Line: 101
                    -- upvalues: ParticleHandler (ref), u3 (copy)
                    ParticleHandler.EnableParticles(u3.FirstAura, false);
                end },
            { 723, function(p28, p29) -- Line: 105
                    -- upvalues: u4 (copy), Attacker (copy), ParticleHandler (ref), u3 (copy)
                    local v30 = u4.SecondBrance.DragonSigilBack:Clone();
                    v30.CFrame = Attacker.Torso.CFrame * CFrame.new(0, 1, 1.5) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966);
                    v30.Parent = workspace.Effects;
                    ParticleHandler.EnableParticles(v30, true);
                    u3.SecondSigil = v30;
                    local v31 = u4.SecondBrance.AuraEnabled:Clone();
                    v31.CFrame = Attacker.Torso.CFrame * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966);
                    v31.Parent = workspace.Effects;
                    ParticleHandler.AttachTo(v31, {
                        MakePartP0 = true,
                        Part = Attacker.Torso,
                        C0 = CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966)
                    });
                    ParticleHandler.EnableParticles(v31, true);
                    u3.SecondAura = v31;
                end },
            { 773, function(p32, p33) -- Line: 130
                    -- upvalues: ParticleHandler (ref), u3 (copy)
                    ParticleHandler.EnableParticles(u3.SecondSigil, false);
                end },
            { 953, function(p34, p35) -- Line: 134
                    -- upvalues: ParticleHandler (ref), u3 (copy)
                    ParticleHandler.EnableParticles(u3.SecondAura, false);
                end },
            { 1058, function(p36, p37) -- Line: 138
                    -- upvalues: u4 (copy), Attacker (copy), ParticleHandler (ref), u3 (copy)
                    local v38 = u4.ThirdBrance.KoiSigil:Clone();
                    v38.CFrame = Attacker.HumanoidRootPart.CFrame * CFrame.new(-2, 1, 2) * CFrame.Angles(0, -2.443460952792061, 1.5707963267948966);
                    v38.Parent = workspace.Effects;
                    ParticleHandler.EnableParticles(v38, true);
                    u3.ThirdSigil = v38;
                    local v39 = u4.ThirdBrance.AuraEnabled:Clone();
                    v39.CFrame = Attacker.Torso.CFrame * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966);
                    v39.Parent = workspace.Effects;
                    ParticleHandler.AttachTo(v39, {
                        MakePartP0 = true,
                        Part = Attacker.Torso,
                        C0 = CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966)
                    });
                    ParticleHandler.EnableParticles(v39, true);
                    u3.ThirdAura = v39;
                end },
            { 1108, function(p40, p41) -- Line: 163
                    -- upvalues: ParticleHandler (ref), u3 (copy)
                    ParticleHandler.EnableParticles(u3.ThirdSigil, false);
                end },
            { 1450, function(p42, p43) -- Line: 167
                    -- upvalues: ParticleHandler (ref), u3 (copy)
                    ParticleHandler.EnableParticles(u3.ThirdAura, false);
                end },
            { 1500, function(p44, p45) -- Line: 171
                end }
        }
    });
    u46:Play();
    u6:Add(function() -- Line: 181
        -- upvalues: u3 (copy)
        for _, v in u3 do
            if v:IsA("BasePart") then
                v:Destroy();
            end;
        end;

        table.clear(u3);
    end);
    u6:Add(Attacker.AncestryChanged:Connect(function() -- Line: 191
        -- upvalues: Attacker (copy), u46 (copy), u6 (copy)
        if Attacker.Parent == nil then
            u46:Stop();
            u6:Destroy();
        end;
    end));
end;