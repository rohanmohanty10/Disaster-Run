  

 

game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local _ = Players.LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.FXHandler);
local LightningBolt = require(ReplicatedStorage.ClientModules.LightningBolt);
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };
local u3 = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" };

return function(p4, p5, p6) -- Line: 38
    -- upvalues: ParticleHandler (copy), u1 (copy), u3 (copy), LightningBolt (copy), u2 (copy), EffectsHandler (copy)
    local u7 = p6 or {};
    local u8 = u7.HSVData or ParticleHandler.GetUnusualHSVData({
        Character = p4
    });
    local v9 = u7.Attribute or "LightningAura";

    if p5 then
        if p4:GetAttribute(v9) then
            return;
        end;

        p4:SetAttribute(v9, true);
        local v10 = os.clock();
        local v11 = os.clock();
        local _ = p4.Humanoid;
        local HumanoidRootPart = p4.HumanoidRootPart;
        local Torso = p4.Torso;
        local v12 = u7.Cooldown or 0.5;
        local v13 = u7.BodyCooldown or 0.25;

        local function EdgePosition(p14) -- Line: 58
            -- upvalues: u1 (ref)
            local v15 = p14.Size / 4;
            local v16 = u1:NextInteger(1, 3);
            local v17 = u1:NextInteger(1, 2) == 1 and 1 or -1;
            local v18 = u1:NextNumber(-1, 1) * v15.X;
            local v19 = u1:NextNumber(-1, 1) * v15.Y;
            local v20 = u1:NextNumber(-1, 1) * v15.Z;

            if v16 == 1 then
                v18 = v17 * v15.X;
            elseif v16 == 2 then
                v19 = v17 * v15.Y;
            else
                v20 = v17 * v15.Z;
            end;

            return Vector3.new(v18, v19, v20);
        end;

        local u21 = ParticleHandler.TryHSVShift(u7.Color or Color3.fromRGB(105, 141, 192), u8);

        while p4:IsDescendantOf(game) and p4:GetAttribute(v9) do
            task.wait();

            if v13 < os.clock() - v11 and not u7.DisableBodyLightning then
                v11 = os.clock();

                for _ = 1, math.random(1, 3) do
                    local v22 = p4[u3[math.random(1, #u3)]];
                    local v23 = p4[u3[math.random(1, #u3)]];
                    local Attachment = Instance.new("Attachment");
                    Attachment.Position = EdgePosition(v22);
                    Attachment.Parent = v22;
                    local Attachment2 = Instance.new("Attachment");
                    Attachment2.Position = EdgePosition(v23);
                    Attachment2.Parent = v23;
                    local v24 = u1:NextNumber(7, 9);
                    local Magnitude = (Attachment.WorldPosition - Attachment2.WorldPosition).Magnitude;
                    local v25 = LightningBolt.new(Attachment, Attachment2, math.random(6, 8));
                    v25.CurveSize0 = Magnitude / 3;
                    v25.CurveSize1 = Magnitude / 3;
                    v25.MinRadius = u1:NextNumber(0, 1);
                    v25.MaxRadius = u1:NextNumber(1.4, 1.8);
                    v25.Color = u21;
                    v25.Thickness = u1:NextNumber(0.08, 0.1);
                    v25.MinThicknessMultiplier = u1:NextNumber(0.65, 0.85);
                    v25.PulseSpeed = v24;
                    v25.PulseLength = u1:NextNumber(0.75, 0.9);
                    v25.Frequency = u1:NextNumber(0.08, 0.2);
                    v25.AnimationSpeed = u1:NextNumber(3, 9);
                    task.delay(1 / v24 + 1, function() -- Line: 112
                        -- upvalues: Attachment (copy), Attachment2 (copy)
                        Attachment:Destroy();
                        Attachment2:Destroy();
                    end);
                end;
            end;

            if v12 < os.clock() - v10 then
                v10 = os.clock();

                for _ = 1, math.random(1, 2) do
                    local Position = Torso.Position;
                    local u26 = CFrame.new(Position, Position + HumanoidRootPart.CFrame.LookVector);
                    local u27 = 16;

                    if Torso.AssemblyLinearVelocity.Magnitude > 5 then
                        u27 = u27 * 1.75;
                    end;

                    local function RaycastR() -- Line: 133
                        -- upvalues: u1 (ref), Position (copy), u26 (copy), u27 (ref), u2 (ref)
                        local v28 = u1:NextNumber(75, 100);
                        local v29 = math.random(1, 2) == 1 and 1 or -1;
                        local v30 = CFrame.Angles(math.rad(-90 - v28 * v29), 0, 0);
                        local Angles = CFrame.Angles;
                        local v31 = u1:NextNumber(-180, 180);
                        local v32 = Angles(0, math.rad(v31), 0);

                        return workspace:Raycast(Position, (u26 * v32 * v30).LookVector * u27, u2);
                    end;

                    local v33 = RaycastR();

                    if not v33 or (HumanoidRootPart.Position - v33.Position).Magnitude <= 3.3 then
                        local v34 = 0;

                        repeat
                            v33 = RaycastR();
                            v34 = v34 + 1;
                        until v33 and (HumanoidRootPart.Position - v33.Position).Magnitude > 3.3 or v34 >= 5;
                    end;

                    if v33 and (HumanoidRootPart.Position - v33.Position).Magnitude > 3.3 then
                        local v35 = p4:FindFirstChild(u3[math.random(1, #u3)]);
                        local Attachment = Instance.new("Attachment");
                        Attachment.Position = EdgePosition(v35);
                        Attachment.Parent = v35;
                        local Attachment2 = Instance.new("Attachment");
                        Attachment2.Parent = workspace.Terrain;
                        Attachment2.WorldPosition = v33.Position;
                        local u36 = math.random(16, 18);
                        local u37 = u1:NextNumber(30, 45);
                        local u38 = u1:NextNumber(0.17, 0.23);
                        local u39 = u1:NextNumber(3, 4.5);
                        local u40 = u1:NextNumber(1, 3);
                        local Magnitude = (Attachment.WorldPosition - Attachment2.WorldPosition).Magnitude;
                        local v41 = Magnitude / u1:NextNumber(2, 7);
                        local v42 = u1:NextNumber(0.5, 2);
                        local Unit = (Attachment2.WorldPosition - Attachment.WorldPosition).Unit;
                        local Unit2 = Unit:Cross(Vector3.new(0, 1, 0)).Unit;
                        local Unit3 = Unit:Cross(Unit2).Unit;
                        local u43 = { Attachment };
                        local v44 = { 0 };

                        for i = 1, 2 do
                            local v45 = i / 3;
                            local v46 = v45 * v42 * 2 * 3.141592653589793;
                            local v47 = Attachment.WorldPosition:Lerp(Attachment2.WorldPosition, v45);
                            local Attachment3 = Instance.new("Attachment");
                            Attachment3.Parent = workspace.Terrain;
                            Attachment3.WorldPosition = v47 + Unit2 * math.cos(v46) * v41 + Unit3 * math.sin(v46) * v41;
                            Attachment3.WorldPosition = Attachment3.WorldPosition - Unit3 * u1:NextNumber(1.8, 2.2);
                            local v48 = Unit + (-Unit2 * math.sin(v46) + Unit3 * math.cos(v46)) * (v42 * 2 * 3.141592653589793 * v41 / Magnitude);
                            Attachment3.WorldCFrame = CFrame.lookAt(Attachment3.WorldPosition, Attachment3.WorldPosition + v48);
                            u43[i + 1] = Attachment3;
                            v44[i + 1] = v46;
                        end;

                        u43[4] = Attachment2;
                        v44[4] = v42 * 2 * 3.141592653589793;
                        task.spawn(function() -- Line: 204
                            -- upvalues: u43 (copy), LightningBolt (ref), u36 (copy), u21 (copy), u38 (copy), u37 (copy), u39 (copy), u40 (copy), EffectsHandler (ref), u7 (ref), u8 (copy)
                            for i = 1, 3 do
                                local v49 = u43[i];
                                local v50 = u43[i + 1];
                                local v51 = (v50.WorldPosition - v49.WorldPosition).Magnitude * 0.55;
                                local v52 = LightningBolt.new(v49, v50, (math.ceil(u36 / 3)));
                                v52.CurveSize0 = v51;
                                v52.CurveSize1 = v51;
                                v52.Color = u21;
                                v52.Thickness = u38;
                                v52.MinThicknessMultiplier = 0.85;
                                v52.PulseSpeed = u37;
                                v52.PulseLength = u39;
                                v52.Frequency = 0.05;
                                v52.AnimationSpeed = u40;
                                EffectsHandler.Wait(1 / u37);

                                if i == 3 then
                                    EffectsHandler.CallEffect("Emit Particle V3", {
                                        Path = "Particles/Awaken/Spark",
                                        AbilityName = "UGrain",
                                        Origin = v50,
                                        SkinName = u7.SkinName,
                                        HSVShift = u8
                                    });
                                end;
                            end;
                        end);
                        task.delay(u37 * 3 + 1, function() -- Line: 237
                            -- upvalues: u43 (copy)
                            for _, v in u43 do
                                v:Destroy();
                            end;
                        end);
                    end;
                end;
            end;
        end;
    else
        if not p4:GetAttribute(v9) then
            return;
        end;

        p4:SetAttribute(v9, nil);
    end;
end;