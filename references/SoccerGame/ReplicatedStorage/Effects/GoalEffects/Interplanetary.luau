  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 10
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    local LocalPlayer = game.Players.LocalPlayer;

    if LocalPlayer.Team == game.Teams.Visitor and (LocalPlayer.PlayerGui.Misc.CloseLimited.Visible == false and (LocalPlayer.PlayerGui.Customization.Enabled == false and not SpectatorController.IsSpectating)) then
        return;
    end;

    local u2 = ReplicatedStorage.Assets.GoalEffects.Interplanetary.Interplanetary:Clone();
    u2.Parent = workspace.Debris;
    u2.Impact.CFrame = p1.Pos;
    u2.SecondImpact.CFrame = p1.Pos;
    u2.AirBubble.CFrame = p1.Pos;
    Lighting.Blur.Size = 0;
    u2.galaxyRoom.Transparency = 1;
    u2.AirBubble.Size = Vector3.new(0.001, 0.001, 0.001);
    task.delay(0.2, function() -- Line: 24
        -- upvalues: u2 (copy), TweenService (ref)
        u2.AirBubble.Size = Vector3.new(60, 60, 60);
        TweenService:Create(u2.AirBubble, TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), {
            Size = Vector3.new(0.001, 0.001, 0.001)
        });
    end);
    task.delay(0.21666666666666667, function() -- Line: 32
        -- upvalues: TweenService (ref), u2 (copy)
        TweenService:Create(u2.galaxyRoom, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();

        for _, descendant in pairs(u2.Impact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.spawn(function() -- Line: 39
                    -- upvalues: descendant (copy)
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;
    end);
    task.delay(0.23333333333333334, function() -- Line: 46
        -- upvalues: TweenService (ref), u2 (copy)
        TweenService:Create(u2.AirBubble, TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), {
            Size = Vector3.new(300, 300, 300)
        }):Play();
    end);
    task.delay(0.3, function() -- Line: 52
        -- upvalues: u2 (copy), TweenService (ref)
        for _, descendant in pairs(u2.GalaxyAura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.spawn(function() -- Line: 55
                    -- upvalues: descendant (copy)
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                    descendant.Enabled = true;
                end);
            end;
        end;

        for _, descendant in pairs(u2.SecondImpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.spawn(function() -- Line: 64
                    -- upvalues: descendant (copy)
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;

        TweenService:Create(u2.AirBubble, TweenInfo.new(0.6833333333333333, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = Vector3.new(0.001, 0.001, 0.001)
        }):Play();
    end);
    task.delay(0.31666666666666665, function() -- Line: 75
        (function(p3: userdata, p4: userdata, u5: userdata, u6: userdata, p7: userdata, u8: userdata) -- Line: 76, Name: ColorCorrectionEffect
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Saturation = p3;
            ColorCorrectionEffect.Contrast = p4;
            ColorCorrectionEffect.Parent = game:GetService("Lighting");
            task.delay(p7, function() -- Line: 82
                -- upvalues: ColorCorrectionEffect (copy), u5 (copy), u6 (copy), u8 (copy)
                ColorCorrectionEffect.Saturation = u5;
                ColorCorrectionEffect.Contrast = u6;
                task.wait(u8);
                ColorCorrectionEffect:Destroy();
            end);
        end)(-1, -3, -1, 3, 0.04, 0.02);
    end);
    task.delay(0.4166666666666667, function() -- Line: 93
        -- upvalues: TweenService (ref), Lighting (ref)
        TweenService:Create(Lighting.Blur, TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear), {
            Size = 12
        }):Play();
    end);
    task.delay(0.5, function() -- Line: 99
        -- upvalues: TweenService (ref), Lighting (ref)
        TweenService:Create(Lighting.Blur, TweenInfo.new(0.7, Enum.EasingStyle.Linear), {
            Size = 5
        }):Play();
    end);
    task.delay(4.083333333333333, function() -- Line: 105
        -- upvalues: u2 (copy)
        for _, descendant in pairs(u2.GalaxyEndEmit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.spawn(function() -- Line: 108
                    -- upvalues: descendant (copy)
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;
    end);
    task.delay(4.1, function() -- Line: 115
        -- upvalues: u2 (copy), TweenService (ref)
        for _, descendant in pairs(u2.GalaxyAura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.spawn(function() -- Line: 118
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        TweenService:Create(u2.galaxyRoom, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
    end);
    task.delay(4.116666666666666, function() -- Line: 129
        -- upvalues: TweenService (ref), Lighting (ref)
        TweenService:Create(Lighting.Blur, TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
    end);
    task.delay(4.15, function() -- Line: 135
        (function(p9: userdata, p10: userdata, u11: userdata, u12: userdata, p13: userdata, u14: userdata) -- Line: 136, Name: ColorCorrectionEffect
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Saturation = p9;
            ColorCorrectionEffect.Contrast = p10;
            ColorCorrectionEffect.Parent = game:GetService("Lighting");
            task.delay(p13, function() -- Line: 142
                -- upvalues: ColorCorrectionEffect (copy), u11 (copy), u12 (copy), u14 (copy)
                ColorCorrectionEffect.Saturation = u11;
                ColorCorrectionEffect.Contrast = u12;
                task.wait(u14);
                ColorCorrectionEffect:Destroy();
            end);
        end)(-1, -3, -1, 3, 0.04, 0.05);
    end);
    task.delay(5, function() -- Line: 153
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
end;