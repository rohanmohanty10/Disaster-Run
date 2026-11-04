 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");
local u1 = {};

local function Ghost(p2) -- Line: 16
    -- upvalues: u1 (copy), VfxManager (copy)
    if u1[p2] then
        return;
    end;

    u1[p2] = {};
    local v3 = { p2:FindFirstChild("BALL", true), p2:FindFirstChild("PlrBall") };
    local Highlight = Instance.new("Highlight", p2);
    Highlight.Name = script.Name .. "Highlight";
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(29, 255, 138);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    VfxManager.DestroyEffect(Highlight, 10);

    for _, descendant in pairs(p2:GetDescendants()) do
        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Shirt") or descendant:IsA("Pants"))))) then
            if descendant.Name ~= "HumanoidRootPart" and not (table.find(v3, descendant) or descendant:GetAttribute("Invis")) then
                descendant:SetAttribute("Invis", true);

                if descendant:IsA("BasePart") then
                    local v4 = descendant:FindFirstChildOfClass("SpecialMesh");
                    local v5;

                    if v4 then
                        v5 = v4.TextureId;
                        v4.TextureId = "";
                    else
                        v5 = nil;
                    end;

                    u1[p2][descendant] = {
                        Color = descendant.Color,
                        Material = descendant.Material,
                        TextureId = v5
                    };
                    descendant.Color = Color3.fromRGB(17, 152, 84);
                    descendant.Material = Enum.Material.Neon;
                    descendant.LocalTransparencyModifier = 0.7;
                elseif descendant:IsA("Shirt") or descendant:IsA("Pants") then
                    u1[p2][descendant] = {
                        Color = descendant.Color3
                    };
                    descendant.Color3 = Color3.fromRGB(17, 152, 84);
                else
                    descendant.LocalTransparencyModifier = 1;
                end;
            end;
        elseif descendant:IsA("SurfaceGui") and not descendant:GetAttribute("Invis") then
            descendant:SetAttribute("Invis", true);
            descendant.Enabled = false;
        end;
    end;
end;

local function Unghost(p6, p7) -- Line: 75
    -- upvalues: u1 (copy)
    if not u1[p6] then
        return;
    end;

    local v8 = { p6:FindFirstChild("BALL", true), p6:FindFirstChild("PlrBall") };
    local v9 = p6:FindFirstChild(script.Name .. "Highlight");

    if v9 then
        v9:Destroy();
    end;

    for _, descendant in pairs(p6:GetDescendants()) do
        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam"))) then
            if descendant.Name ~= "HumanoidRootPart" and (not table.find(v8, descendant) and descendant:GetAttribute("Invis")) then
                descendant:SetAttribute("Invis", nil);
                descendant.LocalTransparencyModifier = 0;
            end;
        elseif descendant:IsA("SurfaceGui") and descendant:GetAttribute("Invis") then
            descendant:SetAttribute("Invis", nil);
            descendant.Enabled = true;
        end;
    end;

    for i, v in pairs(u1[p6]) do
        if i:IsA("BasePart") then
            i.Color = v.Color;
            i.Material = v.Material;
            local v10 = i:FindFirstChildOfClass("SpecialMesh");

            if v10 then
                v10.TextureId = v.TextureId;
            end;
        elseif (i:IsA("Shirt") or i:IsA("Pants")) and i:GetAttribute("Invis") then
            i:SetAttribute("Invis", nil);
            i.Color3 = v.Color;
        end;
    end;

    u1[p6] = nil;
end;

return function(p11, p12) -- Line: 123
    -- upvalues: Debris (copy), VfxManager (copy), SfxManager (copy), ReplicatedStorage (copy), Essentials (copy), Ghost (copy), Unghost (copy)
    local TimeSent = p12.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Character = p12.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Humanoid = Character:FindFirstChild("Humanoid");

    if p12.Task ~= "Spawn" then
        if p12.Task == "Despawn" then
            local v13 = script.Emit:Clone();
            v13.Parent = Debris;
            v13.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, -2.5, 0);
            VfxManager.Emit(v13);
            VfxManager.DestroyEffect(v13, 4);
            SfxManager:playSound({
                Sound = "BBZ Ghost Return To Body",
                Parent = v13
            });
            local v14 = Debris:FindFirstChild(Character.name .. script.Name);

            if v14 then
                v14:Destroy();
            end;

            local v15 = Debris:FindFirstChild(Character.Name .. script.Name .. "Aura");

            if v15 then
                VfxManager.Enable(v15, false);
                VfxManager.DestroyEffect(v15, 2);
            end;

            Unghost(Character);
        end;

        return;
    end;

    local v16 = script.Emit:Clone();
    v16.Parent = Debris;
    v16.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, -2.5, 0);
    VfxManager.Emit(v16);
    VfxManager.DestroyEffect(v16, 4);
    SfxManager:playSound({
        Sound = "BBZ Ghost Out Of Body",
        Parent = v16
    });
    Character.Archivable = true;
    local u17 = Character:Clone();
    Character.Archivable = false;
    u17.Name = Character.Name .. script.Name;
    u17.Parent = Debris;
    VfxManager.DestroyEffect(u17, 10);
    u17.HumanoidRootPart.Anchored = true;
    u17.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;

    for _, v in ipairs(Humanoid.Animator:GetPlayingAnimationTracks()) do
        u17.Humanoid:LoadAnimation(v.Animation):Play(0);
        v:Stop(0.5);
    end;

    local v18 = u17.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.Ghost.OutOfBody);
    v18.Priority = Enum.AnimationPriority.Action3;
    v18:Play(0.5);

    for _, descendant in pairs(u17:GetDescendants()) do
        if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Highlight") or (descendant:IsA("Sound") or (descendant:IsA("SurfaceGui") or (descendant:IsA("Decal") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")))))))) then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") and (descendant.Name == "Basketball" or (descendant.Name == "PlrBall" or descendant.Name == "BALL")) then
            descendant:Destroy();
        end;
    end;

    local Highlight = Instance.new("Highlight", u17);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    local Model = Instance.new("Model", Debris);
    Model.Name = Character.Name .. script.Name .. "Aura";
    VfxManager.DestroyEffect(Model, 14);

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v19 = Character:FindFirstChild(child.Name);

        if v19 then
            local v20 = child:Clone();
            v20.CFrame = v19.CFrame;
            v20.Parent = Model;
            Essentials:Weld(v20, v19);
        end;
    end;

    VfxManager.Enable(Model, true);
    Ghost(Character);
    task.delay(7, function() -- Line: 197
        -- upvalues: u17 (copy), Debris (ref), HumanoidRootPart (copy), VfxManager (ref), Character (copy), Unghost (ref)
        if not (u17 and u17:IsDescendantOf(workspace)) then
            return;
        end;

        local v21 = script.Emit:Clone();
        v21.Parent = Debris;
        v21.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, -2.5, 0);
        VfxManager.Emit(v21);
        VfxManager.DestroyEffect(v21, 4);
        local v22 = Debris:FindFirstChild(Character.name .. script.Name);

        if v22 then
            v22:Destroy();
        end;

        local v23 = Debris:FindFirstChild(Character.Name .. script.Name .. "Aura");

        if v23 then
            VfxManager.Enable(v23, false);
            VfxManager.DestroyEffect(v23, 2);
        end;

        Unghost(Character);
    end);
end;