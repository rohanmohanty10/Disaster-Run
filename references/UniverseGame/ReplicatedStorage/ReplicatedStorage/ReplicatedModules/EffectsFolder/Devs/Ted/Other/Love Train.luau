  

 

local TweenService = game:GetService("TweenService");
local u1 = game.ReplicatedStorage["Client Assets"];
local _ = workspace.CurrentCamera;
local _ = game.Players.LocalPlayer;
require(game.ReplicatedStorage.ReplicatedModules.Animations);
local u2 = Random.new();
local CollectionService = game:GetService("CollectionService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(u3, p4) -- Line: 12
    -- upvalues: u1 (copy), ParticleHandler (copy), u2 (copy), CollectionService (copy), TweenService (copy)
    u3:WaitForChild("HumanoidRootPart");
    local u5 = game.Players:GetPlayerFromCharacter(u3).Data.Skin:GetAttribute("SkinName");
    local v6;

    if u5 and u5 == "Starless Patriot" then
        v6 = u1["D4C: Love Train"]["Love TrainStarless Patriot"]:Clone();
        v6.Name = "Love Train";
    elseif u5 and u5 == "D4C:LT: Lovestruck" then
        v6 = u1["D4C: Love Train"]["Love TrainLovestruck"]:Clone();
        v6.Name = "Love Train";
    else
        v6 = u1["D4C: Love Train"]["Love Train"]:Clone();
    end;

    local u7;

    if p4 then
        u7 = p4.HSVData;
    else
        u7 = nil;
    end;

    ParticleHandler.Unusualify(v6, {
        HSVData = u7
    });

    if u7 and u7.Chroma then
        ParticleHandler.Chromaify(v6, {
            Character = u3
        });
    end;

    v6.Parent = u3;
    v6.Ground.CFrame = u3.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = v6.Ground;
    WeldConstraint.Part1 = u3.HumanoidRootPart;
    WeldConstraint.Parent = v6.Ground;

    for _, descendant in pairs(v6.Ground:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("PointLight") then
            descendant.Enabled = true;
        end;
    end;

    task.wait(0.25);

    local function GetBeamCFrame(p8, p9) -- Line: 58
        -- upvalues: u2 (ref)
        local v10 = CFrame.new(10, 0, 0);
        local Angles = CFrame.Angles;
        local v11 = u2:NextInteger(-360, 360);

        return v10 * Angles(math.rad(v11), 0, 0) * CFrame.new(0, 0, u2:NextInteger(p8 or 1.75, p9 or 2.5));
    end;

    local function CreateBeam(u12, u13) -- Line: 62
        -- upvalues: u5 (copy), u1 (ref), ParticleHandler (ref), u7 (copy), u3 (copy), GetBeamCFrame (copy), CollectionService (ref), TweenService (ref)
        local u14;

        if u5 and u5 == "Starless Patriot" then
            u14 = u1["D4C: Love Train"].BeamStarlessPatriot:Clone();
            u14.Name = "Beam";
        elseif u5 and u5 == "D4C:LT: Lovestruck" then
            u14 = u1["D4C: Love Train"].BeamLovestruck:Clone();
            u14.Name = "Beam";
        else
            u14 = u1["D4C: Love Train"].Beam:Clone();
        end;

        ParticleHandler.Unusualify(u14, {
            HSVData = u7
        });

        if u7 and u7.Chroma then
            ParticleHandler.Chromaify(u14, {
                Character = u3
            });
        end;

        Random.new();
        u14.Center.CFrame = GetBeamCFrame(u12, u13);
        u14.CFrame = u3.HumanoidRootPart.CFrame;
        u14.Parent = u3["Love Train"];
        local AlignPosition = Instance.new("AlignPosition");
        AlignPosition.RigidityEnabled = false;
        AlignPosition.Responsiveness = 800;
        AlignPosition.MaxVelocity = 1000000;
        AlignPosition.Attachment0 = u14.Center;
        AlignPosition.Attachment1 = u3.Torso.WaistCenterAttachment;
        AlignPosition.Parent = u14;
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.CFrame = u3.HumanoidRootPart.CFrame * CFrame.Angles(0, 0, -1.5707963267948966);
        BodyGyro.P = 10000;
        BodyGyro.D = 100;
        BodyGyro.MaxTorque = Vector3.new(10000, 10000, 10000);
        coroutine.wrap(function() -- Line: 101
            -- upvalues: u3 (ref), CollectionService (ref), u14 (ref), TweenService (ref), GetBeamCFrame (ref), u12 (copy), u13 (copy)
            local _ = u3.HumanoidRootPart.CFrame * CFrame.Angles(0, 0, -1.5707963267948966);

            while CollectionService:HasTag(u3, "LoveTrain") do
                local Beam = u14.Beam;
                local v15 = Random.new():NextNumber(0.5, 3);
                TweenService:Create(Beam, TweenInfo.new(v15, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, true), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
                task.wait(v15);

                if u14 and u14:FindFirstChild("Center") then
                    u14.Center.CFrame = GetBeamCFrame(u12, u13);
                    u14.Bottom.Light.Enabled = false;
                    u14.Bottom.Sparks.Enabled = false;
                end;

                task.wait(v15);

                if u14 and u14:FindFirstChild("Bottom") then
                    u14.Bottom.Light.Enabled = true;
                    u14.Bottom.Sparks.Enabled = true;
                end;
            end;
        end)();
        BodyGyro.Parent = u14;
    end;

    for _ = 1, 15 do
        CreateBeam(1.75, 2.5);
    end;

    for _ = 1, 10 do
        CreateBeam(2.5, 6);
    end;

    while u3.Parent and (CollectionService:HasTag(u3, "LoveTrain") or u3:GetAttribute("MisfortuneState")) do
        task.wait(0.1);
    end;

    for _, descendant in pairs(v6.Ground:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("SurfaceLight") then
            descendant.Enabled = false;
        end;
    end;

    for _, child in pairs(v6:GetChildren()) do
        if child.Name == "Beam" then
            TweenService:Create(child.Beam.Attachment1, TweenInfo.new(1), {
                Position = Vector3.new(12, 0, 0)
            }):Play();
        end;
    end;

    task.wait(1);
    v6:Destroy();
end;