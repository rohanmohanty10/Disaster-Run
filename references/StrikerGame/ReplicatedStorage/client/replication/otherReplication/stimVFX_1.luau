 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
game:GetService("RunService");
game:GetService("UserInputService");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
game:GetService("SoundService");
game:GetService("TextService");
game:GetService("ContentProvider");
local v1 = {};
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local _ = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local _ = Lighting.Brightness;
local _ = Lighting.ClockTime;
local _ = Lighting.Ambient;
local _ = Lighting.ExposureCompensation;
local _ = Lighting.Bloom.Threshold;
local _ = Lighting.EnvironmentDiffuseScale;
local _ = Lighting.EnvironmentSpecularScale;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;
require(script.Parent.Parent.MeshEmitter);
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
local mainreplication = require(script.Parent.Parent.mainreplication);
require(script.Parent.Parent.TekrinnDialogue);
local BackgroundHighlight = require(script.Parent.Parent.BackgroundHighlight);

function v1.characterImage(p2) -- Line: 44
    -- upvalues: BackgroundHighlight (copy)
    BackgroundHighlight(p2);
end;

local function emitall(p3, p4) -- Line: 46
    if not p3 then
        return;
    end;

    for _, descendant in pairs(p3:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(p4 or descendant:GetAttribute("EmitCount"));
        end;
    end;
end;

local function enableall(u5, p6, p7) -- Line: 55
    if not u5 then
        return;
    end;

    for _, descendant in pairs(u5:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    if p6 then
        for _, descendant in pairs(u5:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 65
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        return;
    end;

    task.delay(p7, function() -- Line: 71
        -- upvalues: u5 (copy)
        if not u5 then
            return;
        end;

        for _, descendant in pairs(u5:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
end;

local function makeweld(p8, p9, p10, p11) -- Line: 82
    local Weld = Instance.new("Weld");
    Weld.Parent = p8;
    Weld.Part0 = p9;
    Weld.Part1 = p10;

    if p11 then
        Weld.C0 = p11;
    end;
end;

function v1.ReaderShot(p12, p13) -- Line: 94
    -- upvalues: ReplicatedStorage (copy), mainreplication (copy), Debris (copy), emitall (copy)
    local v14 = p12.HumanoidRootPart or p12.PrimaryPart;
    local Resources = ReplicatedStorage.Resources;
    mainreplication.cameraShake(12, 3, 6);
    mainreplication.fov(false, 80);
    mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    local v15 = Resources.TextParticle:Clone();
    local CFrame_new_ret = CFrame.new(0, -5, 1);
    local Weld = Instance.new("Weld");
    Weld.Parent = v15;
    Weld.Part0 = v15;
    Weld.Part1 = v14;

    if CFrame_new_ret then
        Weld.C0 = CFrame_new_ret;
    end;

    v15.Parent = p12;
    Debris:AddItem(v15, 5);
    emitall(v15, 1);
end;

function v1.ReaderSlide(p16, p17) -- Line: 110
    -- upvalues: ReplicatedStorage (copy), mainreplication (copy)
    local v18 = p16.HumanoidRootPart or p16.PrimaryPart;
    local _ = ReplicatedStorage.Resources;
    mainreplication.cameraShake(12, 3, 6);
    mainreplication.bodyVelocity(v18, 250, 2, nil, nil, nil, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
end;

return v1;