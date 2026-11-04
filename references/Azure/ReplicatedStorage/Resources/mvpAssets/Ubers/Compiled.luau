 
 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p3.CamPart["1"]);
            shared.vfx.emit(p2.HumanoidRootPart.Mvp["1"]);
            local TekrinnDialogue = require(game.ReplicatedStorage.client.replication.TekrinnDialogue);
            require(script.Utility.highlight_emit).tweenHighlight(p2, Color3.fromRGB(121, 24, 24), Color3.fromRGB(153, 45, 45), 0.4, Enum.HighlightDepthMode.Occluded, "In", -5);
            shared.vfx.emit(p2["Right Leg"], p2.Torso, p2["Right Arm"], p2["Left Leg"], p2["Left Arm"], p2.Head);
            require(script.Utility:WaitForChild("blur_emit"))(25, 1.3);
            TekrinnDialogue.Speak(p1.Name, {
                {
                    Text = "Excellent work.",
                    TypeSpeed = 0.05,
                    Bold = true,
                    Italic = false,
                    HigherUp = false,
                    Color = ColorSequence.new(Color3.fromRGB(255, 0, 0)),
                    TextStrokeColor = Color3.fromRGB(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 0.05,
                        Lifetime = 0.3
                    }
                }
            });
            require(script.Utility.CCEffect)("emit", 0.3, 0.1, 0.6, Color3.fromRGB(255, 143, 143), 1.2);
            p2.HumanoidRootPart.Mvp["1"].L1.SurfaceLight.Enabled = true;
            task.wait(2.5);
            p2.HumanoidRootPart.Mvp["1"].L1.SurfaceLight.Enabled = false;
        end },
    { 148, function(p4, p5, p6, p7) -- Line: 51
            shared.vfx.emit(p6.CamPart["2"]);
            shared.vfx.emit(p5.HumanoidRootPart.Mvp["2"]);
            shared.vfx.emit(p7);
            game:GetService("ReplicatedStorage");
            require(script.Utility.CCEffect)("emit", 0.34, 0.1, 0.8, Color3.fromRGB(255, 143, 143), 1.2);
            p5.HumanoidRootPart.Mvp["2"].L1.SurfaceLight.Enabled = true;
            task.wait(2);
            p5.HumanoidRootPart.Mvp["2"].L1.SurfaceLight.Enabled = false;
        end },
    { 270, function(p8, p9, p10) -- Line: 70
            shared.vfx.emit(p9.HumanoidRootPart.Mvp["3"]);
            require(game.ReplicatedStorage.client.replication.TekrinnDialogue).Speak(p8.Name, {
                {
                    Text = "Serve me, ubers.",
                    TypeSpeed = 0.08,
                    Bold = true,
                    Italic = false,
                    HigherUp = false,
                    Color = ColorSequence.new(Color3.fromRGB(255, 0, 0)),
                    TextStrokeColor = Color3.fromRGB(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 0.05,
                        Lifetime = 0.3
                    }
                }
            });
        end }
};