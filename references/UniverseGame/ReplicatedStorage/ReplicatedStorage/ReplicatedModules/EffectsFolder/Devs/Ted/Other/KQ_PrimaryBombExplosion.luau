  

 

local TweenService = game:GetService("TweenService");
local _ = game.ReplicatedStorage["Client Assets"];
local Debris = game:GetService("Debris");
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");
local AssetHandler = require(ReplicatedModules.ReplicatedLibrary.AssetHandler);
local SoundGroups = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));

local function CreateInstance(p2, p3) -- Line: 14
    local function CheckProperty(p4, p5) -- Line: 16
        local _ = p4[p5];
    end;

    local u6 = Instance.new(p2);

    for i, v in pairs(p3) do
        if pcall(function() -- Line: 23
            -- upvalues: u6 (copy), i (copy)
            local _ = u6[i];
        end) then
            u6[i] = v;
        end;
    end;

    return u6;
end;

local function LoopParticle(p7, p8, p9) -- Line: 32
    for _, v in pairs(p7) do
        if v:IsA("ParticleEmitter") then
            if p8 then
                v:Emit(v:GetAttribute("EmitCount") or 1);
            end;

            if p9 then
                v.Enabled = p9;
            end;
        end;
    end;
end;

local function EmitParticle(p10, p11) -- Line: 47
    -- upvalues: LoopParticle (copy)
    local CFrame2 = p11.CFrame;
    local Setting = p11.Setting;

    if p11.MakeClone then
        p10 = p10:Clone();
        p10.CFrame = CFrame2;
        p10.Parent = workspace.Effects;
    end;

    if Setting == "Emit" then
        LoopParticle(p10:GetDescendants(), true);

        return p10;
    end;

    if Setting == "Enable" then
        local Enabling = p11.Enabling;
        local v12 = p10:GetDescendants();

        for _, v in pairs(v12) do
            if v:IsA("ParticleEmitter") and Enabling then
                v.Enabled = Enabling;
            end;
        end;
    end;

    return p10;
end;

local u13 = {
    ["Phantom Queen"] = 80,
    ["Vacation Queen"] = 170
};

return function(p14, p15, p16) -- Line: 77
    -- upvalues: u13 (copy), CreateInstance (copy), SoundGroups (copy), EmitParticle (copy), AssetHandler (copy), ParticleHandler (copy), u1 (copy), TweenService (copy), Debris (copy)
    local v17 = p16 or {};
    local SkinName = v17.SkinName;
    local v18 = u13[v17.SkinName] or 0;

    if type(p14) == "string" then
        p14 = workspace.Effects:WaitForChild(p14, 5);
    end;

    if not v17.AbilityName then
        v17.AbilityName = "Killer Queen";
    end;

    local v19 = {
        ["Crazy Explosion Girl"] = 14975627951
    };
    local v20 = CreateInstance("Sound", {
        Volume = 5,
        SoundId = "rbxassetid://" .. (v19[SkinName] and (v19[SkinName] or 10842751938) or 10842751938)
    });
    SoundGroups:AssignSoundTag(v20);
    local v21 = {
        ["Crazy Explosion Girl"] = 14975627616
    };
    local v22 = v21[SkinName] and v21[SkinName] or 10842752119;
    v20.Parent = p14;
    v20:Play();
    game.Debris:AddItem(v20, 3);
    local v23 = EmitParticle(AssetHandler.GetAsset("Particles/Startup", v17), {
        Setting = "Emit",
        MakeClone = true,
        CFrame = p14.CFrame
    });
    ParticleHandler.Unusualify(v23, {
        Character = v17.Character
    });
    task.wait(p15 == nil and 1.22 or (p15 * 1 / 60 or 1.22));
    local Particle = u1({
        Destroy = false,
        Character = v17.Character,
        Particle = AssetHandler.GetAsset("Particles/Explosion", v17),
        Origin = CFrame.new(p14.Position) * CFrame.new(0, -2, 0) * CFrame.Angles(-1.5707963267948966, 0, 0),
        SkinName = v17.SkinName,
        HueShift = v18
    }).Particle;
    task.delay(15, Particle.Destroy, Particle);
    local v24 = CreateInstance("Sound", {
        Volume = 10,
        RollOffMaxDistance = 100,
        SoundId = "rbxassetid://" .. v22,
        Parent = Particle
    });
    SoundGroups:AssignSoundTag(v24);
    v24:Play();
    game.Debris:AddItem(v24, 3);
    TweenService:Create(Particle.PointLight, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
        Brightness = 1.72
    }):Play();

    for _ = 1, 30 do
        local v25 = AssetHandler.GetAsset("Particles/SparkParticle", v17):Clone();
        ParticleHandler.Unusualify(v25, {
            Character = v17.Character
        });
        v25.Position = p14.Position;
        local v26 = math.random(0, 60);
        local v27 = math.random(0, 360);
        v25.Orientation = Vector3.new(v26, v27, 0);
        v25.Parent = workspace.Effects;
        v25.Velocity = v25.CFrame.LookVector * 80;
        ParticleHandler.HueShiftParticles(v25, v18);
        Debris:AddItem(v25, math.random(1, 2));
    end;

    for _ = 1, math.random(5, 10) do
        local u28 = AssetHandler.GetAsset("Particles/TrailDebris", v17):Clone();
        ParticleHandler.Unusualify(u28, {
            Character = v17.Character
        });
        u28.CanCollide = false;
        u28.Position = p14.Position;
        local v29 = math.random(40, 90);
        local v30 = math.random(0, 360);
        u28.Orientation = Vector3.new(v29, v30, 0);
        ParticleHandler.HueShiftParticles(u28, v18);
        u28.Parent = workspace.Effects;
        u28.Velocity = u28.CFrame.LookVector * math.random(60, 100);
        task.delay(1.5, function() -- Line: 168
            -- upvalues: TweenService (ref), u28 (copy)
            TweenService:Create(u28, TweenInfo.new(1), {
                Size = Vector3.new(0, 0, 0)
            }):Play();
            game.Debris:AddItem(u28, 1);
        end);
    end;

    game.Debris:AddItem(v23, 7);
end;