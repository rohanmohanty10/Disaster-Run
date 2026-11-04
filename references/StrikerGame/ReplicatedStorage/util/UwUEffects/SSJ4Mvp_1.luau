 
 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local MeshEmit = require(ReplicatedStorage.MeshEmit);
local RotationController = require(ReplicatedStorage.RotationController);

return {
    [0] = function(p1, p2) -- Line: 9
        local Meshes = p1.Meshes;
        local _ = p1.Cache;
        local Cam = p1.Character.HumanoidRootPart.Cam;

        for _, descendant in pairs(Cam.Cam3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Cam.Cam4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Meshes.VFX.Aura3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Cam.Cam2Red:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(p2.Head.Eye2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Cam.Cam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = false;
            end;
        end;
    end,

    [0.2833333333333333] = function(p3, p4) -- Line: 52
        local _ = p3.Cache;
        local Cam = p3.Character.HumanoidRootPart.Cam;

        for _, descendant in pairs(p3.Meshes.VFX.Eye:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(Cam.Cam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(p4.Head.Eye1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.2843333333333333] = function(p5, p6) -- Line: 77
        -- upvalues: MeshEmit (copy)
        local _ = p5.Character;
        local _ = p5.Cache;

        for _, v in {
            MeshVFX = p5.Meshes.MeshVFX.VFX1
        } do
            MeshEmit(v.Start);
        end;
    end,

    [1.1166666666666667] = function(p7, p8) -- Line: 90
        -- upvalues: TweenService (copy), RotationController (copy)
        local Meshes = p7.Meshes;
        local Cache = p7.Cache;
        local Cam = p7.Character.HumanoidRootPart.Cam;

        for _, descendant in Cam.Cam:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in Cam.Cam2:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Meshes.VFX.Aura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Meshes.VFX.Ground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = true;
            end;
        end;

        local u9 = Meshes.VFX.Beam:Clone();
        table.insert(Cache, u9);
        u9.Parent = workspace.Effects;

        for _, descendant in pairs(u9:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                local Keypoints = descendant.Transparency.Keypoints;
                local NumberValue = Instance.new("NumberValue");
                table.insert(Cache, NumberValue);
                NumberValue.Value = 0;
                NumberValue.Parent = workspace.Effects;
                NumberValue.Changed:Connect(function(p10) -- Line: 139
                    -- upvalues: descendant (copy), Keypoints (copy)
                    descendant.Transparency = NumberSequence.new(Keypoints);
                end);
                local v11 = TweenService:Create(NumberValue, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Value = 1
                });
                v11:Play();
                RotationController.StartRotation(u9, 2, -0.3);
                task.spawn(function() -- Line: 150
                    -- upvalues: u9 (copy), TweenService (ref)
                    for _, descendant2 in pairs(u9:GetDescendants()) do
                        if descendant2:IsA("Beam") then
                            descendant2.TextureSpeed = descendant2.TextureSpeed;
                            TweenService:Create(descendant2, TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                TextureSpeed = 0
                            }):Play();
                            TweenService:Create(descendant2, TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Width0 = 0,
                                Width1 = 0
                            }):Play();
                        end;
                    end;
                end);
                v11.Completed:Connect(function() -- Line: 169
                    -- upvalues: Cache (copy), descendant (copy), Keypoints (copy), TweenService (ref), NumberValue (copy)
                    local NumberValue2 = Instance.new("NumberValue");
                    table.insert(Cache, NumberValue2);
                    NumberValue2.Value = 0;
                    NumberValue2.Parent = descendant;
                    NumberValue2.Changed:Connect(function(p12) -- Line: 174
                        -- upvalues: Keypoints (ref), descendant (ref)
                        local v13 = {};

                        for _, v in ipairs(Keypoints) do
                            table.insert(v13, NumberSequenceKeypoint.new(v.Time, v.Value + (1 - v.Value) * p12));
                        end;

                        descendant.Transparency = NumberSequence.new(v13);
                    end);
                    local v14 = TweenService:Create(NumberValue2, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
                        Value = 1
                    });
                    v14:Play();
                    v14.Completed:Connect(function() -- Line: 188
                        -- upvalues: Keypoints (ref), descendant (ref), TweenService (ref), NumberValue2 (copy), NumberValue (ref)
                        local v15 = {};

                        for _, v in ipairs(Keypoints) do
                            table.insert(v15, NumberSequenceKeypoint.new(v.Time, 1));
                        end;

                        descendant.Transparency = NumberSequence.new(v15);
                        TweenService:Create(descendant, TweenInfo.new(0.3), {
                            TextureSpeed = 0
                        }):Play();
                        NumberValue2:Destroy();
                        NumberValue:Destroy();
                    end);
                end);
            end;
        end;

        task.wait(3);
        u9:Destroy();
    end,

    [1.1176666666666666] = function(p16, p17) -- Line: 207
        -- upvalues: Lighting (copy), TweenService (copy)
        local _ = p16.Character;
        local Meshes = p16.Meshes;
        local Cache = p16.Cache;
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        table.insert(Cache, ColorCorrectionEffect);
        ColorCorrectionEffect.Name = "ImpactFrame";
        ColorCorrectionEffect.Parent = Lighting;
        local VFX = Meshes.VFX;
        local u18 = { "White", "Blue", "White", "Black", "White" };
        task.spawn(function() -- Line: 219
            -- upvalues: u18 (copy), VFX (copy), Cache (copy), Lighting (ref), ColorCorrectionEffect (copy)
            for _, v in ipairs(u18) do
                local v19 = VFX:FindFirstChild(v);

                if v19 then
                    local v20 = v19:Clone();
                    table.insert(Cache, v20);
                    v20.Parent = Lighting;
                    local Saturation = ColorCorrectionEffect.Saturation;
                    ColorCorrectionEffect.Saturation = 0;
                    task.wait(0.025);
                    ColorCorrectionEffect.Saturation = Saturation;
                    v20:Destroy();
                end;
            end;
        end);
        task.spawn(function() -- Line: 237
            -- upvalues: Meshes (copy), TweenService (ref)
            TweenService:Create(Meshes.VFX.Box, TweenInfo.new(0.01, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Transparency = 0
            }):Play();
        end);
    end,

    [2.75] = function(p21, p22) -- Line: 244
        -- upvalues: MeshEmit (copy)
        local _ = p21.Character;
        local Meshes = p21.Meshes;
        local _ = p21.Cache;

        for _, v in {
            MeshVFX = Meshes.MeshVFX.VFX2,
            MeshVFX2 = Meshes.MeshVFX.VFX3
        } do
            MeshEmit(v.Start);
        end;
    end,

    [2.751] = function(p23, p24) -- Line: 258
        -- upvalues: TweenService (copy)
        local Meshes = p23.Meshes;
        local _ = p23.Cache;

        for _, descendant in pairs(p23.Character.HumanoidRootPart.Cam.Cam2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        task.spawn(function() -- Line: 271
            -- upvalues: Meshes (copy), TweenService (ref)
            TweenService:Create(Meshes.VFX.Box, TweenInfo.new(0.01, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end);
    end,

    [3.7333333333333334] = function(p25, p26) -- Line: 278
        local Meshes = p25.Meshes;
        local _ = p25.Cache;
        local Cam = p25.Character.HumanoidRootPart.Cam;

        for _, descendant in pairs(Cam.Cam2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(p26.Head.Eye1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(p26.Head.Eye2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Cam.Cam2Red:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Cam.Cam3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Cam.Cam4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Meshes.VFX.Aura2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Meshes.VFX.Ground2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Meshes.VFX.Aura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Meshes.VFX.Ground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = false;
            end;
        end;
    end,

    [3.7343333333333333] = function(p27, p28) -- Line: 345
        -- upvalues: Lighting (copy)
        local _ = p27.Character;
        local Meshes = p27.Meshes;
        local Cache = p27.Cache;
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        table.insert(Cache, ColorCorrectionEffect);
        ColorCorrectionEffect.Name = "ImpactFrame";
        ColorCorrectionEffect.Parent = Lighting;
        local VFX = Meshes.VFX;
        local u29 = { "White", "Blue", "White", "Black", "White" };
        task.spawn(function() -- Line: 357
            -- upvalues: u29 (copy), VFX (copy), Cache (copy), Lighting (ref), ColorCorrectionEffect (copy)
            for _, v in ipairs(u29) do
                local v30 = VFX:FindFirstChild(v);

                if v30 then
                    local v31 = v30:Clone();
                    table.insert(Cache, v31);
                    v31.Parent = Lighting;
                    local Saturation = ColorCorrectionEffect.Saturation;
                    ColorCorrectionEffect.Saturation = 0;
                    task.wait(0.04);
                    ColorCorrectionEffect.Saturation = Saturation;
                    v31:Destroy();
                end;
            end;
        end);
    end,

    [5.25] = function(p32, p33) -- Line: 375
        -- upvalues: Lighting (copy)
        local _ = p32.Character;
        local Meshes = p32.Meshes;
        local Cache = p32.Cache;
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        table.insert(Cache, ColorCorrectionEffect);
        ColorCorrectionEffect.Name = "ImpactFrame";
        ColorCorrectionEffect.Parent = Lighting;
        local VFX = Meshes.VFX;
        local u34 = { "White", "Blue", "White", "Black", "White" };
        task.spawn(function() -- Line: 387
            -- upvalues: u34 (copy), VFX (copy), Cache (copy), Lighting (ref), ColorCorrectionEffect (copy)
            for _, v in ipairs(u34) do
                local v35 = VFX:FindFirstChild(v);

                if v35 then
                    local v36 = v35:Clone();
                    table.insert(Cache, v36);
                    v36.Parent = Lighting;
                    local Saturation = ColorCorrectionEffect.Saturation;
                    ColorCorrectionEffect.Saturation = 0;
                    task.wait(0.04);
                    ColorCorrectionEffect.Saturation = Saturation;
                    v36:Destroy();
                end;
            end;
        end);
    end,

    [5.251] = function(p37, p38) -- Line: 405
        -- upvalues: TweenService (copy), RotationController (copy)
        local _ = p37.Character;
        local Cache = p37.Cache;
        local u39 = p37.Meshes.VFX.Beam2:Clone();
        table.insert(Cache, u39);
        u39.Parent = workspace.Effects;

        for _, descendant in pairs(u39:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                local Keypoints = descendant.Transparency.Keypoints;
                local NumberValue = Instance.new("NumberValue");
                table.insert(Cache, NumberValue);
                NumberValue.Value = 0;
                NumberValue.Parent = workspace.Effects;
                NumberValue.Changed:Connect(function(p40) -- Line: 426
                    -- upvalues: descendant (copy), Keypoints (copy)
                    descendant.Transparency = NumberSequence.new(Keypoints);
                end);
                local v41 = TweenService:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Value = 1
                });
                v41:Play();
                RotationController.StartRotation(u39, 2, -0.3);
                task.spawn(function() -- Line: 437
                    -- upvalues: u39 (copy), TweenService (ref)
                    for _, descendant2 in pairs(u39:GetDescendants()) do
                        if descendant2:IsA("Beam") then
                            descendant2.TextureSpeed = descendant2.TextureSpeed;
                            TweenService:Create(descendant2, TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                TextureSpeed = 0
                            }):Play();
                            TweenService:Create(descendant2, TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Width0 = 0,
                                Width1 = 0
                            }):Play();
                        end;
                    end;
                end);
                v41.Completed:Connect(function() -- Line: 456
                    -- upvalues: Cache (copy), descendant (copy), Keypoints (copy), TweenService (ref), NumberValue (copy)
                    local NumberValue2 = Instance.new("NumberValue");
                    table.insert(Cache, NumberValue2);
                    NumberValue2.Value = 0;
                    NumberValue2.Parent = descendant;
                    NumberValue2.Changed:Connect(function(p42) -- Line: 461
                        -- upvalues: Keypoints (ref), descendant (ref)
                        local v43 = {};

                        for _, v in ipairs(Keypoints) do
                            table.insert(v43, NumberSequenceKeypoint.new(v.Time, v.Value + (1 - v.Value) * p42));
                        end;

                        descendant.Transparency = NumberSequence.new(v43);
                    end);
                    local v44 = TweenService:Create(NumberValue2, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
                        Value = 1
                    });
                    v44:Play();
                    v44.Completed:Connect(function() -- Line: 475
                        -- upvalues: Keypoints (ref), descendant (ref), TweenService (ref), NumberValue2 (copy), NumberValue (ref)
                        local v45 = {};

                        for _, v in ipairs(Keypoints) do
                            table.insert(v45, NumberSequenceKeypoint.new(v.Time, 1));
                        end;

                        descendant.Transparency = NumberSequence.new(v45);
                        TweenService:Create(descendant, TweenInfo.new(0.3), {
                            TextureSpeed = 0
                        }):Play();
                        NumberValue2:Destroy();
                        NumberValue:Destroy();
                    end);
                end);
            end;
        end;

        task.wait(3);
        u39:Destroy();
    end,

    [6.583333333333333] = function(p46, p47) -- Line: 494
        local Meshes = p46.Meshes;
        local _ = p46.Cache;
        local Cam = p46.Character.HumanoidRootPart.Cam;

        for _, descendant in pairs(Meshes.VFX.Ground2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Meshes.VFX.Aura3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Meshes.VFX.Aura2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Cam.Cam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = true;
            end;
        end;
    end,

    [8] = function() -- Line: 525
    end
};