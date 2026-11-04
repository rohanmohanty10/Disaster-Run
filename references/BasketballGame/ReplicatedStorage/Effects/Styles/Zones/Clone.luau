 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 13
    -- upvalues: VfxManager (copy), Debris (copy), TweenService (copy), ReplicatedStorage (copy), RunService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Torso");

    if Character:GetAttribute("Invis") then
        return;
    end;

    Character.Archivable = true;
    local u4 = Character:Clone();
    Character.Archivable = false;
    VfxManager.DestroyEffect(u4, 1 - v3);
    u4.Parent = Debris;
    u4.HumanoidRootPart.CFrame = CFrame.new(Character.HumanoidRootPart.Position.X, 4, Character.HumanoidRootPart.Position.Z) * Character.HumanoidRootPart.CFrame.Rotation;

    for _, descendant in u4:GetDescendants() do
        if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Highlight") or (descendant:IsA("Sound") or (descendant:IsA("SurfaceGui") or (descendant:IsA("BillboardGui") or (descendant:IsA("Decal") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("LinearVelocity") or (descendant:IsA("BodyVelocity") or descendant:IsA("AlignPosition")))))))))))) then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") then
            descendant.LocalTransparencyModifier = 0;
            task.delay(0.5 - v3, function() -- Line: 37
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant, TweenInfo.new(0.5), {
                    Transparency = 1
                }):Play();
            end);
        elseif descendant:IsA("Humanoid") then
            descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
            descendant.JumpHeight = 7.2;
            task.delay(0.25 - v3, function() -- Line: 44
                -- upvalues: descendant (copy)
                descendant:ChangeState(Enum.HumanoidStateType.Jumping);
            end);
        end;
    end;

    local u5 = u4.Humanoid:LoadAnimation(ReplicatedStorage.Assets.Animations.Shots.ShootF);
    local u6 = u4.PlrBall.Anims.AnimationController:LoadAnimation(ReplicatedStorage.Assets.BallAnimations.Shots.ShootF);
    u5:Play();
    u6:Play();
    u5.TimePosition = v3;
    u6.TimePosition = v3;
    local Highlight = Instance.new("Highlight", u4);
    Highlight.Name = script.Name .. "Highlight";
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    VfxManager.DestroyEffect(Highlight, 1 - v3);
    local Ring = workspace:FindFirstChild("Ring");
    local u7;

    if Ring then
        u7 = Ring:Clone();
        u7.Parent = Debris;
        VfxManager.DestroyEffect(u7, 1 - v3);
    else
        u7 = nil;
    end;

    local u8 = RunService.RenderStepped:Connect(function() -- Line: 74
        -- upvalues: u4 (copy), Character (copy), u7 (ref), Ring (copy)
        u4.HumanoidRootPart.CFrame = CFrame.new(u4.HumanoidRootPart.Position) * Character.HumanoidRootPart.CFrame.Rotation;

        if u7 and Ring then
            u7.CFrame = CFrame.new(u4.HumanoidRootPart.Position.X, 1, u4.HumanoidRootPart.Position.Z) * Ring.CFrame.Rotation;
        end;
    end);
    task.delay(0.5 - v3, function() -- Line: 82
        -- upvalues: u8 (copy), u5 (copy), u6 (copy), TweenService (ref), Highlight (copy), u7 (ref), u4 (copy)
        u8:Disconnect();
        u5:AdjustSpeed(0);
        u6:AdjustSpeed(0);
        TweenService:Create(Highlight, TweenInfo.new(0.5), {
            OutlineTransparency = 1
        }):Play();

        if u7 then
            TweenService:Create(u7, TweenInfo.new(0.5), {
                Transparency = 1
            }):Play();
        end;

        u4.HumanoidRootPart.Anchored = true;
    end);
end;