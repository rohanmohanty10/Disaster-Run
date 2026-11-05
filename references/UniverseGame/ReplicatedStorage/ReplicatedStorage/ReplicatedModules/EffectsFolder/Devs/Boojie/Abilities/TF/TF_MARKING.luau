  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
Random.new();
local TweenService = game:GetService("TweenService");

local function Effect(p1) -- Line: 9
    -- upvalues: TweenService (copy), Effect (copy)
    local Character = p1.Character;
    local v2 = p1.Transparency or 1;
    local Flash = p1.Flash;
    local v3 = p1.StartColor or Color3.new(1, 0, 0);
    local v4 = p1.EndColor or Color3.new(0, 0, 0);
    local v5 = p1.StartOutlineColor or (p1.OutlineColor or Color3.new(1, 0, 0));
    local v6 = p1.EndOutlineColor or v5;
    local v7 = p1.ColorInfo or { 0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out };
    local v8 = p1.TransparencyInfo or { 0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out };
    local v9 = TweenInfo.new(unpack(v7));
    local v10 = TweenInfo.new(unpack(v8));
    local Time = p1.Time;
    local u11 = {};

    for _, descendant in pairs(Character:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.Name:match("Marks") then
            local v12 = descendant.Name:match("MarksOutline");

            if Flash then
                descendant.Color = v12 and v5 and v5 or v3;
            end;

            local v13 = TweenService:Create(descendant, v9, {
                Color = v12 and v6 and v6 or v4
            });
            v13:Play();
            table.insert(u11, v13);
            local v14 = TweenService:Create(descendant, v10, {
                Transparency = v2
            });
            v14:Play();
            table.insert(u11, v14);
        end;
    end;

    task.delay(v8[1] + v7[1], function() -- Line: 51
        -- upvalues: u11 (copy)
        for _, v in pairs(u11) do
            v:Destroy();
        end;
    end);

    if Time then
        task.wait(Time);
        Effect({
            Flash = false,
            Transparency = 1,
            Character = Character,
            TransparencyInfo = p1.EndTransparencyInfo or (p1.TransparencyInfo or { 0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out })
        });
    end;
end;

return Effect;