 

 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("SoundService");
game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
game:GetService("TextChatService");
game:GetService("StarterGui");
game:GetService("MarketplaceService");
local workspace_CurrentCamera = workspace.CurrentCamera;
require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.forum.trove);
require(ReplicatedStorage.forum.fastSignal);
local packets = require(ReplicatedStorage.packets);

return function(u1) -- Line: 26
    -- upvalues: workspace_CurrentCamera (copy), packets (copy), UserInputService (copy)
    if not u1.isTouchEnabled then
        return;
    end;

    u1:destroyContainer();
    local mobileButtons = u1.mobileButtons;
    local u2 = {};
    local u3 = nil;
    local mobileFinish = mobileButtons.mobileFinish;
    local mobileReset = mobileButtons.mobileReset;
    local SizeBox = mobileButtons.SizeBox;
    local TransparencyBox = mobileButtons.TransparencyBox;
    mobileFinish.Visible = true;
    mobileReset.Visible = true;
    TransparencyBox.Visible = true;
    SizeBox.Visible = true;
    local u4 = nil;
    local u5 = mobileButtons.SelectionStroke:Clone();
    local ViewportSize = workspace_CurrentCamera.ViewportSize;
    local u6 = math.min(ViewportSize.X, ViewportSize.Y) <= 500 and 70 or 120;
    SizeBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 60
        -- upvalues: SizeBox (copy), u4 (ref), u6 (copy)
        local Text = SizeBox.Text;

        if tonumber(Text) and u4 then
            u4:SetAttribute("Size", (math.clamp(Text, 0.2, 2)));
            local Attribute = u4:GetAttribute("Size");
            u4.Size = UDim2.fromOffset(u6 * Attribute, u6 * Attribute);
        end;
    end);
    TransparencyBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 69
        -- upvalues: TransparencyBox (copy), u4 (ref)
        local Text = TransparencyBox.Text;

        if tonumber(Text) and u4 then
            u4:SetAttribute("Transparency", (math.clamp(Text, 0, 0.8)));
            u4.ImageTransparency = u4:GetAttribute("Transparency");
        end;
    end);
    table.insert(u2, mobileReset.MouseButton1Up:Connect(function() -- Line: 78
        -- upvalues: mobileButtons (copy), u1 (copy), u6 (copy)
        for _, child in ipairs(mobileButtons.Frame:GetChildren()) do
            if u1.isSmallScreen then
                if u1.originalSmallPosition[child.Name] then
                    child.Position = u1.originalSmallPosition[child.Name];
                    child:SetAttribute("Size", 1);
                    child:SetAttribute("Transparency", 0);
                    child.ImageTransparency = 0;
                    child.Size = UDim2.fromOffset(u6, u6);
                end;
            elseif u1.originalPosition[child.Name] then
                child.Position = u1.originalPosition[child.Name];
                child:SetAttribute("Size", 1);
                child:SetAttribute("Transparency", 0);
                child.ImageTransparency = 0;
                child.Size = UDim2.fromOffset(u6, u6);
            end;
        end;
    end));
    table.insert(u2, mobileFinish.MouseButton1Up:Once(function() -- Line: 108
        -- upvalues: mobileFinish (copy), mobileReset (copy), TransparencyBox (copy), SizeBox (copy), u4 (ref), u5 (copy), u2 (copy), mobileButtons (copy), packets (ref)
        mobileFinish.Visible = false;
        mobileReset.Visible = false;
        TransparencyBox.Visible = false;
        SizeBox.Visible = false;
        u4 = nil;
        pcall(game.Destroy, u5);

        for _, v in u2 do
            v:Disconnect();
        end;

        table.clear(u2);
        local v7 = {};

        for _, child in ipairs(mobileButtons.Frame:GetChildren()) do
            local v8 = child:GetAttribute("Size") or 1;
            local v9 = child:GetAttribute("Transparency") or 0;
            v7[child.Name] = {
                child.Position.X.Scale,
                child.Position.X.Offset,
                child.Position.Y.Scale,
                child.Position.Y.Offset,
                v8,
                v9
            };
        end;

        packets.bytenet_mobilebuttonPositions.send(v7);
    end));

    for _, child in ipairs(mobileButtons.Frame:GetChildren()) do
        table.insert(u2, child.MouseButton1Down:Connect(function() -- Line: 135
            -- upvalues: u4 (ref), child (copy), u5 (copy), SizeBox (copy), u6 (copy), TransparencyBox (copy), u3 (ref)
            u4 = nil;
            u4 = child;
            u5.Parent = u4;
            SizeBox.Text = child.Size.X.Offset / u6;
            TransparencyBox.Text = child:GetAttribute("Transparency") or "";

            if u3 then
                return;
            end;

            u3 = child;
        end));
        table.insert(u2, child.MouseButton1Up:Connect(function() -- Line: 148
            -- upvalues: u3 (ref)
            if not u3 then
                return;
            end;

            u3 = nil;
        end));
    end;

    table.insert(u2, UserInputService.InputChanged:Connect(function(p10) -- Line: 153
        -- upvalues: u3 (ref), UserInputService (ref)
        if not u3 then
            return;
        end;

        if p10.UserInputType == Enum.UserInputType.Touch then
            local MouseLocation = UserInputService:GetMouseLocation();
            u3.Position = UDim2.new(0, MouseLocation.X - 35, 0, MouseLocation.Y - 85);
        end;
    end));
end;