 

 

local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));

return {
    { 0, function(p1, p2, p3) -- Line: 6
            shared.vfx.emit(p1["111"]);
        end },
    { 0, function(p4, p5, p6) -- Line: 12
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p4.Wind);
        end },
    { 72, function(p7, p8, p9) -- Line: 19
            shared.vfx.emit(p7.Smok);
        end },
    { 135, function(p10, p11, p12) -- Line: 25
            shared.vfx.emit(p11.rock.WindMeshes);
        end },
    { 135, function(p13, p14, p15) -- Line: 31
            shared.vfx.emit(p14.rock.Union);
            shared.vfx.emit(p14.Head.Attachment);
        end },
    { 298, function(p16, p17, p18) -- Line: 38
            shared.vfx.emit(p17["Handle.R"].GlassesBreak);
        end },
    { 298, function(p19, p20, p21) -- Line: 44
            shared.vfx.emit(p20["Left Arm"].Wiki);
        end },
    { 361, function(p22, p23, p24) -- Line: 50
            shared.vfx.emit(p24.CamPart.CamLighting["A lot"].CenterBeams);
        end },
    { 361, function(p25, p26, p27) -- Line: 56
            shared.vfx.emit(p25.Tell);
        end },
    { 709, function(p28, p29, p30) -- Line: 63
            shared.vfx.emit(p28.camstarts);
        end },
    { 709, function(p31, p32, p33) -- Line: 69
            shared.vfx.emit(p31.Core);
        end },
    { 767, function(p34, p35, p36) -- Line: 75
            shared.vfx.emit(p36.CamPart.CamLighting["A lot"].CameraWind);
        end },
    { 767, function(p37, p38, p39) -- Line: 82
            shared.vfx.emit(p38.Torso.Attachment);
            shared.vfx.emit(p37.Core2);
        end },
    { 778, function(p40, p41, p42) -- Line: 89
            shared.vfx.emit(p40.SickClouds);
        end },
    { 778, function(p43, p44, p45) -- Line: 95
            -- upvalues: Part_Icles (copy)
            shared.vfx.emit(p43.OpenSKy);
            Part_Icles:AbsoluteEmit(p43.BeaLing);
        end },
    { 973, function(p46, p47, p48) -- Line: 104
            shared.vfx.emit(p47.rock.Union.WindDown);
        end },
    { 1172, function(p49, p50, p51) -- Line: 110
            shared.vfx.emit(p49.Floorhit);
        end }
};