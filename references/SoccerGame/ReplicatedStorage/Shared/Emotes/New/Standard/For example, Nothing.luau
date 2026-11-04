  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Color3_fromRGB_ret = Color3.fromRGB(85, 170, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(0, 0, 0);

local function showLine(p2, p3, p4, p5) -- Line: 10
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), TweenService (copy)
    local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Name = "SubtitleAnchor";
    Attachment.Position = Vector3.new(p5 * 3, -0.4, -3);
    Attachment.Parent = HumanoidRootPart;
    p2:Add(Attachment);
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "SubtitleBillboard";
    BillboardGui.Adornee = Attachment;
    BillboardGui.Size = UDim2.fromScale(7, 1.8);
    BillboardGui.LightInfluence = 0;
    BillboardGui.Parent = HumanoidRootPart;
    p2:Add(BillboardGui);
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.Font = Enum.Font.LuckiestGuy;
    TextLabel.Text = p4;
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3_fromRGB_ret;
    TextLabel.TextTransparency = 1;
    TextLabel.Rotation = p5 * -5;
    TextLabel.Parent = BillboardGui;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret2;
    UIStroke.Thickness = 3;
    UIStroke.Transparency = 1;
    UIStroke.Parent = TextLabel;
    TweenService:Create(Attachment, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = Vector3.new(p5 * 3, 0.8, -3)
    }):Play();
    TweenService:Create(TextLabel, TweenInfo.new(0.35), {
        TextTransparency = 0
    }):Play();
    TweenService:Create(UIStroke, TweenInfo.new(0.35), {
        Transparency = 0
    }):Play();
    task.wait(1.15);

    if not BillboardGui.Parent then
        return;
    end;

    TweenService:Create(Attachment, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = Vector3.new(p5 * 3, 1.4, -3)
    }):Play();
    TweenService:Create(TextLabel, TweenInfo.new(0.3), {
        TextTransparency = 1
    }):Play();
    TweenService:Create(UIStroke, TweenInfo.new(0.3), {
        Transparency = 1
    }):Play();
    task.wait(0.3);
    BillboardGui:Destroy();
    Attachment:Destroy();
end;

return v1({
    looped = false,
    animationId = "rbxassetid://107838426850270",
    meta = {
        rarity = "Limited"
    },

    effect = function(u6: any, p7: userdata, p8: any) -- Line: 69, Name: effect
        -- upvalues: Trove (copy), showLine (copy)
        local u9 = Trove.new();
        local u10 = true;
        u9:Add(function() -- Line: 73
            -- upvalues: u10 (ref)
            u10 = false;
        end);
        task.spawn(function() -- Line: 77
            -- upvalues: showLine (ref), u9 (copy), u6 (copy), u10 (ref)
            showLine(u9, u6, `What does the {u6.Name} Special Consist Of?`, -1);

            if not u10 then
                return;
            end;

            showLine(u9, u6, "For Example Nothing", 1);
        end);
        local v11 = script.BALL:Clone();
        v11.Parent = u6;
        v11.Anchored = false;
        v11.CanCollide = false;
        v11.CanQuery = false;
        v11.CanTouch = false;
        v11.Massless = true;
        v11.BALL.Part0 = u6["Right Arm"];
        v11.BALL.Part1 = v11;
        u9:Add(v11);

        return u9;
    end
});