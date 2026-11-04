  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local LocalPlayer = Players.LocalPlayer;

return function(u1) -- Line: 20
    -- upvalues: SpectatorController (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), VfxManager (copy), EmitModule (copy), UserInputService (copy), RunService (copy), Debris (copy)
    local Char = u1.Char;

    if not Char then
        return;
    end;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    if not Char:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    local u2 = {};

    local function ScreenEffect() -- Line: 35
        -- upvalues: Char (copy), LocalPlayer (ref), TweenService (ref), Lighting (ref)
        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.fromRGB(255, 60, 100)
            }):Play();
            task.delay(0.1, function() -- Line: 39
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;
    end;

    local function CreateEffect(p3, p4) -- Line: 45
        -- upvalues: Char (copy), VfxManager (ref), u2 (copy)
        local v5 = p3:Clone();
        v5.CFrame = Char.HumanoidRootPart.CFrame * p4;
        v5.Parent = workspace.Debris;
        VfxManager.Emit(v5);
        table.insert(u2, v5);
    end;

    local v6 = script.Highlight:Clone();
    v6.Parent = Char;
    EmitModule.emit(v6);
    task.delay(0.21666666666666667, function() -- Line: 60
        -- upvalues: Char (copy), VfxManager (ref), u2 (copy)
        local script_Hit4Emit = script.Hit4Emit;
        local CFrame_new_ret = CFrame.new(0, -2.5, 0);
        local v7 = script_Hit4Emit:Clone();
        v7.CFrame = Char.HumanoidRootPart.CFrame * CFrame_new_ret;
        v7.Parent = workspace.Debris;
        VfxManager.Emit(v7);
        table.insert(u2, v7);
    end);
    task.delay(0.45, function() -- Line: 64
        -- upvalues: Char (copy), VfxManager (ref), u2 (copy)
        local script_Hit4Emit = script.Hit4Emit;
        local CFrame_new_ret = CFrame.new(0, -2.5, 0);
        local v8 = script_Hit4Emit:Clone();
        v8.CFrame = Char.HumanoidRootPart.CFrame * CFrame_new_ret;
        v8.Parent = workspace.Debris;
        VfxManager.Emit(v8);
        table.insert(u2, v8);
    end);
    task.delay(0.65, function() -- Line: 68
        -- upvalues: Char (copy), VfxManager (ref), u2 (copy)
        local script_Hit4Emit = script.Hit4Emit;
        local CFrame_new_ret = CFrame.new(0, -2.5, 0);
        local v9 = script_Hit4Emit:Clone();
        v9.CFrame = Char.HumanoidRootPart.CFrame * CFrame_new_ret;
        v9.Parent = workspace.Debris;
        VfxManager.Emit(v9);
        table.insert(u2, v9);
    end);
    task.delay(0.9, function() -- Line: 72
        -- upvalues: Char (copy), VfxManager (ref), u2 (copy)
        local script_Hit4Emit = script.Hit4Emit;
        local CFrame_new_ret = CFrame.new(0, -2.5, 0);
        local v10 = script_Hit4Emit:Clone();
        v10.CFrame = Char.HumanoidRootPart.CFrame * CFrame_new_ret;
        v10.Parent = workspace.Debris;
        VfxManager.Emit(v10);
        table.insert(u2, v10);
    end);
    task.delay(1.15, function() -- Line: 76
        -- upvalues: Char (copy), VfxManager (ref), u2 (copy)
        local script_Hit4Emit = script.Hit4Emit;
        local CFrame_new_ret = CFrame.new(0, -2.5, 0);
        local v11 = script_Hit4Emit:Clone();
        v11.CFrame = Char.HumanoidRootPart.CFrame * CFrame_new_ret;
        v11.Parent = workspace.Debris;
        VfxManager.Emit(v11);
        table.insert(u2, v11);
    end);
    task.delay(1.25, function() -- Line: 80
        -- upvalues: Char (copy), VfxManager (ref), u2 (copy)
        local script_Hit4Emit = script.Hit4Emit;
        local CFrame_new_ret = CFrame.new(0, -2.5, 0);
        local v12 = script_Hit4Emit:Clone();
        v12.CFrame = Char.HumanoidRootPart.CFrame * CFrame_new_ret;
        v12.Parent = workspace.Debris;
        VfxManager.Emit(v12);
        table.insert(u2, v12);
    end);
    task.delay(1.6, function() -- Line: 84
        -- upvalues: Char (copy), VfxManager (ref), u2 (copy), UserInputService (ref), RunService (ref), u1 (ref), TweenService (ref), Debris (ref)
        local script_Shot = script.Shot;
        local v13 = CFrame.new(0, -2.5, 0) * CFrame.fromOrientation(1.5707963267948966, 0, 0);
        local v14 = script_Shot:Clone();
        v14.CFrame = Char.HumanoidRootPart.CFrame * v13;
        v14.Parent = workspace.Debris;
        VfxManager.Emit(v14);
        table.insert(u2, v14);
        local u15 = UserInputService.TouchEnabled and 0.4 or 0;
        local u16 = {
            Color3.new(0.945098, 0.333333, 1),
            Color3.new(0.203922, 0.309804, 1),
            Color3.new(0.223529, 0.701961, 1),
            Color3.new(0.419608, 1, 0.258824),
            Color3.new(1, 0.894118, 0.298039),
            Color3.new(1, 0.227451, 0.227451),
            Color3.new(0.631373, 0.447059, 1)
        };
        local u17 = 1;
        local u18 = nil;
        local u19 = tick();
        u18 = RunService.Heartbeat:Connect(function() -- Line: 106
            -- upvalues: u1 (ref), u18 (ref), u19 (ref), u15 (ref), u17 (ref), u16 (copy), TweenService (ref), Debris (ref)
            if u1.Char == nil then
                table.clear(u1);
                u1 = nil;

                if u18 then
                    u18:Disconnect();
                    u18 = nil;
                end;
            end;

            if u19 + u15 < tick() then
                u19 = tick();
                u17 = u17 + 1;

                if u17 > #u16 then
                    u17 = 1;
                end;

                u1.Char.Archivable = true;
                local u20 = u1.Char:Clone();
                task.delay(0.55, function() -- Line: 126
                    -- upvalues: u20 (copy)
                    u20:Destroy();
                end);
                task.spawn(function() -- Line: 130
                    -- upvalues: u20 (copy)
                    u20.Torso:FindFirstChild("Jersey"):Destroy();
                end);
                local Children = u20:GetChildren();

                for _, v in pairs(Children) do
                    if v:IsA("Accessory") and v.Name == "Cape" then
                        v:Destroy();
                    elseif v:IsA("Accessory") and v.Name == "Peppermint Cape" then
                        v:Destroy();
                    elseif v:IsA("Accessory") and v.Name == "Santa Hat" then
                        v:Destroy();
                    elseif v:IsA("Script") or v:IsA("LocalScript") then
                        v:Destroy();
                    elseif v:IsA("Highlight") then
                        v.FillColor = u16[u17];
                        v.OutlineColor = u16[u17];
                        v.OutlineTransparency = 0;
                        v.FillTransparency = 0;
                        local v21 = TweenService:Create(v, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            FillTransparency = 1,
                            OutlineTransparency = 1
                        });
                        v21:Play();
                        Debris:AddItem(v21, 0.55);
                    elseif v:IsA("MeshPart") or v:IsA("BasePart") then
                        v.CanCollide = false;
                        v.Anchored = true;

                        if v.Name ~= "HumanoidRootPart" then
                            local v22 = TweenService:Create(v, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                Transparency = 1
                            });
                            v22:Play();
                            Debris:AddItem(v22, 0.55);
                        end;
                    elseif v:IsA("Accessory") then
                        v.Handle.CanCollide = false;
                        v.Handle.Anchored = true;
                        local v23 = TweenService:Create(v.Handle, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            Transparency = 1
                        });
                        v23:Play();
                        Debris:AddItem(v23, 0.55);
                    end;
                end;

                table.clear(Children);
                u20.Parent = workspace;
            end;
        end);
        task.wait(0.4);
        table.clear(u1);
        u1 = nil;

        if u18 then
            u18:Disconnect();
            u18 = nil;
        end;

        table.clear(u16);
        u17 = nil;
    end);
    task.wait(4);

    for _, v in pairs(u2) do
        v:Destroy();
    end;
end;