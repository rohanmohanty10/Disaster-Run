 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local mvpAssets = vfxUtil.getResources().mvpAssets;

return function(p1: any, p2: number) -- Line: 14
    -- upvalues: mvpAssets (copy), vfxUtil (copy), soundUtil (copy), mainreplication (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
    local meow = mvpAssets.Sonic.meow;
    local Root = vfxUtil.getRoot(p1);
    local Compiled_A = require(meow.Compiled_A);
    soundUtil:play(meow.A_Sound, "default");
    local v3 = vfxUtil.mvp_cutscene_defaults(mainreplication, p2);
    local v4 = animationUtil:Load(p1, meow.UserA);
    Root.Anchored = true;
    local v5 = v3:Clone(meow.Effects);
    v5:PivotTo(Root.CFrame);
    v5.Parent = workspace.Effects;
    local v6 = v3:Clone(meow.Highlight_A);
    v6.Parent = p1;
    local _, v7 = mainreplication.cutsceneCamRigWithLetterBox(Root, meow.CamA, meow.FOV_A, nil, CFrame.new(0, -3, 0), meow.Cam, "CamPart");

    if v7 then
        v3:Add(v7);
    end;

    local v8 = {
        ["Screen Cover"] = v3:Add(vfxUtil.getMoonEffects())["Screen Cover"],
        Lighting = Lighting,
        Highlight = v6,
        Workspace = v5
    };
    vfxUtil.cutscene_lighting(v3, v8, meow.Lighting, {
        ClockTime = 14.5,
        GeographicLatitude = 0,
        ExposureCompensation = 0,
        Ambient = Color3.fromRGB(70, 70, 70),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    });
    v4:Play(0);
    local v9 = v3:Construct(MoonPropertyAnimator);
    v9:LoadAndConvertSave(meow.Moon, v8);
    v9:PlayAll();

    for _, v in ipairs(Compiled_A) do
        v3:Add(task.delay(v[1] / 60, v[2], v5));
    end;
end;