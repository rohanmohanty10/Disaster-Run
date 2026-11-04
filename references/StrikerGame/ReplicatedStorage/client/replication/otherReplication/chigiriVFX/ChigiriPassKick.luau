 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Debris");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local mainreplication = require(script.Parent.Parent.Parent.mainreplication);
require(script.Parent.Parent.Parent.TekrinnDialogue);
require(script.Parent.Parent.Parent.MeshEmitter);
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.util.Util);
require(ReplicatedStorage.util.SignalValue);
local trove = require(ReplicatedStorage.forum.trove);
local _ = Players.LocalPlayer;

local function run_dash(p1: table) -- Line: 26
    -- upvalues: trove (copy), mainreplication (copy), Players (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    local Value = p1.Character.Value;
    local u2 = Value.HumanoidRootPart or Value.PrimaryPart;
    local v3 = 1.5 / (p1.Variant.Value == 1 and 1 or 1.25);
    local u4 = trove.new();
    u4:Add(task.delay(10, function() -- Line: 33
        -- upvalues: u4 (copy)
        u4:Destroy();
    end));
    u4:Add((mainreplication.bodyVelocity(u2, (p1.Variant.Value == 2 and 0.95 or 1) * 136.5, v3, nil, nil, nil, TweenInfo.new(v3 + 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out))));

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(Value) then
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.springcamerashake(10, 80);
        local v5 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v5.Parent = Lighting;
        v5.TintColor = Color3.fromRGB(255, 111, 142);
        v5.Brightness = 0.4;
        v5.Contrast = 1;
        v5.Saturation = -0.4;
        TweenService:Create(v5, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v5, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v5.Destroy, v5);
    end;

    u4:Add(task.delay(0.1, function() -- Line: 64
        -- upvalues: ReplicatedStorage (ref), u2 (copy), u4 (copy)
        if shared.allvfxcheck and shared.allvfxcheck() then
            return;
        end;

        local v6 = ReplicatedStorage.Resources.chigiri.chigiriflashstepemitthing:Clone();
        v6.Weld.Part1 = u2;
        v6.Parent = u2;
        u4:Add(v6);

        for _, descendant in pairs(v6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        local v7 = ReplicatedStorage.Resources.chigiri.AttachmentPart.runstart:Clone();
        v7.Parent = u2;
        u4:Add(v7);

        for _, descendant in pairs(v7:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    local u8, u9;

    if shared.allvfxcheck and shared.allvfxcheck() then
        u8 = nil;
        u9 = nil;
    else
        u8 = ReplicatedStorage.Resources.chigiri.AttachmentPart.RunVFX:Clone();
        u8.Parent = u2;
        u4:Add(u8);

        for _, descendant in pairs(u8:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        u9 = ReplicatedStorage.Resources.chigiri.RunVFX:Clone();
        u9.HumanoidRootPart.Part1 = u2;
        u9.Parent = u2;
        u4:Add(u9);

        for _, descendant in pairs(u9:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end;

    local u10;

    if p1.Variant.Value == 2 then
        if shared.allvfxcheck and shared.allvfxcheck() then
            return;
        end;

        u10 = ReplicatedStorage.Resources.chigiri.AttachmentPart.BeamsRun:Clone();
        u10.Parent = u2;
        u4:Add(u10);

        for _, descendant in pairs(u10:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                descendant.Brightness = 1;
            end;
        end;
    else
        u10 = nil;
    end;

    u4:Add(task.delay(v3 / 2, function() -- Line: 146
        -- upvalues: u8 (ref), u9 (ref), u10 (ref)
        if u8 and u9 then
            for _, descendant in pairs(u8:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(u9:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end;

        if u10 then
            for _, descendant in pairs(u10:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                    descendant.Brightness = 0;
                end;
            end;
        end;
    end));
end;

local function emit(p11: table) -- Line: 170
    -- upvalues: Players (copy), mainreplication (copy), ReplicatedStorage (copy), run_dash (copy)
    if p11.Variant.Value ~= 0 then
        run_dash(p11);

        return;
    end;

    local Value = p11.Character.Value;
    task.delay(0.383, function() -- Line: 173
        -- upvalues: Players (ref), Value (copy), mainreplication (ref), ReplicatedStorage (ref)
        if Players.LocalPlayer == Players:GetPlayerFromCharacter(Value) then
            mainreplication.springcamerashake(25, 45);
            mainreplication.fov(false, 50);
            mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        end;

        local v12 = ReplicatedStorage.Resources.chigiri.AttachmentPart.KickImpact1:Clone();
        v12.Parent = Value.HumanoidRootPart or Value.PrimaryPart;

        for _, descendant in pairs(v12:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
end;

return function(u13: table) -- Line: 194
    -- upvalues: Players (copy), mainreplication (copy), ReplicatedStorage (copy), run_dash (copy)
    if u13.Variant.Value == 0 then
        local Value = u13.Character.Value;
        task.delay(0.383, function() -- Line: 173
            -- upvalues: Players (ref), Value (copy), mainreplication (ref), ReplicatedStorage (ref)
            if Players.LocalPlayer == Players:GetPlayerFromCharacter(Value) then
                mainreplication.springcamerashake(25, 45);
                mainreplication.fov(false, 50);
                mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            end;

            local v14 = ReplicatedStorage.Resources.chigiri.AttachmentPart.KickImpact1:Clone();
            v14.Parent = Value.HumanoidRootPart or Value.PrimaryPart;

            for _, descendant in pairs(v14:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
    else
        run_dash(u13);
    end;

    u13.Variant.Changed:Connect(function() -- Line: 197
        -- upvalues: u13 (copy), Players (ref), mainreplication (ref), ReplicatedStorage (ref), run_dash (ref)
        local v15 = u13;

        if v15.Variant.Value ~= 0 then
            run_dash(v15);

            return;
        end;

        local Value = v15.Character.Value;
        task.delay(0.383, function() -- Line: 173
            -- upvalues: Players (ref), Value (copy), mainreplication (ref), ReplicatedStorage (ref)
            if Players.LocalPlayer == Players:GetPlayerFromCharacter(Value) then
                mainreplication.springcamerashake(25, 45);
                mainreplication.fov(false, 50);
                mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            end;

            local v16 = ReplicatedStorage.Resources.chigiri.AttachmentPart.KickImpact1:Clone();
            v16.Parent = Value.HumanoidRootPart or Value.PrimaryPart;

            for _, descendant in pairs(v16:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
    end);
end;