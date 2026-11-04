 
 

return {
    { 0, function(p1, p2) -- Line: 3
            shared.vfx.emit(p1.ScreenEffect);
        end },
    { 18, function(p3, p4) -- Line: 8
            shared.vfx.emit(p3.TuffCharacterRig.Ball["Energy Emit"]);
        end },
    { 260, function(p5, p6) -- Line: 13
            shared.vfx.emit(p5.ScreenEffect);
        end },
    { 310, function(p7, p8) -- Line: 18
            shared.vfx.emit(p7.Folder.Kick);
        end },
    { 372, function(p9, p10) -- Line: 23
            shared.vfx.emit(p9.Folder.ShotVFX, p9.ScreenEffect);
            shared.vfx.emit(p9.TuffCharacterRig.Ball.Attachment2);

            if p10 then
                shared.vfx.emit(p10.CamPart.lineeffects1:FindFirstChild("Attachment").Lines1, p10.CamPart.lineeffects1.Attachment.Lines1);
            end;
        end }
};