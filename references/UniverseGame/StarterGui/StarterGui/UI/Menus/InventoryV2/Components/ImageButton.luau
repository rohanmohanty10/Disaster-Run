  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
require(ReplicatedStorage.ReplicatedRoot.Libraries.Classes.Trove);
require(ReplicatedStorage.ReplicatedModules.Types);
require("../Lib/Types");
local _ = script.Parent.Parent.Assets;

return function(p1, p2) -- Line: 13
    -- upvalues: Fusion (copy)
    local u3 = Fusion.Value(false);
    local v4 = Fusion.New("ImageLabel")({
        BackgroundTransparency = 1,
        Name = "WrappedIcon",
        Image = p1.Image,
        ImageRectSize = p1.ImageRectSize,
        ImageRectOffset = p1.ImageRectOffset,
        ImageColor3 = p1.ImageColor3,
        AnchorPoint = Vector2.one * 0.5,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = Fusion.Spring(Fusion.Computed(function() -- Line: 26
            -- upvalues: u3 (copy)
            return u3:get() and UDim2.fromScale(1.1, 1.1) or UDim2.fromScale(1, 1);
        end), 40, 0.9),
        Parent = p1
    });
    p1.Image = "";
    local v5 = p1:FindFirstChildOfClass("UIGradient");

    if v5 ~= nil then
        v5.Parent = v4;
    end;

    Fusion.Hydrate(p1)({
        [Fusion.OnEvent("MouseEnter")] = function() -- Line: 42
            -- upvalues: u3 (copy)
            u3:set(true);
        end,

        [Fusion.OnEvent("MouseLeave")] = function() -- Line: 46
            -- upvalues: u3 (copy)
            u3:set(false);
        end
    });

    return p1;
end;