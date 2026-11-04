  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
local _ = game.Lighting;
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
require(ReplicatedStorage.Assets.Animations);

local function Weld(p1, p2) -- Line: 15
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p1;
    WeldConstraint.Part1 = p2;
    WeldConstraint.Parent = p1;

    return WeldConstraint;
end;

function EmitAll(p3)
    local function emit(u4) -- Line: 24
        if u4:IsA("ParticleEmitter") or (u4:IsA("Beam") or u4:IsA("Trail")) then
            local Attribute = u4:GetAttribute("EmitDelay");
            local Attribute2 = u4:GetAttribute("EmitCount");

            if Attribute2 and Attribute2 ~= 0 then
                if Attribute and Attribute ~= 0 then
                    task.delay(Attribute, function() -- Line: 31
                        -- upvalues: u4 (copy), Attribute2 (copy)
                        u4:Emit(Attribute2);
                    end);

                    return;
                end;

                u4:Emit(Attribute2);
            end;
        end;
    end;

    if typeof(p3) == "table" then
        for _, v in p3 do
            if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
                emit(v);
            else
                for _, descendant in v:GetDescendants() do
                    emit(descendant);
                end;
            end;
        end;

        return;
    end;

    if p3:IsA("ParticleEmitter") or (p3:IsA("Beam") or p3:IsA("Trail")) then
        emit(p3);

        return;
    end;

    for _, descendant in p3:GetDescendants() do
        emit(descendant);
    end;
end;

local function Destroy_Effect(u5: any, p6: number) -- Line: 62
    task.delay(p6, function() -- Line: 64
        -- upvalues: u5 (copy)
        if typeof(u5) == "table" then
            for _, v in u5 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u5 then
            u5:Destroy();
        end;
    end);
end;

return function(p7) -- Line: 80
    -- upvalues: SpectatorController (copy), SoundManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Character = p7.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Folder = Instance.new("Folder");
    Folder.Parent = workspace.Debris;
    tick();
    local Values = game:GetService("Players").LocalPlayer.Character.Values;

    if not (Values.Goalie.Value or Values.IsInPenalty.Value) then
        local u8 = 0;
        local u11 = game:GetService("RunService").RenderStepped:Connect(function(p9) -- Line: 95
            -- upvalues: u8 (ref)
            u8 = u8 + p9 * 60;
            local script_FOV = script.FOV;
            local math_ceil_ret = math.ceil(u8);
            local v10 = script_FOV:FindFirstChild((tonumber(math_ceil_ret)));

            if not v10 then
                return;
            end;

            game.Workspace.CurrentCamera.FieldOfView = v10.Value;
        end);
        task.delay(8, function() -- Line: 107
            -- upvalues: u11 (ref)
            if u11 then
                u11:Disconnect();
            end;
        end);
    end;

    local FieldOfView = game.Workspace.CurrentCamera.FieldOfView;
    SoundManager.SpawnSound("GingaMonsterBG", 3, workspace, 150);
    local u12 = {};

    for _, child in pairs(Character:GetChildren()) do
        if child:IsA("BasePart") then
            local v13 = child;

            for _, child2 in pairs(script.Aura:GetChildren()) do
                local v14 = child2:Clone();
                v14.Parent = v13;
                v14.Enabled = true;
                table.insert(u12, v14);
            end;
        end;
    end;

    print("GM VFX");
    local u15 = script.LegVFX.Charge:Clone();
    table.insert(u12, u15);
    u15.Parent = Character["Right Leg"];
    local u16 = script.LegVFX.Release:Clone();
    table.insert(u12, u16);
    u16.Parent = Character["Right Leg"];
    local u17 = script.HRPVFX:Clone();
    u17.CFrame = HumanoidRootPart.CFrame;
    u17.Parent = Folder;
    task.delay(2.3, function() -- Line: 145
        -- upvalues: u17 (copy), u15 (copy), u16 (copy)
        EmitAll(u17.FlyingBall);
        EmitAll(u15);
        u16.Smoke1:Emit(5);
        task.wait(1.4);
        u17.FlyingBall.Debris:Emit(15);
        u17.FlyingBall.Smoke1:Emit(5);
        u17.FlyingBall.Wind1:Emit(3);
        EmitAll(u15);
        u16.Smoke1:Emit(5);
        task.wait(1.3);

        for _, child in pairs(u15:GetChildren()) do
            child.Enabled = true;
        end;

        task.wait(1.2);

        for _, child in pairs(u15:GetChildren()) do
            child.Enabled = false;
        end;

        task.wait(0.4);
        EmitAll(u16);
    end);
    task.delay(8, function() -- Line: 175
        -- upvalues: FieldOfView (copy), Folder (copy), u12 (copy)
        game.Workspace.CurrentCamera.FieldOfView = FieldOfView;

        if Folder then
            Folder:Destroy();
        end;

        for _, v in pairs(u12) do
            v:Destroy();
        end;
    end);
end;