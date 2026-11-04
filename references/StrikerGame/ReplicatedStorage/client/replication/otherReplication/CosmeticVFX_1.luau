 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local wiki = require(ReplicatedStorage.wiki);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local Util = require(ReplicatedStorage.util.Util);
local WickerSprite = require(ReplicatedStorage.forum.WickerSprite);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local _ = vfxUtil.getResources().GoalEffects;
local goal_effects = wiki.goal_effects;
local v5 = {
    goalfx_default = function(p1: userdata, p2: any) -- Line: 19, Name: goalfx_default
        -- upvalues: goal_effects (copy), vfxUtil (copy)
        if not p1 then
            return;
        end;

        if p2 then
            local Position = p2.Position;
            local centrePoint = workspace.map.centrePoint;
            local CFrame_new_ret = CFrame.new(Position, (Vector3.new(centrePoint.Position.X, Position, centrePoint.Position.Z)));
            local v3 = goal_effects[p1.Name] or {};

            if typeof(v3.Offset) == "CFrame" then
                CFrame_new_ret = CFrame_new_ret * v3.Offset;
            elseif typeof(v3.Offset) == "Vector3" then
                CFrame_new_ret = CFrame_new_ret + v3.Offset;
            end;

            local v4 = p1:Clone();

            if p1:IsA("Model") then
                v4:PivotTo(CFrame_new_ret);
            elseif p1:IsA("BasePart") then
                v4.CFrame = CFrame_new_ret;
            end;

            v4.Parent = workspace.Effects;
            vfxUtil.forge.emit(v4);
            vfxUtil.disposal(v4);

            return v4;
        end;
    end
};
local karma = vfxUtil.getResources().karma;
local u6 = {
    {
        136007243766167,
        25,
        Vector2.new(5, 5),
        10,
        Vector2.new(1024, 576),
        karma.bababooey
    },
    {
        136020156130007,
        19,
        Vector2.new(4, 5),
        10,
        Vector2.new(1024, 720),
        karma.chicken
    }
};

