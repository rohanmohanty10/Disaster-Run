  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p2) -- Line: 17
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), TweenService (copy), EffectsHandler (copy), u1 (copy)
    local v3 = p2 or {};
    local Attacker = v3.Attacker;
    local Target = v3.Target;
    local Duration = v3.Duration;
    local u4 = AssetHandler.CloneAsset("Particles/BrainFreeze/Frozen", AssetHandler.GetAbilityData(Attacker));
    u4.Parent = Target;
    u4:ScaleTo(Target:GetScale() * u4:GetScale());
    ParticleHandler.Unusualify(u4, {
        IncludeParts = true,
        IncludeSurfaces = true,
        HSVData = ParticleHandler.GetUnusualHSVData({
            Character = Attacker
        })
    });
    local u5 = {};
    local u6 = { { "Head" }, { "Left Arm", "Right Arm", "Torso" }, { "Left Leg", "Right Leg" } };
    local u7 = {};
    local u8 = {
        HatAttachment = "Head",
        HairAttachment = "Head",
        FaceFrontAttachment = "Head",
        NeckAttachment = "Torso",
        BodyFrontAttachment = "Torso",
        WaistFrontAttachment = "Torso",
        RightGripAttachment = "Right Arm",
        LeftGripAttachment = "Left Arm",
        RightShoulderAttachment = "Right Arm",
        LeftShoulderAttachment = "Left Arm",
        RightFootAttachment = "Right Leg",
        LeftFootAttachment = "Left Leg"
    };

    for _, child in u4:GetChildren() do
        if Target:FindFirstChild(child.Name) then
            local Weld = Instance.new("Weld");
            Weld.Part0 = child;
            Weld.Part1 = Target[child.Name];
            Weld.Parent = u4;
            u5[child.Name] = {};

            for _, child2 in child:GetChildren() do
                if child2:IsA("BasePart") then
                    child2.Transparency = 1;
                    u5[child.Name][tonumber(child2.Name)] = child2;
                end;
            end;
        end;
    end;

    task.spawn(function() -- Line: 77
        -- upvalues: Duration (copy), u6 (copy), u7 (copy), TweenService (ref), Target (copy), u8 (copy), u5 (copy), EffectsHandler (ref)
        local v9 = Duration;

        for _, v in u6 do
            local u10 = v9 / #u6;

            local function Highlight(p11) -- Line: 83
                -- upvalues: u7 (ref), TweenService (ref), u10 (copy)
                local Highlight = Instance.new("Highlight");
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.FillTransparency = 1;
                Highlight.OutlineTransparency = 1;
                Highlight.FillColor = Color3.fromRGB(93, 177, 255);
                Highlight.OutlineColor = Color3.fromRGB(93, 177, 255);
                Highlight.Parent = p11;
                table.insert(u7, Highlight);
                TweenService:Create(Highlight, TweenInfo.new(u10 * 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    FillTransparency = 0.7,
                    OutlineTransparency = 0.5
                }):Play();

                return Highlight;
            end;

            for _, v2 in v do
                Highlight(Target[v2]);

                for _, child in ipairs(Target:GetChildren()) do
                    if child:IsA("Accessory") and child:FindFirstChild("Handle") then
                        local Handle = child.Handle;
                        local v12 = Handle:FindFirstChildOfClass("Attachment");

                        if v12 and u8[v12.Name] == v2 then
                            Highlight(Handle);
                        end;
                    end;
                end;

                task.spawn(function() -- Line: 115
                    -- upvalues: u5 (ref), v2 (copy), TweenService (ref), u10 (copy)
                    local v13 = u5[v2];

                    if not v13 then
                        return;
                    end;

                    for _, v4 in ipairs(v13) do
                        local v14 = TweenService:Create(v4, TweenInfo.new(u10 / #v13, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                            Transparency = 0.1
                        });
                        v14:Play();
                        v14.Completed:Wait();
                    end;
                end);
            end;

            EffectsHandler.Wait(u10);
        end;
    end);
    task.delay(Duration, function() -- Line: 133
        -- upvalues: u7 (copy), u4 (copy), Attacker (copy), u1 (ref), TweenService (ref)
        for _, v in u7 do
            v:Destroy();
        end;

        table.clear(u7);
        u4.Parent = workspace.Effects;
        task.delay(2.5, u4.Destroy, u4);

        for _, descendant in u4:GetDescendants() do
            if descendant:IsA("Weld") or (descendant:IsA("WeldConstraint") or descendant:IsA("ManualWeld")) then
                descendant:Destroy();
            end;
        end;

        for i, descendant in u4:GetDescendants() do
            if descendant:IsA("BasePart") then
                if i % 3 == 0 then
                    descendant:Destroy();
                else
                    local CFrame2 = Attacker.HumanoidRootPart.CFrame;
                    descendant.Size = descendant.Size * 0.65;
                    descendant.CFrame = descendant.CFrame * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
                    local BodyVelocity = Instance.new("BodyVelocity");
                    BodyVelocity.MaxForce = Vector3.new(10000000, 1000, 100000);
                    BodyVelocity.Velocity = (CFrame2.LookVector * u1:NextNumber(0.1, 1) + CFrame2.RightVector * u1:NextNumber(-0.5, 0.5) + CFrame2.UpVector * u1:NextNumber(0.3, 0.8)) * 25;
                    BodyVelocity.Parent = descendant;
                    task.delay(0.25, BodyVelocity.Destroy, BodyVelocity);
                    descendant.CollisionGroup = "Ghosted";
                    descendant.CanCollide = true;
                    TweenService:Create(descendant, TweenInfo.new(u1:NextNumber(0.75, 1.25), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, u1:NextNumber(1, 1.25)), {
                        Size = Vector3.new(0, 0, 0)
                    }):Play();
                end;
            end;
        end;
    end);
end;