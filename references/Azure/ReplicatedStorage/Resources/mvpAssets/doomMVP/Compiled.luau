 

 

local Util = require(game:GetService("ReplicatedStorage").util.Util);
local vfxUtil = require(game:GetService("ReplicatedStorage").util.vfxUtil);

return {
    { 165, function(p1, p2) -- Line: 6
            -- upvalues: Util (copy), vfxUtil (copy)
            Util.Gif(p2.ImpactFrames, 33);
            vfxUtil.emitAll(p1.Part);
        end },
    { 166, function(p3) -- Line: 13
            -- upvalues: vfxUtil (copy)
            vfxUtil.emitAll(p3.Part);
        end },
    { 206, function(p4, p5, p6) -- Line: 19
            -- upvalues: vfxUtil (copy)
            vfxUtil.emitAll(p6.Teammate1, p6.Duo);
        end },
    { 311, function(p7, p8, p9) -- Line: 25
            -- upvalues: vfxUtil (copy)
            vfxUtil.emitAll(p9.Teammate2);
        end },
    { 312, function(p10) -- Line: 31
            -- upvalues: vfxUtil (copy)
            vfxUtil.emitAll(p10.trea);
        end }
};