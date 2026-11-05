  

 

while not _G.Petal do
    task.wait(0.1);
end;

local Petal = _G.Petal;
local u1 = Petal("New");
local u2 = Petal("Util");
local _ = u2.Tween;
local ReplicatedModules = game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules");
require(ReplicatedModules.PathShortcuts);
local Classes = ReplicatedModules:FindFirstChild("Classes");
local Sequence_V2 = require(Classes:FindFirstChild("Sequence_V2"));

return function(u3, u4) -- Line: 16
    -- upvalues: u1 (copy), Sequence_V2 (copy), u2 (copy)
    if u3:GetAttribute("Animated") or not u3:GetAttribute("Ready") then
        return;
    end;

    u3:SetAttribute("Animated", true);
    local Content = u3:WaitForChild("Content");
    local u5 = u1("NumberValue")({
        Name = "Intensity",
        Value = 0,
        Parent = u3
    });
    local u6 = 0;
    Sequence_V2.CreateFromOldSequence({
        Speed = 1,

        Validate = function(p7) -- Line: 33, Name: Validate
            -- upvalues: u3 (copy)
            return u3.Parent ~= nil;
        end,

        Frames = {
            { 0, function(u8) -- Line: 37
                    -- upvalues: Content (copy), u3 (copy), u4 (copy), u6 (ref), u5 (copy), u2 (ref)
                    local u9 = u8:GetCache("Cache");
                    u9.Pos = Content.Position;
                    u9.Rot = Content.Rotation;
                    local v10 = u3:GetAttribute("Rarity") or "Common";

                    if v10 == "Unobtainable" or (v10 == "Limited" or v10 == "Developer") then
                        u4:PlaySound("card_clickhexedlegendary");
                        u4:PlaySound("ug_gacha_mythic");
                    else
                        u4:PlaySound("card_click" .. v10:lower());
                    end;

                    task.spawn(function() -- Line: 50
                        -- upvalues: u8 (copy), u3 (ref), u6 (ref), u5 (ref), Content (ref), u9 (copy)
                        while u8:IsPlaying() and u3.Parent do
                            u6 = u5.Value;
                            Content.Position = u9.Pos + UDim2.new(math.random(-u6, u6) / 700, 0, math.random(-u6, u6) / 700, 0);
                            Content.Rotation = math.random(-u6, u6) / 3;
                            task.wait();
                        end;
                    end);
                    u2.Tween(u5, 1.35, "Quad", "Out", {
                        Value = 10
                    });
                end },
            { 42, function(p11, p12) -- Line: 64
                    -- upvalues: u1 (ref), Content (copy), u2 (ref)
                    local v13 = u1("Frame")({
                        Name = "Flash",
                        ZIndex = 3,
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        Parent = Content,
                        Size = Content.Cover.Size,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    });
                    u2.Tween(v13, 0.85, "Quad", "Out", {
                        BackgroundTransparency = 0
                    });
                    task.wait(0.85);
                    Content.Cover.Visible = false;
                    u2.Tween(v13, 0.15, "Quad", "Out", {
                        BackgroundTransparency = 1
                    });
                end },
            { 81, function(p14, p15) -- Line: 87
                    -- upvalues: u2 (ref), u5 (copy)
                    u2.Tween(u5, 0.15, "Quad", "Out", {
                        Value = 25
                    });
                end },
            { 93, function(p16, p17) -- Line: 91
                    -- upvalues: u2 (ref), u5 (copy)
                    u2.Tween(u5, 0.4, "Quad", "Out", {
                        Value = 0
                    });
                end },
            { 117, function(p18, p19) -- Line: 95
                    -- upvalues: Content (copy), u5 (copy)
                    local v20 = p18:GetCache("Cache");
                    Content.Position = v20.Pos;
                    Content.Rotation = v20.Rot;
                    u5:Destroy();
                end }
        }
    }):Play();
end;