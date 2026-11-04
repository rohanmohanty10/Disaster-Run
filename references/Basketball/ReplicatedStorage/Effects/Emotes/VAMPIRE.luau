 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
require(ReplicatedStorage.Controllers.UIController);
local Debris = workspace:FindFirstChild("Debris");
local _ = game.Players.LocalPlayer;

local function EnablingVFX(p1: userdata, p2: boolean) -- Line: 19
    for _, descendant in ipairs(p1:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
            descendant.Enabled = p2;
        end;
    end;
end;

local function Emit(p3: userdata) -- Line: 27
    for _, descendant in ipairs(p3:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            local u4 = descendant:GetAttribute("EmitDelay") or 0;
            local u5 = descendant:GetAttribute("EmitCount") or 1;
            local u6 = descendant:GetAttribute("EmitDuration") or 0;
            task.spawn(function() -- Line: 33
                -- upvalues: u4 (copy), descendant (copy), u5 (copy), u6 (copy)
                task.wait(u4);

                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(u5);
                end;

                if u6 > 0 then
                    descendant.Enabled = true;
                    task.wait(u6);
                    descendant.Enabled = false;
                end;
            end);
        end;
    end;
end;

local function Destroy_Effect(u7: userdata, p8: number) -- Line: 48
    task.delay(p8, function() -- Line: 49
        -- upvalues: u7 (copy)
        u7:Destroy();
    end);
end;

return function(u9, p10) -- Line: 54
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), SfxManager (copy), Emit (copy), Debris (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p10.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Char:FindFirstChild("BALL", true);
    local v11 = Char.Name .. script.Parent.Name .. script.Name;

    if p10.Task ~= "Cutscene" then
        local v12 = p10.Task == "Cleanup" and Debris:FindFirstChild(v11);

        if v12 then
            v12:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u13 = workspace:GetServerTimeNow() - p10.previousTime + p10.passedTime;
    local u14 = 0;
    local u15 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u15 = RunService.RenderStepped:Connect(function(p16) -- Line: 73
        -- upvalues: u9 (copy), u15 (ref), u14 (ref), u13 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u9.MovementController.States.Ability == false then
            u15:Disconnect();

            return;
        end;

        if u14 <= 0 then
            u14 = p16 * 60 * u13;
        end;

        u14 = u14 + p16 * 60;
        local v17 = script_Fov[math.ceil(u14)];

        if v17 ~= nil then
            if math.ceil(u14) >= #script_Fov then
                u15:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v17, p16 * 6);
        end;
    end);
    local Shirt = Instance.new("Shirt");
    Shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=10645254963";
    Shirt.Parent = Char;
    task.delay(3.34 - u13, function() -- Line: 96
        -- upvalues: Shirt (copy)
        Shirt:Destroy();
    end);
    task.delay(3.34 - u13, function() -- Line: 100
        -- upvalues: u15 (ref)
        u15:Disconnect();
    end);
    SfxManager:playSound({
        Sound = script.Sound,
        Parent = workspace,
        Duration = 3.34 - u13
    }).TimePosition = u13;
    local u18 = script.Torso.Attachment:Clone();
    u18.Parent = Char:FindFirstChild("Torso");
    local u19 = script.VFX:Clone();
    u19.Name = v11;
    u19.Parent = workspace.Debris;
    u19:PivotTo(HumanoidRootPart.CFrame);
    u19.CamTrans.CFrame = CamRig.camera.CFrame * CFrame.new(0, 0, -0.2) * CFrame.Angles(0, 3.141592653589793, -3.141592653589793);
    u19.CamTrans.WeldConstraint.Part1 = CamRig.camera;
    u19.CamTrans.WeldConstraint.Part0 = u19.CamTrans;
    task.delay(0 - u13, function() -- Line: 123
        -- upvalues: Emit (ref), u19 (copy)
        Emit(u19.CameraAtmosphere);
    end);
    task.delay(0.18333333333333332 - u13, function() -- Line: 127
        -- upvalues: Emit (ref), u19 (copy)
        Emit(u19.CamTrans);
    end);
    task.delay(2.966666666666667 - u13, function() -- Line: 131
        -- upvalues: Emit (ref), u19 (copy)
        Emit(u19.CamTrans);
    end);
    task.delay(3.34 - u13, function() -- Line: 135
        -- upvalues: u19 (copy), u18 (copy)
        u19:Destroy();
        u18:Destroy();
    end);
end;