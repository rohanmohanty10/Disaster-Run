  

 

local LocalPlayer = game.Players.LocalPlayer;
local RunService = game:GetService("RunService");
game:GetService("StarterGui");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local AnimationHandler = require(PathShortcuts.ReplicatedModules.AnimationHandler);
local Trove = require(PathShortcuts.KnitPath.Trove);
local Promise = require(PathShortcuts.KnitPath.Promise);
local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
local AnimatorService = require(ReplicatedRoot.Services.AnimatorService);
local AbilityService = require(ReplicatedRoot.Services.Gameplay.AbilityService);
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local CurrentCamera = workspace.CurrentCamera;
local u2 = {};
local u3 = {
    Fluorescence = {
        [0] = {
            TimeIn = 0.01,
            FOV = 50
        },
        [93] = {
            TimeIn = 0.4666666666666667,
            FOV = 70
        },
        [121] = {
            TimeIn = 0.4666666666666667,
            FOV = 50
        },
        [150] = {
            TimeIn = 0.43333333333333335,
            FOV = 67.073
        },
        [191] = {
            TimeIn = 0.1,
            FOV = 60.7
        },
        [197] = {
            TimeIn = 0.3333333333333333,
            FOV = 30
        },
        [218] = {
            TimeIn = 0.55,
            FOV = 50.37
        },
        [251] = {
            TimeIn = 0.1,
            FOV = 52.534
        },
        [257] = {
            TimeIn = 0.85,
            FOV = 57.836
        },
        [308] = {
            TimeIn = 0.1,
            FOV = 58.39
        },
        [314] = {
            TimeIn = 1.3666666666666667,
            FOV = 65
        },
        [396] = {
            TimeIn = 0.6666666666666666,
            FOV = 55.323
        },
        [436] = {
            TimeIn = 0.36666666666666664,
            FOV = 30
        },
        [458] = {
            TimeIn = 0.5,
            FOV = 50
        },
        [612] = {
            TimeIn = 0.08333333333333333,
            FOV = 48.909
        },
        [670] = {
            TimeIn = 0.01,
            FOV = 30
        },
        [673] = {
            TimeIn = 0.11666666666666667,
            FOV = 42.271
        },
        [680] = {
            TimeIn = 0.2833333333333333,
            FOV = 48.841
        }
    },
    Shadow = {
        [0] = {
            TimeIn = 0.1,
            FOV = 40
        },
        [80] = {
            TimeIn = 0,
            FOV = 100
        },
        [81] = {
            TimeIn = 0,
            FOV = 50
        },
        [117] = {
            TimeIn = 0.1,
            FOV = 70
        },
        [198] = {
            TimeIn = 0.1,
            FOV = 50
        },
        [264] = {
            TimeIn = 0.1,
            TimeOut = 1,
            FOV = 40
        }
    },
    ["Lesson 5"] = {
        [43] = {
            TimeIn = 0.01,
            FOV = 50
        },
        [68] = {
            TimeIn = 1.39,
            FOV = 100
        },
        [155] = {
            TimeIn = 0.01,
            FOV = 60
        },
        [221] = {
            TimeIn = 0.01,
            FOV = 55
        },
        [252] = {
            TimeIn = 0.01,
            FOV = 30
        },
        [288] = {
            TimeIn = 0.417,
            FOV = 70
        },
        [343] = {
            TimeIn = 0.85,
            FOV = 50
        },
        [402] = {
            TimeIn = 2.09,
            FOV = 50
        },
        [574] = {
            TimeIn = 0.01,
            FOV = 90
        },
        [645] = {
            TimeIn = 0.01,
            FOV = 60
        },
        [755] = {
            TimeIn = 0.01,
            FOV = 70
        },
        [775] = {
            TimeIn = 0.75,
            FOV = 40
        },
        [867] = {
            TimeIn = 0.01,
            FOV = 70
        }
    },
    ["Lesson 5 Love Train"] = {
        [0] = {
            TimeIn = 0.01,
            FOV = 70
        },
        [147] = {
            TimeIn = 0.5166666666666667,
            FOV = 50
        },
        [178] = {
            TimeIn = 1.1166666666666667,
            FOV = 60
        },
        [245] = {
            TimeIn = 0.7166666666666667,
            FOV = 70
        },
        [288] = {
            TimeIn = 0.5833333333333334,
            FOV = 30
        },
        [323] = {
            TimeIn = 0.5833333333333334,
            FOV = 70
        },
        [453] = {
            TimeIn = 2.65,
            FOV = 50
        },
        [737] = {
            TimeIn = 0.26666666666666666,
            FOV = 70
        },
        [753] = {
            TimeIn = 0.5833333333333334,
            FOV = 50
        },
        [998] = {
            TimeIn = 0.35,
            FOV = 70
        },
        [1019] = {
            TimeIn = 1.3333333333333333,
            FOV = 40
        },
        [1099] = {
            TimeIn = 0.6833333333333333,
            FOV = 70
        },
        [1519] = {
            TimeIn = 1.3166666666666667,
            FOV = 50
        },
        [1598] = {
            TimeIn = 1.1666666666666667,
            FOV = 70
        }
    },
    UGrain = {
        [0] = {
            TimeIn = 0.3,
            FOV = 35
        },
        [600] = {
            TimeIn = 6,
            FOV = 65
        }
    },
    Molotov = {
        [0] = {
            TimeIn = 0.45,
            FOV = 50
        },
        [350] = {
            TimeIn = 1.85,
            FOV = 45
        },
        [448] = {
            TimeIn = 0.25,
            FOV = 70
        },
        [620] = {
            TimeIn = 0.45,
            FOV = 55
        },
        [784] = {
            TimeIn = 0.1,
            FOV = 50
        },
        [1203] = {
            TimeIn = 0.5,
            FOV = 65
        },
        [1360] = {
            TimeIn = 1,
            FOV = 40
        }
    },
    ["Soft Pinnacle"] = {
        [0] = {
            TimeIn = 0.45,
            FOV = 70
        },
        [115] = {
            TimeIn = 0.25,
            FOV = 90
        },
        [120] = {
            TimeIn = 0.15,
            FOV = 70
        },
        [121] = {
            TimeIn = 0.15,
            FOV = 60
        },
        [130] = {
            TimeIn = 0.15,
            FOV = 90
        },
        [137] = {
            TimeIn = 0.15,
            FOV = 100
        },
        [145] = {
            TimeIn = 0.3,
            FOV = 90
        },
        [180] = {
            TimeIn = 0.3,
            FOV = 95
        },
        [187] = {
            TimeIn = 0.3,
            FOV = 105
        },
        [192] = {
            TimeIn = 0.3,
            FOV = 75
        }
    },
    ["MAYHEM Universal Sovereign"] = {
        [0] = {
            TimeIn = 0,
            FOV = 40
        },
        [1] = {
            TimeIn = 0.6833333333333333,
            FOV = 60
        },
        [42] = {
            TimeIn = 0.06666666666666667,
            FOV = 30
        },
        [46] = {
            TimeIn = 4.55,
            FOV = 40
        },
        [319] = {
            TimeIn = 1.2,
            FOV = 60
        },
        [391] = {
            TimeIn = 0.6666666666666666,
            FOV = 40
        }
    },
    ["MAYHEM Mayhem Sovereign"] = {
        [0] = {
            TimeIn = 0,
            FOV = 55
        },
        [98] = {
            TimeIn = 0.4,
            FOV = 75
        },
        [122] = {
            TimeIn = 0.15,
            FOV = 40
        },
        [131] = {
            TimeIn = 0.03333333333333333,
            FOV = 55
        },
        [133] = {
            TimeIn = 2.85,
            FOV = 55
        },
        [304] = {
            TimeIn = 0.85,
            FOV = 40
        },
        [355] = {
            TimeIn = 0.11666666666666667,
            FOV = 70
        },
        [362] = {
            TimeIn = 0.9166666666666666,
            FOV = 55
        },
        [417] = {
            TimeIn = 0,
            FOV = 55
        }
    },
    ["MAYHEM Chaos Sovereign"] = {
        [0] = {
            TimeIn = 0,
            FOV = 60
        },
        [273] = {
            TimeIn = 0.31666666666666665,
            FOV = 40
        },
        [292] = {
            TimeIn = 0.13333333333333333,
            FOV = 60
        },
        [300] = {
            TimeIn = 0.03333333333333333,
            FOV = 70
        },
        [302] = {
            TimeIn = 0.13333333333333333,
            FOV = 90
        },
        [388] = {
            TimeIn = 0.75,
            FOV = 90
        },
        [433] = {
            TimeIn = 0.2833333333333333,
            FOV = 60
        }
    },
    ["MAYHEM Rainbow Sovereign"] = {
        [0] = {
            TimeIn = 0,
            FOV = 50
        },
        [1] = {
            TimeIn = 0.9833333333333333,
            FOV = 35
        },
        [220] = {
            TimeIn = 0,
            FOV = 40
        },
        [221] = {
            TimeIn = 1.1666666666666667,
            FOV = 35
        }
    },
    ["MAYHEM Catastrophe Sovereign"] = { {
            TimeIn = 0,
            FOV = 50
        } }
};

