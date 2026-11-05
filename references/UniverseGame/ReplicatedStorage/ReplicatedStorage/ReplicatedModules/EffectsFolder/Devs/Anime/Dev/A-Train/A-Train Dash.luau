  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Pirates = ReplicatedStorage:FindFirstChild("Client Assets").Pirates;
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();

return function(p2) -- Line: 12
    -- upvalues: Pirates (copy), TweenService (copy), u1 (copy)
    local Character = p2.Character;
    local Start = p2.Start;
    local End = p2.End;
    task.spawn(function() -- Line: 20
        -- upvalues: Pirates (ref), Start (copy), End (copy), TweenService (ref), u1 (ref)
        for i = 0, 2 do
            local v3 = Pirates.Cutlass.PierceMeshes.Shockwave:Clone();
            v3.Size = v3.Size * 2.65;
            v3.CFrame = Start:Lerp(End, (i + 0.5) / 3) * CFrame.Angles(1.5707963267948966, 0, 0);
            v3.Parent = workspace.Effects;
            task.delay(1, v3.Destroy, v3);
            TweenService:Create(v3, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 1,
                Size = v3.Size * 1.3,
                CFrame = v3.CFrame * CFrame.Angles(0, u1:NextNumber(0, 6.283185307179586), 0)
            }):Play();
            task.wait(0.025);
        end;
    end);
    local v4 = Pirates.Cutlass.PierceMeshes.Forward:Clone();
    v4.CFrame = Start * CFrame.Angles(0, -1.5707963267948966, 0);
    v4.Parent = workspace.Effects;
    task.delay(0.5, v4.Destroy, v4);
    TweenService:Create(v4, TweenInfo.new(0.425, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = Vector3.new(40, 0, 0),
        CFrame = v4.CFrame * CFrame.new(-20, 0, 0)
    }):Play();
    local v5 = Pirates.Cutlass.PierceMeshes.BlackCoil:Clone();
    v5.Size = v5.Size * 2;
    v5.CFrame = Start * CFrame.Angles(1.5707963267948966, 0, 0);
    v5.Parent = workspace.Effects;
    task.delay(0.65, v5.Destroy, v5);
    TweenService:Create(v5, TweenInfo.new(0.33, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = v5.Size * 1.25 + Vector3.new(0, 40, 0)
    }):Play();
    TweenService:Create(v5, TweenInfo.new(0.65, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Transparency = 1,
        CFrame = v5.CFrame * CFrame.new(0, -20, 0) * CFrame.Angles(0, u1:NextNumber(0, 6.283185307179586), 0)
    }):Play();
    local v6 = Pirates.Cutlass.PierceMeshes.WhiteCoil:Clone();
    v6.Size = v6.Size * 2;
    v6.CFrame = v4.CFrame;
    v6.Parent = workspace.Effects;
    task.delay(0.4, v6.Destroy, v6);
    local v7 = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    local v8 = {
        Size = Vector3.new(40, 0, 0)
    };
    local v9 = v6.CFrame * CFrame.new(-20, 0, 0);
    local Angles = CFrame.Angles;
    local v10 = u1:NextNumber(45, 180);
    v8.CFrame = v9 * Angles(math.rad(v10), 0, 0);
    TweenService:Create(v6, v7, v8):Play();
    local v11 = Pirates.Cutlass.PierceMeshes.Release:Clone();
    v11.CFrame = Start * CFrame.Angles(0, u1:NextNumber(0, 6.283185307179586), 0);
    v11.Parent = workspace.Effects;
    task.delay(0.65, v11.Destroy, v11);
    local v12 = v11.Size * 1.5;
    local v13 = v12.Y - v11.Size.Y;
    TweenService:Create(v11, TweenInfo.new(0.65, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = v12,
        CFrame = v11.CFrame * CFrame.Angles(0, u1:NextNumber(0, 6.283185307179586), 0) * CFrame.new(0, v13 / 2, 0)
    }):Play();
    task.wait(0.15);
    local CFrame2 = Character.HumanoidRootPart.CFrame;
    local v14 = p2.TweenDelay or 0;
    local v15 = p2.Lifetime or 0.18;
    local Model = Instance.new("Model");
    task.delay(v15 + v14, Model.Destroy, Model);
    local v16 = Instance.fromExisting(Character.HumanoidRootPart);
    v16.Anchored = true;
    v16.CFrame = CFrame2;
    v16.Parent = Model;
    Model.PrimaryPart = v16;
    local v17 = next;
    local v18, v19 = Character:GetChildren();

    for _, v in v17, v18, v19 do
        if not v:IsA("Model") and (not v:IsA("LuaSourceContainer") and (not v:IsA("Folder") and v.Archivable)) then
            local v20 = v:Clone();
            local v21 = next;
            local v22, v23 = v20:GetDescendants();

            for _, v2 in v21, v22, v23 do
                if v2:IsA("Sound") or (v2:IsA("ParticleEmitter") or (v2:IsA("Trail") or (v2:IsA("LuaSourceContainer") or (v2:IsA("Folder") or (v2:IsA("Motor6D") or v2:IsA("Weld") and v2.Name ~= "AfterimageWeld"))))) or v2:IsA("BillboardGui") then
                    v2:Destroy();
                end;
            end;

            if v20:IsA("Humanoid") then
                v20.DisplayDistanceType = "None";
                v20.HealthDisplayType = "AlwaysOff";
                v20.BreakJointsOnDeath = false;
                v20.EvaluateStateMachine = false;
                v20.RequiresNeck = false;
                v20.AutomaticScalingEnabled = false;
            end;

            if v20:IsA("Accessory") then
                v20 = v20:FindFirstChild("handle") or v20:FindFirstChild("Handle");
                local v = v:FindFirstChild("handle") or v:FindFirstChild("Handle");
            end;

            if v20:IsA("BasePart") and v20.Transparency < 1 then
                v20.CollisionGroup = "FX";
                v20.CanCollide = false;
                v20.CanQuery = false;
                v20.Anchored = false;
                v20.CastShadow = false;
                v20.CFrame = CFrame2 * CFrame2:ToObjectSpace(v.CFrame);
                local ManualWeld = Instance.new("ManualWeld");
                ManualWeld.Name = "AfterimageWeld";
                ManualWeld.Part0 = v20;
                ManualWeld.Part1 = v16;
                ManualWeld.C0 = ManualWeld.Part0.CFrame:ToObjectSpace(ManualWeld.Part1.CFrame);
                ManualWeld.Parent = v16;
                local v24 = TweenService:Create(v20, TweenInfo.new(v15 * 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, v15 * 0.75), {
                    Transparency = 1
                });
                task.delay(v14, v24.Play, v24);
            end;

            v20.Parent = Model;
        end;
    end;

    Model.Parent = workspace.Effects;
    Model.PrimaryPart.CFrame = Start;
    TweenService:Create(Model.PrimaryPart, TweenInfo.new(v15, Enum.EasingStyle.Linear), {
        CFrame = End
    }):Play();
end;