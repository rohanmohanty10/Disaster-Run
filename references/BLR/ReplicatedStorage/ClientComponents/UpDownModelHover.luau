  

game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Component = require(ReplicatedStorage.Packages.Component);
local Trove = require(ReplicatedStorage.Packages.Trove);
local v1 = Component.new({
    Tag = "UpDownModelHover"
});

function v1.Construct(p2) -- Line: 13
    -- upvalues: Trove (copy)
    p2.Trove = Trove.new();
end;

function v1.Stop(p3) -- Line: 17
    p3.Trove:Destroy();
end;

function v1.Start(p4) -- Line: 21
    p4.Trove:Destroy();
    local Attribute = p4.Instance:GetAttribute("OriginalPivot");
    p4._periodOverride = p4.Instance:GetAttribute("Period");
    p4._amplitudeOverride = p4.Instance:GetAttribute("Amplitude");

    if not Attribute then
        Attribute = p4.Instance:GetPivot();
        p4.Instance:SetAttribute("OriginalPivot", Attribute);
    end;

    p4.originalPivot = Attribute;
    p4.offset = 0;
    p4._startTime = 0;
end;

function v1.HeartbeatUpdate(p5, p6) -- Line: 40
    p5._startTime = p5._startTime + p6;
    p5.offset = (math.sin(6.283185307179586 / (p5._periodOverride or 2.5) * p5._startTime) + 1) * 0.5 * (p5._amplitudeOverride or 0.5);
end;

function v1.RenderSteppedUpdate(p7, p8) -- Line: 45
    if not p7.originalPivot then
        return;
    end;

    p7.Instance:PivotTo(p7.originalPivot + Vector3.new(0, p7.offset, 0));
end;

return v1;