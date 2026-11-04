  

game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("SoundService");
local Component = require(ReplicatedStorage.Packages.Component);
local Trove = require(ReplicatedStorage.Packages.Trove);
local v1 = Component.new({
    Tag = "AutoSizeList"
});

function v1.Construct(p2) -- Line: 12
    -- upvalues: Trove (copy)
    p2.Trove = Trove.new();
    local Instance = p2.Instance;
    local u3 = Instance:GetAttribute("ExcessSpace") or UDim.new(0, 80);
    local u4 = Instance:FindFirstChildWhichIsA("UIGridStyleLayout");

    local function update() -- Line: 19
        -- upvalues: u4 (copy), Instance (copy), u3 (copy)
        local Y = u4.AbsoluteContentSize.Y;

        if Y < Instance.AbsoluteWindowSize.Y then
            Instance.CanvasSize = UDim2.fromOffset(0, Y);

            return;
        end;

        Instance.CanvasSize = UDim2.fromOffset(u3.Scale, Y + u3.Offset);
    end;

    local Y = u4.AbsoluteContentSize.Y;

    if Y < Instance.AbsoluteWindowSize.Y then
        Instance.CanvasSize = UDim2.fromOffset(0, Y);
    else
        Instance.CanvasSize = UDim2.fromOffset(u3.Scale, Y + u3.Offset);
    end;

    p2.Trove:Add(u4:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(update));
end;

function v1.Stop(p5) -- Line: 33
    p5.Trove:Destroy();
end;

return v1;