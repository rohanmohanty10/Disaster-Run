  

 

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local LimbColors = require(script.LimbColors);

local function Quad(p1, p2, p3, p4) -- Line: 13
    return p1:Lerp(p2, p4):Lerp(p2:Lerp(p3, p4), p4);
end;

local function NumLerp(p5, p6, p7) -- Line: 19
    return p5 + (p6 - p5) * p7;
end;

local function Rng(p8, p9) -- Line: 24
    return Random.new():NextNumber(p8, p9);
end;

return function(u10, p11) -- Line: 28
    -- upvalues: LimbColors (copy), Rng (copy), TweenService (copy), EffectsHandler (copy), AssetHandler (copy), CollectionService (copy)
    local v12 = p11 or {};
    local u13 = v12.RelativePart or u10:FindFirstChild("HumanoidRootPart");

    if not u13 then
        return;
    end;

    local v14 = os.clock();
    local v15 = v12.Arms or {
        Left = script.Left,
        Right = script.Right
    };
    local Left = v15.Left;
    local Right = v15.Right;

    local function GetOffset(p16) -- Line: 47
        return p16 == 0 and CFrame.new(-2, 0, 0) or CFrame.new(2, 0, 0);
    end;

    local function Create(p17) -- Line: 51
        -- upvalues: Right (copy), Left (copy), u13 (copy), u10 (copy), LimbColors (ref), Rng (ref), TweenService (ref), EffectsHandler (ref)
        local u18 = u13.CFrame * CFrame.new(0, 0, -2) * (p17 == 0 and CFrame.new(-2, 0, 0) or CFrame.new(2, 0, 0));
        local u19 = u13.CFrame * CFrame.new(0, 0, -9);
        local u20 = (p17 == 1 and Right or Left):Clone();
        u20.Parent = workspace.Effects;
        u20:PivotTo(u18);
        u20.Anchored = true;
        local v21 = p17 == 0 and "Right Arm" or (p17 == 1 and "Left Arm" or "");
        u20.Color = u10:FindFirstChild(v21).Color;

        if u10:GetAttribute("NPC") then
            u20.Color = LimbColors.DefaultCosmeticModel["Right Arm"];
        elseif u10:GetAttribute("CosmeticsOn") then
            u20.Color = LimbColors.DefaultCosmeticModel[v21];
        end;

        if u10:GetAttribute("Busoshoku") then
            u20.Color = Color3.fromRGB(0, 0, 0);
            u20.Material = Enum.Material.Neon;
            local Highlight = Instance.new("Highlight");
            Highlight.OutlineColor = Color3.fromHex(u10:GetAttribute("Busoshoku"));
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.FillTransparency = 1;
            Highlight.Parent = u20;
        end;

        local v22 = u18:Lerp(u19, 0.5);
        local Magnitude = (u18.Position - u19.Position).Magnitude;
        local u23 = v22 * CFrame.new(p17 == 1 and Random.new():NextNumber(0, 5) or Random.new():NextNumber(-5, 0), Random.new():NextNumber(-4, 4), Rng(-Magnitude / 3, Magnitude / 3));
        local u24 = u18;
        task.delay(0.1, function() -- Line: 104
            -- upvalues: TweenService (ref), u20 (copy)
            TweenService:Create(u20, TweenInfo.new(0.05), {
                Size = Vector3.new(0, 0, 0)
            }):Play();
            task.delay(0.2, u20.Destroy, u20);
        end);
        task.spawn(function() -- Line: 109
            -- upvalues: u18 (copy), u23 (ref), u19 (copy), u20 (copy), u24 (ref), EffectsHandler (ref)
            for i = 0, 6.25 do
                local v25 = i / 6.25;
                local v26 = u23;
                local v27 = u18:Lerp(v26, v25):Lerp(v26:Lerp(u19, v25), v25);
                u20:PivotTo(CFrame.new(u24.Position, v27.Position));
                u24 = v27;
                EffectsHandler.Wait();
            end;

            task.delay(0.25, function() -- Line: 120
                -- upvalues: u20 (ref), EffectsHandler (ref)
                local v28 = next;
                local v29, v30 = u20:GetDescendants();
                local v31 = nil;

                for _, v in v28, v29, v30 do
                    if v:IsA("ParticleEmitter") then
                        v.Enabled = false;
                        v31 = v.Lifetime.Max;
                    end;
                end;

                EffectsHandler.Wait(v31);
                u20:Destroy();
            end);
        end);
    end;

    local v32 = 0;
    local v33 = u10:GetAttribute("Busoshoku") or "FF0000";
    local v34 = u10:GetAttribute("Busoshoku") and AssetHandler.GetAsset("Particles/HawkGatling", {
        AbilityName = "Hito Model: Nika",
        SkinName = v12.SkinName
    }) or AssetHandler.GetAsset("Particles/Gear1/Gatling/BarrageFX", {
        AbilityName = "Gomu",
        SkinName = v12.SkinName
    });

    if v33 then
        v33 = Color3.fromHex(v33);
    end;

    local HumanoidRootPart = u10.HumanoidRootPart;

    if HumanoidRootPart then
        task.spawn(EffectsHandler.CallEffect, "Enable Particles", {
            Enabled = true,
            Parent = HumanoidRootPart,
            Offset = CFrame.new(0, 0, -2) * CFrame.Angles(0, 3.141592653589793, 0),
            ReferencePart = v34,
            Id = v14,
            AttributeColors = {
                Haki = v33
            }
        });
    end;

    repeat
        Create(v32);
        v32 = v32 == 0 and 1 or 0;
        EffectsHandler.Wait(0.01);
    until not (CollectionService:HasTag(u10, "Barraging") and (u10.Parent and u10));

    EffectsHandler.CallEffect("Enable Particles", {
        Id = v14
    });
end;