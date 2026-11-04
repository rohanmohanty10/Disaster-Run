 
 

local colorcorrection_emit = require(game.ReplicatedStorage.mvputils.colorcorrection_emit);
local camshake_emit = require(game.ReplicatedStorage.mvputils.camshake_emit);
local highlight_emit = require(game.ReplicatedStorage.mvputils.highlight_emit);

return {
    { 141, function(p1, p2) -- Line: 7
            if p2 then
                shared.vfx.emit(p2.CamPart.ArsenalCamEffects.BG);
            end;
        end },
    { 194, function(p3) -- Line: 14
            -- upvalues: colorcorrection_emit (copy), camshake_emit (copy)
            colorcorrection_emit(-1.3, 1, 15, Color3.fromRGB(255, 88, 88), 0.2);
            colorcorrection_emit(1.3, -1, -15, Color3.fromRGB(255, 102, 0), 0.3);
            camshake_emit.shake(0.5, 0.15, 0.2);
            shared.vfx.emit(p3.Shine);
        end },
    { 195, function(p4) -- Line: 24
            -- upvalues: colorcorrection_emit (copy)
            colorcorrection_emit(0.3, 0.2, 0.5, Color3.fromRGB(255, 255, 255), 1.4);
        end },
    { 854, function(p5) -- Line: 29
            -- upvalues: highlight_emit (copy)
            highlight_emit.tweenHighlight(p5["azlball\'"], Color3.fromRGB(255, 123, 83), Color3.fromRGB(138, 67, 45), 0.8, Enum.HighlightDepthMode.Occluded, "In", 0.3);
        end },
    { 939, function(p6) -- Line: 42
            -- upvalues: highlight_emit (copy)
            shared.vfx.emit(p6["azlball\'"].Torso.Dash, p6["azlball\'"].HumanoidRootPart["3"]);
            shared.vfx.emit(p6.Arsenal);
            highlight_emit.tweenHighlight(p6["azlball\'"], Color3.fromRGB(138, 67, 45), Color3.fromRGB(138, 67, 45), 0.5, Enum.HighlightDepthMode.AlwaysOnTop, "In", -2);
        end }
};