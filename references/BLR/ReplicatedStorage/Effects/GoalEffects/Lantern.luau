  

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local CameraShaker = require(ReplicatedStorage.Shared.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local u1 = script:WaitForChild("Lunar Lantern");
local u2 = script:WaitForChild("Lantern Explosion");
local ImpactFrames = script:WaitForChild("ImpactFrames");
local workspace_Debris = workspace.Debris;
local Attribute = script:GetAttribute("numLanterns");
local Attribute2 = script:GetAttribute("drag");
script:GetAttribute("secondsUntilRise");
local Attribute3 = script:GetAttribute("riseSpeed");
local Attribute4 = script:GetAttribute("fadeTime");
local Attribute5 = script:GetAttribute("spreadAngle");
local CFrame_Angles_ret = CFrame.Angles(-1.5707963267948966, 0, 0);

local function RandomCone(p3: vector, p4: number) -- Line: 38
    local math_cos_ret = math.cos(p4);
    local v5 = 1 - math.random() * (1 - math_cos_ret);
    local v6 = math.random() * 3.141592653589793 * 2;
    local math_sqrt_ret = math.sqrt(1 - v5 * v5);
    local v7 = math_sqrt_ret * math.cos(v6);
    local v8 = math_sqrt_ret * math.sin(v6);
    local math_abs_ret = math.abs(v8);
    local Vector3_new_ret = Vector3.new(v7, math_abs_ret, v5);

    if p3.Z > 0.9999 then
        return Vector3_new_ret;
    end;

    if p3.Z < -0.9999 then
        return -Vector3_new_ret;
    end;

    local v9 = (Vector3.new(0, 0, 1)):Cross(p3);
    local v10 = p3:Dot(Vector3.new(0, 0, 1));
    local math_acos_ret = math.acos(v10);

    return CFrame.fromAxisAngle(v9, math_acos_ret) * Vector3_new_ret;
end;

return function(p11) -- Line: 56
    -- upvalues: Attribute4 (copy), u2 (copy), workspace_Debris (copy), VfxManager (copy), CameraShaker (copy), Attribute (copy), u1 (copy), Debris (copy), RandomCone (copy), Attribute5 (copy), ImpactFrames (copy), Lighting (copy), RunService (copy), Attribute2 (copy), CFrame_Angles_ret (copy), Attribute3 (copy), TweenService (copy)
    local Position = p11.Pos.Position;
    local Random_new_ret = Random.new();
    local u12 = tick();
    local TweenInfo_new_ret = TweenInfo.new(Attribute4);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    (game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart");
    local v13 = u2:Clone();
    v13.Parent = workspace_Debris;
    v13.Position = Position;
    VfxManager.Emit(v13);
    VfxManager.Emit(v13["Base VFX"]);
    VfxManager.Emit(v13.Wind);
    CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p14) -- Line: 79
        -- upvalues: workspace_CurrentCamera (copy)
        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(p14.Position * 5) * p14.Rotation;
    end);
    local u15 = {};
    local u16 = {};

    for i = 0, Attribute do
        local v17 = {};
        local v18 = u1:Clone();
        Debris:AddItem(v18, 30);
        v18.Position = Position + Random_new_ret:NextUnitVector() * (Random_new_ret:NextNumber(1, 30) / 10);
        v18.Parent = workspace_Debris;
        v17.Model = v18;
        v17.Direction = RandomCone((workspace.BallSpawn.Position - Position).Unit, Attribute5);
        v17.Velocity = Random_new_ret:NextNumber(30, 60) / 10;
        v17.UpVelocity = 0;
        v17.LifeTimeAfterRise = Random_new_ret:NextNumber(30, 60) / 10;
        v17.Rising = false;
        v17.Rotation = 0;
        table.insert(u15, v17);
        local _ = i;
    end;

    for _, child in pairs(ImpactFrames:GetChildren()) do
        local v19 = child:Clone();
        Debris:AddItem(v19, 4);
        v19.Parent = Lighting;
        table.insert(u16, v19);
    end;

    coroutine.wrap(function() -- Line: 111
        -- upvalues: u16 (copy), RunService (ref)
        for _, v in pairs(u16) do
            v.Enabled = true;
            RunService.RenderStepped:Wait();
            RunService.RenderStepped:Wait();
            v.Enabled = false;
        end;
    end)();
    local u23 = RunService.RenderStepped:Connect(function(p20) -- Line: 121
        -- upvalues: u12 (copy), u15 (copy), Attribute2 (ref), CFrame_Angles_ret (ref), Attribute3 (ref), TweenService (ref), TweenInfo_new_ret (copy), Attribute4 (ref)
        local v21 = (tick() - u12) * 3;

        for _, v in pairs(u15) do
            local v22 = v.Direction * math.pow(v.Velocity * (1 - Attribute2), v21);
            local Model = v.Model;
            Model.Position = Model.Position + v22;
            v.Model.CFrame = CFrame.new(v.Model.Position, v.Model.Position + (-v22 + Vector3.new(0, 0.4, 0))) * CFrame_Angles_ret * CFrame.Angles(0, v.Rotation, 0);
            v.Rotation = v.Rotation + p20;

            if math.pow(v.Velocity * (1 - Attribute2), v21) < 0.05 then
                local Model2 = v.Model;
                Model2.Position = Model2.Position + Vector3.new(0, v.UpVelocity, 0) * p20;
                v.UpVelocity = v.UpVelocity + Attribute3 * p20;

                if not v.Rising then
                    v.Rising = true;
                    task.delay(v.LifeTimeAfterRise - 3, function() -- Line: 134
                        -- upvalues: v (copy)
                        for _, descendant in pairs(v.Model:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = false;
                            end;
                        end;
                    end);
                    task.delay(v.LifeTimeAfterRise, function() -- Line: 140
                        -- upvalues: v (copy), TweenService (ref), TweenInfo_new_ret (ref), Attribute4 (ref)
                        for _, descendant in pairs(v.Model:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = false;
                            end;
                        end;

                        TweenService:Create(v.Model, TweenInfo_new_ret, {
                            Transparency = 1
                        }):Play();
                        task.delay(Attribute4, function() -- Line: 146
                            -- upvalues: v (ref)
                            v.Model:Destroy();
                        end);
                    end);
                end;
            end;
        end;
    end);
    task.delay(30, function() -- Line: 158
        -- upvalues: u23 (copy)
        if u23.Connected then
            u23:Disconnect();
        end;
    end);
end;