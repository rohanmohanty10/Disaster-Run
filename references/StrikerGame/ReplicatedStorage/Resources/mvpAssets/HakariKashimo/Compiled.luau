 
 

return {
    { 86, function(p1, p2, p3, p4, p5, p6) -- Line: 3
            require(game.ReplicatedStorage.mvputils.highlight_emit).tweenHighlight(p5, Color3.fromRGB(62, 165, 71), Color3.fromRGB(120, 255, 99), 1, Enum.HighlightDepthMode.Occluded, "In", 0.3);
            shared.vfx.emit(p3.Root.mvp.Start);
        end },
    { 138, function(p7, p8, p9, p10, p11, p12) -- Line: 19
            require(game.ReplicatedStorage.mvputils.highlight_emit).tweenHighlight(p9.Doimaindsity.HakariDomainSlotMachines1, Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255), 0.5, Enum.HighlightDepthMode.Occluded, "In", 0);
            require(game.ReplicatedStorage.mvputils.highlight_emit).tweenHighlight(p9.Doimaindsity.HakariDomainSlotMachines2, Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255), 1, Enum.HighlightDepthMode.Occluded, "In", 0);
        end },
    { 146, function(p13, p14, p15, p16, p17, p18) -- Line: 43
            shared.vfx.emit(p15.Root.mvp.Fast);
        end },
    { 310, function(p19, p20, p21, p22, p23, p24) -- Line: 48
            shared.vfx.emit(p22.CamPart.Pressure);
        end },
    { 385, function(p25, p26, p27, p28, p29, p30) -- Line: 53
            require(game.ReplicatedStorage.mvputils.colorcorrection_emit)(-0.3, -0.1, 0.7, Color3.fromRGB(250, 255, 162), 0.4);
            shared.vfx.emit(p27.Root.mvp.coin0);
        end },
    { 394, function(p31, p32, p33, p34, p35, p36) -- Line: 61
            shared.vfx.emit(p33.Root.mvp.coin1);
            require(game.ReplicatedStorage.mvputils.colorcorrection_emit)(-0.3, -0.1, 0.7, Color3.fromRGB(250, 255, 162), 0.4);
        end },
    { 416, function(p37, p38, p39, p40, p41, p42) -- Line: 69
            shared.vfx.emit(p39.Root.mvp.coin2);
            require(game.ReplicatedStorage.mvputils.colorcorrection_emit)(-0.3, -0.1, 0.7, Color3.fromRGB(250, 255, 162), 0.4);
        end },
    { 430, function(p43, p44, p45, p46, p47, p48) -- Line: 77
            shared.vfx.emit(p45.Root.mvp.coin3);
            require(game.ReplicatedStorage.mvputils.colorcorrection_emit)(-0.3, -0.1, 0.7, Color3.fromRGB(250, 255, 162), 0.4);
        end },
    { 486, function(p49, p50, p51, p52, p53, p54) -- Line: 85
            shared.vfx.emit(p51.Root.mvp.Jackpot);
            shared.vfx.emit(p52.CamPart["1"]);
            require(game.ReplicatedStorage.mvputils.highlight_emit).tweenHighlight(p53, Color3.fromRGB(0, 0, 0), Color3.fromRGB(120, 255, 99), 1, Enum.HighlightDepthMode.Occluded, "In", 0);
            require(game.ReplicatedStorage.mvputils.colorcorrection_emit)(-0.05, 0.1, 0.7, Color3.fromRGB(58, 255, 104), 0.7);
            shared.vfx.emit(p49.Torso, p49["Right Leg"], p49["Right Arm"], p49["Left Leg"], p49["Left Arm"], p49.Head);
        end },
    { 601, function(p55, p56, p57, p58, p59, p60) -- Line: 110
            shared.vfx.emit(p57.Root.mvp.Kashimo);
            shared.vfx.emit(p58.CamPart["2"]);
            shared.vfx.emit(p56);
            require(game.ReplicatedStorage.mvputils.highlight_emit).tweenHighlight(p60, Color3.fromRGB(102, 47, 165), Color3.fromRGB(141, 84, 255), 1, Enum.HighlightDepthMode.Occluded, "In", -2);
        end },
    { 693, function(p61, p62, p63, p64, p65, p66) -- Line: 130
            shared.vfx.emit(p63.Root.mvp.PreClash);
            require(game.ReplicatedStorage.mvputils.colorcorrection_emit)(0.3, -0.2, 0.5, Color3.fromRGB(42, 42, 42), 0.4);
        end },
    { 727, function(p67, p68, p69, p70, p71, p72) -- Line: 138
            shared.vfx.emit(p70.CamPart.Clash);
            shared.vfx.emit(p69.Root.mvp.Clash);
        end }
};