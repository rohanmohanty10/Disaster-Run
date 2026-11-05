  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 7
    -- upvalues: TweenService (copy), EffectsHandler (copy), AssetHandler (copy)
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");
    local v2 = p1.Name .. "/" .. os.clock();

    if p1:GetAttribute("EffectCD") then
        return;
    end;

    local v3 = next;
    local v4, v5 = p1:GetDescendants();

    for _, v in v3, v4, v5 do
        if v.Name ~= "HumanoidRootPart" then
            if v:IsA("BasePart") or (v:IsA("Decal") or v:IsA("Texture")) then
                v:SetAttribute("OldTransparency", v.Transparency);
                TweenService:Create(v, TweenInfo.new(0.1), {
                    Transparency = 1
                }):Play();
            elseif (v:IsA("ParticleEmitter") or (v:IsA("Trail") or v:IsA("Beam"))) and v.Enabled ~= false then
                v.Enabled = false;
                v:SetAttribute("WasEnabled", true);
            end;
        end;
    end;

    EffectsHandler.CallEffect("Enable Particles", {
        Enabled = true,
        Parent = HumanoidRootPart,
        Offset = CFrame.identity,
        ReferencePart = AssetHandler.GetAsset("Particles/Soru", {
            AbilityName = "Hito Model: Nika"
        }),
        Id = v2
    });

    while p1.Parent and p1:GetAttribute("Quickstepping") do
        task.wait();
    end;

    if not p1.Parent then
        return;
    end;

    EffectsHandler.CallEffect("Enable Particles", {
        Id = v2
    });
    local v6 = next;
    local v7, v8 = p1:GetDescendants();

    for _, v in v6, v7, v8 do
        if (v:IsA("BasePart") or (v:IsA("Decal") or v:IsA("Texture"))) and v:GetAttribute("OldTransparency") then
            local v9 = v:GetAttribute("OldTransparency");
            v:SetAttribute("OldTransparency", nil);
            TweenService:Create(v, TweenInfo.new(0.1), {
                Transparency = v9
            }):Play();
        elseif (v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Beam"))) and v:GetAttribute("WasEnabled") then
            v.Enabled = true;
            v:SetAttribute("WasEnabled", nil);
        end;
    end;
end;