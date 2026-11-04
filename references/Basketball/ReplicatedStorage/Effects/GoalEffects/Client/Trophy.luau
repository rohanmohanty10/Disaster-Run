 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: Debris (copy), SfxManager (copy), RunService (copy), VfxManager (copy), TweenService (copy)
    local u3 = script.Trophy:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame);
    SfxManager:playSound({
        Sound = "TrophySFX",
        Parent = workspace
    });
    u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    local u4 = nil;
    u4 = RunService.RenderStepped:Connect(function() -- Line: 21
        -- upvalues: u3 (copy), u4 (ref)
        if u3 and u3:FindFirstChild("Cylinder0011") then
            u3.Trophy.CFrame = u3.Cylinder0011.Bone.Connector.WorldCFrame;

            return;
        end;

        u4:Disconnect();
    end);
    VfxManager.Emit(u3.Score);
    local u5 = {};
    local u6 = {};

    for _, descendant in pairs(u3.Cylinder0011.Bone.Attachment:GetDescendants()) do
        if descendant:IsA("Beam") then
            table.insert(u5, descendant);
            u6[descendant] = {};
            local v7 = descendant;

            for i, v in ipairs(descendant.Transparency.Keypoints) do
                u6[v7][i] = {
                    Start = v.Value,
                    Needed = 1 - v.Value
                };
            end;
        end;
    end;

    local NumberValue = Instance.new("NumberValue", u3);
    NumberValue.Changed:Connect(function() -- Line: 49
        -- upvalues: u5 (copy), u6 (copy), NumberValue (copy)
        for _, v in u5 do
            local v8 = v;
            local v9 = {};

            for i, v2 in ipairs(v.Transparency.Keypoints) do
                table.insert(v9, NumberSequenceKeypoint.new(v2.Time, u6[v8][i].Start + u6[v8][i].Needed * NumberValue.Value));
            end;

            v8.Transparency = NumberSequence.new(v9);
        end;
    end);
    NumberValue.Value = 1;
    task.delay(0.7166666666666667, function() -- Line: 63
        -- upvalues: VfxManager (ref), u3 (copy), TweenService (ref), NumberValue (copy)
        VfxManager.Enable(u3.Cylinder0011.Bone.Attachment, true);
        TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 0
        }):Play();
    end);
    task.delay(1.7333333333333334, function() -- Line: 68
        -- upvalues: u3 (copy), TweenService (ref), NumberValue (copy)
        for _, descendant in pairs(u3.Cylinder0011.Bone.Attachment:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 1
        }):Play();
    end);
    task.delay(2.566666666666667, function() -- Line: 77
        -- upvalues: u3 (copy), VfxManager (ref)
        u3.Cylinder0011.Transparency = 1;
        u3.Trophy.Transparency = 1;
        VfxManager.Emit(u3.Cylinder0011.Bone.Despawn);
    end);
    VfxManager.DestroyEffect(u3, 4);
end;