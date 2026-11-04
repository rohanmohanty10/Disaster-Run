 
 

local v1 = {};
local RunService = game:GetService("RunService");

({}).Trash = function(u2, p3) -- Line: 5, Name: Trash
    task.delay(p3 or 1, function() -- Line: 6
        -- upvalues: u2 (copy)
        pcall(game.Destroy, u2);
    end);
end;

local function emit(p4) -- Line: 11
    for _, v in p4:QueryDescendants("ParticleEmitter") do
        v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
    end;
end;

local function enable(p5, p6) -- Line: 16
    for _, v in p5:QueryDescendants("ParticleEmitter, Beam, Trail, SurfaceLight, SpotLight, PointLight") do
        v.Enabled = true;
        task.delay(p6, function() -- Line: 19
            -- upvalues: v (copy)
            v.Enabled = false;
        end);
    end;
end;

function v1.template(p7: table) -- Line: 23
    p7.Character:FindFirstChild("HumanoidRootPart");
end;

function v1.Start(p8: table) -- Line: 27
    -- upvalues: enable (copy)
    local HumanoidRootPart = p8.Character:FindFirstChild("HumanoidRootPart");
    local u9 = script.VFX.TrailsStart:Clone();
    u9.Parent = HumanoidRootPart;
    u9:PivotTo(HumanoidRootPart.CFrame);
    enable(u9, 0.6);
    task.delay(0.6, function() -- Line: 6
        -- upvalues: u9 (copy)
        pcall(game.Destroy, u9);
    end);
    local u10 = script.VFX.LightStart:Clone();
    u10.Parent = HumanoidRootPart;
    u10:PivotTo(HumanoidRootPart.CFrame);
    enable(u10, 0.6);
    task.delay(0.6, function() -- Line: 6
        -- upvalues: u10 (copy)
        pcall(game.Destroy, u10);
    end);
    local TweenService = game:GetService("TweenService");
    local u11 = script.VFX.Cam:Clone();
    u11.Parent = HumanoidRootPart;
    u11:PivotTo(HumanoidRootPart.CFrame);
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Parent = u11;
    local u12 = {};
    local u13 = {};

    for _, descendant in u11:GetDescendants() do
        if descendant:IsA("Beam") then
            descendant.Enabled = true;
            local Keypoints = descendant.Transparency.Keypoints;
            u12[descendant] = Keypoints[math.ceil(#Keypoints / 2)].Value;
            local v15 = NumberValue.Changed:Connect(function(p14) -- Line: 61
                -- upvalues: u12 (copy), descendant (copy)
                descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, u12[descendant] + (1 - u12[descendant]) * p14), NumberSequenceKeypoint.new(1, 1) });
            end);
            table.insert(u13, v15);
        end;
    end;

    NumberValue.Value = 0;
    task.wait(0.4);
    local v16 = TweenService:Create(NumberValue, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
        Value = 1
    });
    v16:Play();
    v16.Completed:Connect(function() -- Line: 77
        -- upvalues: u13 (copy), NumberValue (copy), u11 (copy)
        task.wait(1);

        for _, v in u13 do
            v:Disconnect();
        end;

        NumberValue:Destroy();

        for _, descendant in u11:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(0.8, function() -- Line: 6
        -- upvalues: u11 (copy)
        pcall(game.Destroy, u11);
    end);
end;

function v1.TragicBackGround(p17: table) -- Line: 91
    -- upvalues: enable (copy)
    local HumanoidRootPart = p17.Character:FindFirstChild("HumanoidRootPart");
    local u18 = script.VFX.TragicBackground:Clone();
    u18.Parent = HumanoidRootPart;
    u18:PivotTo(HumanoidRootPart.CFrame);
    enable(u18, 0.85);
    task.delay(0.85, function() -- Line: 6
        -- upvalues: u18 (copy)
        pcall(game.Destroy, u18);
    end);
    local u19 = script.VFX.Domain:Clone();
    u19.Parent = HumanoidRootPart;
    u19:PivotTo(HumanoidRootPart.CFrame);
    enable(u19, 0.85);
    task.delay(0.85, function() -- Line: 6
        -- upvalues: u19 (copy)
        pcall(game.Destroy, u19);
    end);
    local u20 = script.VFX.LightTragic:Clone();
    u20.Parent = HumanoidRootPart;
    u20:PivotTo(HumanoidRootPart.CFrame);
    enable(u20, 0.85);
    task.delay(0.85, function() -- Line: 6
        -- upvalues: u20 (copy)
        pcall(game.Destroy, u20);
    end);
    local u21 = script.VFX.TragicCam:Clone();
    u21.Parent = HumanoidRootPart;
    u21:PivotTo(HumanoidRootPart.CFrame);
    enable(u21, 0.85);
    task.delay(0.85, function() -- Line: 6
        -- upvalues: u21 (copy)
        pcall(game.Destroy, u21);
    end);
end;

function v1.Step(p22: table) -- Line: 120
    -- upvalues: enable (copy)
    local HumanoidRootPart = p22.Character:FindFirstChild("HumanoidRootPart");
    local u23 = script.VFX.StepLight:Clone();
    u23.Parent = HumanoidRootPart;
    u23:PivotTo(HumanoidRootPart.CFrame);
    enable(u23, 0.517);
    task.delay(0.517, function() -- Line: 6
        -- upvalues: u23 (copy)
        pcall(game.Destroy, u23);
    end);
    local u24 = script.VFX.CameraStep:Clone();
    u24:PivotTo(HumanoidRootPart.CFrame);
    u24.Parent = HumanoidRootPart;
    enable(u24, 0.517);
    task.delay(0.517, function() -- Line: 6
        -- upvalues: u24 (copy)
        pcall(game.Destroy, u24);
    end);
end;

function v1.ActualStep(p25: table) -- Line: 135
    -- upvalues: emit (copy)
    local HumanoidRootPart = p25.Character:FindFirstChild("HumanoidRootPart");
    local u26 = script.VFX.Step:Clone();
    u26.Parent = HumanoidRootPart;
    u26:PivotTo(HumanoidRootPart.CFrame);
    emit(u26);
    task.delay(1, function() -- Line: 6
        -- upvalues: u26 (copy)
        pcall(game.Destroy, u26);
    end);
end;

function v1.Transition(p27: table) -- Line: 144
    -- upvalues: enable (copy)
    local HumanoidRootPart = p27.Character:FindFirstChild("HumanoidRootPart");
    local u28 = script.VFX.Transition:Clone();
    u28.Parent = HumanoidRootPart;
    u28:PivotTo(HumanoidRootPart.CFrame);
    enable(u28, 0.1);
    task.delay(0.1, function() -- Line: 6
        -- upvalues: u28 (copy)
        pcall(game.Destroy, u28);
    end);
end;

function v1.AuraFarm(p29: table) -- Line: 154
    -- upvalues: enable (copy), RunService (copy)
    local HumanoidRootPart = p29.Character:FindFirstChild("HumanoidRootPart");
    local u30 = p29.Camera and p29.Camera.camera;
    local u31 = script.VFX.LightPose:Clone();
    u31.Parent = HumanoidRootPart;
    u31:PivotTo(HumanoidRootPart.CFrame);
    enable(u31, 1.15);
    task.delay(1.15, function() -- Line: 6
        -- upvalues: u31 (copy)
        pcall(game.Destroy, u31);
    end);

    if u30 then
        local u32 = script.VFX.Background:Clone();
        local u33 = script.VFX.CamAura:Clone();
        local u34 = u32.Background.CFrame:ToObjectSpace(u32:GetPivot());
        local u35 = u33.CamAura.CFrame:ToObjectSpace(u33:GetPivot());
        local v36 = RunService.RenderStepped:Connect(function() -- Line: 167
            -- upvalues: u32 (copy), u30 (copy), u34 (copy), u33 (copy), u35 (copy)
            u32:PivotTo(u30.CFrame * u34);
            u33:PivotTo(u30.CFrame * u35);
        end);
        u32:PivotTo(u30.CFrame * u34);
        u33:PivotTo(u30.CFrame * u35);
        u32.Parent = HumanoidRootPart;
        u33.Parent = HumanoidRootPart;
        enable(u32, 1.15);
        enable(u33, 1.15);
        task.delay(1.15, function() -- Line: 6
            -- upvalues: u32 (copy)
            pcall(game.Destroy, u32);
        end);
        task.delay(1.15, function() -- Line: 6
            -- upvalues: u33 (copy)
            pcall(game.Destroy, u33);
        end);
        task.delay(1.15, v36.Disconnect, v36);
    end;

    local u37 = script.VFX.HeadFX:Clone();
    u37.Parent = HumanoidRootPart;
    u37:PivotTo(HumanoidRootPart.CFrame);
    enable(u37, 1.15);
    task.delay(1.15, function() -- Line: 6
        -- upvalues: u37 (copy)
        pcall(game.Destroy, u37);
    end);
    local u38 = script.VFX.Domain2:Clone();
    u38.Parent = HumanoidRootPart;
    u38:PivotTo(HumanoidRootPart.CFrame);
    enable(u38, 1.15);
    task.delay(1.15, function() -- Line: 6
        -- upvalues: u38 (copy)
        pcall(game.Destroy, u38);
    end);
end;

function v1.ActualStep2(p39: table) -- Line: 193
    -- upvalues: emit (copy), enable (copy)
    local HumanoidRootPart = p39.Character:FindFirstChild("HumanoidRootPart");
    local u40 = script.VFX.Step2:Clone();
    u40.Parent = HumanoidRootPart;
    u40:PivotTo(HumanoidRootPart.CFrame);
    emit(u40);
    task.delay(1, function() -- Line: 6
        -- upvalues: u40 (copy)
        pcall(game.Destroy, u40);
    end);
    local u41 = script.VFX.StepLight2:Clone();
    u41.Parent = HumanoidRootPart;
    u41:PivotTo(HumanoidRootPart.CFrame);
    enable(u41, 0.3);
    task.delay(0.3, function() -- Line: 6
        -- upvalues: u41 (copy)
        pcall(game.Destroy, u41);
    end);
end;

function v1.LastAura(p42: table) -- Line: 207
    -- upvalues: enable (copy), emit (copy)
    local HumanoidRootPart = p42.Character:FindFirstChild("HumanoidRootPart");
    local u43 = script.VFX.CamEnd:Clone();
    u43.Parent = HumanoidRootPart;
    u43:PivotTo(HumanoidRootPart.CFrame);
    enable(u43, 2.016);
    task.delay(2.016, function() -- Line: 6
        -- upvalues: u43 (copy)
        pcall(game.Destroy, u43);
    end);
    local u44 = script.VFX.LightEnd:Clone();
    u44.Parent = HumanoidRootPart;
    u44:PivotTo(HumanoidRootPart.CFrame);
    enable(u44, 2.016);
    task.delay(2.016, function() -- Line: 6
        -- upvalues: u44 (copy)
        pcall(game.Destroy, u44);
    end);
    local u45 = script.VFX.ImpactLast:Clone();
    u45.Parent = HumanoidRootPart;
    u45:PivotTo(HumanoidRootPart.CFrame);
    emit(u45);
    task.delay(2.016, function() -- Line: 6
        -- upvalues: u45 (copy)
        pcall(game.Destroy, u45);
    end);
end;

return v1;