  

 

require(game.ReplicatedStorage.ReplicatedModules.Animations);
local LocalPlayer = game.Players.LocalPlayer;
(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid");
local ContextActionService = game:GetService("ContextActionService");
game:GetService("GuiService");
local TweenService = game:GetService("TweenService");
local LocalPlayer2 = game.Players.LocalPlayer;
local u1 = {};
local BlurEffect = Instance.new("BlurEffect", workspace.CurrentCamera);
BlurEffect.Name = "OmnitrixBlur";
BlurEffect.Size = 0;
local u2 = LocalPlayer2:GetMouse();
local u3 = UDim2.new(0.8, 0, 0.8, 0);
local u4 = UDim2.new(0.005, 0, 0.005, 0);
local Frame = Instance.new("Frame");
Frame.Size = UDim2.new(0.2, 0, 0.3, 0);
Frame.SizeConstraint = Enum.SizeConstraint.RelativeXX;
Frame.BackgroundTransparency = 0.5;
Frame.BackgroundColor3 = Color3.new(0, 0, 0);
Frame.AnchorPoint = Vector2.new(0.5, 0.5);
Frame.ZIndex = 2;
local TextLabel = Instance.new("TextLabel", Frame);
TextLabel.BackgroundTransparency = 1;
TextLabel.AnchorPoint = Vector2.new(0, 1);
TextLabel.Position = UDim2.new(0, 0, 1, 0);
TextLabel.Size = UDim2.new(1, 0, 0.25, 0);
TextLabel.TextScaled = true;
TextLabel.TextColor3 = Color3.new(1, 1, 1);
TextLabel.Name = "AlienNameLabel";
TextLabel.Font = Enum.Font.Sarpanch;
local ImageLabel = Instance.new("ImageLabel", Frame);
ImageLabel.BackgroundTransparency = 1;
ImageLabel.Size = UDim2.new(1, 0, 0.75, 0);
ImageLabel.Name = "Icon";
local _ = script.Parent;
local Selector = script.Parent.Selector;
Selector.Size = u4;
Selector.Visible = false;
local Line = script.Parent.Line;
Line.Visible = false;
local v5 = { "Tree", "Snake", "Scorpion", "Ant", { 6923705037, 6923705587, 6923705302, 6923704766 } };

local function newMenuItem(p6, p7, p8, p9) -- Line: 60
    -- upvalues: Frame (copy), Selector (copy), u1 (copy)
    local v10 = {};
    local v11 = Frame:Clone();
    v11.AlienNameLabel.Text = p6;
    v11.Name = p6;
    local v12 = math.rad(90 + p7);
    v11.Position = UDim2.new(math.cos(v12) * 0.4 + 0.5, 0, 0.5 - math.sin(v12) * 0.4, 0);
    v11.Parent = Selector;
    v11.Icon.Image = "rbxassetid://" .. p9;
    v10.Vector = Vector2.new(math.cos(v12), (math.sin(v12)));
    v10.Range = p8;
    v10.Angle = p7 - 90;
    u1[v11] = v10;
end;

local u13 = nil;

for i = 1, 4 do
    newMenuItem(v5[i], (i - 1) * 90, 90, v5[#v5][i]);
end;

local function getButtonFromVector(p14) -- Line: 90
    -- upvalues: u1 (copy)
    for i, v in pairs(u1) do
        if math.acos((p14.X * v.Vector.X + p14.Y * v.Vector.Y) / p14.Magnitude) <= math.rad(v.Range) / 2 then
            return i;
        end;
    end;

    return nil;
end;

local function setLine(p15, p16) -- Line: 101
    -- upvalues: Line (copy)
    if workspace.Mechanics.TimeStopped.Value == true then
        return;
    end;

    local v17 = script.Parent.AbsoluteSize / 2;
    local v18 = p15 - v17;
    Line.Position = UDim2.new(0, (v17.X + p15.X) / 2, 0, (v17.Y + p15.Y) / 2);
    Line.Size = UDim2.new(0, (p15 - v17).Magnitude, 0.003, 0);
    local v19 = math.atan2(v18.Y, v18.X);
    Line.Rotation = math.deg(v19);
end;

local function onMouseMoved(p20, p21, p22) -- Line: 111
    -- upvalues: u2 (copy), getButtonFromVector (copy), u13 (ref), setLine (copy), u1 (copy), Selector (copy)
    if workspace.Mechanics.TimeStopped.Value == true then
        return;
    end;

    local v23 = Vector2.new(u2.X, u2.Y);
    local v24 = v23 / script.Parent.AbsoluteSize;
    local v25 = Vector2.new(0.5, 0.5);

    if (v25 - v24).Magnitude >= 0.1 then
        local v26 = getButtonFromVector((v25 - v24) * Vector2.new(-1, 1));

        if v26 ~= u13 then
            u13 = v26;
            setLine(u13.AbsolutePosition + u13.AbsoluteSize / 2, u1[u13].Angle);

            for _, child in pairs(Selector:GetChildren()) do
                if child:IsA("Frame") then
                    child.BackgroundColor3 = Color3.new(0, 0, 0);
                end;
            end;

            u13.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3);
            script.DialA:Play();
        end;
    else
        setLine(v23);

        for _, child in pairs(Selector:GetChildren()) do
            if child:IsA("Frame") then
                child.BackgroundColor3 = Color3.new(0, 0, 0);
            end;
        end;

        u13 = nil;
    end;
end;

return {
    openMenu = function(p27) -- Line: 143, Name: openMenu
        -- upvalues: u2 (copy), setLine (copy), TweenService (copy), BlurEffect (copy), ContextActionService (copy), onMouseMoved (copy), Line (copy), Selector (copy), u3 (copy)
        setLine((Vector2.new(u2.X, u2.Y)));
        TweenService:Create(BlurEffect, TweenInfo.new(0.3), {
            Size = 20
        }):Play();
        ContextActionService:BindAction("RadialMenu", onMouseMoved, false, Enum.UserInputType.MouseMovement);
        Line.Visible = true;
        Selector.Visible = true;
        Selector:TweenSizeAndPosition(u3, Selector.Position, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true);
        menuOpen = true;
        script.Open:Play();
    end,

    closeMenu = function(p28) -- Line: 155, Name: closeMenu
        -- upvalues: TweenService (copy), BlurEffect (copy), ContextActionService (copy), Line (copy), Selector (copy), u4 (copy), u13 (ref)
        if workspace.Mechanics.TimeStopped.Value == true then
            workspace.Mechanics.TimeStopped:GetPropertyChangedSignal("Value"):Wait();
        end;

        TweenService:Create(BlurEffect, TweenInfo.new(0.3), {
            Size = 0
        }):Play();
        ContextActionService:UnbindAction("RadialMenu");
        Line.Visible = false;
        Selector:TweenSizeAndPosition(u4, Selector.Position, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.4, true, function() -- Line: 163
            -- upvalues: Selector (ref)
            if not menuOpen then
                Selector.Visible = false;
            end;
        end);
        menuOpen = false;
        local v29 = u13 and u13.AlienNameLabel.Text or nil;
        u13 = nil;

        return v29;
    end
};