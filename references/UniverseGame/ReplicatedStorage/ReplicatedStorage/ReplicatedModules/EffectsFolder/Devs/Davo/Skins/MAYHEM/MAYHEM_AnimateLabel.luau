  

 

local _ = game:GetService("Players").LocalPlayer;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 12
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.KnitPath.Trove);
end);
local u2 = nil;
local u3 = {};
local u4 = nil;
u4 = {
    Default = function(p5) -- Line: 21
        local Label = p5.Label;

        while true do
            task.wait();
            local v6 = os.clock() * 69;
            local v7 = math.cos(v6 / 25) / 4.5 + -8;
            local v8 = math.cos(v6 / 75) / 5 + 5.333333333333333;
            p5.StudsOffset = Vector3.new(v7, v8, 0);
            Label.Rotation = math.cos(v6 / 32) * -5;
        end;
    end,

    Crazed = function(p9) -- Line: 32
        -- upvalues: TweenService (copy), u2 (ref)
        local Label = p9.Label;
        local v10 = Random.new();
        local u11 = TweenService:Create(Label, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            TextStrokeColor3 = Color3.new()
        });
        u11:Play();
        u2:Add(function() -- Line: 40
            -- upvalues: u11 (copy)
            u11:Cancel();
        end);

        while true do
            task.wait();
            local v12 = os.clock() * v10:NextNumber(25, 500);
            local v13 = math.cos(v12 / 25) / 15 + -8;
            local v14 = math.cos(v12 / 75) / 17.5 + 5.333333333333333;
            p9.StudsOffset = Vector3.new(v13, v14, 0);
            Label.Rotation = math.cos(v12 / 32) * 5;
        end;
    end,

    Chaos = function(p15) -- Line: 52
        local Label = p15.Label;
        local v16 = Random.new();
        local v17 = 0;

        while true do
            v17 = v17 + task.wait();
            local v18 = os.clock() * v16:NextNumber(25, 500);
            local v19 = math.cos(v18 / 25) / 15 + -8;
            local v20 = math.cos(v18 / 75) / 17.5 + 5.333333333333333;
            p15.StudsOffset = Vector3.new(v19, v20, 0);
            Label.Rotation = math.cos(v18 / 32) * 2.5;
        end;
    end,

    Mayhem = function(p21) -- Line: 93
        -- upvalues: TweenService (copy), u3 (copy), u2 (ref), EffectsHandler (copy), RunService (copy), u4 (ref)
        local Label = p21.Label;
        local Text = Label.Text;
        local TextStrokeColor3 = Label.TextStrokeColor3;
        local v22, v23, v24 = TextStrokeColor3:ToHSV();
        local u25 = Random.new();
        local u26 = false;
        local u27 = TweenService:Create(Label, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            TextStrokeColor3 = Color3.fromHSV(v22, v23, v24 / 2)
        });
        table.insert(u3, u27);
        local u28 = TweenService:Create(Label, TweenInfo.new(0.375, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextStrokeColor3 = TextStrokeColor3
        });
        table.insert(u3, u28);
        local u29 = TweenService:Create(p21, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Brightness = 3
        });
        table.insert(u3, u29);
        u2:Add(function() -- Line: 113
            -- upvalues: u26 (ref), u29 (copy), u27 (copy), u28 (copy)
            u26 = true;
            u29:Cancel();
            u27:Cancel();
            u28:Cancel();
        end);
        u27:Play();
        u29:Play();
        u2:Connect(u27.Completed, function(p30) -- Line: 123
            -- upvalues: u26 (ref), u28 (copy), EffectsHandler (ref), u27 (copy)
            if p30 == Enum.TweenStatus.Canceled or u26 then
                return;
            end;

            u28:Play();
            EffectsHandler.Wait(2);

            if u26 then
                return;
            end;

            u27:Play();
        end);
        u2:Connect(RunService.Heartbeat, function() -- Line: 130
            -- upvalues: u25 (copy), Text (copy), Label (copy), EffectsHandler (ref)
            if u25:NextInteger(1, 20) == 1 then
                local v31 = u25:NextInteger(1, #Text);
                local u32 = string.sub(Label.Text, v31, v31);

                if u32:upper() == u32 then
                    Label.Text = string.gsub(Label.Text, u32, u32:lower());
                    task.spawn(function() -- Line: 136
                        -- upvalues: EffectsHandler (ref), u25 (ref), Label (ref), u32 (ref)
                        EffectsHandler.Wait(u25:NextNumber(0, 0.1));
                        Label.Text = string.gsub(Label.Text, u32:lower(), u32:upper());
                    end);
                end;
            end;
        end);
        u4.Default(p21);
    end
};

