  

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local CameraShaker = require(ReplicatedStorage.Shared.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local workspace_Debris = workspace.Debris;
local Anims = script:WaitForChild("Anims");
local u1 = {
    Left = Anims:WaitForChild("Left"),
    Right = Anims:WaitForChild("Right")
};
local Red = script:WaitForChild("Red");
local Yellow = script:WaitForChild("Yellow");
local u2 = script:WaitForChild("Dragon Explosion");
local ImpactFrames = script:WaitForChild("ImpactFrames");

return function(p3) -- Line: 24
    -- upvalues: u2 (copy), Red (copy), Yellow (copy), Debris (copy), workspace_Debris (copy), u1 (copy), TweenService (copy), CameraShaker (copy), VfxManager (copy), ImpactFrames (copy), Lighting (copy), RunService (copy)
    local Pos = p3.Pos;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u4 = {};
    local v5 = u2:Clone();
    local u6 = Red:Clone();
    local u7 = Yellow:Clone();
    v5.Parent = workspace.Debris;
    Debris:AddItem(v5, 30);
    v5.CFrame = Pos;
    u6:PivotTo(Pos + Pos.RightVector * 3 + -Pos.LookVector * 2 + Vector3.new(0, 30, 0));
    u7:PivotTo(Pos + -Pos.RightVector * 3 + Vector3.new(0, 30, 0));
    u6.Parent = workspace_Debris;
    u7.Parent = workspace_Debris;
    local v8 = u6.AnimationController.Animator:LoadAnimation(u1.Left);
    local v9 = u7.AnimationController.Animator:LoadAnimation(u1.Right);
    task.delay(2.05, function() -- Line: 47
        -- upvalues: TweenService (ref), u6 (copy), u7 (copy)
        TweenService:Create(u6["Dragon.001"], TweenInfo.new(0.75), {
            Transparency = 1
        }):Play();
        TweenService:Create(u7["Dragon.001"], TweenInfo.new(0.75), {
            Transparency = 1
        }):Play();
    end);
    task.delay(4, function() -- Line: 52
        -- upvalues: u6 (copy), u7 (copy)
        u6:Destroy();
        u7:Destroy();
    end);
    v8:Play();
    task.delay(0.05, function() -- Line: 58
        -- upvalues: u6 (copy)
        u6["Dragon.001"].Transparency = 0;
    end);
    task.delay(2.05, function() -- Line: 62
        -- upvalues: TweenService (ref), u7 (copy)
        TweenService:Create(u7["Dragon.001"], TweenInfo.new(0.75), {
            Transparency = 1
        }):Play();
    end);
    v9:Play();
    task.delay(0.05, function() -- Line: 66
        -- upvalues: u7 (copy)
        u7["Dragon.001"].Transparency = 0;
    end);
    local u10 = 70;
    CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p11) -- Line: 71
        -- upvalues: workspace_CurrentCamera (copy), u10 (ref)
        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(p11.Position * u10) * p11.Rotation;
    end);
    VfxManager.Emit(v5);
    VfxManager.Emit(v5.charge);
    VfxManager.Emit(v5.Main);
    task.delay(0.3, function() -- Line: 82
        -- upvalues: u10 (ref), ImpactFrames (ref), Debris (ref), Lighting (ref), u4 (copy), RunService (ref)
        u10 = 10;

        for _, child in pairs(ImpactFrames:GetChildren()) do
            local v12 = child:Clone();
            Debris:AddItem(v12, 4);
            v12.Parent = Lighting;
            table.insert(u4, v12);
        end;

        coroutine.wrap(function() -- Line: 94
            -- upvalues: u4 (ref), RunService (ref)
            for _, v in pairs(u4) do
                v.Enabled = true;
                RunService.RenderStepped:Wait();
                RunService.RenderStepped:Wait();
                v.Enabled = false;
            end;
        end)();
    end);
end;