 

 

local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));

return {
    { 200, function(p1, p2) -- Line: 5
            shared.vfx.emit(p1.bg1);
        end },
    { 223, function(p3, p4) -- Line: 10
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p3.smoke);
        end },
    { 230, function(p5, p6) -- Line: 15
            shared.vfx.emit(p5["0"]);
        end },
    { 350, function(p7, p8) -- Line: 20
            shared.vfx.emit(p7.step);
        end },
    { 365, function(p9, p10) -- Line: 25
            shared.vfx.emit(p9.step);
        end },
    { 373, function(p11, p12) -- Line: 30
            shared.vfx.emit(p11.step);
        end },
    { 448, function(p13, p14) -- Line: 35
            shared.vfx.emit(p13.step);
        end },
    { 453, function(p15, p16) -- Line: 40
            shared.vfx.emit(p15.throw);
        end },
    { 476, function(p17, p18) -- Line: 45
            shared.vfx.emit(p17.bg2b);
        end },
    { 574, function(p19, p20) -- Line: 50
            shared.vfx.emit(p19.bg2);
        end },
    { 694, function(p21, p22) -- Line: 55
            shared.vfx.emit(p22["Left Arm"].OffBallBurst);
        end },
    { 745, function(p23, p24) -- Line: 60
            shared.vfx.emit(p24.rolandweapon6.Sword);
        end },
    { 791, function(p25, p26) -- Line: 65
            shared.vfx.emit(p25.bg4);
        end },
    { 863, function(p27, p28) -- Line: 70
            shared.vfx.emit(p27.bg4roland);
        end }
};