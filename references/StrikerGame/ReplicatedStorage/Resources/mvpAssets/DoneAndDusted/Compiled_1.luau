 
 

return {
    { 0, function(p1) -- Line: 3
            shared.vfx.emit(p1.FlashyDomain2);
        end },
    { 27, function(p2) -- Line: 8
            shared.vfx.emit(p2.ScreenEffectZoomlong);
        end },
    { 57, function(p3, p4) -- Line: 13
            shared.vfx.emit(p3.FlashyDomain, p3.ScreenEffectDetailsAngled);
            shared.vfx.emit(p4.CamPart.nagistrongglare.Text);
        end }
};