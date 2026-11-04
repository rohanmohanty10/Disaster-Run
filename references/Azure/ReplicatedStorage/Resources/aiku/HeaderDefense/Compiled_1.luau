 
 

return {
    { 20, function(p1, p2, p3) -- Line: 3
            require(game.ReplicatedStorage.mvputils.colorcorrection_emit)(-0.09, 0.3, 0.5, Color3.fromRGB(199, 255, 178), 0.9);
            shared.vfx.emit(p3.camera.Lines);
            shared.vfx.emit(p3.camera.Headed);
            shared.vfx.emit(p1.Head.Headed);
        end },
    { 92, function(p4, p5, p6) -- Line: 14
            shared.vfx.emit(p5.Transition);
        end },
    { 131, function(p7, p8, p9) -- Line: 19
            shared.vfx.emit(p7.Head.Breath);
            require(game.ReplicatedStorage.mvputils.highlight_emit).tweenHighlight(p7, Color3.fromRGB(52, 120, 43), Color3.fromRGB(103, 255, 69), 0.6, Enum.HighlightDepthMode.Occluded, "In", 0.7);
            shared.vfx.emit(p7.Head.Eyes);
            shared.vfx.emit(p7.Head.EyesFlash);
            require(game.ReplicatedStorage.mvputils.colorcorrection_emit)(0.1, 0.2, 0.5, Color3.fromRGB(201, 255, 185), 0.84);
        end }
};