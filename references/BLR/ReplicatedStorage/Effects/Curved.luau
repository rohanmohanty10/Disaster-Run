  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);

return function(u1) -- Line: 10
    -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
    task.delay(1.25, function() -- Line: 11
        -- upvalues: ReplicatedStorage (ref), u1 (ref), VfxManager (ref)
        local u2 = ReplicatedStorage.Assets.Vfx.HioriImpact:Clone();
        u2.Parent = workspace;
        u2.Anchored = true;
        u2.CFrame = u1.Plr.Character.HumanoidRootPart.CFrame * CFrame.new(-0.15, -1.2, -2);
        VfxManager.Emit(u2);
        task.delay(2, function() -- Line: 17
            -- upvalues: u2 (copy)
            u2:Destroy();
        end);
    end);
    task.spawn(function() -- Line: 20
        -- upvalues: ReplicatedStorage (ref), u1 (ref)
        local Descendants = ReplicatedStorage.Assets.Auras.Ice.Particles:GetDescendants();
        local v3 = {};

        for _, v in pairs(Descendants) do
            if v:IsA("ParticleEmitter") == false then
                if v:IsA("Highlight") then
                    local v4 = v:Clone();
                    v4.Name = "FlowParticle";
                    v4.Parent = u1.Plr.Character;
                end;
            elseif not v3[v.Parent] then
                if v.Parent:IsA("Attachment") then
                    v3[v.Parent] = true;
                    local v5 = v.Parent:Clone();
                    v5.Name = "FlowParticle";
                    v5.Parent = u1.Plr.Character[v.Parent.Parent.Name];
                else
                    local v6 = v:Clone();
                    v6.Name = "FlowParticle";
                    v6.Parent = u1.Plr.Character[v.Parent.Name];
                end;
            end;
        end;

        table.clear(v3);
        table.clear(Descendants);
    end);
    task.delay(3, function() -- Line: 56
        -- upvalues: u1 (ref)
        task.spawn(function() -- Line: 58
            -- upvalues: u1 (ref)
            local Descendants = u1.Plr.Character:GetDescendants();

            for _, v in pairs(Descendants) do
                if v ~= nil and (v.Parent ~= nil and (v.Name == "FlowParticle" or v.Parent.Name == "FlowParticle")) then
                    if v.Parent:IsA("Attachment") then
                        v.Parent:Destroy();
                    else
                        v:Destroy();
                    end;
                end;
            end;

            table.clear(Descendants);
            table.clear(u1);
            u1 = nil;
        end);
    end);
end;