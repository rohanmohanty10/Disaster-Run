 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("RunService");
local FrameMarker = require(ReplicatedStorage.mvputils.FrameMarker);
local Library = require(ReplicatedStorage.mvputils.Library);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);

return function(p1: userdata, p2: userdata, p3: userdata) -- Line: 11
    -- upvalues: vfxUtil (copy), Debris (copy), FrameMarker (copy), Library (copy)
    local Root = vfxUtil.getRoot(p1);
    vfxUtil.getRoot(p2);
    local Torso = p2:FindFirstChild("Torso");

    if not (Root and (p2 and Torso)) then
        return;
    end;

    local u4 = script.kb:Clone();
    u4.Parent = Torso;
    local v5 = p3:FindFirstChildOfClass("Attachment");

    if not v5 then
        warn("No cam attachment kid");

        return;
    end;

    local v6 = v5:FindFirstChild("0");

    if v6 then
        local u7 = v6:FindFirstChildOfClass("Beam");
        local TimeOfDay = game.Lighting.TimeOfDay;
        local u8 = script.FX:Clone();
        u8.Parent = workspace.Effects;
        u8:PivotTo(Root.CFrame);
        Debris:AddItem(u8, 15);

        return FrameMarker.new({
            Framerate = 60
        }):Chain({
            [9] = function() -- Line: 42
                -- upvalues: Library (ref), u8 (copy)
                Library.Particles:Emit(u8.VFX.thosewhostep);
            end,

            [67] = function() -- Line: 48
            end,

            [86] = function() -- Line: 53
                -- upvalues: Library (ref), u8 (copy)
                Library.Particles:Emit(u8.VFX.one);
            end,

            [105] = function() -- Line: 60
                -- upvalues: Library (ref), u8 (copy), u4 (copy)
                Library.Particles:Emit(u8.VFX.shove);
                Library.Particles:Enable(u4, 1);
                task.delay(1, function() -- Line: 66
                    -- upvalues: u4 (ref)
                    if u4 then
                        u4:Destroy();
                    end;
                end);
            end,

            [124] = function() -- Line: 74
                -- upvalues: Library (ref), u8 (copy)
                Library.Particles:Emit(u8.VFX.floor1);
            end,

            [276] = function() -- Line: 80
                -- upvalues: Library (ref), u8 (copy), Root (copy), u7 (copy)
                Library.Particles:Enable(u8.slines, 2);
                Library.Lighting.CCFlash({
                    Brightness = -0.9,
                    Contrast = 2,
                    Saturation = 0.4,
                    Duration = 2,
                    Color = Color3.fromRGB(255, 255, 255)
                });
                Library.Lighting.Highlight({
                    Duration = 2,
                    FadeDirection = "Out",
                    InitalFillTransparency = -1,
                    Model = Root.Parent,
                    FillColor = Color3.fromRGB(0, 0, 0),
                    OutlineColor = Color3.fromRGB(0, 0, 0)
                });
                u7.Enabled = true;
                game.Lighting.TimeOfDay = "00:00:00";
            end,

            [402] = function() -- Line: 110
                -- upvalues: u7 (copy), TimeOfDay (copy)
                u7.Enabled = false;
                game.Lighting.TimeOfDay = TimeOfDay;
            end,

            [550] = function() -- Line: 118
                -- upvalues: Library (ref), u8 (copy)
                Library.Particles:Emit(u8.steps.one);
            end,

            [571] = function() -- Line: 124
                -- upvalues: Library (ref), u8 (copy)
                Library.Particles:Emit(u8.steps.two);
            end,

            [610] = function() -- Line: 130
                -- upvalues: Library (ref), u8 (copy)
                Library.Particles:Emit(u8.steps.three);
            end
        });
    end;

    warn("No cam attachment2 kid");
end;