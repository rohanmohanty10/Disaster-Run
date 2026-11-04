 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");
local _ = game.Players.LocalPlayer;

local function lerp(p1, p2, p3) -- Line: 14
    return p1 + (p2 - p1) * p3;
end;

local function QuadBezier(p4, p5, p6, p7) -- Line: 18
    local v8 = p5 + (p6 - p5) * p4;

    return v8 + (p6 + (p7 - p6) * p4 - v8) * p4;
end;

local function randNum(p9, p10) -- Line: 25
    return Random.new():NextNumber(p9, p10);
end;

local function scaleDown(p11, p12) -- Line: 31
    for _, v in p11 do
        if v:IsA("ParticleEmitter") then
            local v13 = v;
            local v14 = {};

            for _, v2 in v.Size.Keypoints do
                local v15;

                if v2.Envelope then
                    v15 = v2.Envelope / 5 or nil;
                else
                    v15 = nil;
                end;

                if v15 ~= v15 then
                    v15 = nil;
                end;

                table.insert(v14, NumberSequenceKeypoint.new(v2.Time, v2.Value / 5, v15));
            end;

            v13.Size = NumberSequence.new(v14);
            v13.Speed = NumberRange.new(v13.Speed.Min / 5, v13.Speed.Max / 5);
        elseif v:IsA("Attachment") then
            v.Position = v.Position / 5;

            if v.Position ~= v.Position then
                v.Position = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("BasePart") then
            v.Position = p12.CFrame.Position + (v.Position - p12.CFrame.Position) / 5;

            if v.Position ~= v.Position then
                v.Position = p12.CFrame.Position;
            end;

            v.Size = v.Size / 5;

            if v.Size ~= v.Size then
                v.Size = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("Beam") then
            v.Width0 = v.Width0 / 5;
            v.Width1 = v.Width1 / 5;
        end;
    end;
end;

return function(p16, p17) -- Line: 73
    -- upvalues: Debris (copy), scaleDown (copy), VfxManager (copy), TweenService (copy)
    if p17.Preview then
        p17.CFrame = p17.CFrame - Vector3.new(0, 2, 0);
    end;

    local v18 = script.Vine:Clone();
    v18:PivotTo(p17.CFrame * CFrame.new(0, -30, 0) * CFrame.Angles(1.5707963267948966, 0, 0));
    v18.Parent = Debris;

    if p17.Preview then
        v18:PivotTo(p17.CFrame * CFrame.new(0, -6, 0) * CFrame.Angles(1.5707963267948966, 0, 0));
        v18:ScaleTo(0.2);
    end;

    local u19 = v18.Vine1.AnimationController:LoadAnimation(script.VineAnim);
    u19:Play();
    local u20 = v18.Vine2.AnimationController:LoadAnimation(script.VineAnim);
    u20:Play();
    u19:AdjustSpeed(4);
    u20:AdjustSpeed(4);
    task.delay(1.125, function() -- Line: 93
        -- upvalues: u19 (copy), u20 (copy)
        u19:AdjustSpeed(0);
        u20:AdjustSpeed(0);
    end);
    local v21 = script.NatureGoalFX:Clone();
    v21:PivotTo(p17.CFrame * CFrame.Angles(0, 1.5707963267948966, 0));
    v21.Parent = Debris;

    if p17.Preview then
        scaleDown(v21:GetDescendants(), p17);
    end;

    VfxManager.DestroyEffect(v21, 4.5);

    for _, descendant in v21:GetDescendants() do
        if descendant:IsA("MeshPart") and descendant.Name == "Flower" then
            local CFrame2 = descendant.CFrame;
            local Size = descendant.Size;
            descendant.Size = Vector3.new(0, 0, 0);
            descendant.CFrame = descendant.CFrame * CFrame.new(0, -10 / (p17.Preview and 5 or 1), 0);
            TweenService:Create(descendant, TweenInfo.new(0.355, Enum.EasingStyle.Back), {
                CFrame = CFrame2,
                Size = Size
            }):Play();
        end;
    end;

    VfxManager.Emit(v21.Emits.Explode);
    VfxManager.Emit(v21.Emits.Emit);
    VfxManager.Enable(v21.Enables, true);
    task.wait(2.25);
    VfxManager.Emit(v21.Emits.GrassDisappear);
    VfxManager.Enable(v21.Enables, false);

    for _, descendant in v21:GetDescendants() do
        if descendant:IsA("MeshPart") and descendant.Name == "Flower" then
            TweenService:Create(descendant, TweenInfo.new(0.355, Enum.EasingStyle.Back), {
                Size = Vector3.new(0, 0, 0),
                CFrame = descendant.CFrame * CFrame.new(0, -10 / (p17.Preview and 5 or 1), 0)
            }):Play();
        end;
    end;

    task.wait(0.5);

    for _, descendant in v18:GetDescendants() do
        if descendant:IsA("MeshPart") then
            TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Back), {
                Transparency = 1
            }):Play();
        end;
    end;

    VfxManager.DestroyEffect(v18, 1);
end;