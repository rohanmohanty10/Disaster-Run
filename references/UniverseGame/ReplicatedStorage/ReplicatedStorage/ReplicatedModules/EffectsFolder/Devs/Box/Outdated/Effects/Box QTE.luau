  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local SoundGroups = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));

local function CreateInstance(p2, p3) -- Line: 8
    local function CheckProperty(p4, p5) -- Line: 10
        local _ = p4[p5];
    end;

    local u6 = Instance.new(p2);

    for i, v in pairs(p3) do
        if pcall(function() -- Line: 17
            -- upvalues: u6 (copy), i (copy)
            local _ = u6[i];
        end) then
            u6[i] = v;
        end;
    end;

    return u6;
end;

local u7 = {};

return function(p8) -- Line: 27
    -- upvalues: LocalPlayer (copy), u1 (copy), CreateInstance (copy), SoundGroups (copy), Debris (copy), u7 (copy), TweenService (copy)
    local v9 = p8 or {};

    if LocalPlayer.PlayerGui:FindFirstChild("QTE") or not v9.Start then
        local v11 = {
            Success = function() -- Line: 57
                -- upvalues: u7 (ref), LocalPlayer (ref), CreateInstance (ref), SoundGroups (ref), Debris (ref), TweenService (ref)
                if u7[LocalPlayer] then
                    u7[LocalPlayer]:Pause();
                    LocalPlayer.PlayerGui.QTE.Ring:Destroy();
                    local Frame = LocalPlayer.PlayerGui.QTE.Frame;
                    local v10 = CreateInstance("Sound", {
                        SoundId = "rbxassetid://8552855145",
                        Volume = 1,
                        Parent = workspace
                    });
                    SoundGroups:AssignSoundTag(v10);
                    v10:Play();
                    Debris:AddItem(v10, 2.5);
                    TweenService:Create(Frame, TweenInfo.new(0.5), {
                        BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                    }):Play();
                    TweenService:Create(Frame.TextLabel, TweenInfo.new(0.5), {
                        TextColor3 = Color3.fromRGB(0, 255, 0)
                    }):Play();
                    TweenService:Create(Frame, TweenInfo.new(1), {
                        Size = UDim2.new(0.117, 0, 0.212, 0)
                    }):Play();
                    TweenService:Create(Frame, TweenInfo.new(1), {
                        Position = UDim2.new(0.5, 0, 0.851, 0)
                    }):Play();
                    TweenService:Create(Frame, TweenInfo.new(0.75), {
                        BackgroundTransparency = 1
                    }):Play();
                    TweenService:Create(Frame.TextLabel, TweenInfo.new(1), {
                        TextSize = 150
                    }):Play();
                    TweenService:Create(Frame.TextLabel, TweenInfo.new(0.75), {
                        TextTransparency = 1
                    }):Play();
                    coroutine.wrap(function() -- Line: 79
                        -- upvalues: LocalPlayer (ref)
                        task.wait(2);

                        if LocalPlayer.PlayerGui.QTE then
                            LocalPlayer.PlayerGui.QTE:Destroy();
                        end;
                    end)();
                end;
            end,

            Failed = function() -- Line: 87
                -- upvalues: u7 (ref), LocalPlayer (ref), TweenService (ref)
                if u7[LocalPlayer] then
                    u7[LocalPlayer]:Pause();
                    LocalPlayer.PlayerGui.QTE.Ring:Destroy();
                    local Frame = LocalPlayer.PlayerGui.QTE.Frame;
                    TweenService:Create(Frame, TweenInfo.new(0.5), {
                        BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    }):Play();
                    TweenService:Create(Frame.TextLabel, TweenInfo.new(0.5), {
                        TextColor3 = Color3.fromRGB(255, 0, 0)
                    }):Play();
                    TweenService:Create(Frame, TweenInfo.new(1), {
                        Size = UDim2.new(0.117, 0, 0.212, 0)
                    }):Play();
                    TweenService:Create(Frame, TweenInfo.new(1), {
                        Position = UDim2.new(0.5, 0, 0.851, 0)
                    }):Play();
                    TweenService:Create(Frame, TweenInfo.new(0.75), {
                        BackgroundTransparency = 1
                    }):Play();
                    TweenService:Create(Frame.TextLabel, TweenInfo.new(1), {
                        TextSize = 150
                    }):Play();
                    TweenService:Create(Frame.TextLabel, TweenInfo.new(0.75), {
                        TextTransparency = 1
                    }):Play();
                    coroutine.wrap(function() -- Line: 104
                        -- upvalues: LocalPlayer (ref)
                        task.wait(2);

                        if LocalPlayer.PlayerGui.QTE then
                            LocalPlayer.PlayerGui.QTE:Destroy();
                        end;
                    end)();
                end;
            end,

            Destroy = function() -- Line: 112
                -- upvalues: LocalPlayer (ref)
                if LocalPlayer.PlayerGui.QTE then
                    LocalPlayer.PlayerGui.QTE:Destroy();
                end;
            end
        };

        if v11[v9.UIEffect] then
            task.spawn(v11[v9.UIEffect]);
        end;

        return;
    end;

    local v12 = u1.QTE:Clone();
    v12.Parent = LocalPlayer.PlayerGui;
    local Ring = v12.Ring;
    v12.Frame.TextLabel.Text = v9.Bind;
    local v13 = {
        Size = UDim2.new(0.06, 0, 0.109, 0),
        Position = UDim2.new(0.5, 0, 0.851, 0)
    };
    local v14 = CreateInstance("Sound", {
        SoundId = "rbxassetid://8552855569",
        Volume = 1,
        Parent = workspace
    });
    SoundGroups:AssignSoundTag(v14);
    v14:Play();
    Debris:AddItem(v14, 4);
    u7[LocalPlayer] = TweenService:Create(Ring, TweenInfo.new(v9.Duration), v13);
    u7[LocalPlayer]:Play();
end;