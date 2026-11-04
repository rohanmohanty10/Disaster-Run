  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local script_Fov = require(script.Fov);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local u1 = { "Head", "Left Arm", "Right Arm", "Torso", "Left Leg", "Right Leg" };

return function(p2) -- Line: 23
    -- upvalues: SpectatorController (copy), SoundManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), u1 (copy), VfxManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    if game.Players.LocalPlayer.Character.Values.Goalie.Value and (p2.Char ~= game.Players.LocalPlayer.Character and p2.enemy ~= game.Players.LocalPlayer.Character) then
        return;
    end;

    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    SoundManager.SpawnSound("KunigamiFallenHero", 0.7, workspace, 150);
    local u3 = 0;
    local u4 = nil;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u4 = RunService.RenderStepped:Connect(function(p5) -- Line: 36
        -- upvalues: u3 (ref), script_Fov (ref), u4 (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        u3 = u3 + p5 * 60;
        local v6 = script_Fov[math.ceil(u3)];

        if v6 ~= nil then
            if math.ceil(u3) >= #script_Fov then
                u4:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v6, p5 * 10);
        end;
    end);
    task.delay(7, function() -- Line: 50
        -- upvalues: u4 (ref)
        u4:Disconnect();
    end);
    local u7 = {};
    task.delay(1.8, function() -- Line: 57
        -- upvalues: u1 (ref), Char (copy), u7 (copy)
        local Children = script.Aura:GetChildren();

        for _, v in u1 do
            local v8 = v;

            for _, v2 in Children do
                local v9 = v2:Clone();
                v9.Name = "FlowParticle";
                v9.Parent = Char[v8];
                table.insert(u7, v9);
            end;
        end;

        table.clear(Children);
    end);
    task.delay(6.8, function() -- Line: 73
        -- upvalues: u7 (copy)
        for _, v in u7 do
            v.Enabled = false;
            task.delay(1, function() -- Line: 76
                -- upvalues: v (copy)
                v:Destroy();
            end);
        end;
    end);
    local script_Attachments = script.Attachments;

    for _, child in script_Attachments:GetChildren() do
        child:Clone().Parent = HumanoidRootPart;
    end;

    local u10 = {};

    for _, child in script:GetChildren() do
        if script_Attachments:FindFirstChild(child.Name) then
            local v11 = child:Clone();
            v11.Parent = workspace.Debris;
            v11.CFrame = HumanoidRootPart:FindFirstChild(v11.Name).WorldCFrame;
            u10[v11.Name] = v11;
        end;
    end;

    task.delay(1.75, function() -- Line: 99
        -- upvalues: u10 (copy), VfxManager (ref)
        VfxManager.Emit(u10.push);
    end);
    task.delay(1.8, function() -- Line: 104
        -- upvalues: u10 (copy), VfxManager (ref)
        VfxManager.Enable(u10.are, true);
    end);
    task.delay(2.95, function() -- Line: 109
        -- upvalues: u10 (copy), VfxManager (ref)
        local Area = u10.Area;
        local Wall = u10.Wall;
        VfxManager.Enable(u10.floor, true);
        VfxManager.Enable(Area, true);
        VfxManager.Enable(Wall, true);
    end);
    task.delay(5.2, function() -- Line: 119
        -- upvalues: u10 (copy), VfxManager (ref)
        local floor = u10.floor;
        local Area = u10.Area;
        local Wall = u10.Wall;
        VfxManager.Enable(u10.are, false);
        VfxManager.Enable(floor, false);
        VfxManager.Enable(Area, false);
        VfxManager.Enable(Wall, false);
    end);
    task.delay(4.9, function() -- Line: 131
        -- upvalues: u10 (copy), VfxManager (ref)
        local punch = u10.punch;
        VfxManager.Emit(u10.shoot);
        VfxManager.Emit(punch);
    end);
    task.delay(5.45, function() -- Line: 139
        -- upvalues: u10 (copy), VfxManager (ref)
        local punch = u10.punch;
        VfxManager.Emit(u10.shoot);
        VfxManager.Emit(punch);
    end);
    task.delay(6.8, function() -- Line: 147
        -- upvalues: u10 (copy), HumanoidRootPart (copy)
        for _, v in u10 do
            local v12 = HumanoidRootPart:FindFirstChild(v.Name);

            if v12 then
                v12:Destroy();
            end;

            v:Destroy();
        end;

        table.clear(u10);
    end);
end;