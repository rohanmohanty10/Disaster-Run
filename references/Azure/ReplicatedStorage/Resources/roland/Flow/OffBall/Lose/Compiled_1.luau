 
 

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
            shared.vfx.emit(p6.Dodge);

            for _, v in p6.Start.lights:QueryDescendants("Light") do
                v.Enabled = false;
            end;

            for _, v in p6.Dodge.lights:QueryDescendants("Light") do
                v.Enabled = true;
            end;
        end },
    { 67, function(p9, p10, p11) -- Line: 22
            shared.vfx.emit(p11.Head.Eye);
        end },
    { 87, function(p12, p13, p14) -- Line: 27
            shared.vfx.emit(p12.Despair);

            for _, v in p12.Dodge.lights:QueryDescendants("Light") do
                v.Enabled = false;
            end;

            for _, v in p12.Despair.lights:QueryDescendants("Light") do
                v.Enabled = true;
            end;
        end },
    { 93, function(p15, p16, p17) -- Line: 34
            shared.vfx.emit(p15.SwordStab);
        end },
    { 140, function(p18, p19, p20) -- Line: 39
            for _, v in p18.Despair.lights:QueryDescendants("Light") do
                v.Enabled = false;
            end;
        end },
    { 223, function(p21, p22, p23) -- Line: 44
            shared.vfx.emit(p21.Aurafarm);

            for _, v in p21.Aurafarm.lights:QueryDescendants("Light") do
                v.Enabled = true;
            end;
        end },
    { 309, function(p24, p25, p26) -- Line: 50
            for _, v in p24.Aurafarm.lights:QueryDescendants("Light") do
                v.Enabled = false;
            end;
        end },
    { 368, function(p27, p28, p29) -- Line: 55
            shared.vfx.emit(p27.Aurafarm2);

            for _, v in p27.Aurafarm2.lights:QueryDescendants("Light") do
                v.Enabled = true;
            end;
        end },
    { 467, function(p30, p31, p32) -- Line: 61
            shared.vfx.emit(p30.Closeup);

            for _, v in p30.Aurafarm2.lights:QueryDescendants("Light") do
                v.Enabled = false;
            end;

            for _, v in p30.Closeup.lights:QueryDescendants("Light") do
                v.Enabled = true;
            end;
        end },
    { 600, function(p33, p34, p35) -- Line: 68
            for _, v in p33.Closeup.lights:QueryDescendants("Light") do
                v.Enabled = false;
            end;
        end }
};