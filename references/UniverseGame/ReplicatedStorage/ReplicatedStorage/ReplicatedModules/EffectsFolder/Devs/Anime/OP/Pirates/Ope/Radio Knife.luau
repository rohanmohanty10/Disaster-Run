  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();

return function(u2, p3) -- Line: 15
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), LocalPlayer (copy), EffectsHandler (copy), u1 (copy), TweenService (copy)
    if not (u2 and (u2:IsDescendantOf(game) and u2:GetAttribute("RadioKnife"))) then
        return;
    end;

    local v4 = p3 or {};
    local v5 = {
        AbilityName = "Ope",
        SkinName = v4.SkinName
    };
    local v6 = v4.Speed or 1;
    local v7 = v4.StartFrame or 30;
    local HumanoidRootPart = u2:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    task.spawn(function() -- Line: 33
        -- upvalues: u2 (copy), ParticleHandler (ref)
        local Kikoku = u2:WaitForChild("Kikoku", 5);

        if Kikoku and Kikoku:WaitForChild("Handle", 2):WaitForChild("Emit", 2) then
            ParticleHandler.Emit(Kikoku.Handle.Emit, ParticleHandler.GenerateEmitInfo(Kikoku.Handle.Emit));
        end;
    end);
    local v8 = AssetHandler.GetAsset("Particles/RadioKnife/BodyCharge", v5):Clone();
    ParticleHandler.Unusualify(v8, {
        Character = u2
    });
    v8.Parent = u2;
    ParticleHandler.AttachTo(v8, {
        Part = u2.Torso,
        Offset = CFrame.identity
    });
    local v9 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    task.wait(v7 / 60 / v6);

    if not u2:IsDescendantOf(game) then
        return;
    end;

    while true do
        if u2:GetAttribute("Timestopped") then
            task.wait(0.1);
        else
            if v9 == u2 then
                task.spawn(EffectsHandler.CallEffect, "Camera Shake", { 0.4, 12, 0.1, 0.5, Vector3.new(0.25, 0.25, 0.25), Vector3.new(1, 1, 1) });
            end;

            local v10 = u1:NextNumber(0.11, 0.13);
            local v11 = v10 * 60 * 1.3;
            local CFrame2 = HumanoidRootPart.CFrame;
            local Angles = CFrame.Angles;
            local v12 = math.random(-30, 30);
            local v13 = math.random(1, 2) == 1 and 180 or 0;
            local v14 = CFrame2 * Angles(0, 0, (math.rad(v12 + v13)));
            task.spawn(EffectsHandler.CallEffect, "FlipbookSlash", {
                Time = 0.17,
                SurfaceDirection = "Bottom",
                Character = u2,
                SlashMesh = AssetHandler.GetAsset("Particles/RadioKnife/SlashMesh", v5),
                Flipbook = AssetHandler.GetAsset("Particles/RadioKnife/SlashBook", v5),
                Origin = v14 * CFrame.new(0, 0, u1:NextNumber(-1.35, -1.55)) * CFrame.Angles(0, -1.8325957145940461, 0),
                EndCFrame = CFrame.Angles(0, -1.6580627893946132, 0),
                Size = Vector3.new(v10, 0.15, v10) * 1.3,
                Color = Color3.fromRGB(500, 300, 1500)
            });
            local Folder = Instance.new("Folder");
            Folder.Parent = workspace.Effects;
            task.delay(1.5, Folder.Destroy, Folder);
            local v15 = AssetHandler.GetAsset("Particles/RadioKnife/BeamSlash", v5):Clone();
            ParticleHandler.Unusualify(v15, {
                Character = u2
            });
            v15.CFrame = v14 * CFrame.new(0, 0, -v11);
            v15.Parent = Folder;
            local v16 = AssetHandler.GetAsset("Particles/RadioKnife/Line", v5):Clone();
            ParticleHandler.Unusualify(v16, {
                Character = u2
            });
            v16.CFrame = v14 * CFrame.new(0, 0, -v11) * CFrame.Angles(0, 1.5707963267948966, 0);
            v16.Parent = Folder;
            task.delay(0.5, v16.Destroy, v16);
            local v17 = AssetHandler.GetAsset("Particles/RadioKnife/CircleHolder", v5):Clone();
            ParticleHandler.Unusualify(v17, {
                Character = u2
            });
            v17.CFrame = v14 * CFrame.Angles(0, 0, 1.5707963267948966);
            v17.Parent = Folder;
            ParticleHandler.Emit(Folder, ParticleHandler.GenerateEmitInfo(Folder));
            TweenService:Create(v16.Mesh, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Scale = Vector3.new(0, 0, 0.1)
            }):Play();
            TweenService:Create(v17, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                CFrame = v17.CFrame * CFrame.Angles(-1.6580627893946132, 0, 0)
            }):Play();
            EffectsHandler.CallEffect("Generate Quasiduck Lightning", u2, {
                Size = 0.2,
                Color = ParticleHandler.TryHSVShift(ColorSequence.new(Color3.fromRGB(148, 121, 255)), ParticleHandler.GetUnusualHSVData({
                    Character = u2
                })),
                Speed = u1:NextNumber(9.25, 10.75),
                CFrames = { HumanoidRootPart.CFrame * CFrame.new(u1:NextNumber(-2, 2), math.random(-3, 2), u1:NextNumber(-0.5, 0.5)), u2["Right Arm"].CFrame * CFrame.new(u1:NextNumber(-1, 1), u1:NextNumber(-1, -1.2), u1:NextNumber(-1, 1)) }
            }).Frequency = u1:NextNumber(0.4, 0.9);
            AssetHandler.ScaleAsset(Folder, {
                Scale = 1.3
            });

            for _, child in v15.B1:GetChildren() do
                EffectsHandler.CallEffect("Boat Tween", child, {
                    Time = 0.25,
                    EasingStyle = "ExitExpressive",
                    EasingDirection = "Out",
                    StepType = "RenderStepped",
                    Goal = {
                        Transparency = NumberSequence.new(1)
                    }
                });
            end;

            task.wait(0.085 / v6);
        end;

        if not (u2:IsDescendantOf(game) and u2:GetAttribute("RadioKnife")) then
            if u2:IsDescendantOf(game) then
                task.delay(ParticleHandler.EnableParticle(v8, false), v8.Destroy, v8);
            end;

            return;
        end;
    end;
end;