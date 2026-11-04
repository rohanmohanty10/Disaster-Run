 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local Presentation = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation");
local HudNavigation = require(Presentation:WaitForChild("HudNavigation"));
local ValleyPanels = require(Presentation:WaitForChild("ValleyPanels"));
local CombineScreen = require(Presentation:WaitForChild("CombineScreen"));
local v1 = ValleyPanels.screen(LocalPlayer, "Combine", 66);
local u2 = ValleyPanels.make("Frame", v1, "Shade", {
    BackgroundTransparency = 0.35,
    BorderSizePixel = 0,
    Active = true,
    Visible = false,
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.new(0, 0, 0)
});
ValleyPanels.fullscreenShade(v1, u2);
local u3 = CombineScreen.new();
u3.frame.Visible = true;
u3.frame.Parent = u2;
ValleyPanels.cursorWhileVisible(u3.closeButton);
local u4 = false;
local u5 = true;
local u6 = false;

local function setOpen(p7) -- Line: 31
    -- upvalues: u4 (ref), u5 (ref), HudNavigation (copy), u2 (copy), u6 (ref), LocalPlayer (copy), u3 (copy)
    if p7 == u4 or p7 and not u5 then
        return;
    end;

    if p7 then
        HudNavigation.opening("Combine");
    end;

    u4 = p7;
    local v8;

    if p7 then
        v8 = not u6;
    else
        v8 = p7;
    end;

    u2.Visible = v8;
    LocalPlayer:SetAttribute("CombineOpen", p7 or nil);

    if p7 then
        u3:opened();

        return;
    end;

    u3:closed();
end;

u3.closeButton.Activated:Connect(function() -- Line: 48
    -- upvalues: u4 (ref), u2 (copy), LocalPlayer (copy), u3 (copy)
    if u4 ~= false then
        u4 = false;
        u2.Visible = false;
        LocalPlayer:SetAttribute("CombineOpen", nil);
        u3:closed();
    end;
end);
HudNavigation.register("Combine", function() -- Line: 51
    -- upvalues: setOpen (copy), u4 (ref)
    setOpen(not u4);
end);
HudNavigation.Opening.Event:Connect(function(p9) -- Line: 54
    -- upvalues: u4 (ref), u2 (copy), LocalPlayer (copy), u3 (copy)
    if p9 ~= "Combine" and u4 ~= false then
        u4 = false;
        u2.Visible = false;
        LocalPlayer:SetAttribute("CombineOpen", nil);
        u3:closed();
    end;
end);
UserInputService.InputBegan:Connect(function(p10) -- Line: 59
    -- upvalues: u4 (ref), u2 (copy), LocalPlayer (copy), u3 (copy)
    if u4 and (p10.KeyCode == Enum.KeyCode.Escape and u4 ~= false) then
        u4 = false;
        u2.Visible = false;
        LocalPlayer:SetAttribute("CombineOpen", nil);
        u3:closed();
    end;
end);
u3:start({
    open = function() -- Line: 65, Name: open
        -- upvalues: u4 (ref), u5 (ref), HudNavigation (copy), u2 (copy), u6 (ref), LocalPlayer (copy), u3 (copy)
        if u4 ~= true then
            if not u5 then
                return;
            end;

            HudNavigation.opening("Combine");
            u4 = true;
            u2.Visible = not u6;
            LocalPlayer:SetAttribute("CombineOpen", true);
            u3:opened();
        end;
    end,

    close = function() -- Line: 68, Name: close
        -- upvalues: u4 (ref), u2 (copy), LocalPlayer (copy), u3 (copy)
        if u4 ~= false then
            u4 = false;
            u2.Visible = false;
            LocalPlayer:SetAttribute("CombineOpen", nil);
            u3:closed();
        end;
    end,

    isOpen = function() -- Line: 71, Name: isOpen
        -- upvalues: u4 (ref)
        return u4;
    end,

    setAvailable = function(p11) -- Line: 74, Name: setAvailable
        -- upvalues: u5 (ref), HudNavigation (copy)
        u5 = p11;
        HudNavigation.setAvailable("Combine", p11);
    end,

    setHidden = function(p12, p13) -- Line: 80, Name: setHidden
        -- upvalues: u6 (ref), TweenService (copy), u2 (copy), u4 (ref)
        u6 = p12;
        local v14 = TweenService:Create(u2, TweenInfo.new(p13 or 0), {
            BackgroundTransparency = p12 and 1 or 0.35
        });

        if p12 then
            v14.Completed:Once(function(p15) -- Line: 84
                -- upvalues: u6 (ref), u2 (ref)
                if p15 == Enum.PlaybackState.Completed and u6 then
                    u2.Visible = false;
                end;
            end);
        else
            u2.Visible = u4;
        end;

        v14:Play();
    end
});