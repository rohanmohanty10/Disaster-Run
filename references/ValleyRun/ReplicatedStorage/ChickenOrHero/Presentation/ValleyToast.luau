 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Theme = Skin.Theme;
local v1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = 0;
local u9 = {};

local function build() -- Line: 18
    -- upvalues: u2 (ref), u3 (ref), Theme (copy), u7 (ref), u4 (ref), u5 (ref), u6 (ref), Skin (copy), Players (copy)
    u2 = Instance.new("ScreenGui");
    u2.Name = "ValleyToast";
    u2.DisplayOrder = 90;
    u2.ResetOnSpawn = false;
    u2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    u2:SetAttribute("SelfManagedText", true);
    u3 = Instance.new("TextLabel");
    u3.Name = "Message";
    u3.AnchorPoint = Vector2.new(0.5, 0);
    u3.Position = UDim2.new(0.5, 0, 0, 72);
    u3.Size = UDim2.fromOffset(0, 0);
    u3.AutomaticSize = Enum.AutomaticSize.XY;
    u3.BackgroundColor3 = Theme.Ink;
    u3.Font = Enum.Font.GothamBold;
    u3.TextSize = 16;
    u3.TextColor3 = Theme.Paper;
    u3.TextWrapped = true;
    u3.Visible = false;
    u7 = Instance.new("UISizeConstraint");
    u7.MaxSize = Vector2.new(520, 160);
    u7.Parent = u3;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingLeft = UDim.new(0, 16);
    UIPadding.PaddingRight = UDim.new(0, 16);
    UIPadding.PaddingTop = UDim.new(0, 10);
    UIPadding.PaddingBottom = UDim.new(0, 10);
    UIPadding.Parent = u3;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 8);
    UICorner.Parent = u3;
    u4 = Instance.new("UIStroke");
    u4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    u4.Color = Theme.Gold;
    u4.Parent = u3;
    local _, v10, v11, v12 = Skin.toast(u3);
    u4 = v10;
    u5 = v11;
    u6 = v12;
    u3.Parent = u2;
    u2.Parent = Players.LocalPlayer:WaitForChild("PlayerGui");
end;

local function fade(p13, p14) -- Line: 61
    -- upvalues: u9 (copy), TweenService (copy), u3 (ref), u4 (ref), u5 (ref), u6 (ref)
    local v15 = u9[p14];

    if not v15 then
        v15 = TweenInfo.new(p14);
        u9[p14] = v15;
    end;

    local v16 = p13 and 0 or 1;
    TweenService:Create(u3, v15, {
        BackgroundTransparency = p13 and 0.2 or 1,
        TextTransparency = p13 and 0 or 1
    }):Play();
    TweenService:Create(u4, v15, {
        Transparency = v16
    }):Play();
    TweenService:Create(u5, v15, {
        Transparency = v16
    }):Play();

    if u6 then
        TweenService:Create(u6, v15, {
            Transparency = v16
        }):Play();
    end;
end;

local function fit() -- Line: 78
    -- upvalues: u3 (ref), u7 (ref)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v17 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize or Vector2.new(1280, 720);
    local v18 = v17.X < 700 and true or v17.Y < 500;
    u3.TextSize = v18 and 14 or 18;
    local v19;

    if v18 then
        v19 = Vector2.new(380, 90);
    else
        v19 = Vector2.new(520, 160);
    end;

    u7.MaxSize = v19;
end;

function v1.show(p20, p21) -- Line: 86
    -- upvalues: u2 (ref), build (copy), fit (copy), u8 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), fade (copy)
    if type(p20) ~= "string" or p20 == "" then
        return;
    end;

    if not (u2 and u2.Parent) then
        build();
    end;

    fit();
    u8 = u8 + 1;
    local u22 = u8;
    u3.Text = p20;

    if not u3.Visible then
        u3.BackgroundTransparency = 1;
        u3.TextTransparency = 1;
        u4.Transparency = 1;
        u5.Transparency = 1;

        if u6 then
            u6.Transparency = 1;
        end;

        u3.Visible = true;
    end;

    fade(true, 0.15);
    task.delay(p21 or 3, function() -- Line: 108
        -- upvalues: u8 (ref), u22 (copy), u3 (ref), fade (ref)
        if u8 ~= u22 or not u3 then
            return;
        end;

        fade(false, 0.3);
        task.delay(0.3, function() -- Line: 113
            -- upvalues: u8 (ref), u22 (ref), u3 (ref)
            if u8 == u22 and u3 then
                u3.Visible = false;
            end;
        end);
    end);
end;

return v1;