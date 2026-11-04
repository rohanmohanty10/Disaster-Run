 
 

local Util = require(game:GetService("ReplicatedStorage").util.Util);

return {
    { 0, function(p1) -- Line: 5
            shared.vfx.emit(p1.Hamon);
        end },
    { 104, function(p2) -- Line: 10
            shared.vfx.emit(p2.bACKGROUND);
        end },
    { 133, function(p3) -- Line: 15
            -- upvalues: Util (copy)
            if not Util.isepilepsysafe() then
                shared.vfx.emit(p3.ScreenEffect);
            end;
        end },
    { 682, function(p4) -- Line: 22
            -- upvalues: Util (copy)
            if not Util.isepilepsysafe() then
                shared.vfx.emit(p4.ScreenEffect2);
            end;
        end },
    { 714, function(p5) -- Line: 29
            -- upvalues: Util (copy)
            if not Util.isepilepsysafe() then
                shared.vfx.emit(p5.ScreenEffect2);
            end;
        end },
    { 752, function(p6) -- Line: 36
            -- upvalues: Util (copy)
            if not Util.isepilepsysafe() then
                shared.vfx.emit(p6.ScreenEffect2);
            end;
        end },
    { 789, function(p7) -- Line: 43
            -- upvalues: Util (copy)
            if not Util.isepilepsysafe() then
                shared.vfx.emit(p7.ScreenEffect2);
            end;
        end },
    { 831, function(p8) -- Line: 50
            -- upvalues: Util (copy)
            if not Util.isepilepsysafe() then
                shared.vfx.emit(p8.ScreenEffect2);
            end;
        end },
    { 865, function(p9) -- Line: 57
            -- upvalues: Util (copy)
            if not Util.isepilepsysafe() then
                shared.vfx.emit(p9.ScreenEffect2);
            end;
        end },
    { 897, function(p10) -- Line: 64
            shared.vfx.emit(p10.WhatWillHappenToJimmy);
            shared.vfx.emit(p10.Splash2);
        end },
    { 990, function(p11) -- Line: 70
            shared.vfx.emit(p11["Tv death"]);
        end }
};