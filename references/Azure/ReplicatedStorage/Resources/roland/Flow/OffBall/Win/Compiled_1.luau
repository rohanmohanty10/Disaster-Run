 
 

local function setLights(p1, p2) -- Line: 1
    for _, v in p1:QueryDescendants("Light") do
        v.Enabled = p2;
    end;
end;

return {
    { 0, function(p3, p4, p5) -- Line: 9
            shared.vfx.emit(p3.Start);

            for _, v in p3.Start.lights:QueryDescendants("Light") do
                v.Enabled = true;
            end;
        end },
    { 52, function(p6, p7, p8) -- Line: 15
            for _, v in p6.Start.lights:QueryDescendants("Light") do
                v.Enabled = false;
            end;
        end },
    { 59, function(p9, p10, p11) -- Line: 20
            shared.vfx.emit(p9.Stab);
            shared.vfx.emit(p10.Durandal.smoke);
        end },
    { 106, function(p12, p13, p14) -- Line: 26
            shared.vfx.emit(p12.Smoke);
        end },
    { 136, function(p15, p16, p17) -- Line: 31
            shared.vfx.emit(p15.VictimFall);

            for _, v in p15.VictimFall.lights:QueryDescendants("Light") do
                v.Enabled = true;
            end;
        end },
    { 227, function(p18, p19, p20) -- Line: 37
            for _, v in p18.VictimFall.lights:QueryDescendants("Light") do
                v.Enabled = false;
            end;
        end },
    { 251, function(p21, p22, p23) -- Line: 42
            shared.vfx.emit(p21.Step);
        end },
    { 340, function(p24, p25, p26) -- Line: 47
            shared.vfx.emit(p24.Slash);

            for _, v in p24.Slash.lights:QueryDescendants("Light") do
                v.Enabled = true;
            end;
        end },
    { 420, function(p27, p28, p29) -- Line: 53
            for _, v in p27.Slash.lights:QueryDescendants("Light") do
                v.Enabled = false;
            end;
        end }
};