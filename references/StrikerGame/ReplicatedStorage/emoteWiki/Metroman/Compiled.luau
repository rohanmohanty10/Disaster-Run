 

 

return {
    { 142, function(p1) -- Line: 3
            require(game.ReplicatedStorage.mvputils.ThePlixAfterimages).Fire(p1, {
                HoldTime = 0.05,
                FadeTime = 0.2,
                TweenToPlayer = true,
                Colors = { Color3.fromRGB(0, 0, 0) },
                CFrameOffset = CFrame.new(0, 0, 5)
            });
        end },
    { 277, function(p2) -- Line: 13
            require(game.ReplicatedStorage.mvputils.ThePlixAfterimages).Fire(p2, {
                HoldTime = 0.05,
                FadeTime = 0.2,
                TweenToPlayer = true,
                Colors = { Color3.fromRGB(0, 0, 0) },
                CFrameOffset = CFrame.new(0, 0, 5)
            });
        end }
};