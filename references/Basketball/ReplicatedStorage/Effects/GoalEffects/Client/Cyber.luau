 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local _ = game.Players.LocalPlayer;

local function scaleDown(p1, p2) -- Line: 12
    for _, v in p1 do
        if v:IsA("ParticleEmitter") then
            local v3 = v;
            local v4 = {};

            for _, v2 in v.Size.Keypoints do
                local v5;

                if v2.Envelope then
                    v5 = v2.Envelope / 10 or nil;
                else
                    v5 = nil;
                end;

                if v5 ~= v5 then
                    v5 = nil;
                end;

                table.insert(v4, NumberSequenceKeypoint.new(v2.Time, v2.Value / 10, v5));
            end;

            v3.Size = NumberSequence.new(v4);
            v3.Speed = NumberRange.new(v3.Speed.Min / 10, v3.Speed.Max / 10);
        elseif v:IsA("Attachment") then
            v.Position = v.Position / 10;

            if v.Position ~= v.Position then
                v.Position = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("BasePart") then
            v.Position = p2.CFrame.Position + (v.Position - p2.CFrame.Position) / 10;

            if v.Position ~= v.Position then
                v.Position = p2.CFrame.Position;
            end;

            v.Size = v.Size / 10;

            if v.Size ~= v.Size then
                v.Size = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("Beam") then
            v.Width0 = v.Width0 / 10;
            v.Width1 = v.Width1 / 10;
            v.CurveSize0 = v.CurveSize0 / 10;
            v.CurveSize1 = v.CurveSize1 / 10;
        end;
    end;
end;

return function(p6, p7) -- Line: 57
    -- upvalues: scaleDown (copy), VfxManager (copy)
    local v8 = script.Cyber:Clone();
    v8:PivotTo(p7.CFrame);
    v8.Parent = workspace.Debris;

    if p7.Preview then
        scaleDown(v8:GetDescendants(), p7);
    end;

    VfxManager.Emit(v8);
    VfxManager.DestroyEffect(v8, 6);
end;