return function(u33, u34, p35, p36) -- Line: 148
    -- upvalues: u1 (ref), u2 (ref), TweenService (copy), u3 (copy), u4 (ref), EffectsHandler (copy)
    if u34:GetAttribute("CoreAnimation") then
        u34:SetAttribute("CoreAnimation", p36.LabelAnimation or p35);

        return;
    end;

    u34:SetAttribute("CoreAnimation", p36.LabelAnimation or p35);
    local Label = u34.Label;
    local UIGradient = Label.UIGradient;
    local TransparencyGradient = Label.TransparencyGradient;
    local v37 = u1.new();
    u2 = v37:Extend();
    local u38 = nil;
    local _ = u34.Size;
    local u39 = TweenService:Create(UIGradient, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Offset = Vector2.new(0.5, 0)
    });
    local u40 = nil;

    local function TweenVisibility(u41, u42) -- Line: 162
        -- upvalues: u40 (ref), TransparencyGradient (copy), UIGradient (copy)
        if u40 then
            task.cancel(u40);
        end;

        TransparencyGradient.Enabled = true;
        UIGradient.Enabled = false;
        local u43 = 0;
        u40 = task.spawn(function() -- Line: 170
            -- upvalues: u43 (ref), u41 (copy), u42 (copy), TransparencyGradient (ref), UIGradient (ref)
            local v44;

            repeat
                u43 = u43 + task.wait();
                v44 = u41 and 1 - u43 / u42 or u43 / u42;
                TransparencyGradient.Transparency = NumberSequence.new(v44);
            until u41 and v44 <= 0 or not u41 and v44 >= 1;

            if u41 then
                TransparencyGradient.Enabled = false;
                UIGradient.Enabled = true;
            end;
        end);
    end;

    UIGradient.Offset = Vector2.new(-0.5, 0);

    local function Update(p45) -- Line: 189
        -- upvalues: u2 (ref), u38 (ref), u3 (ref), u4 (ref), u34 (copy)
        u2:Clean();

        if u38 then
            task.cancel(u38);
        end;

        for _, v in u3 do
            if v then
                v:Cancel();
            end;
        end;

        table.clear(u3);
        u38 = task.spawn(p45 and u4[p45] or u4.Default, u34);
    end;

    v37:AttachToInstance(u34:FindFirstAncestorOfClass("Model") or u34);
    v37:Connect(u39.Completed, function() -- Line: 203
        -- upvalues: UIGradient (copy), EffectsHandler (ref), u39 (copy)
        UIGradient.Enabled = false;
        UIGradient.Offset = Vector2.new(-0.5, 0);
        EffectsHandler.Wait(5);
        UIGradient.Enabled = true;
        u39:Play();
    end);
    v37:Connect(u34:GetAttributeChangedSignal("CoreAnimation"), function() -- Line: 210
        -- upvalues: Update (copy), u34 (copy)
        Update(u34:GetAttribute("CoreAnimation"));
    end);
    v37:Connect(u33:GetAttributeChangedSignal("Quoting"), function() -- Line: 213
        -- upvalues: u33 (copy), u40 (ref), TransparencyGradient (copy), UIGradient (copy)
        local v46 = u33:GetAttribute("Quoting");

        if v46 == nil or v46 == true then
            if v46 then
                if u40 then
                    task.cancel(u40);
                end;

                TransparencyGradient.Enabled = true;
                UIGradient.Enabled = false;
                local u47 = 0;
                local u48 = false;
                local u49 = 0.225;
                u40 = task.spawn(function() -- Line: 170
                    -- upvalues: u47 (ref), u48 (copy), u49 (copy), TransparencyGradient (ref), UIGradient (ref)
                    local v50;

                    repeat
                        u47 = u47 + task.wait();
                        v50 = u48 and 1 - u47 / u49 or u47 / u49;
                        TransparencyGradient.Transparency = NumberSequence.new(v50);
                    until u48 and v50 <= 0 or not u48 and v50 >= 1;

                    if u48 then
                        TransparencyGradient.Enabled = false;
                        UIGradient.Enabled = true;
                    end;
                end);

                return;
            end;

            if u40 then
                task.cancel(u40);
            end;

            TransparencyGradient.Enabled = true;
            UIGradient.Enabled = false;
            local u51 = 0;
            local u52 = true;
            local u53 = 0.5;
            u40 = task.spawn(function() -- Line: 170
                -- upvalues: u51 (ref), u52 (copy), u53 (copy), TransparencyGradient (ref), UIGradient (ref)
                local v54;

                repeat
                    u51 = u51 + task.wait();
                    v54 = u52 and 1 - u51 / u53 or u51 / u53;
                    TransparencyGradient.Transparency = NumberSequence.new(v54);
                until u52 and v54 <= 0 or not u52 and v54 >= 1;

                if u52 then
                    TransparencyGradient.Enabled = false;
                    UIGradient.Enabled = true;
                end;
            end);
        end;
    end);
    u39:Play();
    Update(u34:GetAttribute("CoreAnimation"));
end;