  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local script_Fov = require(script.Fov);

local function isGoalie() -- Line: 12
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Values") then
        return game.Players.LocalPlayer.Character.Values.Goalie.Value;
    end;

    return false;
end;

return function(p1) -- Line: 21
    -- upvalues: TweenService (copy), VfxManager (copy), Debris (copy), RunService (copy), script_Fov (copy), Essentials (copy)
    local HumanoidRootPart = p1.Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v2;

    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Values") then
        v2 = game.Players.LocalPlayer.Character.Values.Goalie.Value;
    else
        v2 = false;
    end;

    if not v2 then
        local _ = workspace.CurrentCamera.FieldOfView;
        local workspace_CurrentCamera = workspace.CurrentCamera;
        workspace_CurrentCamera.FieldOfView = 30;
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.3), {
            FieldOfView = 35
        }):Play();
        task.delay(1.31, function() -- Line: 32
            -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.39), {
                FieldOfView = 25
            }):Play();
        end);
        task.delay(2.8, function() -- Line: 35
            -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.38), {
                FieldOfView = 50
            }):Play();
        end);
        task.delay(3.18, function() -- Line: 38
            -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.12), {
                FieldOfView = 30
            }):Play();
        end);
        task.delay(3.3, function() -- Line: 41
            -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(2.4), {
                FieldOfView = 25
            }):Play();
        end);
    end;

    local u3 = script.Dribble:Clone();
    u3.Parent = workspace.Debris;
    u3.CFrame = HumanoidRootPart.CFrame * CFrame.new(3, -2.5, -1.8);
    task.delay(0.48, function() -- Line: 49
        -- upvalues: VfxManager (ref), u3 (copy), Debris (ref)
        VfxManager.Emit(u3);
        Debris:AddItem(u3, 5);
    end);
    local u4 = script.semit:Clone();
    u4.Parent = workspace.Debris;
    u4.CFrame = HumanoidRootPart.CFrame * CFrame.new(-2.4, 0.6, -5.7);
    task.delay(1.2, function() -- Line: 57
        -- upvalues: VfxManager (ref), u4 (copy), Debris (ref)
        VfxManager.Emit(u4);
        Debris:AddItem(u4, 5);
    end);
    local u5 = script["question mark"]:Clone();
    u5.Parent = workspace.Debris;
    u5.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.081, 1.3, -5.423);
    task.delay(1.74, function() -- Line: 65
        -- upvalues: VfxManager (ref), u5 (copy), Debris (ref)
        VfxManager.Emit(u5);
        Debris:AddItem(u5, 5);
    end);
    local u6 = script.Shoot:Clone();
    u6.Parent = workspace.Debris;
    task.delay(2.8, function() -- Line: 72
        -- upvalues: u6 (copy), HumanoidRootPart (copy), VfxManager (ref)
        u6:PivotTo(HumanoidRootPart.CFrame * CFrame.new(1.952, 3.715, -12.447) * CFrame.Angles(0, 1.5707963267948966, 0));
        VfxManager.Enable(u6, true);
    end);
    task.delay(3.2, function() -- Line: 77
        -- upvalues: VfxManager (ref), u6 (copy), Debris (ref)
        VfxManager.Enable(u6, false);
        Debris:AddItem(u6, 5);
    end);
    local u7 = script.kick:Clone();
    u7.Parent = workspace.Debris;
    task.delay(3.3, function() -- Line: 84
        -- upvalues: u7 (copy), HumanoidRootPart (copy), VfxManager (ref), Debris (ref)
        u7:PivotTo(HumanoidRootPart.CFrame * CFrame.new(7.379, 0.4, -15.456) * CFrame.Angles(0.47123889803846897, 1.5707963267948966, -1.5707963267948966));
        VfxManager.Emit(u7);
        Debris:AddItem(u7, 5);
    end);
    local u8 = 0;
    local u9 = nil;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 94
        -- upvalues: u8 (ref), script_Fov (ref), u9 (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        u8 = u8 + p10 * 60;
        local v11 = script_Fov[math.ceil(u8)];

        if v11 ~= nil then
            if math.ceil(u8) >= #script_Fov then
                u9:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v11, p10 * 10);
        end;
    end);
    task.delay(4.3, function() -- Line: 108
        -- upvalues: u9 (ref)
        u9:Disconnect();
    end);
end;