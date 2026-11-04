 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Teams = game:GetService("Teams");
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 17
    -- upvalues: Players (copy), Debris (copy), Essentials (copy), SfxManager (copy), VfxManager (copy), TweenService (copy), RunService (copy), Teams (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Enemy = p2.Enemy;
    local v4 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local v5 = Character:FindFirstChild(script.Name .. "Guitar");
    Character:FindFirstChild("BALL", true);

    if p2.Task == "Music Fling" then
        local u6 = script.MusicFlingAura:Clone();
        u6.Name = Character.Name .. script.Name .. "MusicFlingAura";
        u6.Parent = Debris;
        u6.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(u6, HumanoidRootPart);
        u6:SetAttribute("Active", true);
        task.delay(3, function() -- Line: 37
            -- upvalues: u6 (copy)
            if not (u6 and u6:GetAttribute("Active")) then
                return;
            end;

            u6:SetAttribute("Active", nil);
        end);
        local u7 = SfxManager:playSound({
            Sound = "BBZ Popstar Music Fling",
            Parent = u6
        });
        local u8 = {};

        local function v9() -- Line: 46
            -- upvalues: u8 (ref), VfxManager (ref), u6 (copy), TweenService (ref), u7 (copy)
            for _, v in u8 do
                v:Disconnect();
            end;

            VfxManager.Enable(u6, false);
            VfxManager.DestroyEffect(u6, 2);
            u8 = nil;
            TweenService:Create(u7, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Volume = 0
            }):Play();
        end;

        table.insert(u8, u6.AttributeChanged:Connect(v9));
        table.insert(u8, u6.Destroying:Connect(v9));

        return;
    end;

    if p2.Task ~= "Fling" then
        if p2.Task ~= "Soul Strings" then
            if p2.Task == "Music Fling Cleanup" then
                local v10 = Debris:FindFirstChild(Character.Name .. script.Name .. "MusicFlingAura");

                if v10 then
                    v10:SetAttribute("Active", nil);

                    return;
                end;
            else
                local v11 = p2.Task == "Soul Strings Cleanup" and Debris:FindFirstChild(Character.Name .. script.Name .. "GuitarAura");

                if v11 then
                    v11:SetAttribute("Active", nil);
                end;
            end;

            return;
        end;

        task.wait(0.2833333333333333 - v3);

        if v5 and v5.PrimaryPart then
            v5.PrimaryPart.Transparency = 0;
        end;

        local u12 = script.GuitarAura:Clone();
        u12.Name = Character.Name .. script.Name .. "GuitarAura";
        u12.Parent = Debris;
        u12:SetAttribute("Active", true);
        task.delay(5, function() -- Line: 115
            -- upvalues: u12 (copy)
            if not (u12 and u12:GetAttribute("Active")) then
                return;
            end;

            u12:SetAttribute("Active", nil);
        end);
        SfxManager:playSound({
            Sound = "BBZ Popstar Soul Strings",
            Parent = u12
        });
        local u13 = {};
        local CoreEnd = u12.CoreEnd;

        if v4 then
            for _, v in Teams[Essentials:ActualTeam(v4.Team.Name)]:GetPlayers() do
                if v.Character and v.Character:FindFirstChild("Torso") then
                    local Torso = v.Character.Torso;
                    local v14 = CoreEnd:Clone();
                    v14.Parent = Torso;
                    table.insert(u13, v14);
                end;
            end;
        end;

        local u15 = {};

        local function v16() -- Line: 139
            -- upvalues: u15 (ref), VfxManager (ref), u12 (copy), TweenService (ref), u13 (copy)
            for _, v in u15 do
                v:Disconnect();
            end;

            VfxManager.Enable(u12, false);
            VfxManager.DestroyEffect(u12, 2);

            for _, descendant in pairs(u12:GetDescendants()) do
                if descendant:IsA("SpotLight") then
                    TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Brightness = 0
                    }):Play();
                end;
            end;

            for _, v in pairs(u13) do
                VfxManager.Enable(v, false);
                VfxManager.DestroyEffect(v, 2);
            end;

            u15 = nil;
        end;

        table.insert(u15, RunService.RenderStepped:Connect(function() -- Line: 161
            -- upvalues: HumanoidRootPart (copy), u12 (copy)
            if not (HumanoidRootPart and (u12 and (HumanoidRootPart:IsDescendantOf(workspace) and u12:IsDescendantOf(workspace)))) then
                return;
            end;

            u12.CFrame = CFrame.new(HumanoidRootPart.Position.X, 4, HumanoidRootPart.Position.Z);
        end));
        table.insert(u15, u12.AttributeChanged:Connect(v16));
        table.insert(u15, u12.Destroying:Connect(v16));

        return;
    end;

    local HumanoidRootPart2 = Enemy.HumanoidRootPart;
    local _ = Enemy.Torso;
    SfxManager:playSound({
        Sound = "BBZ Popstar Music Fling Enemy",
        Parent = HumanoidRootPart2
    });
    local v17 = script.EnemyAura:Clone();
    v17.Parent = Debris;
    v17.CFrame = Enemy.HumanoidRootPart.CFrame;
    Essentials:Weld(v17, HumanoidRootPart2);
    task.wait(0.8 - v3);
    local u18 = script.Projectile:Clone();
    u18.Parent = Debris;
    u18.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart2.Position);
    local _, v19, _ = u18.CFrame:ToOrientation();
    TweenService:Create(u18, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        CFrame = CFrame.new(u18.Position) * CFrame.fromOrientation(-0.5235987755982988, v19, 0) * CFrame.new(0, 0, 15)
    }):Play();
    task.wait(0.5);
    local v20 = RunService.Heartbeat:Connect(function() -- Line: 84
        -- upvalues: HumanoidRootPart (copy), HumanoidRootPart2 (copy), TweenService (ref), u18 (copy)
        if not (HumanoidRootPart and (HumanoidRootPart2 and (HumanoidRootPart:IsDescendantOf(workspace) and HumanoidRootPart2:IsDescendantOf(workspace)))) then
            return;
        end;

        TweenService:Create(u18, TweenInfo.new(0.15), {
            CFrame = CFrame.new(HumanoidRootPart2.Position, HumanoidRootPart.Position) * CFrame.Angles(0, 3.141592653589793, 0)
        }):Play();
    end);
    task.wait(0.15);
    v20:Disconnect();
    u18.Anchored = false;
    u18.CFrame = HumanoidRootPart2.CFrame;
    Essentials:Weld(u18, HumanoidRootPart2);
    task.wait(1);
    VfxManager.Enable(v17, false);
    VfxManager.Enable(u18, false);
    VfxManager.DestroyEffect(v17, 2);
    VfxManager.DestroyEffect(u18, 2);
end;