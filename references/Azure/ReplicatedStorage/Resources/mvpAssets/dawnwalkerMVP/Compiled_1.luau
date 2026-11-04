 
 

return {
    { 0, function(p1) -- Line: 4
            shared.vfx.emit(p1.Beams1);
            shared.vfx.emit(p1.CamVfx.Winds);
            shared.vfx.emit(p1.CamVfx.Flares.Flare1);
        end },
    { 104, function(p2) -- Line: 12
            shared.vfx.emit(p2.Beams2);
            shared.vfx.emit(p2.CamVfx.smth.ey2);
        end },
    { 203, function(p3) -- Line: 19
            shared.vfx.emit(p3.FakeHead);
        end },
    { 227, function(p4, p5, p6) -- Line: 25
            shared.vfx.emit(p4.imapct);
            shared.vfx.emit(p4.CamVfx.smth.Beam);
            shared.vfx.emit(p4.Beams3);
            local v7 = p6 and p6:FindFirstChild("Highlight");

            if v7 then
                shared.vfx.emit(v7);
            end;
        end },
    { 281, function(p8, p9) -- Line: 40
            local v10 = p9:FindFirstChild("Torso") or p9:FindFirstChild("UpperTorso");
            local v11 = v10 and v10:FindFirstChild("Enable");

            if v11 then
                shared.vfx.emit(v11);
            end;
        end },
    { 328, function(p12) -- Line: 52
            shared.vfx.emit(p12.CamVfx.Lines4, p12.CamVfx.Lines3, p12.CamVfx.Lines2);
            shared.vfx.emit(p12.CamVfx.smth.ey);
            shared.vfx.emit(p12.CamVfx.Flares.Flare2.Flare2);
            p12.HaloAura.Aura.Attachment.PointLight.Enabled = true;
        end },
    { 411, function(p13) -- Line: 61
            shared.vfx.emit(p13.CamVfx.Lines4, p13.CamVfx.Lines3, p13.CamVfx.Lines2);
        end },
    { 553, function(p14) -- Line: 67
            shared.vfx.emit(p14.CamVfx.Impact612);
            shared.vfx.emit(p14.FakeRarm);
            p14.HaloAura.Aura.Attachment.PointLight.Enabled = false;
            p14.HaloAura.Aura.PointLight.Enabled = true;
        end },
    { 581, function(p15) -- Line: 76
            shared.vfx.emit(p15.smth);
        end },
    { 650, function(p16) -- Line: 82
            shared.vfx.emit(p16.pureaura);
        end },
    { 684, function(p17) -- Line: 88
            shared.vfx.emit(p17.CamVfx.Lighting2);
            shared.vfx.emit(p17.CamVfx.Flares.Flare3);
            shared.vfx.emit(p17.Beams5);
            shared.vfx.emit(p17.CamVfx.ey);
        end }
};