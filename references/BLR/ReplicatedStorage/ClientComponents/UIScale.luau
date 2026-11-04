  

game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Component = require(ReplicatedStorage.Packages.Component);
local Trove = require(ReplicatedStorage.Packages.Trove);
local v1 = Component.new({
    Tag = "UIScale"
});

function v1.Construct(p2) -- Line: 15
    -- upvalues: Trove (copy)
    p2.Trove = Trove.new();
    p2._Multiplier = p2.Instance:GetAttribute("ScaleMultiplier") or 1;
    p2._ScreenGui = p2.Instance:FindFirstAncestorWhichIsA("ScreenGui");

    if p2.Instance:IsA("UIGridLayout") then
        p2.properties = {
            CellSize = p2.Instance.CellSize,
            CellPadding = p2.Instance.CellPadding
        };
    end;
end;

function v1.Stop(p3) -- Line: 29
    p3.Trove:Destroy();
end;

function v1.Start(u4) -- Line: 33
    u4.Trove:Destroy();
    u4.Trove:Connect(u4.Instance:GetAttributeChangedSignal("Multiplier"), function() -- Line: 36
        -- upvalues: u4 (copy)
        u4._Multiplier = u4.Instance:GetAttribute("Multiplier");
        u4:UpdateScale();
    end);
    u4.Trove:Connect(u4._ScreenGui:GetPropertyChangedSignal("AbsoluteSize"), function() -- Line: 41
        -- upvalues: u4 (copy)
        u4:UpdateScale();
    end);
    u4:UpdateScale();
end;

function v1.UpdateScale(p5) -- Line: 48
    local v6 = math.clamp(p5._ScreenGui.AbsoluteSize.Y, 320, 1440) / 1080 * p5._Multiplier * 100;
    local v7 = math.round(v6) / 100;

    if p5.properties then
        for i, v in p5.properties do
            if typeof(p5.Instance[i]) == "UDim2" then
                p5.Instance[i] = UDim2.new(v.X.Scale, v.X.Offset * v7, v.Y.Scale, v.Y.Offset * v7);
            end;
        end;
    end;
end;

return v1;