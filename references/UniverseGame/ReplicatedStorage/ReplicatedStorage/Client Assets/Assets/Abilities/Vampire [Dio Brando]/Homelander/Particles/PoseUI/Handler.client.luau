  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(PathShortcuts.KnitPath.Knit);
local u1 = Random.new();
local Parent = script.Parent;
local Holder = Parent.Holder;
local Container = Holder.Container;

if Lighting:FindFirstChild("CrucibleLightning") then
    Lighting.CrucibleLightning:Destroy();
end;

local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
ColorCorrectionEffect.Name = "CrucibleLightning";
ColorCorrectionEffect.Parent = Lighting;
local v2 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
    Saturation = -0.25,
    TintColor = Color3.fromRGB(255, 75, 75)
});
local u3 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
    Saturation = 0,
    TintColor = Color3.new(1, 1, 1)
});
local u4 = { "GOD", "HOMELANDER", "SLAY ALL", "ERADICATE", "FEAR", "ABOVE ALL", "AMERICA" };

local function GenerateLabel(p5) -- Line: 41
    -- upvalues: Container (copy), Holder (copy), u1 (copy), TweenService (copy), EffectsHandler (copy)
    local u6 = Container:Clone();
    u6.Label:Destroy();
    u6.Parent = Holder;
    u6.GroupTransparency = 1;
    u6.Visible = true;
    u6.Rotation = u1:NextNumber(-20, 20);
    u6.Position = UDim2.fromScale(0.5 + u1:NextNumber(-0.4, 0.4), 0.5 + u1:NextNumber(-0.4, 0.4));
    local v7 = TweenService:Create(u6, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    });
    local u8 = TweenService:Create(u6, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        GroupTransparency = 1
    });
    local u9 = {};

    for i = 1, string.len(p5) do
        local v10 = Container.Label:Clone();
        v10.LayoutOrder = i;
        v10.Letter.Text = string.sub(p5, i, i);
        v10.Parent = u6;
        v10.Visible = true;
        table.insert(u9, v10);
    end;

    local u11 = task.spawn(function() -- Line: 69
        -- upvalues: EffectsHandler (ref), u9 (copy), u1 (ref)
        while true do
            EffectsHandler.Wait(0.01);

            for _, v in u9 do
                v.Letter.Position = UDim2.fromScale(0.5 + u1:NextNumber(-0.075, 0.075), 0.5 + u1:NextNumber(-0.075, 0.075));
            end;
        end;
    end);
    v7:Play();
    v7.Completed:Once(function() -- Line: 79
        -- upvalues: u8 (copy), u11 (copy), u6 (copy)
        u8:Play();
        u8.Completed:Once(function() -- Line: 81
            -- upvalues: u11 (ref), u6 (ref)
            pcall(task.cancel, u11);
            u6:Destroy();
        end);
    end);
end;

local u12 = task.spawn(function() -- Line: 88
    -- upvalues: EffectsHandler (copy), u1 (copy), GenerateLabel (copy), u4 (copy)
    while true do
        EffectsHandler.Wait(u1:NextNumber(0.2, 0.45));
        GenerateLabel(u4[u1:NextInteger(1, #u4)]);
    end;
end);
v2:Play();
v2.Completed:Once(function() -- Line: 97
    -- upvalues: EffectsHandler (copy), u12 (copy), u3 (copy), ColorCorrectionEffect (copy), Parent (copy)
    EffectsHandler.Wait(0.5);
    local Character = game.Players.LocalPlayer.Character;

    repeat
        task.wait();
    until Character:IsDescendantOf(workspace) ~= true or not Character:GetAttribute("Posing");

    pcall(task.cancel, u12);
    u3:Play();
    u3.Completed:Once(function() -- Line: 108
        -- upvalues: ColorCorrectionEffect (ref), EffectsHandler (ref), Parent (ref)
        ColorCorrectionEffect:Destroy();
        EffectsHandler.Wait(3);
        Parent:Destroy();
    end);
end);