function v5.goalfx_ohmydearwontyoulookatwhatyouvedonetome(p7, p8, p9) -- Line: 56
    -- upvalues: vfxUtil (copy), u6 (copy), karma (copy), WickerSprite (copy), TweenService (copy), soundUtil (copy)
    local PlayerGui = vfxUtil.getPlayerGui();
    local v10 = u6[math.floor(p9 * #u6) + 1];
    local u11 = karma.baba_jumpscare:Clone();
    u11.ImageLabel.Image = "rbxassetid://" .. v10[1];
    u11.Parent = PlayerGui;
    local v12 = WickerSprite.new();
    v12.TotalFrames = v10[2];
    v12.Frames = v10[3];
    v12.FPS = v10[4];
    v12.Dimensions = v10[5];
    v12:Add(u11.ImageLabel);
    v12:AttachToInstance(u11);
    v12:Play();
    task.delay(v12.TimeLength, function() -- Line: 77
        -- upvalues: TweenService (ref), u11 (copy)
        local v13 = TweenService:Create(u11.ImageLabel, TweenInfo.new(1), {
            ImageTransparency = 1,
            BackgroundTransparency = 1
        });
        v13:Play();
        v13.Completed:Once(function() -- Line: 83
            -- upvalues: u11 (ref)
            u11:Destroy();
        end);
    end);
    soundUtil:play(v10[6], "default");
end;

local u14 = { 114671993429164, 127499864244464, 112562433212508, 99977017361270 };

function v5.goalfx_hafted(p15, p16, p17) -- Line: 92
    -- upvalues: vfxUtil (copy), karma (copy), u14 (copy), TweenService (copy), soundUtil (copy)
    local PlayerGui = vfxUtil.getPlayerGui();
    local u18 = karma.elhaft:Clone();
    u18:FindFirstChildOfClass("ImageLabel").Image = "rbxassetid://" .. u14[math.floor(p17 * #u14) + 1];
    u18.Parent = PlayerGui;
    task.delay(2, function() -- Line: 102
        -- upvalues: TweenService (ref), u18 (copy)
        local v19 = TweenService:Create(u18.ImageLabel, TweenInfo.new(1), {
            ImageTransparency = 1,
            BackgroundTransparency = 1
        });
        v19:Play();
        v19.Completed:Once(function() -- Line: 108
            -- upvalues: u18 (ref)
            u18:Destroy();
        end);
    end);
    soundUtil:play(math.random() <= 0.5 and karma.hafted or karma.hafted2, "default");
end;

local u20 = { 85282219198005, 77794932275250, 83579697407636, 72461680287372 };

function v5.goalfx_vagospizza(p21, p22, p23) -- Line: 117
    -- upvalues: vfxUtil (copy), karma (copy), u20 (copy), TweenService (copy), soundUtil (copy)
    local PlayerGui = vfxUtil.getPlayerGui();
    local u24 = karma.vagospizzag:Clone();
    u24:FindFirstChildOfClass("ImageLabel").Image = "rbxassetid://" .. u20[math.floor(p23 * #u20) + 1];
    u24.Parent = PlayerGui;
    task.delay(2, function() -- Line: 127
        -- upvalues: TweenService (ref), u24 (copy)
        local v25 = TweenService:Create(u24.ImageLabel, TweenInfo.new(1), {
            ImageTransparency = 1,
            BackgroundTransparency = 1
        });
        v25:Play();
        v25.Completed:Once(function() -- Line: 133
            -- upvalues: u24 (ref)
            u24:Destroy();
        end);
    end);
    soundUtil:play(karma.boom, "default");
    local math_random_ret = math.random(1, 4);
    soundUtil:play(math_random_ret == 1 and karma.vagospizza or math_random_ret == 2 and karma.vagospizza2 or (math_random_ret == 3 and karma.vagospizza3 or karma.vagospizza4), "default");
end;

function v5.goalfx_pide(p26, p27, p28) -- Line: 150
    local Players = game:GetService("Players");
    local TweenService2 = game:GetService("TweenService");
    local Debris = game:GetService("Debris");
    local SoundService = game:GetService("SoundService");
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://106455506444721";
    Sound.Volume = 10;
    Sound.Parent = SoundService;
    Sound:Play();
    Debris:AddItem(Sound, 5);
    local Sound2 = Instance.new("Sound");
    Sound2.SoundId = "rbxassetid://78933782645574";
    Sound2.Volume = 10;
    Sound2.Parent = SoundService;
    Sound2:Play();
    Debris:AddItem(Sound2, 5);

    for _, v in ipairs(Players:GetPlayers()) do
        local v29 = v:FindFirstChildOfClass("PlayerGui");

        if v29 then
            local ScreenGui = Instance.new("ScreenGui");
            ScreenGui.Name = "pide";
            ScreenGui.IgnoreGuiInset = true;
            ScreenGui.DisplayOrder = 9999;
            ScreenGui.ResetOnSpawn = false;
            ScreenGui.Parent = v29;
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.Image = "rbxassetid://79437641074592";
            ImageLabel.Parent = ScreenGui;
            local v30 = TweenService2:Create(ImageLabel, TweenInfo.new(2.1), {
                ImageTransparency = 1
            });
            v30:Play();
            v30.Completed:Connect(function() -- Line: 193
                -- upvalues: ScreenGui (copy)
                ScreenGui:Destroy();
            end);
        end;
    end;
end;

local u31 = { 99869115442624, 95814661471528, 132241448268633, 134290122694198, 136082354132100 };

function v5.goalfx_yurier(p32, p33, p34) -- Line: 207
    -- upvalues: Util (copy), soundUtil (copy), karma (copy), vfxUtil (copy), u31 (copy), TweenService (copy)
    if Util.isepilepsysafe() then
        soundUtil:play(karma.yuriersfx, "default");

        return;
    end;

    local PlayerGui = vfxUtil.getPlayerGui();
    local u35 = karma.yurier:Clone();
    u35:FindFirstChildOfClass("ImageLabel").Image = "rbxassetid://" .. u31[math.floor(p34 * #u31) + 1];
    u35.Parent = PlayerGui;
    task.delay(2, function() -- Line: 222
        -- upvalues: TweenService (ref), u35 (copy)
        local v36 = TweenService:Create(u35.ImageLabel, TweenInfo.new(1), {
            ImageTransparency = 1,
            BackgroundTransparency = 1
        });
        v36:Play();
        v36.Completed:Once(function() -- Line: 228
            -- upvalues: u35 (ref)
            u35:Destroy();
        end);
    end);
    soundUtil:play(karma.yuriersfx, "default");
end;

function v5.ayanokojifastshot(p37) -- Line: 236
    -- upvalues: vfxUtil (copy), karma (copy), TweenService (copy), soundUtil (copy), TekrinnDialogue (copy)
    local PlayerGui = vfxUtil.getPlayerGui();
    local u38 = karma.elhaft:Clone();
    u38:FindFirstChildOfClass("ImageLabel").Image = "rbxassetid://120609834729987";
    u38.Parent = PlayerGui;
    task.delay(2, function() -- Line: 246
        -- upvalues: TweenService (ref), u38 (copy)
        local v39 = TweenService:Create(u38.ImageLabel, TweenInfo.new(1), {
            ImageTransparency = 1,
            BackgroundTransparency = 1
        });
        v39:Play();
        v39.Completed:Once(function() -- Line: 252
            -- upvalues: u38 (ref)
            u38:Destroy();
        end);
    end);
    soundUtil:play(karma.impressive);
    TekrinnDialogue.Speak(p37, {
        {
            Text = "So, what are you going to do next?",
            Italic = true,
            TypeSpeed = 0.05,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
            Shake = {
                Enabled = true,
                Intensity = 2,
                Lifetime = 0.2
            }
        }
    });
end;

return v5;