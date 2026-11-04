  

game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Component = require(ReplicatedStorage.Packages.Component);
local Trove = require(ReplicatedStorage.Packages.Trove);
local v1 = Component.new({
    Tag = "TimeScaleAttr"
});
TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
TweenInfo.new(0.3);

local function map(p2, p3, p4, p5, p6) -- Line: 14
    local v7 = (p2 - p3) / (p4 - p3) * (p6 - p5) + p5;

    if p5 < p6 then
        local math_min_ret = math.min(v7, p6);

        return math.max(math_min_ret, p5);
    end;

    local math_min_ret = math.min(v7, p5);

    return math.max(math_min_ret, p6);
end;

function v1.Construct(p8) -- Line: 23
    -- upvalues: Trove (copy)
    p8.Trove = Trove.new();
    p8.MappingStartLoudness = p8.Instance:GetAttribute("MappingStartLoudness") or 0;
    p8.MappingEndLoudness = p8.Instance:GetAttribute("MappingEndLoudness") or 1000;
    p8.MappingStartTimeScale = p8.Instance:GetAttribute("MappingStartTimeScale") or 0;
    p8.MappingEndTimeScale = p8.Instance:GetAttribute("MappingEndTimeScale") or 4;
end;

function v1.Stop(p9) -- Line: 32
    p9.Trove:Destroy();
end;

function v1.Start(p10) -- Line: 36
    p10.Trove:Destroy();
end;

function v1.HeartbeatUpdate(p11, p12) -- Line: 40
    if not p11._timeSound then
        p11._timeSound = p11.Instance:FindFirstChild("SongForTimeScale", true);
    end;

    if not p11._timeScaleAttach then
        p11._timeScaleAttach = p11.Instance:FindFirstChild("TIMESCALE", true);
    end;

    if p11._timeSound then
        local MappingStartLoudness = p11.MappingStartLoudness;
        local MappingStartTimeScale = p11.MappingStartTimeScale;
        local MappingEndTimeScale = p11.MappingEndTimeScale;
        local v13 = (p11._timeSound.PlaybackLoudness - MappingStartLoudness) / (p11.MappingEndLoudness - MappingStartLoudness) * (MappingEndTimeScale - MappingStartTimeScale) + MappingStartTimeScale;
        local v14;

        if MappingStartTimeScale < MappingEndTimeScale then
            local math_min_ret = math.min(v13, MappingEndTimeScale);
            v14 = math.max(math_min_ret, MappingStartTimeScale);
        else
            local math_min_ret = math.min(v13, MappingStartTimeScale);
            v14 = math.max(math_min_ret, MappingEndTimeScale);
        end;

        if p11._timeScaleAttach then
            for _, descendant in p11._timeScaleAttach:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = v14;
                end;
            end;
        end;
    end;
end;

function v1.RenderSteppedUpdate(p15, p16) -- Line: 69
end;

return v1;