 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Zone = require(ReplicatedStorage.Effects.Base.Zone);
local LocalPlayer = game.Players.LocalPlayer;
local UIController = require(ReplicatedStorage.Controllers.UIController);

return function(u1, p2) -- Line: 15
    -- upvalues: SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), Zone (copy), LocalPlayer (copy), ReplicatedStorage (copy), UIController (copy), VfxManager (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Torso");
    SfxManager:playSound({
        Sound = "FullCourt",
        Duration = 9,
        Parent = workspace
    });
    local u4 = 0;
    local u5 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u5 = RunService.RenderStepped:Connect(function(p6) -- Line: 28
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
    task.delay(10 - u3, function() -- Line: 47
        -- upvalues: u5 (ref)
        u5:Disconnect();
    end);
    Zone(u1, {
        Hide = true,
        Time = 10,
        Char = Character
    });
    task.delay(7 - u3, function() -- Line: 52
        -- upvalues: LocalPlayer (ref), ReplicatedStorage (ref), UIController (ref)
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = LocalPlayer.PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        local v8 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v8.Parent = ScreenGui;
        UIController:PlayFlipbook(v8, "FullCourt", 0.03);
        task.wait(2);
        ScreenGui:Destroy();
    end);
    local u9 = script.AllVFX:Clone();
    u9.Parent = workspace.Debris;
    u9.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
    local u10 = script.Head.VFX:Clone();
    u10.Parent = Character:FindFirstChild("Head");
    local CamRig = workspace:FindFirstChild("CamRig");
    local u11 = nil;
    task.spawn(function() -- Line: 77
        -- upvalues: CamRig (copy), u11 (ref), Essentials (ref)
        if CamRig then
            u11 = script.Camera_VFX:Clone();
            u11.Parent = workspace.Debris;
            u11.CFrame = CamRig:FindFirstChild("camera").CFrame;
            Essentials:Weld(CamRig:FindFirstChild("camera"), u11);
        end;
    end);
    local BALL = Character:FindFirstChild("BALL", true);
    local u12 = {};

    for _, child in script.Aura.Aura:GetChildren() do
        local v13 = Character:FindFirstChild(child.Name);

        if v13 then
            for _, child2 in child:GetChildren() do
                local v14 = child2:Clone();
                v14.Parent = v13;
                u12[v14] = v14;
            end;
        end;
    end;

    if BALL then
        for _, child in script.Aura["Ball aura"].ball.BALL:GetChildren() do
            local v15 = child:Clone();
            v15.Parent = BALL;
            u12[v15] = v15;
        end;
    end;

    task.delay(0.43 - u3, function() -- Line: 111
        -- upvalues: VfxManager (ref), u9 (copy)
        VfxManager.Emit(u9.Dribble_1);
    end);
    task.delay(0.883 - u3, function() -- Line: 115
        -- upvalues: VfxManager (ref), u9 (copy)
        VfxManager.Emit(u9.Sniper_Step1);
    end);
    task.delay(0.883 - u3, function() -- Line: 119
        -- upvalues: VfxManager (ref), u9 (copy)
        VfxManager.Emit(u9.Sniper_Step1);
    end);
    task.delay(1.133 - u3, function() -- Line: 123
        -- upvalues: VfxManager (ref), u10 (copy)
        VfxManager.Emit(u10.Emit);
    end);
    task.delay(1.3 - u3, function() -- Line: 127
        -- upvalues: VfxManager (ref), u9 (copy)
        VfxManager.Emit(u9.Sniper_Step2);
        VfxManager.Emit(u9.Dribble_2);
    end);
    task.delay(2 - u3, function() -- Line: 132
        -- upvalues: u11 (ref), VfxManager (ref), u9 (copy)
        if u11 then
            VfxManager.Enable(u11.LeftCinematicBars, true);
            VfxManager.Enable(u11.RightCinematicBars, true);
        end;

        VfxManager.Emit(u9["First Jump"]);
    end);
    task.delay(4.433 - u3, function() -- Line: 141
        -- upvalues: u11 (ref), VfxManager (ref)
        if not u11 then
            return;
        end;

        VfxManager.Enable(u11.LeftCinematicBars, false);
        VfxManager.Enable(u11.RightCinematicBars, false);
    end);
    task.delay(7 - u3, function() -- Line: 147
        -- upvalues: VfxManager (ref), u11 (ref), u10 (copy)
        VfxManager.Enable(u11.slantedBottom, true);
        VfxManager.Enable(u11.slantedTop, true);
        VfxManager.Emit(u10.Glasses.Emit);
        VfxManager.Enable(u10.Glasses.Enabled, true);
    end);
    task.delay(3 - u3, function() -- Line: 155
        -- upvalues: VfxManager (ref), u9 (copy)
        VfxManager.Emit(u9.Ball_Sweat);
    end);
    task.delay(10.45 - u3, function() -- Line: 159
        -- upvalues: u12 (copy), u11 (ref), VfxManager (ref)
        for _, v in u12 do
            if v then
                v:Destroy();
            end;
        end;

        if u11 then
            VfxManager.Enable(u11.slantedBottom, false);
            VfxManager.Enable(u11.slantedTop, false);
        end;
    end);
    task.delay(10.45 - u3, function() -- Line: 171
        -- upvalues: VfxManager (ref), u10 (copy), u9 (copy), u11 (ref)
        VfxManager.Enable(u10.Glasses.Enabled, false);
        u9:Destroy();
        u10:Destroy();
        u11:Destroy();
    end);
end;