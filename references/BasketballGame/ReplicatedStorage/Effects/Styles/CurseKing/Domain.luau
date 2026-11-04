 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Trove);
require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 17
    -- upvalues: LocalPlayer (copy), Players (copy), Essentials (copy), Debris (copy), RunService (copy), TweenService (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Enemy = p2.Enemy;
    local HumanoidRootPart = Enemy:FindFirstChild("HumanoidRootPart");

    if LocalPlayer.Character == Enemy then
        if p2.CFrame then
            HumanoidRootPart.CFrame = p2.CFrame;
        end;

        for _, v in Players:GetPlayers() do
            if v ~= LocalPlayer and (v.Character and (v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart"))) then
                v.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
                Essentials:HideCharacter(v.Character, {});
                task.delay(6 - v3, function() -- Line: 35
                    -- upvalues: v (copy), Debris (ref), Essentials (ref)
                    if not (v.Character and v.Character:FindFirstChild("HumanoidRootPart")) then
                        return;
                    end;

                    if not Debris:FindFirstChild(v.Character.Name .. "DomainBubble") then
                        v.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer;
                        Essentials:UnhideCharacter(v.Character, {});
                    end;
                end);
            end;
        end;

        local v5 = RunService.Heartbeat:Connect(function() -- Line: 44
            -- upvalues: HumanoidRootPart (copy)
            local v4 = HumanoidRootPart.Position - Vector3.new(0, 4, -297.5);

            if v4.Magnitude > 20 then
                return;
            end;

            if v4.Magnitude * Vector3.new(1, 0, 1) == 0 then
                HumanoidRootPart.AssemblyLinearVelocity = HumanoidRootPart.CFrame.LookVector * Vector3.new(50, 0, 50);

                return;
            end;

            HumanoidRootPart.AssemblyLinearVelocity = v4.Unit * Vector3.new(50, 0, 50);
        end);
        local v6 = script.Map:Clone();
        v6.Parent = Debris;
        task.wait(6 - v3);

        if v5 then
            v5:Disconnect();
        end;

        for _, descendant in v6:GetDescendants() do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end;

        VfxManager.Enable(v6, false);
        VfxManager.DestroyEffect(v6, 8);

        return;
    end;

    local u7 = script.DomainBubble:Clone();
    u7.Name = Enemy.Name .. "DomainBubble";
    u7.Parent = Debris;
    u7:PivotTo(HumanoidRootPart.CFrame);
    u7.Transparency = 1;
    u7.Part.Transparency = 1;
    VfxManager.DestroyEffect(u7, 8);
    local u8 = RunService.Heartbeat:Connect(function() -- Line: 79
        -- upvalues: LocalPlayer (ref), u7 (copy), TweenService (ref)
        if not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
            return;
        end;

        if (LocalPlayer.Character.HumanoidRootPart.Position - u7.Position).Magnitude > u7.Size.X / 2 then
            TweenService:Create(u7, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Transparency = 0
            }):Play();
            TweenService:Create(u7.Part, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Transparency = 0
            }):Play();

            return;
        end;

        TweenService:Create(u7, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 0.9
        }):Play();
        TweenService:Create(u7.Part, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 0.9
        }):Play();
    end);
    task.delay(6 - v3, function() -- Line: 90
        -- upvalues: u7 (copy), u8 (copy), RunService (ref), TweenService (ref)
        u7.Name = "DomainBubble";
        u8:Disconnect();
        RunService.Heartbeat:Wait();
        TweenService:Create(u7, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        TweenService:Create(u7.Part, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
    end);
    Enemy.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    Essentials:HideCharacter(Enemy, {});
    task.delay(6 - v3, function() -- Line: 100
        -- upvalues: Enemy (copy), Debris (ref), LocalPlayer (ref), Essentials (ref)
        if not (Enemy and (Enemy:FindFirstChild("Humanoid") and Enemy:FindFirstChild("HumanoidRootPart"))) then
            return;
        end;

        if not Debris:FindFirstChild(LocalPlayer.Character.Name .. "DomainBubble") then
            Enemy.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer;
            Essentials:UnhideCharacter(Enemy, {});
        end;
    end);
end;