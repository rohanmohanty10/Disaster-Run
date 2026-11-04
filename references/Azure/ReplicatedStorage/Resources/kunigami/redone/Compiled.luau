 

 

return {
    { 65, function(p1, p2) -- Line: 3
            shared.vfx.emit(p2.Head.breath);
        end },
    { 106, function(p3, p4) -- Line: 8
            p3["Right Arm"].Light.PointLight.Enabled = true;

            for _, descendant in pairs(p3["Right Arm"].Attachment:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            shared.vfx.emit(p3["Right Arm"].Beam1.Beam);
        end },
    { 157, function(p5, p6) -- Line: 23
            shared.vfx.emit(p5["Right Arm"]["0"]);
        end },
    { 186, function(p7, p8, p9) -- Line: 28
            shared.vfx.emit(p8.HumanoidRootPart["3"]);
            p7["Right Arm"].Light.PointLight.Enabled = false;
            shared.vfx.emit(p7.HumanoidRootPart["10"]);
            shared.vfx.emit(p9.camera:FindFirstChild("Attachment"):FindFirstChild("ScreenGlare1"):FindFirstChild("Black"), p9.camera:FindFirstChild("Attachment"):FindFirstChild("ScreenGlare1").Black);
        end },
    { 193, function(p10, p11) -- Line: 37
            shared.vfx.emit(p10["Right Arm"]);
        end }
};