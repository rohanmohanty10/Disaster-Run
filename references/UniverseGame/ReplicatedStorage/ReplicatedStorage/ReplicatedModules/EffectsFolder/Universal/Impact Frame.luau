  

 

local ContentProvider = game:GetService("ContentProvider");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("TweenService");
require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V2);
local LocalPlayer = Players.LocalPlayer;
local ImageLabel = Instance.new("ImageLabel");
ImageLabel.Image = "";
ImageLabel.Size = UDim2.new(1, 0, 1, 0);
ImageLabel.Position = UDim2.new(0, 0, 0, 0);
ImageLabel.ZIndex = 100;
ImageLabel.Parent = script;
ImageLabel.Visible = false;
local u1 = {};

return function(u2) -- Line: 27
    -- upvalues: LocalPlayer (copy), Lighting (copy), u1 (copy), ImageLabel (copy), ContentProvider (copy)
    local Settings = LocalPlayer:FindFirstChild("Settings");
    local v3 = u2.Type or "Highlight";
    local Time = u2.Time;

    if Settings and not (u2.BypassSettings or Settings.ImpactFrame.Value) then
        return;
    end;

    if v3 ~= "Highlight" then
        if v3 == "Image" then
            local u4 = u2.Frames or {};
            local _ = u2.Speed or 1;
            local State = u2.State;
            local Identifier = u2.Identifier;
            local Preload = u2.Preload;
            local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");

            if not (PlayerGui and u4) then
                return;
            end;

            local Core = PlayerGui:FindFirstChild("Core");

            if not Core then
                return;
            end;

            local function ClearImageLabels() -- Line: 86
                -- upvalues: u1 (ref), Identifier (copy)
                local v5 = u1[Identifier];

                if not v5 then
                    return;
                end;

                for _, v in pairs(v5) do
                    if v and v.Parent then
                        v:Destroy();
                    end;
                end;

                u1[Identifier] = nil;
            end;

            local function CreateImageLabels() -- Line: 104
                -- upvalues: ImageLabel (ref), Core (copy), u4 (copy), Preload (copy), ContentProvider (ref)
                local function CreateImageLabel(p6) -- Line: 107
                    -- upvalues: ImageLabel (ref), Core (ref)
                    local v7 = ImageLabel:Clone();
                    v7.Parent = Core;
                    v7.ImageTransparency = 0;
                    v7.BackgroundTransparency = 1;
                    v7.Visible = true;
                    v7.Image = p6;
                    v7.Size = UDim2.fromScale(0, 0);

                    return v7;
                end;

                local v8 = {};

                for i, v in pairs(u4) do
                    local v9 = ImageLabel:Clone();
                    v9.Parent = Core;
                    v9.ImageTransparency = 0;
                    v9.BackgroundTransparency = 1;
                    v9.Visible = true;
                    v9.Image = v;
                    v9.Size = UDim2.fromScale(0, 0);
                    v8[i] = v9;
                end;

                if Preload ~= false then
                    ContentProvider:PreloadAsync(u4);
                end;

                return #v8 > 0 and v8 and v8 or nil;
            end;

            if State == "Load" then
                u1[Identifier] = CreateImageLabels();

                return;
            end;

            if State == "Play" then
                local v10 = u1[Identifier] or CreateImageLabels();

                if not v10 then
                    return;
                end;

                local u11 = Time / #v10;

                for i, v in pairs(v10) do
                    if v and v.Parent then
                        task.delay(u11 * (i - 1), function() -- Line: 148
                            -- upvalues: v (copy), u11 (copy)
                            v.Size = UDim2.fromScale(1, 1);
                            task.wait(u11);
                            v.Size = UDim2.fromScale(0, 0);
                        end);
                    end;
                end;

                if u2.Cleanup ~= false then
                    task.delay(Time, ClearImageLabels);

                    return;
                end;
            elseif State == "Clear" then
                ClearImageLabels();
            end;
        end;

        return;
    end;

    local v12 = u2.Models or {};
    task.spawn(function() -- Line: 41
        -- upvalues: u2 (copy), Lighting (ref), Time (copy)
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Brightness = u2.StartBrightness or 1;
        ColorCorrectionEffect.TintColor = u2.BackgroundColor or ColorCorrectionEffect.TintColor;
        ColorCorrectionEffect.Parent = Lighting;
        task.wait(Time / 2);
        ColorCorrectionEffect.Brightness = u2.EndBrightness or -1;
        task.wait(Time / 2);
        ColorCorrectionEffect:Destroy();
    end);

    for _, v in pairs(v12) do
        task.spawn(function() -- Line: 55
            -- upvalues: u2 (copy), v (copy), Time (copy)
            local Highlight = Instance.new("Highlight");
            Highlight.OutlineTransparency = 1;
            Highlight.FillTransparency = 0;
            Highlight.FillColor = u2.StartFillColor or Color3.new(0, 0, 0);
            Highlight.Parent = v;
            task.wait(Time / 2);
            Highlight.FillColor = u2.EndFillColor or Color3.new(1, 1, 1);
            task.wait(Time / 2);
            Highlight:Destroy();
        end);
    end;
end;