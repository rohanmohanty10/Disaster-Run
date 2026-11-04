  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(u1) -- Line: 12
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), Essentials (copy), VfxManager (copy), UserInputService (copy), RunService (copy), TweenService (copy), Debris (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        table.clear(u1);

        return;
    end;

    local u2 = ReplicatedStorage.Assets.Vfx.YukiFlash:Clone();
    u2.Parent = u1.Char;
    u2.CFrame = u1.Char.HumanoidRootPart.CFrame;
    Essentials:Weld(u2, u1.Char.HumanoidRootPart);
    VfxManager.Enable(u2, false);
    task.delay(0.3, function() -- Line: 25
        -- upvalues: VfxManager (ref), u2 (copy)
        VfxManager.Enable(u2, true);
    end);
    task.spawn(function() -- Line: 29
        -- upvalues: UserInputService (ref), RunService (ref), u1 (ref), TweenService (ref), Debris (ref)
        local u3 = UserInputService.TouchEnabled and 0.15 or 0.1;
        local u4 = nil;
        local u5 = tick();
        u4 = RunService.Heartbeat:Connect(function() -- Line: 38
            -- upvalues: u1 (ref), u4 (ref), u5 (ref), u3 (ref), TweenService (ref), Debris (ref)
            if u1.Char == nil then
                table.clear(u1);
                u1 = nil;

                if u4 then
                    u4:Disconnect();
                    u4 = nil;
                end;
            end;

            if u5 + u3 < tick() then
                u5 = tick();
                u1.Char.Archivable = true;
                local u6 = u1.Char:Clone();
                task.spawn(function() -- Line: 55
                    -- upvalues: u6 (copy)
                    u6.Torso:FindFirstChild("Jersey"):Destroy();
                end);
                local Children = u6:GetChildren();

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
                        v.FillColor = Color3.new(1, 1, 1);
                        v.OutlineColor = Color3.new(1, 1, 1);
                        v.OutlineTransparency = 7;
                        v.FillTransparency = 0.7;
                        local v7 = TweenService:Create(v, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            FillTransparency = 1,
                            OutlineTransparency = 1
                        });
                        v7:Play();
                        Debris:AddItem(v7, 0.35);
                    elseif v:IsA("MeshPart") or v:IsA("BasePart") then
                        v.CanCollide = false;
                        v.Anchored = true;

                        if v.Name ~= "HumanoidRootPart" then
                            local v8 = TweenService:Create(v, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                Transparency = 1
                            });
                            v8:Play();
                            Debris:AddItem(v8, 0.35);
                        end;
                    elseif v:IsA("Accessory") then
                        v.Handle.CanCollide = false;
                        v.Handle.Anchored = true;
                        local v9 = TweenService:Create(v.Handle, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            Transparency = 1
                        });
                        v9:Play();
                        Debris:AddItem(v9, 0.35);
                    end;
                end;

                table.clear(Children);
                u6.Parent = workspace;
                task.delay(0.35, function() -- Line: 114
                    -- upvalues: u6 (copy)
                    u6:Destroy();
                end);
            end;
        end);
        task.delay(0.4, function() -- Line: 120
            -- upvalues: u4 (ref)
            if u4 then
                u4:Disconnect();
                u4 = nil;
            end;
        end);
    end);
    local u10 = UserInputService.TouchEnabled and 0.15 or 0.08;
    local u11 = 1;
    local u12 = nil;
    task.delay(0.5, function() -- Line: 136
        -- upvalues: u12 (ref), RunService (ref), u1 (ref), u10 (ref), ReplicatedStorage (ref), VfxManager (ref)
        local u13 = tick();
        u12 = RunService.Heartbeat:Connect(function() -- Line: 138
            -- upvalues: u1 (ref), u12 (ref), u13 (ref), u10 (ref), ReplicatedStorage (ref), VfxManager (ref)
            if u1.Char == nil then
                table.clear(u1);
                u1 = nil;

                if u12 then
                    u12:Disconnect();
                    u12 = nil;
                end;
            end;

            if u13 + u10 < tick() then
                u13 = tick();
                local u14 = ReplicatedStorage.Assets.Vfx.YukimiyaImpact:Clone();
                u14.Parent = workspace;
                u14.CFrame = u1.Char.HumanoidRootPart.CFrame;
                VfxManager.Emit(u14["Medium Impact"]);
                task.delay(1, function() -- Line: 156
                    -- upvalues: u14 (copy)
                    u14:Destroy();
                end);
            end;
        end);
    end);
    task.delay(0.7, function() -- Line: 161
        -- upvalues: VfxManager (ref), u2 (copy), u1 (ref), u12 (ref), u11 (ref)
        VfxManager.Enable(u2, false);
        task.delay(2, function() -- Line: 163
            -- upvalues: u2 (ref)
            u2:Destroy();
        end);
        table.clear(u1);
        u1 = nil;

        if u12 then
            u12:Disconnect();
            u12 = nil;
        end;

        u11 = nil;
    end);
end;