 

 

return {
    { 0, function(p1, p2, p3) -- Line: 5
            require(script.Parent.This).Load("Part1");
            workspace.Terrain.MVPCloud.Enabled = true;
            require(script.Parent.Hope):New();
            p2.vfx.Yea.Beam.Enabled = true;
        end },
    { 19, function(p4, p5, p6) -- Line: 14
            require(script.Parent.Hope):Next();
        end },
    { 29, function(p7, p8, p9) -- Line: 20
            require(script.Parent.Hope):Next();
        end },
    { 39, function(p10, p11, p12) -- Line: 26
            require(script.Parent.Hope):Next();
        end },
    { 48, function(p13, p14, p15) -- Line: 32
            require(script.Parent.Hope):Next();
        end },
    { 63, function(p16, p17, p18) -- Line: 38
            require(script.Parent.Hope):Next();
        end },
    { 83, function(p19, p20, p21) -- Line: 44
            require(script.Parent.Hope):Okay();
        end },
    { 1330, function(p22, p23, p24) -- Line: 50
            p23.vfx.Yea.Beam.Enabled = false;
        end },
    { 1479, function(p25, p26, p27) -- Line: 56
            require(script.Parent.This).Load("Part2");
            workspace.Terrain.MVPCloud.Enabled = false;
        end }
};