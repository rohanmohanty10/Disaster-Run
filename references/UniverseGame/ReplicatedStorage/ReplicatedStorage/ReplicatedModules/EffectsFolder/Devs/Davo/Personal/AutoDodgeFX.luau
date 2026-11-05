  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 10
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.KnitPath.Trove);
end);

return function(u2) -- Line: 14
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), u1 (ref), TweenService (copy)
    local HumanoidRootPart = u2:FindFirstChild("HumanoidRootPart");
    local u3 = u2.Name .. "/" .. os.clock();
    EffectsHandler.CallEffect("Afterimage", {
        Duration = 0.69,
        Speed = 0.69,
        Brightness = 1,
        Lifetime = 0.69,
        Transparency = 0.25,
        BypassTransparency = true,
        Whitelist = { u2 },
        Blacklist = { "ParticleEmitter", "Stand", "Highlight" }
    });
    EffectsHandler.CallEffect("Enable Particles", {
        Enabled = true,
        Parent = HumanoidRootPart,
        Offset = CFrame.identity,
        ReferencePart = AssetHandler.GetAsset("Particles/Soru", {
            AbilityName = "Hito Model: Nika"
        }),
        Id = u3
    });
    task.delay(0.1, function() -- Line: 37
        -- upvalues: EffectsHandler (ref), u3 (copy)
        EffectsHandler.CallEffect("Enable Particles", {
            Id = u3
        });
    end);

    if u2:GetAttribute("VanishingHookFX") then
        u2:SetAttribute("VanishFXUpdate", true);

        return;
    end;

    u2:SetAttribute("VanishingHookFX", true);
    local u4 = u1.new();
    local u5 = nil;
    local u6 = u2:GetDescendants();

    local function UpdateThread() -- Line: 51
        -- upvalues: u4 (copy), u5 (ref)
        if not u4 then
            return;
        end;

        if u5 then
            task.cancel(u5);
        end;

        u5 = task.delay(0.225, function() -- Line: 56
            -- upvalues: u4 (ref)
            u4:Destroy();
        end);
    end;

    u4:Connect(u2:GetAttributeChangedSignal("VanishFXUpdate"), function() -- Line: 61
        -- upvalues: u2 (copy), u4 (copy), u5 (ref)
        if u2:GetAttribute("VanishFXUpdate") then
            u2:SetAttribute("VanishFXUpdate", nil);

            if not u4 then
                return;
            end;

            if u5 then
                task.cancel(u5);
            end;

            u5 = task.delay(0.225, function() -- Line: 56
                -- upvalues: u4 (ref)
                u4:Destroy();
            end);
        end;
    end);
    u4:Add(function() -- Line: 68
        -- upvalues: u6 (copy), TweenService (ref), u2 (copy)
        for _, v in u6 do
            local v7;

            if v then
                v7 = v:GetAttribute("VanishFXTransparency");
            else
                v7 = v;
            end;

            if v7 then
                if typeof(v7) == "number" then
                    local v8 = TweenService:Create(v, TweenInfo.new(0.25), {
                        Transparency = v7
                    });
                    v8:Play();
                    v8.Completed:Once(function() -- Line: 76
                        -- upvalues: v (copy)
                        if v then
                            v:SetAttribute("VanishFXRealTransparency", nil);
                        end;
                    end);
                    v:SetAttribute("VanishFXRealTransparency", v7);
                else
                    v.Enabled = v7;
                end;

                v:SetAttribute("VanishFXTransparency", nil);
            end;
        end;

        u2:SetAttribute("VanishingHookFX", nil);
        table.clear(u6);
    end);

    if u4 then
        if u5 then
            task.cancel(u5);
        end;

        u5 = task.delay(0.225, function() -- Line: 56
            -- upvalues: u4 (copy)
            u4:Destroy();
        end);
    end;

    for _, v in u6 do
        if v:IsA("BasePart") or (v:IsA("Decal") or v:IsA("Texture")) then
            v:SetAttribute("VanishFXTransparency", v:GetAttribute("VanishFXRealTransparency") or v.Transparency);
            v:SetAttribute("VanishFXRealTransparency", nil);
            TweenService:Create(v, TweenInfo.new(0.1), {
                Transparency = v.Transparency + 0.25
            }):Play();
        elseif (v:IsA("ParticleEmitter") or (v:IsA("Trail") or v:IsA("Beam"))) and v.Enabled then
            v.Enabled = false;

            if v:IsA("ParticleEmitter") then
                v:Clear();
            end;

            v:SetAttribute("VanishFXTransparency", true);
        end;
    end;
end;