  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
require(PathShortcuts.KnitPath.Knit);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u1 = {
    CFrame.new(0, 0.5, -0.25) * CFrame.Angles(-0.4363323129985824, -0.9599310885968813, 2.6179938779914944),
    CFrame.new(0, 0.22, 0) * CFrame.Angles(0, 0.7504915783575618, -0.4363323129985824),
    CFrame.new(0, 0.4, -0.25) * CFrame.Angles(0, -0.7853981633974483, 3.490658503988659),
    CFrame.new(0, 0.25, -0.45) * CFrame.Angles(0, 0.7853981633974483, 0.6632251157578453)
};

return function(p2) -- Line: 15
    -- upvalues: u1 (copy), EffectsHandler (copy)
    local _ = p2.Character;
    local v3 = u1[p2.CharacterState["Rush Attack"].Count];
    EffectsHandler.CallEffect("FlipbookSlash", {
        Time = 0.18,
        Size = Vector3.new(9, 9, 9),
        SurfaceDirection = "Bottom",
        Origin = p2.RootPart.CFrame * CFrame.new(0, 0, -1.5) * v3,
        EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
        Color = Color3.fromRGB(472, 547, 637)
    });
end;