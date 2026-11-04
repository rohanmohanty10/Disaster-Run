 
 

local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));

return {
    { 108, function(p1, p2, p3) -- Line: 7
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p1.Punk.VFX.glitch);
        end },
    { 154, function(p4, p5, p6) -- Line: 14
            shared.vfx.emit(p6.Head.CryEnable2);
        end },
    { 163, function(p7, p8, p9) -- Line: 20
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p8.CamPart["1"]);
        end },
    { 212, function(p10, p11, p12) -- Line: 27
            require(script.Parent.Modules.head).Trigger(p12, 0.45, 0.15);
        end },
    { 250, function(p13, p14, p15) -- Line: 34
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p13.Punk.VFX.step);
        end },
    { 282, function(p16, p17, p18) -- Line: 41
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p16.Punk.VFX.follow);
        end },
    { 285, function(p19, p20, p21) -- Line: 47
            require(script.Parent.Modules.SandevistanTrail).Trigger(p21, 6.3, 0.1);
        end },
    { 374, function(p22, p23, p24) -- Line: 54
            shared.vfx.emit(p23.CamPart.ScreenAffect1);
        end },
    { 512, function(p25, p26, p27) -- Line: 61
            shared.vfx.emit(p27.Head.CrySwipe);
        end },
    { 632, function(p28, p29, p30) -- Line: 67
            shared.vfx.emit(p30.Head.CryEnable2);
        end }
};