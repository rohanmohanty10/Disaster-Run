  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), VfxManager (copy), TweenService (copy), RunService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and (game.Players.LocalPlayer.PlayerGui.Misc.CloseLimited.Visible == false and (game.Players.LocalPlayer.PlayerGui.Customization.Enabled == false and not SpectatorController.IsSpectating)) then
        table.clear(p1);

        return;
    end;

    local v2 = ReplicatedStorage.Assets.GoalEffects["Time Stop"];
    local u3 = v2.Mesh:Clone();
    u3.Parent = workspace.Debris;
    u3.CFrame = p1.Pos;
    u3.Size = Vector3.new(1, 1, 1);
    local u4 = v2.Mesh:Clone();
    u4.Parent = workspace.Debris;
    u4.CFrame = p1.Pos;
    u4.Size = Vector3.new(1, 1, 1);
    local u5 = v2.ZAWORLD:Clone();
    u5.Parent = workspace.Debris;
    u5.CFrame = p1.Pos;
    local v6 = v2.Sound:Clone();
    v6.Parent = u3;
    v6:Play();
    VfxManager.Emit(u5);
    task.spawn(function() -- Line: 41
        -- upvalues: u5 (copy), TweenService (ref)
        local Descendants = u5:GetDescendants();

        for _, v in pairs(Descendants) do
            if v:IsA("ParticleEmitter") ~= false then
                local u7 = TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    TimeScale = 0
                });
                u7:Play();
                task.delay(1, function() -- Line: 50
                    -- upvalues: u7 (copy)
                    u7:Destroy();
                end);
            end;
        end;

        table.clear(Descendants);
    end);
    local Unit = game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity.Unit;
    local Magnitude = game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity.Magnitude;
    local u8 = TweenService:Create(u3, TweenInfo.new(1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = Vector3.new(300, 300, 300),
        Transparency = 3
    });
    local u9 = TweenService:Create(u4, TweenInfo.new(0.85, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = Vector3.new(150, 150, 150),
        Transparency = 5
    });
    local v10 = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        AssemblyLinearVelocity = Vector3.new(0, game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity.Y, 0)
    });
    task.delay(1, function() -- Line: 71
        task.spawn(function() -- Line: 72
            if game.Players.LocalPlayer.Team ~= game.Teams.Visitor then
                local Children = game.Players.LocalPlayer.Character:GetChildren();

                for _, v in pairs(Children) do
                    if v:IsA("BasePart") and v.Name ~= "Football" then
                        v.Anchored = true;
                    end;
                end;

                table.clear(Children);
            end;
        end);
    end);
    u8:Play();
    u9:Play();
    v10:Play();
    local u11 = {
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

    for i = 1, 7 do
        ColorCorrection.TintColor = u11[tostring(i)].TintColor;
        ColorCorrection.Brightness = u11[tostring(i)].Brightness;
        ColorCorrection.Contrast = u11[tostring(i)].Contrast;
        ColorCorrection.Saturation = u11[tostring(i)].Saturation;
        RunService.Heartbeat:Wait();
        RunService.Heartbeat:Wait();
        RunService.Heartbeat:Wait();
        RunService.Heartbeat:Wait();
        RunService.Heartbeat:Wait();
        RunService.Heartbeat:Wait();
        local _ = i;
    end;

    task.wait(1);
    task.delay(1.5, function() -- Line: 153
        -- upvalues: TweenService (ref), ColorCorrection (copy)
        local u12 = TweenService:Create(ColorCorrection, TweenInfo.new(2, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Saturation = 0.5,
            Contrast = 0.25,
            Brightness = 0,
            TintColor = Color3.new(1, 1, 1)
        });
        u12:Play();
        task.delay(2, function() -- Line: 159
            -- upvalues: u12 (copy)
            u12:Destroy();
        end);
    end);
    task.delay(1, function() -- Line: 164
        -- upvalues: TweenService (ref), u4 (copy), u3 (copy), u5 (copy)
        TweenService:Create(u4, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Size = Vector3.new(0, 0, 0),
            Transparency = 1
        }):Play();
        local u13 = TweenService:Create(u3, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Size = Vector3.new(0, 0, 0),
            Transparency = 1
        });
        u13:Play();
        task.delay(3, function() -- Line: 175
            -- upvalues: u13 (copy)
            u13:Destroy();
        end);
        task.spawn(function() -- Line: 179
            -- upvalues: u5 (ref), TweenService (ref)
            local Descendants = u5:GetDescendants();

            for _, v in pairs(Descendants) do
                if v:IsA("ParticleEmitter") ~= false then
                    local u14 = TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        TimeScale = 1
                    });
                    u14:Play();
                    task.delay(1, function() -- Line: 188
                        -- upvalues: u14 (copy)
                        u14:Destroy();
                    end);
                end;
            end;

            table.clear(Descendants);
        end);
    end);
    task.delay(1.5, function() -- Line: 197
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
    task.delay(5, function() -- Line: 212
        -- upvalues: u8 (copy), u9 (copy), u11 (ref), u5 (copy), u3 (copy), u4 (copy)
        u8:Destroy();
        u9:Destroy();
        table.clear(u11);
        u11 = nil;
        u5:Destroy();
        u3:Destroy();
        u4:Destroy();
    end);
end;