 
 

return {
    { 19, function(p1) -- Line: 3
            local ReplicatedStorage = game:GetService("ReplicatedStorage");
            local MeshEmitModule = require(ReplicatedStorage.util.MeshEmitModule);

            for _, v in {
                aaa = p1.vfx2
            } do
                MeshEmitModule(v.Start);
            end;
        end },
    { 37, function(p2) -- Line: 18
            local ReplicatedStorage = game:GetService("ReplicatedStorage");
            local MeshEmitModule = require(ReplicatedStorage.util.MeshEmitModule);

            for _, v in {
                aaa = p2.vfx3
            } do
                MeshEmitModule(v.Start);
            end;
        end },
    { 45, function(p3) -- Line: 33
            shared.vfx.emit(p3.Part.effect4);
        end },
    { 52, function(p4) -- Line: 39
            shared.vfx.emit(p4.Part.effect5);
        end },
    { 58, function(p5) -- Line: 45
            shared.vfx.emit(p5.Part.effect6);
        end },
    { 68, function(p6) -- Line: 51
            shared.vfx.emit(p6.Part.effect7);
        end },
    { 74, function(p7) -- Line: 57
            shared.vfx.emit(p7.Part.effect8);
        end },
    { 84, function(p8) -- Line: 63
            shared.vfx.emit(p8.Part.effect9);
            local ReplicatedStorage = game:GetService("ReplicatedStorage");
            local MeshEmitModule = require(ReplicatedStorage.util.MeshEmitModule);

            for _, v in {
                aaa = p8.vfx9mesh.Mesh1,
                aaa2 = p8.vfx9mesh.Mesh2,
                aaa3 = p8.vfx9mesh.Mesh3,
                aaa4 = p8.vfx9mesh.Mesh4
            } do
                MeshEmitModule(v.Start);
            end;
        end },
    { 117, function(p9) -- Line: 84
            shared.vfx.emit(p9.Part.effect10);
        end },
    { 134, function(p10) -- Line: 90
            local ReplicatedStorage = game:GetService("ReplicatedStorage");
            local MeshEmitModule = require(ReplicatedStorage.util.MeshEmitModule);

            for _, v in {
                aaa = p10.vfx11
            } do
                MeshEmitModule(v.Start);
            end;
        end }
};