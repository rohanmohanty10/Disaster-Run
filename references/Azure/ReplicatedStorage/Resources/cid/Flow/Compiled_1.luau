 
 

return {
    { 0, function(p1, p2) -- Line: 3
            local shared_vfx = shared.vfx;
            shared_vfx.emit(p1.wind);
            shared_vfx.emit(p2.Torso);
            shared_vfx.emit(p2.Head.glare1);
        end },
    { 28, function(p3, p4) -- Line: 11
            local shared_vfx = shared.vfx;
            shared_vfx.emit(p3.Part);
            shared_vfx.emit(p3.beamwindlast);
            shared_vfx.emit(p3.smokes);
            shared_vfx.emit(p3.mesh2, p3.mesh1);
            shared_vfx.emit(p3.winddecalmesh);
        end },
    { 188, function(p5, p6) -- Line: 21
            shared.vfx.emit(p5.step);
        end },
    { 289, function(p7, p8) -- Line: 27
            shared.vfx.emit(p8.Head.secondglare);
        end },
    { 397, function(p9, p10) -- Line: 33
            shared.vfx.emit(p9.stuff);
        end },
    { 400, function(p11, p12) -- Line: 39
            local shared_vfx = shared.vfx;
            shared_vfx.emit(p12.Crowbar.MeshPartMesh);
            shared_vfx.emit(p11.mesh2, p11.mesh1);
        end },
    { 466, function(p13, p14) -- Line: 46
            shared.vfx.emit(p14.Sword.slime);
        end },
    { 495, function(p15, p16) -- Line: 52
            shared.vfx.emit(p16.Sword);
        end },
    { 673, function(p17, p18) -- Line: 58
            local shared_vfx = shared.vfx;
            shared_vfx.emit(p17.glare);
            shared_vfx.emit(p17.HighlightTextures);
        end },
    { 706, function(p19, p20) -- Line: 66
            local shared_vfx = shared.vfx;
            shared_vfx.emit(p19.mesh1, p19.mesh2, p19.wind2, p19.Part, p19.beamwindlast, p20.Torso);
            shared_vfx.emit(p19.windemit);
            shared_vfx.emit(p19.atomic);
        end },
    { 831, function(p21, p22) -- Line: 74
            shared.vfx.emit(p22.Head.secondglare);
        end }
};