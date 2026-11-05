  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local Debris = game:GetService("Debris");
local UtilityLibrary = require(game:GetService("ReplicatedStorage").ReplicatedModules.UtilityLibrary);

return function(p2, p3, p4) -- Line: 9
    -- upvalues: Players (copy), u1 (copy), UtilityLibrary (copy), TweenService (copy), RunService (copy), CollectionService (copy), Debris (copy)
    local u5, v6 = unpack(p4);
    local v7 = v6 or 0;
    local v8 = Players:GetPlayerFromCharacter(p2);

    if not p2:FindFirstChild("Humanoid") then
        p2 = p2.Parent;
    end;

    local Stand = p2:FindFirstChild("Stand");
    local u9 = u1[p3].BarrageArms["Stand Left Arm"];
    local u10 = u1[p3].BarrageArms["Stand Right Arm"];
    local u11 = { u1[p3].BarrageArms.Colors:GetAttribute("Color1"), u1[p3].BarrageArms.Colors:GetAttribute("Color2") };
    local v12 = Stand:GetAttribute("SkinName");

    if v12 and u1[p3]:FindFirstChild(v12) then
        u9 = u1[p3][v12]["Stand Left Arm"];
        u10 = u1[p3][v12]["Stand Right Arm"];

        if u1[p3][v12]:FindFirstChild("Colors") then
            u11 = { u1[p3][v12].Colors:GetAttribute("Color1"), u1[p3][v12].Colors:GetAttribute("Color2") };
        end;
    end;

    local u13 = -3.5 + v7;
    local u14 = -5 + v7;
    local u15 = -11 + v7;
    local u16 = 0;
    local u17 = 0;

    local function EnableTrailEffects(p18) -- Line: 65
        -- upvalues: u11 (ref)
        local TrailAttachment = p18:FindFirstChild("TrailAttachment");

        if TrailAttachment then
            local v19 = math.random(1, 2);

            for _, child in pairs(TrailAttachment:GetChildren()) do
                if child:IsA("Trail") then
                    child.Color = ColorSequence.new(u11[v19]);
                    child.Enabled = true;
                end;
            end;

            local TrailEffect = p18:FindFirstChild("TrailEffect");

            if TrailEffect then
                TrailEffect.Specs.Color = ColorSequence.new(u11[v19]);
                coroutine.wrap(function() -- Line: 82
                    -- upvalues: TrailEffect (copy)
                    TrailEffect.Specs.Enabled = true;
                    task.wait(0.17);
                    TrailEffect.Specs.Enabled = false;
                end)();
            end;
        end;
    end;

    local u35 = { function() -- Line: 94
            -- upvalues: u5 (copy), u13 (copy), u14 (copy), u15 (copy), UtilityLibrary (ref), u9 (ref), EnableTrailEffects (copy), TweenService (ref), RunService (ref)
            local v20 = u5.CFrame * CFrame.new(-2, 0, u13);
            local v21 = u5.CFrame * CFrame.new(-5, 1.5, u14);
            local v22 = u5.CFrame * CFrame.new(0, -1.5, u15);
            local u23 = UtilityLibrary.CreateBezierCurve(v20, v21, v22, 17);
            local u24 = u9:Clone();
            u24.CFrame = u5.CFrame;
            u24.Parent = workspace.Effects;
            EnableTrailEffects(u24);
            coroutine.wrap(function() -- Line: 107
                -- upvalues: TweenService (ref), u24 (copy)
                wait(0.2);
                TweenService:Create(u24, TweenInfo.new(0.1), {
                    Transparency = 1
                }):Play();

                for _, child in pairs(u24:GetChildren()) do
                    if child:IsA("BasePart") or child:IsA("MeshPart") then
                        TweenService:Create(child, TweenInfo.new(0.1), {
                            Size = Vector3.new()
                        }):Play();
                    end;
                end;
            end)();
            coroutine.wrap(function() -- Line: 118
                -- upvalues: u23 (copy), u24 (copy), RunService (ref)
                for i = 1, #u23 do
                    if u23[i + 1] then
                        u24.CFrame = CFrame.new(u23[i].Position, u23[i + 1].Position) * CFrame.Angles(1.5707963267948966, 0, 0);
                        RunService.Heartbeat:Wait();
                    end;
                end;

                wait(0.365);
                u24:Destroy();
            end)();
        end, function() -- Line: 129
            -- upvalues: u5 (copy), u13 (copy), u14 (copy), u15 (copy), UtilityLibrary (ref), u9 (ref), EnableTrailEffects (copy), TweenService (ref), RunService (ref)
            local v25 = u5.CFrame * CFrame.new(-1, 0, u13);
            local v26 = u5.CFrame * CFrame.new(-4, 5, u14);
            local v27 = u5.CFrame * CFrame.new(0, 0, u15);
            local u28 = UtilityLibrary.CreateBezierCurve(v25, v26, v27, 17);
            local u29 = u9:Clone();
            u29.CFrame = u5.CFrame;
            u29.Parent = workspace.Effects;
            EnableTrailEffects(u29);
            coroutine.wrap(function() -- Line: 142
                -- upvalues: TweenService (ref), u29 (copy)
                wait(0.2);
                TweenService:Create(u29, TweenInfo.new(0.1), {
                    Transparency = 1
                }):Play();

                for _, child in pairs(u29:GetChildren()) do
                    if child:IsA("BasePart") or child:IsA("MeshPart") then
                        TweenService:Create(child, TweenInfo.new(0.1), {
                            Size = Vector3.new()
                        }):Play();
                    end;
                end;
            end)();
            coroutine.wrap(function() -- Line: 153
                -- upvalues: u28 (copy), u29 (copy), RunService (ref)
                for i = 1, #u28 do
                    if u28[i + 1] then
                        u29.CFrame = CFrame.new(u28[i].Position, u28[i + 1].Position) * CFrame.Angles(1.5707963267948966, 0, 0);
                        RunService.Heartbeat:Wait();
                    end;
                end;

                wait(0.365);
                u29:Destroy();
            end)();
        end, function() -- Line: 164
            -- upvalues: u5 (copy), u13 (copy), u14 (copy), u15 (copy), UtilityLibrary (ref), u9 (ref), EnableTrailEffects (copy), TweenService (ref), RunService (ref)
            local v30 = u5.CFrame * CFrame.new(-2, 0, u13);
            local v31 = u5.CFrame * CFrame.new(-5, -2, u14);
            local v32 = u5.CFrame * CFrame.new(0, 0, u15);
            local u33 = UtilityLibrary.CreateBezierCurve(v30, v31, v32, 17);
            local u34 = u9:Clone();
            u34.CFrame = u5.CFrame;
            u34.Parent = workspace.Effects;
            EnableTrailEffects(u34);
            coroutine.wrap(function() -- Line: 177
                -- upvalues: TweenService (ref), u34 (copy)
                wait(0.2);
                TweenService:Create(u34, TweenInfo.new(0.1), {
                    Transparency = 1
                }):Play();

                for _, child in pairs(u34:GetChildren()) do
                    if child:IsA("BasePart") or child:IsA("MeshPart") then
                        TweenService:Create(child, TweenInfo.new(0.1), {
                            Size = Vector3.new()
                        }):Play();
                    end;
                end;
            end)();
            coroutine.wrap(function() -- Line: 188
                -- upvalues: u33 (copy), u34 (copy), RunService (ref)
                for i = 1, #u33 do
                    if u33[i + 1] then
                        u34.CFrame = CFrame.new(u33[i].Position, u33[i + 1].Position) * CFrame.Angles(1.5707963267948966, 0, 0);
                        RunService.Heartbeat:Wait();
                    end;
                end;

                wait(0.365);
                u34:Destroy();
            end)();
        end };
    local u51 = { function() -- Line: 202
            -- upvalues: u5 (copy), u13 (copy), u14 (copy), u15 (copy), UtilityLibrary (ref), u10 (ref), EnableTrailEffects (copy), TweenService (ref), RunService (ref)
            local v36 = u5.CFrame * CFrame.new(2, 0, u13);
            local v37 = u5.CFrame * CFrame.new(5, 1.5, u14);
            local v38 = u5.CFrame * CFrame.new(0, -1, u15);
            local u39 = UtilityLibrary.CreateBezierCurve(v36, v37, v38, 17);
            local u40 = u10:Clone();
            u40.CFrame = u5.CFrame;
            u40.Parent = workspace.Effects;
            EnableTrailEffects(u40);
            coroutine.wrap(function() -- Line: 215
                -- upvalues: TweenService (ref), u40 (copy)
                wait(0.2);
                TweenService:Create(u40, TweenInfo.new(0.1), {
                    Transparency = 1
                }):Play();

                for _, child in pairs(u40:GetChildren()) do
                    if child:IsA("BasePart") or child:IsA("MeshPart") then
                        TweenService:Create(child, TweenInfo.new(0.1), {
                            Size = Vector3.new()
                        }):Play();
                    end;
                end;
            end)();
            coroutine.wrap(function() -- Line: 226
                -- upvalues: u39 (copy), u40 (copy), RunService (ref)
                for i = 1, #u39 do
                    if u39[i + 1] then
                        u40.CFrame = CFrame.new(u39[i].Position, u39[i + 1].Position) * CFrame.Angles(1.5707963267948966, 0, 0);
                        RunService.Heartbeat:Wait();
                    end;
                end;

                wait(0.365);
                u40:Destroy();
            end)();
        end, function() -- Line: 237
            -- upvalues: u5 (copy), u13 (copy), u14 (copy), u15 (copy), UtilityLibrary (ref), u10 (ref), EnableTrailEffects (copy), TweenService (ref), RunService (ref)
            local v41 = u5.CFrame * CFrame.new(1, 0, u13);
            local v42 = u5.CFrame * CFrame.new(4, 5, u14);
            local v43 = u5.CFrame * CFrame.new(0, 0, u15);
            local u44 = UtilityLibrary.CreateBezierCurve(v41, v42, v43, 17);
            local u45 = u10:Clone();
            u45.CFrame = u5.CFrame;
            u45.Parent = workspace.Effects;
            EnableTrailEffects(u45);
            coroutine.wrap(function() -- Line: 250
                -- upvalues: TweenService (ref), u45 (copy)
                wait(0.2);
                TweenService:Create(u45, TweenInfo.new(0.1), {
                    Transparency = 1
                }):Play();

                for _, child in pairs(u45:GetChildren()) do
                    if child:IsA("BasePart") or child:IsA("MeshPart") then
                        TweenService:Create(child, TweenInfo.new(0.1), {
                            Size = Vector3.new()
                        }):Play();
                    end;
                end;
            end)();
            coroutine.wrap(function() -- Line: 261
                -- upvalues: u44 (copy), u45 (copy), RunService (ref)
                for i = 1, #u44 do
                    if u44[i + 1] then
                        u45.CFrame = CFrame.new(u44[i].Position, u44[i + 1].Position) * CFrame.Angles(1.5707963267948966, 0, 0);
                        RunService.Heartbeat:Wait();
                    end;
                end;

                wait(0.365);
                u45:Destroy();
            end)();
        end, function() -- Line: 272
            -- upvalues: u5 (copy), u13 (copy), u14 (copy), u15 (copy), UtilityLibrary (ref), u10 (ref), EnableTrailEffects (copy), TweenService (ref), RunService (ref)
            local v46 = u5.CFrame * CFrame.new(2, 0, u13);
            local v47 = u5.CFrame * CFrame.new(5, -2, u14);
            local v48 = u5.CFrame * CFrame.new(0, 0, u15);
            local u49 = UtilityLibrary.CreateBezierCurve(v46, v47, v48, 17);
            math.random(1, 2);
            local u50 = u10:Clone();
            u50.CFrame = u5.CFrame;
            u50.Parent = workspace.Effects;
            EnableTrailEffects(u50);
            coroutine.wrap(function() -- Line: 287
                -- upvalues: TweenService (ref), u50 (copy)
                wait(0.2);
                TweenService:Create(u50, TweenInfo.new(0.1), {
                    Transparency = 1
                }):Play();

                for _, child in pairs(u50:GetChildren()) do
                    if child:IsA("BasePart") or child:IsA("MeshPart") then
                        TweenService:Create(child, TweenInfo.new(0.1), {
                            Size = Vector3.new()
                        }):Play();
                    end;
                end;
            end)();
            coroutine.wrap(function() -- Line: 298
                -- upvalues: u49 (copy), u50 (copy), RunService (ref)
                for i = 1, #u49 do
                    if u49[i + 1] then
                        u50.CFrame = CFrame.new(u49[i].Position, u49[i + 1].Position) * CFrame.Angles(1.5707963267948966, 0, 0);
                        RunService.Heartbeat:Wait();
                    end;
                end;

                wait(0.365);
                u50:Destroy();
            end)();
        end };
    local u52 = true;

    if v8 then
        local u53 = nil;
        u53 = v8.CharacterRemoving:Connect(function() -- Line: 315
            -- upvalues: u53 (ref), u52 (ref)
            u53:Disconnect();

            if u52 then
                u52 = false;
            end;
        end);
    end;

    local v54 = u1.BarrageParticle:Clone();
    v54.CFrame = p2.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(-1.5707963267948966, 0, 0);
    v54.Anchored = true;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p2.HumanoidRootPart;
    WeldConstraint.Part1 = v54;
    WeldConstraint.Parent = v54;
    v54.Anchored = false;
    v54.Parent = workspace.Effects;

    for _, descendant in pairs(v54:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    while true do
        task.wait(0.06);
        local u55 = math.random(1, 3);
        local u56 = math.random(1, 3);

        if u16 == u55 then
            u55 = math.random(1, 3);
        end;

        if u17 == u56 then
            u56 = math.random(1, 3);
        end;

        coroutine.wrap(function() -- Line: 352
            -- upvalues: u16 (ref), u55 (ref), u35 (copy)
            u16 = u55;
            u35[u55]();
        end)();
        coroutine.wrap(function() -- Line: 357
            -- upvalues: u17 (ref), u56 (ref), u51 (copy)
            task.wait(0.0325);
            u17 = u56;
            u51[u56]();
        end)();

        if not u52 or (not CollectionService:HasTag(p2, "Barraging") or (p2.Humanoid.Health <= 0 or p2 == nil)) then
            for _, descendant in pairs(v54:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            Debris:AddItem(v54, 1.5);

            return;
        end;
    end;
end;