 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Zone = require(ReplicatedStorage.Effects.Base.Zone);
local _ = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 13
    -- upvalues: SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), Zone (copy), VfxManager (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Torso");
    workspace:FindFirstChild("CamRig");
    local BALL = Character:FindFirstChild("BALL", true);
    SfxManager:playSound({
        Sound = "MeteorStrike",
        Parent = workspace
    });
    local CamRig = workspace:FindFirstChild("CamRig");
    local u4 = 0;
    local u5 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u5 = RunService.RenderStepped:Connect(function(p6) -- Line: 32
        -- upvalues: u1 (copy), u5 (ref), u4 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u5:Disconnect();

            return;
        end;

        if u4 <= 0 then
            u4 = p6 * 60 * u3;
        end;

        u4 = u4 + p6 * 60;
        local v7 = script_Fov[math.ceil(u4)];

        if v7 ~= nil then
            if math.ceil(u4) >= #script_Fov then
                u5:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v7, p6 * 6);
        end;
    end);
    task.delay(8 - u3, function() -- Line: 50
        -- upvalues: u5 (ref)
        u5:Disconnect();
    end);
    Zone(u1, {
        Hide = true,
        Time = 7.88,
        Char = Character
    });
    local u8 = script.VFX:Clone();
    u8.Parent = workspace.Debris;
    u8:PivotTo(HumanoidRootPart.CFrame);
    local u9 = script.BALL.Trails:Clone();
    u9.Parent = BALL;
    local u10 = script.cameraVFX:Clone();
    u10.Parent = workspace.Debris;
    task.delay(10, function() -- Line: 66
        -- upvalues: u8 (copy), u9 (copy), u10 (copy)
        if u8 then
            u8:Destroy();
        end;

        if u9 then
            u9:Destroy();
        end;

        if u10 then
            u10:Destroy();
        end;
    end);
    local camera = CamRig.camera;
    u10.CFrame = camera.CFrame;
    Essentials:Weld(camera, u10);
    local u11 = {};

    for _, child in script.Aura:GetChildren() do
        local v12 = Character:FindFirstChild(child.Name);

        if v12 then
            for _, child2 in child:GetChildren() do
                local v13 = child2:Clone();
                v13.Parent = v12;
                u11[v13] = v13;
            end;
        end;
    end;

    task.delay(0.033, function() -- Line: 91
        -- upvalues: u8 (copy), VfxManager (ref), u9 (copy)
        VfxManager.Emit(u8.Ball_Emit);
        VfxManager.Enable(u9, true);
    end);
    task.delay(0.267, function() -- Line: 99
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Dribbles.Dribble_0);
    end);
    task.delay(0.783, function() -- Line: 104
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Dribbles.Dribble_1);
    end);
    task.delay(1.3, function() -- Line: 109
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Steps.Step0);
    end);
    task.delay(1.58, function() -- Line: 114
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Steps.Step1);
    end);
    task.delay(1.6, function() -- Line: 119
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Dribbles.Dribble_2);
    end);
    task.delay(1.88, function() -- Line: 124
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Steps.Step2);
    end);
    task.delay(2.26, function() -- Line: 129
        -- upvalues: u8 (copy)
        for _, descendant in u8.Wind_Floor:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(2.41, function() -- Line: 138
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Release);
    end);
    task.delay(2.45, function() -- Line: 143
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Small_Jump);
    end);
    task.delay(2.8, function() -- Line: 148
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Impact_1);
    end);
    task.delay(2.85, function() -- Line: 153
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Steps.Step3);
    end);
    task.delay(3.61, function() -- Line: 158
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Landing);

        for _, descendant in u8.Wind_Floor:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        VfxManager.Enable(u8.Jump_Lines, true);
    end);
    task.delay(4.18, function() -- Line: 173
        -- upvalues: u8 (copy), VfxManager (ref), u10 (copy), u11 (ref)
        VfxManager.Emit(u8.Jump);
        local Space = u8.Space;
        VfxManager.Enable(Space, true);
        Space.BackgroundGalaxy.Void.Transparency = 0;
        Space.SpaceZone.Transparency = 0;
        VfxManager.Enable(u10, true);
        VfxManager.Enable(u8.Jump_Lines, true);

        for _, v in u11 do
            if v:IsA("Attachment") then
                VfxManager.Enable(v, true);
            else
                v.Enabled = true;
            end;
        end;
    end);
    task.delay(4.5, function() -- Line: 199
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Grab_Emit);
        VfxManager.Enable(u8.OuterEnergy, true);
    end);
    task.delay(5.9, function() -- Line: 207
        -- upvalues: u8 (copy)
        for _, descendant in u8.Wind_Floor:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(6.967, function() -- Line: 216
        -- upvalues: u8 (copy), VfxManager (ref)
        VfxManager.Emit(u8.Impact_2);
    end);
    task.delay(7.88, function() -- Line: 221
        -- upvalues: u8 (copy), u9 (copy), u10 (copy), u11 (ref)
        u8:Destroy();
        u9:Destroy();
        u10:Destroy();

        for _, v in u11 do
            v:Destroy();
        end;

        table.clear(u11);
        u11 = nil;
    end);
end;