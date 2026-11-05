  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local RunService = game:GetService("RunService");
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Petal = _G.Petal;
Petal("New");
local u1 = Petal("Util");
local RingStroke = script.RingStroke;
local _ = game:GetService("Players").LocalPlayer;

return function(p2) -- Line: 12
    -- upvalues: RingStroke (copy), u1 (copy), RunService (copy)
    local Thickness = p2.Thickness;
    local Duration = p2.Duration;
    local CFrame = p2.CFrame;
    local Size = p2.Size;
    local v3 = p2.FormFactor or "Circle";
    local v4 = p2.Color or Color3.fromRGB(255, 255, 255);
    local u5 = RingStroke:Clone();
    local u6 = u5:GetChildren();

    for _, v in u6 do
        local Frame = v.Frame;
        local Stroke = Frame.Stroke;
        local Corner = Frame.Corner;

        if v3 == "Square" then
            Stroke.LineJoinMode = Enum.LineJoinMode.Miter;
            Corner.CornerRadius = UDim.new(0, 0);
        end;

        Stroke.Color = v4;
        Stroke.Thickness = Thickness[1];
        v.Enabled = true;
    end;

    local u7 = Vector3.new(Size[1], 0, Size[1]);
    u5.Size = u7;
    u5.CFrame = CFrame;

    local function Effect() -- Line: 43
        -- upvalues: Duration (copy), u6 (copy), u1 (ref), Thickness (copy), u5 (copy), u7 (copy), Size (copy), RunService (ref)
        local v8 = Duration * 60;

        for i = 1, v8 do
            local v9 = i / v8;

            for _, v in u6 do
                local Frame = v.Frame;
                local Stroke = Frame.Stroke;
                local _ = Frame.Corner;
                Stroke.Transparency = u1.QuadraticBezier(0, 0, 1, v9);
                Stroke.Thickness = u1.QuadraticBezier(Stroke.Thickness, Thickness[2], 0, v9);
                Frame.Size = u1.Lerp(Frame.Size, UDim2.new(0.6, 0, 0.6, 0), v9);
            end;

            u5.Size = u1.Lerp(u7, Vector3.new(Size[2], 0, Size[2]), v9);
            RunService.RenderStepped:Wait();
        end;

        u5:Destroy();
    end;

    u5.Parent = workspace.Effects;
    task.spawn(Effect);
end;