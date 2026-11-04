  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 13
    -- upvalues: SpectatorController (copy), EmitModule (copy), TweenService (copy), RunService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and (game.Players.LocalPlayer.PlayerGui.Misc.CloseLimited.Visible == false and (game.Players.LocalPlayer.PlayerGui.Customization.Enabled == false and not SpectatorController.IsSpectating)) then
        return;
    end;

    local u2 = script.GE:Clone();
    u2.Parent = workspace.Debris;
    u2:PivotTo(p1.Pos);
    u2.Part.Sound:Play();
    EmitModule.emit(u2);
    task.delay(8, function() -- Line: 24
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
    task.spawn(function() -- Line: 28
        -- upvalues: u2 (copy), TweenService (ref)
        local Descendants = u2:GetDescendants();

        for _, v in pairs(Descendants) do
            if v:IsA("ParticleEmitter") ~= false then
                local u3 = TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    TimeScale = 0
                });
                u3:Play();
                task.delay(1, function() -- Line: 37
                    -- upvalues: u3 (copy)
                    u3:Destroy();
                end);
            end;
        end;

        table.clear(Descendants);
    end);
    local Unit = game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity.Unit;
    local Magnitude = game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity.Magnitude;
    local v4 = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        AssemblyLinearVelocity = Vector3.new(0, game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity.Y, 0)
    });
    task.delay(1.5, function() -- Line: 52
        task.spawn(function() -- Line: 53
            local Children = game.Players.LocalPlayer.Character:GetChildren();

            for _, v in pairs(Children) do
                if v:IsA("BasePart") then
                    v.Anchored = true;
                end;
            end;

            table.clear(Children);
        end);
    end);
    v4:Play();
    local u5 = {
        ["1"] = {
            Brightness = 0.25,
            Contrast = 1.5,
            Saturation = -0.5,
            TintColor = Color3.new(0.231373, 0.878431, 1)
        },
        ["2"] = {
            Brightness = 0.5,
            Contrast = 1,
            Saturation = -1,
            TintColor = Color3.new(0.313725, 0.376471, 1)
        },
        ["3"] = {
            Brightness = 0.35,
            Contrast = 0.75,
            Saturation = -0.5,
            TintColor = Color3.new(0.298039, 0.105882, 1)
        },
        ["4"] = {
            Brightness = 0.2,
            Contrast = 1,
            Saturation = -1.5,
            TintColor = Color3.new(1, 0.376471, 0.129412)
        },
        ["5"] = {
            Brightness = 0.35,
            Contrast = 0.5,
            Saturation = -2,
            TintColor = Color3.new(0.933333, 1, 0.368627)
        },
        ["6"] = {
            Brightness = 0.25,
            Contrast = 1,
            Saturation = -1.5,
            TintColor = Color3.new(0.262745, 1, 0.227451)
        },
        ["7"] = {
            Brightness = 0.2,
            Contrast = 0.75,
            Saturation = -1,
            TintColor = Color3.new(1, 1, 1)
        }
    };
    local ColorCorrection = game.Lighting.ColorCorrection;
    task.delay(1.5, function() -- Line: 116
        -- upvalues: ColorCorrection (copy), u5 (ref), RunService (ref)
        for i = 1, 7 do
            ColorCorrection.TintColor = u5[tostring(i)].TintColor;
            ColorCorrection.Brightness = u5[tostring(i)].Brightness;
            ColorCorrection.Contrast = u5[tostring(i)].Contrast;
            ColorCorrection.Saturation = u5[tostring(i)].Saturation;
            RunService.Heartbeat:Wait();
            RunService.Heartbeat:Wait();
            RunService.Heartbeat:Wait();
            RunService.Heartbeat:Wait();
            RunService.Heartbeat:Wait();
            RunService.Heartbeat:Wait();
            local _ = i;
        end;
    end);
    task.wait(1);
    task.delay(1.5, function() -- Line: 131
        -- upvalues: TweenService (ref), ColorCorrection (copy)
        local u6 = TweenService:Create(ColorCorrection, TweenInfo.new(2, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Saturation = 0.5,
            Contrast = 0.25,
            Brightness = 0,
            TintColor = Color3.new(1, 1, 1)
        });
        u6:Play();
        task.delay(2, function() -- Line: 137
            -- upvalues: u6 (copy)
            u6:Destroy();
        end);
    end);
    task.delay(1, function() -- Line: 142
        -- upvalues: u2 (copy), TweenService (ref)
        task.spawn(function() -- Line: 143
            -- upvalues: u2 (ref), TweenService (ref)
            local Descendants = u2:GetDescendants();

            for _, v in pairs(Descendants) do
                if v:IsA("ParticleEmitter") ~= false then
                    local u7 = TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        TimeScale = 1
                    });
                    u7:Play();
                    task.delay(1, function() -- Line: 152
                        -- upvalues: u7 (copy)
                        u7:Destroy();
                    end);
                end;
            end;

            table.clear(Descendants);
        end);
    end);
    task.delay(1.5, function() -- Line: 161
        -- upvalues: Unit (copy), Magnitude (copy)
        local Children = game.Players.LocalPlayer.Character:GetChildren();

        for _, v in pairs(Children) do
            if v:IsA("BasePart") then
                v.Anchored = false;
            end;
        end;

        table.clear(Children);
        game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Unit * Magnitude;
    end);
    task.delay(5, function() -- Line: 176
        -- upvalues: u5 (ref), u2 (copy)
        table.clear(u5);
        u5 = nil;
        u2:Destroy();
    end);
end;