local function CutsceneFunc(u4) -- Line: 461
    -- upvalues: u3 (copy), Trove (copy), u2 (copy), LocalPlayer (copy), CurrentCamera (copy), TweenService (copy), Promise (copy), UserInputService (copy), u1 (copy), AbilityService (copy), Core (copy), AnimatorService (copy), AnimationHandler (copy), RunService (copy), CutsceneFunc (copy)
    local Target = u4.Target;
    local Character = u4.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    local AbilityName = u4.AbilityName;
    local SkinName = u4.SkinName;
    local AnimationName = u4.AnimationName;
    local AnimationPath = u4.AnimationPath;
    local u5 = u4.Offset or CFrame.identity;
    local Debug = u4.Debug;
    local FOVData = u4.FOVData;
    local u6 = {};

    for i, v in type(FOVData) ~= "string" and { FOVData } or u3[FOVData] do
        table.insert(u6, {
            Frame = i,
            FOVData = v
        });
    end;

    table.sort(u6, function(p7, p8) -- Line: 495
        return p7.Frame > p8.Frame;
    end);
    local u9 = u4.EasingTime or 0;
    local u10 = u4.EasingStyle or "Sine";
    local u11 = u4.EasingDirection or "Out";
    local StartTimePosition = u4.StartTimePosition;
    local u12 = Trove.new();
    local u13 = u4.Prefix or AbilityName .. (AnimationPath or (AnimationName or nil));

    if u4.Stop then
        local v14 = u2[u13];

        if v14 then
            v14:Stop();
        end;

        return;
    end;

    if not u4.Bypass and LocalPlayer.Settings.CutsceneCamera.Value == false then
        return;
    end;

    if u4.Interrupt then
        for _, v in pairs(u2) do
            v:Stop();
        end;
    end;

    if u2[u13] then
        u2[u13]:Stop();

        return;
    end;

    local function TweenFOV(p15) -- Line: 532
        -- upvalues: CurrentCamera (ref), TweenService (ref)
        if p15.Used then
            return;
        end;

        p15.Used = true;

        if p15.FOVData.TimeIn == 0 then
            CurrentCamera.FieldOfView = p15.FOVData.FOV;

            return;
        end;

        TweenService:Create(CurrentCamera, TweenInfo.new(p15.FOVData.TimeIn or 1), {
            FieldOfView = p15.FOVData.FOV
        }):Play();
    end;

    Promise.try(function() -- Line: 544
        -- upvalues: UserInputService (ref), LocalPlayer (ref), u12 (copy), Debug (copy), CurrentCamera (ref), u6 (copy), TweenFOV (copy), TweenService (ref), u4 (copy), u1 (ref), HumanoidRootPart (copy), u5 (copy), AnimationPath (copy), AbilityService (ref), AbilityName (copy), SkinName (copy), Core (ref), AnimatorService (ref), AnimationHandler (ref), AnimationName (copy), u2 (ref), u13 (copy), StartTimePosition (copy), RunService (ref), u9 (copy), u10 (copy), u11 (copy), Character (copy), Target (copy)
        if not UserInputService.TouchEnabled then
            local UI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UI");
            UI.Enabled = false;
            u12:Add(function() -- Line: 551
                -- upvalues: UI (copy)
                UI.Enabled = true;
            end);
        end;

        if not Debug then
            CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        end;

        if u6[#u6] and u6[#u6].Frame == 0 then
            TweenFOV(u6[#u6]);
        end;

        if u6[1] then
            u12:Add(function() -- Line: 563
                -- upvalues: u6 (ref), CurrentCamera (ref), LocalPlayer (ref), TweenService (ref)
                if u6[1].TimeOut == 0 then
                    CurrentCamera.FieldOfView = LocalPlayer.Settings.FieldOfView.Value;

                    return;
                end;

                TweenService:Create(CurrentCamera, TweenInfo.new(u6[1].TimeOut or 1), {
                    FieldOfView = LocalPlayer.Settings.FieldOfView.Value
                }):Play();
            end);
        end;

        local v16 = u12:Clone(u4.CameraRig or u1.Universal.CameraRig);
        v16.Name = u4.DisplayName or v16.Name;
        local PrimaryPart = v16.PrimaryPart;

        if u4.RigProperties then
            for i, v in pairs(u4.RigProperties) do
                if v16:FindFirstChild(i) then
                    local v17 = v16[i];

                    for i2, v2 in pairs(v) do
                        v17[i2] = v2;
                    end;
                end;
            end;
        end;

        local u18;

        if u4.CameraRig then
            u18 = v16:FindFirstChild(u4.CameraPart);
        else
            u18 = v16.camera;
        end;

        PrimaryPart.CFrame = HumanoidRootPart.CFrame * u5;
        v16.Parent = workspace.Effects;
        PrimaryPart.Anchored = true;
        local Animator = (v16:FindFirstChild("AnimationController") or v16:FindFirstChild("Humanoid")).Animator;
        local v19 = nil;

        if AnimationPath then
            local v20 = AbilityService.GetAbilityData({
                Ability = AbilityName,
                Skin = SkinName
            });

            if v20 then
                local v21 = Core.Get({
                    Path = AnimationPath
                }, v20.Directory);

                if v21 then
                    v19 = u12:Construct(AnimatorService.CreateAnimation, v21);
                end;
            end;
        else
            v19 = u12:Add(AnimationHandler.CreateAnimationByName(AbilityName, SkinName, AnimationName));
        end;

        local u22 = Animator:LoadAnimation(v19);
        u2[u13] = u22;
        u22:Play(u4.FadeTime, u4.Weight, u4.Speed);

        if StartTimePosition then
            u22.TimePosition = StartTimePosition;
        end;

        u12:Add(function() -- Line: 625
            -- upvalues: u2 (ref), u13 (ref)
            u2[u13] = nil;
        end);
        u12:Add(function() -- Line: 629
            -- upvalues: u2 (ref), u22 (copy), CurrentCamera (ref)
            for _, v in pairs(u2) do
                if v ~= u22 then
                    return;
                end;
            end;

            CurrentCamera.CameraType = Enum.CameraType.Custom;
        end);
        local u23 = 0;
        u12:Connect(RunService.RenderStepped, function(p24) -- Line: 640
            -- upvalues: u23 (ref), PrimaryPart (copy), HumanoidRootPart (ref), u5 (ref), Debug (ref), CurrentCamera (ref), u9 (ref), TweenService (ref), u10 (ref), u11 (ref), u18 (ref), Character (ref), u12 (ref), Target (ref), u6 (ref), TweenFOV (ref)
            u23 = u23 + p24;
            PrimaryPart.CFrame = HumanoidRootPart.CFrame * u5;

            if not Debug and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                if u9 and u9 > 0 then
                    local v25 = TweenService:GetValue(math.clamp(u23 / u9, 0, 1), u10, u11);

                    if v25 >= 1 then
                        CurrentCamera.CFrame = u18.CFrame;
                    else
                        CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(u18.CFrame, v25);
                    end;
                else
                    CurrentCamera.CFrame = u18.CFrame;
                end;
            end;

            if Character and not Character.Parent then
                u12:Destroy();
            end;

            if Target and not Target.Parent then
                u12:Destroy();
            end;

            for _, v in u6 do
                if u23 * 60 >= v.Frame then
                    TweenFOV(v);

                    return;
                end;
            end;
        end);
        u22.Stopped:Wait();
    end):catch(warn):finallyCall(u12.Destroy, u12):await();
    u2[u13] = nil;

    if u4.NextCutscene then
        CutsceneFunc(u4.NextCutscene);
    end;
end;

return CutsceneFunc;