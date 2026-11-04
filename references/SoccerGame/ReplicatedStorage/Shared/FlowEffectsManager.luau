  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Assets = ReplicatedStorage.Assets;
local Trove = require(ReplicatedStorage.Shared.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local LoadParticleRig = require(ReplicatedStorage.Shared.LoadParticleRig);
local getFlowData = require(ReplicatedStorage.Shared.utils.getFlowData);

return {
    Load = function(p1: table, u2: userdata, u3: string, p4: boolean) -- Line: 13, Name: Load
        -- upvalues: Trove (copy), getFlowData (copy), ReplicatedStorage (copy), Essentials (copy), VfxManager (copy), Assets (copy), LoadParticleRig (copy)
        local u5 = Trove.new();
        local u6 = getFlowData(u3);
        local v7 = ReplicatedStorage.Assets.Auras:FindFirstChild(u3);

        if not v7 and (u6 and u6.AuraFallback) then
            v7 = ReplicatedStorage.Assets.Auras:FindFirstChild(u6.AuraFallback);
        end;

        if p4 then
            local v8;

            if v7 then
                v8 = v7.Activate:Clone();
            else
                local v9;

                if u6 then
                    v9 = u6.Color;
                else
                    v9 = u6;
                end;

                if not v9 then
                    v9 = Color3.fromRGB(255, 255, 255);
                    warn((`[WARNING]: No color for flow {u3}`));
                end;

                v8 = ReplicatedStorage.Assets.Auras.BaseActivateEffect:Clone();

                for _, descendant in v8:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ColorSequence.new(v9, Color3.fromRGB(v9.R * 0.7, v9.G * 0.7, v9.B * 0.7));
                    end;
                end;
            end;

            v8.Transparency = 1;
            v8.Parent = u2.HumanoidRootPart;
            v8.CFrame = u2.HumanoidRootPart.CFrame;
            task.delay(2, v8.Destroy, v8);
            Essentials:WeldOffset(u2.HumanoidRootPart, v8, CFrame.new(0, -3.2, 0) * CFrame.fromEulerAnglesXYZ(0, 0, -1.5707963267948966));
            VfxManager.Emit(v8);
            u5:Add(v8);
        end;

        if u6 and (u6.VFXId and u6.VFXId ~= "") then
            local u10 = Assets.CharacterParticleRigs:FindFirstChild(u6.VFXId);
            local v11 = false;

            if u10 then
                local v12;
                v11, v12 = pcall(function() -- Line: 61
                    -- upvalues: u10 (copy), u6 (copy), u3 (copy), u5 (copy), LoadParticleRig (ref), u2 (copy)
                    local v13 = u10:Clone();

                    if u6.PreVFX then
                        u6.PreVFX(v13, u3, u6, u5);
                    end;

                    u5:Add((LoadParticleRig(u2, v13)));

                    if u6.PostVFX then
                        u6.PostVFX(u2, u3, u6, u5);
                    end;
                end);

                if not v11 then
                    warn((`[FlowEffectsManager]: particle rig "{u6.VFXId}" failed for flow {u3}, falling back to legacy aura: {v12}`));
                end;
            else
                warn((`[FlowEffectsManager]: missing particle rig "{u6.VFXId}" for flow {u3}, falling back to legacy aura`));
            end;

            if v11 then
                return u5;
            end;
        end;

        if not v7 then
            return u5;
        end;

        for _, child in v7.Particles:Clone():GetChildren() do
            if u2:FindFirstChild(child.Name) then
                local v14 = child;

                for _, child2 in child:GetChildren() do
                    child2.Parent = u2[v14.Name];
                    u5:Add(child2);
                end;
            end;
        end;

        if u3 == "Destructive Impulses" then
            local v15 = ReplicatedStorage.Assets.Vfx.ProdigyBeams.Beams:Clone();
            v15.Parent = u2:FindFirstChild("HumanoidRootPart");
            local u16 = ReplicatedStorage.Assets.Vfx.RinLifeOnTheLine.Attachment:Clone();
            u16.Parent = u2:FindFirstChild("HumanoidRootPart");
            u16.PlayFirst.ParticleEmitter:Emit(1);
            task.delay(0.3, function() -- Line: 108
                -- upvalues: u16 (copy)
                if not u16:IsDescendantOf(workspace) then
                    return;
                end;

                u16.PlaySecond.ParticleEmitter:Emit(1);
            end);

            for _, child in ReplicatedStorage.Assets.Auras["Destructive Impulses"].Extra:GetChildren() do
                local v17 = u2:FindFirstChild(child.Name);

                if v17 then
                    local v18 = child:Clone();
                    v18.Parent = v17;
                    v18.CFrame = v17.CFrame;
                    Essentials:Weld(v17, v18);
                    u5:Add(v18);
                end;
            end;

            u5:Add(v15);
            u5:Add(u16);
        end;

        if u3 == "Godspeed" then
            for _, child in ReplicatedStorage.Assets.Auras.Godspeed.Extra:GetChildren() do
                local v19 = u2:FindFirstChild(child.Name);

                if v19 then
                    local v20 = child:Clone();
                    v20.Parent = v19;
                    v20.CFrame = v19.CFrame;
                    Essentials:Weld(v19, v20);
                    u5:Add(v20);
                end;
            end;
        end;

        return u5;
    end
};