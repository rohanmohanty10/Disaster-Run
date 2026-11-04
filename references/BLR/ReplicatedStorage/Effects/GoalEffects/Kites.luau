  

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
game:GetService("Lighting");
local CameraShaker = require(ReplicatedStorage.Shared.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local GoalExplosion = script:WaitForChild("GoalExplosion");
local workspace_Debris = workspace.Debris;
local Attribute = script:GetAttribute("numLanterns");
local Attribute2 = script:GetAttribute("drag");
script:GetAttribute("secondsUntilRise");
local Attribute3 = script:GetAttribute("riseSpeed");
local Attribute4 = script:GetAttribute("fadeTime");
local Attribute5 = script:GetAttribute("spreadAngle");
local CFrame_Angles_ret = CFrame.Angles(0.7853981633974483, 0, 0);

local function RandomCone(p1: vector, p2: number) -- Line: 36
    local math_cos_ret = math.cos(p2);
    local v3 = 1 - math.random() * (1 - math_cos_ret);
    local v4 = math.random() * 3.141592653589793 * 2;
    local math_sqrt_ret = math.sqrt(1 - v3 * v3);
    local v5 = math_sqrt_ret * math.cos(v4);
    local v6 = math_sqrt_ret * math.sin(v4);
    local math_abs_ret = math.abs(v6);
    local Vector3_new_ret = Vector3.new(v5, math_abs_ret, v3);

    if p1.Z > 0.9999 then
        return Vector3_new_ret;
    end;

    if p1.Z < -0.9999 then
        return -Vector3_new_ret;
    end;

    local v7 = (Vector3.new(0, 0, 1)):Cross(p1);
    local v8 = p1:Dot(Vector3.new(0, 0, 1));
    local math_acos_ret = math.acos(v8);

    return CFrame.fromAxisAngle(v7, math_acos_ret) * Vector3_new_ret;
end;

return function(p9) -- Line: 54
    -- upvalues: Attribute4 (copy), GoalExplosion (copy), workspace_Debris (copy), VfxManager (copy), CameraShaker (copy), Attribute (copy), Debris (copy), RandomCone (copy), Attribute5 (copy), RunService (copy), Attribute2 (copy), CFrame_Angles_ret (copy), Attribute3 (copy), TweenService (copy)
    local Position = p9.Pos.Position;
    local Random_new_ret = Random.new();
    local u10 = tick();
    local TweenInfo_new_ret = TweenInfo.new(Attribute4);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    (game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart");
    local v11 = GoalExplosion:Clone();
    v11.Parent = workspace_Debris;
    v11:PivotTo(p9.Pos);
    VfxManager.Emit(v11);
    CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p12) -- Line: 75
        -- upvalues: workspace_CurrentCamera (copy)
        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(p12.Position * 5) * p12.Rotation;
    end);
    local u13 = {};

    for i = 0, Attribute do
        local v14 = {};
        local v15;

        if math.random() > 0.5 then
            v15 = script.Kite1:Clone();
        else
            v15 = script.Kite2:Clone();
        end;

        Debris:AddItem(v15, 30);
        v15.Position = Position + Random_new_ret:NextUnitVector() * (Random_new_ret:NextNumber(1, 30) / 10);
        v15.Parent = workspace_Debris;
        v14.Model = v15;
        v14.Direction = RandomCone((workspace.BallSpawn.Position - Position).Unit, Attribute5);
        v14.Velocity = Random_new_ret:NextNumber(30, 60) / 40;
        v14.UpVelocity = 0;
        v14.LifeTimeAfterRise = Random_new_ret:NextNumber(30, 60) / 10;
        v14.Rising = false;
        v14.Rotation = 0;
        table.insert(u13, v14);
        local _ = i;
    end;

    local u19 = RunService.RenderStepped:Connect(function(p16) -- Line: 103
        -- upvalues: u10 (copy), u13 (copy), Attribute2 (ref), CFrame_Angles_ret (ref), Attribute3 (ref), TweenService (ref), TweenInfo_new_ret (copy), Attribute4 (ref)
        local v17 = (tick() - u10) * 3;

        for _, v in pairs(u13) do
            local v18 = v.Direction * math.pow(v.Velocity * (1 - Attribute2), v17);
            local Model = v.Model;
            Model.Position = Model.Position + v18;
            v.Model.CFrame = CFrame.new(v.Model.Position, v.Model.Position + (-v18 + Vector3.new(0, 0.4, 0))) * CFrame_Angles_ret * CFrame.Angles(0, v.Rotation, 0);
            v.Rotation = v.Rotation + p16;

            if math.pow(v.Velocity * (1 - Attribute2), v17) < 0.05 then
                local Model2 = v.Model;
                Model2.Position = Model2.Position + Vector3.new(0, v.UpVelocity, 0) * p16;
                v.UpVelocity = v.UpVelocity + Attribute3 * p16;

                if not v.Rising then
                    v.Rising = true;
                    task.delay(v.LifeTimeAfterRise - 3, function() -- Line: 116
                        -- upvalues: v (copy)
                        for _, descendant in pairs(v.Model:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = false;
                            end;
                        end;
                    end);
                    task.delay(v.LifeTimeAfterRise, function() -- Line: 122
                        -- upvalues: v (copy), TweenService (ref), TweenInfo_new_ret (ref), Attribute4 (ref)
                        for _, descendant in pairs(v.Model:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = false;
                            end;
                        end;

                        TweenService:Create(v.Model, TweenInfo_new_ret, {
                            Transparency = 1
                        }):Play();
                        task.delay(Attribute4, function() -- Line: 128
                            -- upvalues: v (ref)
                            v.Model:Destroy();
                        end);
                    end);
                end;
            end;
        end;
    end);
    task.delay(30, function() -- Line: 140
        -- upvalues: u19 (copy)
        if u19.Connected then
            u19:Disconnect();
        end;
    end);
end;