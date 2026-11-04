 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

local function HideCharacter(p1: userdata, p2: any) -- Line: 13
    for _, descendant in p1:GetDescendants() do
        if (descendant:IsA("BasePart") or descendant:IsA("Decal")) and descendant ~= p2 then
            descendant.Transparency = descendant.Transparency + 1;
        end;
    end;
end;

local function UnhideCharacter(p3: userdata, p4: any) -- Line: 22
    for _, descendant in p3:GetDescendants() do
        if (descendant:IsA("BasePart") or descendant:IsA("Decal")) and descendant ~= p4 then
            descendant.Transparency = descendant.Transparency - 1;
        end;
    end;
end;

return function(u5, p6) -- Line: 31
    -- upvalues: SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), HideCharacter (copy), Lighting (copy), VfxManager (copy), UnhideCharacter (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u7 = workspace:GetServerTimeNow() - p6.TimeSent;
    local Character = p6.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Torso = Character:FindFirstChild("Torso");
    SfxManager:playSound({
        Sound = "PhantomMove",
        Parent = workspace
    });
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 44
        -- upvalues: u5 (copy), u9 (ref), u8 (ref), u7 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u5.MovementController.States.Ability == false then
            u9:Disconnect();

            return;
        end;

        if u8 <= 0 then
            u8 = p10 * 60 * u7;
        end;

        u8 = u8 + p10 * 60;
        local v11 = script_Fov[math.ceil(u8)];

        if v11 ~= nil then
            if math.ceil(u8) >= #script_Fov then
                u9:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v11, p10 * 6);
        end;
    end);
    task.delay(5 - u7, function() -- Line: 62
        -- upvalues: u9 (ref)
        u9:Disconnect();
    end);
    task.delay(0.85, function() -- Line: 67
        -- upvalues: Character (copy), HideCharacter (ref), Lighting (ref), VfxManager (ref), HumanoidRootPart (copy)
        local BALL = Character:FindFirstChild("PlrBall"):FindFirstChild("BALL");
        HideCharacter(Character, BALL);
        local u12 = script.Impact:Clone();
        u12.Parent = Lighting;
        task.delay(0.05, function() -- Line: 75
            -- upvalues: u12 (copy)
            u12.Contrast = -10000;
            task.wait(0.05);
            u12:Destroy();
        end);
        task.delay(0.5, function() -- Line: 82
            -- upvalues: BALL (copy), VfxManager (ref)
            local v13 = BALL;
            v13.Transparency = v13.Transparency + 1;
            local v14 = script.FlashStepBall:Clone();
            v14.Parent = workspace;
            v14.CFrame = BALL.CFrame;
            VfxManager.Emit(v14);
            task.wait(3);
            v14:Destroy();
        end);
        local v15 = script["Phantom Flash Step [humanoid]"]:Clone();
        v15.Parent = workspace;
        v15.CFrame = HumanoidRootPart.CFrame;
        VfxManager.Emit(v15);
        task.wait(3);
        v15:Destroy();
    end);
    task.delay(2.2, function() -- Line: 100
        -- upvalues: Torso (copy), VfxManager (ref), Character (copy), UnhideCharacter (ref)
        local v16 = script.FlashStep2:Clone();
        v16.Parent = workspace;
        v16.CFrame = Torso.CFrame;
        VfxManager.Emit(v16);
        task.wait(0.1);
        local BALL = Character:FindFirstChild("PlrBall"):FindFirstChild("BALL");
        BALL.Transparency = BALL.Transparency - 1;
        UnhideCharacter(Character, BALL);
        task.wait(3);
        v16:Destroy();
    end);
    task.delay(4.85, function() -- Line: 116
        -- upvalues: Torso (copy)
        local v17 = Torso.CFrame * CFrame.new(2.1, 3.8, -4);
        local v18 = script["Perfect Arc"]:Clone();
        v18.Parent = workspace;
        v18.CFrame = v17;

        for _, descendant in v18:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
                descendant.TimeScale = 0.1;
            end;
        end;

        task.wait(1.2);

        for _, descendant in v18:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
                descendant.TimeScale = 1;
            end;
        end;

        task.wait(4);
        v18:Destroy();
    end);
end;