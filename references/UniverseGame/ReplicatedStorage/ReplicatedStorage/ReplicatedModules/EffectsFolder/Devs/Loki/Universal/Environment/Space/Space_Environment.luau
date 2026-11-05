  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local _ = ReplicatedStorage.ReplicatedRoot;
require(ReplicatedStorage.ReplicatedModules.Types);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local u1 = nil;

local function _(p2, p3) -- Line: 22
    return Random.new():NextNumber(p2, p3);
end;

local function TweenCallback(p4, p5, u6, p7, p8, p9, p10, p11, p12) -- Line: 26
    -- upvalues: TweenService (copy)
    local v13 = TweenService:Create(p4, TweenInfo.new(p7 or 0.5, p8 or Enum.EasingStyle.Quad, p9 or Enum.EasingDirection.Out, p10 or 0, p11 or false, p12 or 0), p5);
    v13.Completed:Once(function() -- Line: 36
        -- upvalues: u6 (copy)
        if u6 then
            u6();
        end;
    end);
    v13:Play();
end;

local LocalPlayer = Players.LocalPlayer;

return function(p14, p15) -- Line: 50
    -- upvalues: u1 (ref), Trove (copy), Lighting (copy), EffectsHandler (copy), LocalPlayer (copy), TweenCallback (copy)
    if not p14 then
        if u1 then
            u1:Destroy();
            u1 = nil;
        end;

        return;
    end;

    local u16 = Trove.new();
    local u17 = true;
    u16:Add(function() -- Line: 62
        -- upvalues: u17 (ref)
        u17 = false;
    end);
    u1 = u16;
    task.spawn(function() -- Line: 68
        -- upvalues: Lighting (ref), EffectsHandler (ref), u16 (copy), LocalPlayer (ref), TweenCallback (ref), u17 (ref)
        local SpaceSky = Lighting:WaitForChild("SpaceSky", 4.5);

        if not SpaceSky then
            warn("No sky");

            return;
        end;

        local SpaceAtmosphere = Lighting:FindFirstChild("SpaceAtmosphere");
        local u18 = EffectsHandler.CallEffect("Ambience Music", {
            Sound = "rbxassetid://133255572552527",
            Volume = 0.25,
            TweenInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        });
        local u19 = u16:Extend();
        u19:Add((EffectsHandler.CallEffect("Ambience Music", {
            Sound = "rbxassetid://112559244744673",
            Volume = 0.2,
            TweenInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        })));
        u16:Connect(LocalPlayer:GetAttributeChangedSignal("NoAmbienceMusic"), function() -- Line: 90
            -- upvalues: LocalPlayer (ref), u18 (copy)
            local v20 = LocalPlayer:GetAttribute("NoAmbienceMusic") ~= nil;
            u18.Volume:set(v20 and 0 or 0.25);
        end);

        if SpaceAtmosphere then
            u16:Connect(LocalPlayer:GetAttributeChangedSignal("CurrentBiome"), function() -- Line: 96
                -- upvalues: LocalPlayer (ref), u19 (copy), SpaceAtmosphere (copy), EffectsHandler (ref), TweenCallback (ref)
                local v21 = LocalPlayer:GetAttribute("CurrentBiome");
                u19:Destroy();

                if SpaceAtmosphere.Name ~= "SpaceAtmosphere" then
                    return;
                end;

                u19:Add((EffectsHandler.CallEffect("Ambience Music", {
                    Volume = 0.2,
                    Sound = v21 == "Delta" and "rbxassetid://118393284494045" or (v21 == "Crystal" and "rbxassetid://83382463833670" or "rbxassetid://112559244744673"),
                    TweenInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                })));
                local v22 = v21 == "Delta";
                local v23 = {
                    Offset = 0.25,
                    Glare = 0,
                    Density = v22 and 0.54 or 0.3
                };
                local v24;

                if v22 then
                    v24 = Color3.fromRGB(176, 255, 139);
                else
                    v24 = Color3.new(0.78, 0.78, 0.78);
                end;

                v23.Color = v24;
                v23.Haze = v22 and 3 or 0;
                TweenCallback(SpaceAtmosphere, v23, nil, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            end);
        end;

        u16:Add(u18);
        local _ = workspace.Gravity;
        workspace.Gravity = 110;
        u16:Add(function() -- Line: 139
            workspace.Gravity = 196.2;
        end);
        local v25 = 0;

        while u17 do
            v25 = v25 + task.wait();

            if not u17 then
                break;
            end;

            SpaceSky.SkyboxOrientation = vector.create(0, v25 * 1, 0);
        end;
    end);
end;