  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local LightingStorage = require(ReplicatedStorage2.Shared.LightingStorage);

return function(u1) -- Line: 14
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), LightingStorage (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local u2 = ReplicatedStorage.Assets.Awakenings.Yuki.City:Clone();
    u2.Parent = workspace;
    u2.PrimaryPart.CFrame = u1.Plr.Character.HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(0, -1.5707963267948966, 0) * CFrame.new(7, 0.1, -9);
    local ColorCorrection = game.Lighting.ColorCorrection;
    local u3 = script.AwakeningCat:Clone();
    u3.Parent = workspace;
    u3.PrimaryPart.Anchored = true;
    u3.PrimaryPart.CFrame = u1.Plr.Character.HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0) * CFrame.new(0, -2, -0.25);
    local v4 = u3.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.YukiCat);
    v4:Play();
    v4:Destroy();
    game.Lighting.Ambient = Color3.new(0.552941, 0.52549, 0.411765);
    game.Lighting.Brightness = 1;
    game.Lighting.OutdoorAmbient = Color3.new(0.235294, 0.545098, 0.580392);
    game.Lighting.ClockTime = 8.8;
    game.Lighting.Atmosphere.Color = Color3.new(0.780392, 0.639216, 0.501961);
    ColorCorrection.Enabled = false;
    local u5 = {};

    for _, child in ReplicatedStorage.Assets.Awakenings.Yuki.Light:GetChildren() do
        local v6 = child:Clone();
        v6.Parent = game.Lighting;
        u5[v6.Name] = v6;
    end;

    task.delay(2, function() -- Line: 46
        -- upvalues: ReplicatedStorage (ref), u1 (ref), u5 (copy)
        task.spawn(function() -- Line: 47
            -- upvalues: ReplicatedStorage (ref), u1 (ref)
            local Descendants = ReplicatedStorage.Assets.Auras.Dribbler.Particles:GetDescendants();
            local v7 = {};

            for _, v in pairs(Descendants) do
                if v:IsA("ParticleEmitter") == false then
                    if v:IsA("Highlight") then
                        local v8 = v:Clone();
                        v8.Name = "FlowParticle";
                        v8.Parent = u1.Plr.Character;
                    end;
                elseif not v7[v.Parent] then
                    if v.Parent:IsA("Attachment") then
                        v7[v.Parent] = true;
                        local v9 = v.Parent:Clone();
                        v9.Name = "FlowParticle";
                        v9.Parent = u1.Plr.Character[v.Parent.Parent.Name];
                    else
                        local v10 = v:Clone();
                        v10.Name = "FlowParticle";
                        v10.Parent = u1.Plr.Character[v.Parent.Name];
                    end;
                end;
            end;

            table.clear(v7);
            table.clear(Descendants);
        end);
        u5.BLACK.Enabled = true;
        task.wait(0.04);
        u5.BLACK.Enabled = false;
        u5["Black+White"].Enabled = true;
        task.wait(0.04);
        u5["Black+White"].Enabled = false;
        u5.WHITE.Enabled = true;
        task.wait(0.04);
        u5.WHITE.Enabled = false;
        u5["White+Back"].Enabled = true;
        task.wait(0.04);
        u5["White+Back"].Enabled = false;
    end);
    task.delay(4.75, function() -- Line: 99
        -- upvalues: u5 (copy), ColorCorrection (copy), u2 (copy), u3 (copy), LightingStorage (ref), u1 (ref)
        game.Lighting.Ambient = Color3.new(0.541176, 0.6, 0.67451);
        game.Lighting.Brightness = 5;
        game.Lighting.OutdoorAmbient = Color3.new(0.313725, 0.396078, 0.54902);
        game.Lighting.Atmosphere.Color = Color3.new(0.34902, 0.368627, 0.780392);

        for _, v in u5 do
            v:Destroy();
        end;

        ColorCorrection.Enabled = true;
        u2:Destroy();
        u3:Destroy();
        LightingStorage.ResetColors();
        task.spawn(function() -- Line: 117
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