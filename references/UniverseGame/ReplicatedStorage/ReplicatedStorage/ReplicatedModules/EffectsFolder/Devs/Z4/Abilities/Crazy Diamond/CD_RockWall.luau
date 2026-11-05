  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

local function Wait(p1) -- Line: 8
    -- upvalues: RunService (copy)
    local v2 = 0;

    repeat
        v2 = v2 + RunService.Heartbeat:Wait();
    until (p1 or 0) <= v2;

    return v2;
end;

return function(p3, u4) -- Line: 19
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), TweenService (copy), RunService (copy)
    local Player = u4.Player;
    local v5 = AssetHandler.CloneAsset("Models/Wall", {
        AbilityName = "Crazy Diamond"
    });
    v5.Parent = workspace.Effects;
    local v6 = 0;

    if Player and Player.Data.Skin:GetAttribute("UnusualHueId") then
        v6 = v6 + Player.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    if v6 > 0 then
        ParticleHandler.HSVShiftParticles(v5, {
            HueShift = v6
        });
    end;

    local Attachments = v5.Attachments;
    local Meshes = v5.Meshes;
    Attachments.CFrame = u4.Offset or CFrame.lookAlong(u4.Position, p3.CFrame.LookVector, u4.Normal) * CFrame.new(0, 3.5, 0) * CFrame.Angles(1.5707963267948966, 0, 0);
    local v7 = next;
    local v8, v9 = Meshes:GetDescendants();

    for _, v in v7, v8, v9 do
        if v:IsA("BasePart") then
            local _ = v.Orientation.X;
            v.Color = u4.Color;
            v.Material = u4.Material;
            v.TopSurface = Enum.SurfaceType.Smooth;
            v.BottomSurface = Enum.SurfaceType.Smooth;
            v.CollisionGroup = "FX";

            if u4.Instance then
                local v10 = next;
                local v11, v12 = u4.Instance:GetChildren();

                for _, v2 in v10, v11, v12 do
                    if v2:IsA("Decal") or v2:IsA("Texture") then
                        v2:Clone().Parent = v;
                    end;
                end;
            end;

            ParticleHandler.EnableAllParticles(v, true);
            task.spawn(function() -- Line: 64
                -- upvalues: Attachments (copy), v (copy), u4 (copy), TweenService (ref), ParticleHandler (ref)
                local v13 = Attachments:FindFirstChild(v.Name);

                if v13 then
                    local Position = v.Position;
                    local Position2 = u4.Position;
                    local v14 = math.random(-1, 1);
                    local v15 = math.random(-1, 0);
                    local v16 = Position2 + Vector3.new(v14, v15, math.random(-1, 1)) * 4 * 3;
                    local v17 = math.random(-7, 7);
                    local v18 = math.random(-7, 7);
                    local v19 = Position + Vector3.new(v17, v18, math.random(-7, 7)) * 3;
                    local v20 = math.random(-5, 5);
                    local v21 = math.random(-5, 5);
                    local v22 = Position + Vector3.new(v20, v21, math.random(-5, 5)) * 3;
                    local Orientation = v.Orientation;
                    local v23 = math.random(-360, 360);
                    local v24 = math.random(-360, 360);
                    v.Orientation = Vector3.new(v23, v24, math.random(-360, 360));
                    TweenService:Create(v, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
                        Orientation = Orientation
                    }):Play();

                    for i = 1, 36 do
                        if v.Position == v13.WorldPosition then
                            break;
                        end;

                        local v25 = i / 36;
                        v.Position = (1 - v25) ^ 3 * v16 + 3 * (1 - v25) ^ 2 * v25 * v19 + 3 * (1 - v25) * v25 ^ 2 * v22 + v25 ^ 3 * v13.WorldPosition;
                        task.wait();
                    end;
                end;

                ParticleHandler.EnableAllParticles(v, false);
                v.Anchored = true;
            end);
        end;
    end;

    local v26 = 0;

    repeat
        v26 = v26 + RunService.Heartbeat:Wait();
    until (12 or 0) <= v26;

    local v27 = next;
    local v28, v29 = v5:GetDescendants();

    for _, v in v27, v28, v29 do
        if v:IsA("Texture") or (v:IsA("Decal") or v:IsA("BasePart")) then
            TweenService:Create(v, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                Transparency = 1
            }):Play();
        end;
    end;

    local v30 = 0;

    repeat
        v30 = v30 + RunService.Heartbeat:Wait();
    until (0.6 or 0) <= v30;

    v5:Destroy();
end;